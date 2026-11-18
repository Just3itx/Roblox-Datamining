import type { Http } from '../core/http.ts';
import type { Block, DiffLine, Section } from '../core/report.ts';
import { sortKeys } from '../core/store.ts';
import { compareStrings, countLabel, formatNumber, mdLink, plural } from '../core/text.ts';
import { assetTypeName } from './asset-types.ts';
import type { Tracker } from './types.ts';

export const LIMITEDS_FILE = 'limiteds/roblox.json';

/** One row from catalog v2 search/items/details with salesTypeFilter=2 (limiteds only). */
interface CatalogLimited {
  id: number;
  name: string;
  assetType?: number;
  itemCreatedUtc?: string;
  itemRestrictions?: string[];
  price?: number | null;
  lowestResalePrice?: number | null;
  totalQuantity?: number | null;
  unitsAvailableForConsumption?: number | null;
  offSaleDeadline?: string | null;
}

export interface TrackedLimited {
  id: number;
  name: string;
  type: string;
  created: string;
  kind: 'Limited' | 'LimitedUnique' | 'Collectible';
  onSale: boolean;
  price: number | null;
  remaining: number | null;
  totalQuantity: number | null;
  lowestResale: number | null;
}

const DETAILS = 'https://catalog.roblox.com/v2/search/items/details';

/** Pages the Roblox-account limiteds (Limit=120 keeps it to a handful of catalog requests). */
export async function fetchRobloxLimiteds(http: Http): Promise<CatalogLimited[]> {
  const items: CatalogLimited[] = [];
  let cursor = '';
  for (let page = 0; page < 30; page++) {
    const url = `${DETAILS}?CreatorTargetId=1&CreatorType=1&Category=1&SortType=3&Limit=120&salesTypeFilter=2${cursor ? `&Cursor=${encodeURIComponent(cursor)}` : ''}`;
    const result = await http.json<{ data?: CatalogLimited[]; nextPageCursor: string | null }>(url);
    for (const item of result.data ?? []) items.push(item);
    if (!result.nextPageCursor) break;
    cursor = result.nextPageCursor;
  }
  return items;
}

function toLimited(d: CatalogLimited): TrackedLimited {
  const restrictions = d.itemRestrictions ?? [];
  const remaining = d.unitsAvailableForConsumption ?? null;
  return {
    id: d.id,
    name: d.name.trim(),
    type: assetTypeName(d.assetType),
    created: d.itemCreatedUtc ?? '',
    kind: restrictions.includes('LimitedUnique') ? 'LimitedUnique' : restrictions.includes('Limited') ? 'Limited' : 'Collectible',
    onSale: (remaining ?? 0) > 0,
    price: d.price ?? null,
    remaining,
    totalQuantity: d.totalQuantity ?? null,
    lowestResale: d.lowestResalePrice ?? null,
  };
}

const robux = (value: number | null) => (value === null ? '—' : value === 0 ? 'Free' : `R$ ${formatNumber(value)}`);
const stock = (item: TrackedLimited) =>
  item.totalQuantity !== null
    ? `${formatNumber(item.remaining ?? 0)}/${formatNumber(item.totalQuantity)}`
    : item.remaining !== null
      ? formatNumber(item.remaining)
      : '—';

const itemUrl = (id: number) => `https://www.roblox.com/catalog/${id}`;

/** A one-line fingerprint; when it changes between runs the item is "changed". */
const fingerprint = (i: TrackedLimited) =>
  `${i.name} · ${i.onSale ? robux(i.price) : 'SOLD-OUT'} · stock ${stock(i)} · resale ${robux(i.lowestResale)}`;

function changeLine(before: TrackedLimited, after: TrackedLimited): DiffLine {
  const parts: string[] = [];
  if (before.onSale !== after.onSale) parts.push(after.onSale ? '🟢 back ON SALE' : '🔴 SOLD OUT from Roblox');
  if (before.price !== after.price) parts.push(`price ${robux(before.price)} → ${robux(after.price)}`);
  if (before.remaining !== after.remaining) parts.push(`stock ${stock(before)} → ${stock(after)}`);
  if (before.lowestResale !== after.lowestResale) parts.push(`resale ${robux(before.lowestResale)} → ${robux(after.lowestResale)}`);
  if (before.name !== after.name) parts.push(`renamed "${before.name}" → "${after.name}"`);
  return { op: ' ', text: `${after.name} (${after.id}): ${parts.join('; ') || 'updated'}` };
}

function newItemsTable(items: TrackedLimited[]): Block {
  return {
    type: 'table',
    columns: ['Item', 'Type', 'Kind', 'Price', 'Stock', 'Resale', 'Status'],
    rows: items.map((i) => [
      mdLink(i.name, itemUrl(i.id)),
      i.type,
      i.kind,
      robux(i.price),
      stock(i),
      robux(i.lowestResale),
      i.onSale ? '🟢 on sale' : '🔜 not on sale',
    ]),
  };
}

export const limitedsTracker: Tracker = {
  id: 'limiteds',
  title: 'Limited items',
  icon: '🔴',
  description: 'Every Roblox limited/collectible: new drops, price & resale moves, stock, and sell-outs.',

  async run({ http, store, warn, log }) {
    const rows = await fetchRobloxLimiteds(http);
    if (!rows.length) {
      warn('limiteds: enumeration returned no items');
      return null;
    }
    log(`limiteds: ${rows.length} items`);

    const current: Record<string, TrackedLimited> = {};
    for (const row of rows) current[String(row.id)] = toLimited(row);

    const previous = (await store.readJson<Record<string, TrackedLimited>>(LIMITEDS_FILE)) ?? {};
    await store.writeJson(LIMITEDS_FILE, sortKeys(current));

    if (Object.keys(previous).length === 0) {
      return {
        id: 'limiteds',
        icon: '🔴',
        title: 'Limited items',
        short: '🔴 Limiteds snapshot',
        headline: `First snapshot of ${plural(Object.keys(current).length, 'limited')}`,
        blocks: [{ type: 'text', text: `Tracking ${formatNumber(Object.keys(current).length)} Roblox limiteds/collectibles.` }],
      } satisfies Section;
    }

    const added: TrackedLimited[] = [];
    const changed: DiffLine[] = [];
    for (const [id, item] of Object.entries(current)) {
      const old = previous[id];
      if (!old) added.push(item);
      else if (fingerprint(old) !== fingerprint(item)) changed.push(changeLine(old, item));
    }
    const removed = Object.keys(previous).filter((id) => !current[id]);
    if (!added.length && !changed.length && !removed.length) return null;

    added.sort((a, b) => compareStrings(b.created, a.created));
    const counts = { added: added.length, removed: removed.length, changed: changed.length };
    const blocks: Block[] = [];
    if (added.length) blocks.push({ type: 'text', text: '### 🆕 New limiteds' }, newItemsTable(added));
    if (changed.length) blocks.push({ type: 'diff', title: `Updated (${changed.length})`, lines: changed, open: changed.length <= 40 });
    if (removed.length) {
      blocks.push({ type: 'diff', title: `Delisted (${removed.length})`, lines: removed.map((id) => ({ op: '-', text: `${previous[id]!.name} (${id})` })) });
    }

    const comingSoon = added.filter((i) => !i.onSale).length;
    return {
      id: 'limiteds',
      icon: '🔴',
      title: 'Limited items',
      short: `🔴 Limiteds ${countLabel(counts)}`,
      headline:
        `${plural(added.length, 'new limited')}, ${plural(changed.length, 'update')}` +
        (comingSoon ? ` · ${comingSoon} not on sale yet 🔜` : ''),
      blocks,
    } satisfies Section;
  },
};
