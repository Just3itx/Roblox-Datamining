import { readFile } from 'node:fs/promises';
import type { Block, DiffLine, Section } from '../core/report.ts';
import { sortKeys } from '../core/store.ts';
import { errorMessage, formatNumber, mdLink, plural } from '../core/text.ts';
import { assetTypeName } from './asset-types.ts';
import { fetchAssetDetails, fetchBundleDetails, mapLimit } from './economy.ts';
import type { Tracker } from './types.ts';

/** Hand-edited input file at the repo root (not under data/). */
export const WATCHLIST_INPUT = 'watchlist.json';
const STATE_FILE = 'watchlist/state.json';

export interface WatchEntry {
  id: number;
  type: 'Asset' | 'Bundle';
  note?: string;
}

/** The mined snapshot of one watched item. */
export interface WatchState {
  exists: boolean;
  name?: string;
  detail?: string;
  onSale?: boolean;
}

export function parseWatchlist(text: string): WatchEntry[] {
  const parsed = JSON.parse(text) as { items?: unknown } | unknown[];
  const items = Array.isArray(parsed) ? parsed : ((parsed as { items?: unknown }).items ?? []);
  if (!Array.isArray(items)) return [];
  return items.flatMap((raw): WatchEntry[] => {
    const entry = raw as Partial<WatchEntry>;
    if (typeof entry.id !== 'number') return [];
    const type = entry.type === 'Bundle' ? 'Bundle' : 'Asset';
    return [{ id: entry.id, type, ...(entry.note ? { note: entry.note } : {}) }];
  });
}

const url = (entry: WatchEntry) =>
  entry.type === 'Bundle' ? `https://www.roblox.com/bundles/${entry.id}` : `https://www.roblox.com/catalog/${entry.id}`;

async function snapshot(http: Parameters<Tracker['run']>[0]['http'], entry: WatchEntry): Promise<WatchState> {
  if (entry.type === 'Bundle') {
    const bundle = await fetchBundleDetails(http, entry.id);
    if (!bundle) return { exists: false };
    return { exists: true, name: bundle.name, detail: `${bundle.bundleType ?? 'Bundle'} · ${bundle.items?.length ?? 0} items` };
  }
  const asset = await fetchAssetDetails(http, entry.id);
  if (!asset) return { exists: false };
  const onSale = asset.IsForSale ?? false;
  const price = asset.PriceInRobux ?? asset.CollectiblesItemDetails?.CollectibleLowestResalePrice ?? null;
  return {
    exists: true,
    name: asset.Name.trim(),
    onSale,
    detail: `${assetTypeName(asset.AssetTypeId)} · ${onSale ? (price ? `R$ ${formatNumber(price)}` : 'on sale') : 'not on sale'}`,
  };
}

const describe = (s: WatchState) => (s.exists ? `${s.name} — ${s.detail}` : 'does not exist yet');

function changeLine(entry: WatchEntry, before: WatchState, after: WatchState): DiffLine | null {
  if (!before.exists && after.exists) return { op: '+', text: `🎉 APPEARED — ${describe(after)} (${entry.id})` };
  if (before.exists && !after.exists) return { op: '-', text: `vanished — was ${describe(before)} (${entry.id})` };
  if (before.onSale === false && after.onSale === true) return { op: '+', text: `🟢 ON SALE — ${describe(after)} (${entry.id})` };
  if (describe(before) !== describe(after)) return { op: ' ', text: `changed — ${describe(before)} → ${describe(after)} (${entry.id})` };
  return null;
}

export const watchlistTracker: Tracker = {
  id: 'watchlist',
  title: 'Watchlist',
  icon: '👁️',
  description: `Item/bundle ids you list in ${WATCHLIST_INPUT}; alerts when each appears, goes on sale, or changes.`,

  async run({ http, store, log, warn }) {
    let entries: WatchEntry[];
    try {
      entries = parseWatchlist(await readFile(WATCHLIST_INPUT, 'utf8'));
    } catch (error) {
      if ((error as NodeJS.ErrnoException).code === 'ENOENT') return null;
      warn(`watchlist: could not read ${WATCHLIST_INPUT}: ${errorMessage(error)}`);
      return null;
    }
    if (!entries.length) return null;
    log(`watchlist: checking ${entries.length} items`);

    const states = await mapLimit(entries, 10, async (entry) => {
      try {
        return await snapshot(http, entry);
      } catch (error) {
        warn(`watchlist: ${entry.type} ${entry.id}: ${errorMessage(error)}`);
        return null;
      }
    });

    const current: Record<string, WatchState> = {};
    for (let i = 0; i < entries.length; i++) {
      const state = states[i];
      if (state) current[String(entries[i]!.id)] = state;
    }

    const previous = (await store.readJson<Record<string, WatchState>>(STATE_FILE)) ?? {};
    await store.writeJson(STATE_FILE, sortKeys(current));
    if (Object.keys(previous).length === 0) {
      const live = Object.values(current).filter((s) => s.exists).length;
      return {
        id: 'watchlist',
        icon: '👁️',
        title: 'Watchlist',
        short: '👁️ Watchlist snapshot',
        headline: `Watching ${plural(entries.length, 'item')} (${live} live now)`,
        blocks: [{ type: 'text', text: `First snapshot. Edit \`${WATCHLIST_INPUT}\` to change what's watched.` }],
      } satisfies Section;
    }

    const lines: DiffLine[] = [];
    for (const entry of entries) {
      const before = previous[String(entry.id)];
      const after = current[String(entry.id)];
      if (!before || !after) continue;
      const line = changeLine(entry, before, after);
      if (line) lines.push(line);
    }
    if (!lines.length) return null;

    const blocks: Block[] = [
      { type: 'diff', title: `Watchlist changes (${lines.length})`, lines, open: true },
      { type: 'text', text: entries.filter((e) => current[String(e.id)]?.exists).map((e) => mdLink(current[String(e.id)]!.name ?? String(e.id), url(e))).join(' · ') },
    ];
    return {
      id: 'watchlist',
      icon: '👁️',
      title: 'Watchlist',
      short: `👁️ Watchlist ${lines.length} change${lines.length === 1 ? '' : 's'}`,
      headline: `${plural(lines.length, 'watched item')} changed`,
      blocks,
    } satisfies Section;
  },
};
