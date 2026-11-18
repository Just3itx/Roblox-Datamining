import { readFile, writeFile } from 'node:fs/promises';
import { renderTable } from './core/report.ts';
import type { Store } from './core/store.ts';
import { formatNumber, mdCode, mdLink, utcStamp } from './core/text.ts';
import type { ApiDumpMeta } from './trackers/api-dump/index.ts';
import { META_FILE } from './trackers/api-dump/index.ts';
import { CATALOG_FILE, type TrackedItem } from './trackers/catalog.ts';
import { FFLAG_APPS, flagFile, type Flags } from './trackers/fflags.ts';
import type { Chart } from './trackers/games.ts';
import { BINARIES, LIVE_FILE, type BinaryType, type LiveVersions } from './trackers/versions.ts';

const START = '<!-- status:start -->';
const END = '<!-- status:end -->';

/** Builds the live status block shown at the top of the README from the current snapshots. */
export async function buildStatus(store: Store, now: Date, repository = process.env.GITHUB_REPOSITORY): Promise<string> {
  const parts: string[] = [];

  if (repository) {
    const base = `https://github.com/${repository}`;
    parts.push(
      `<p align="center">` +
        `<a href="${base}/actions/workflows/mine.yml"><img alt="Mine" src="${base}/actions/workflows/mine.yml/badge.svg"></a> ` +
        `<a href="${base}/actions/workflows/ci.yml"><img alt="CI" src="${base}/actions/workflows/ci.yml/badge.svg"></a> ` +
        `<a href="${base}/commits/main"><img alt="Last change" src="https://img.shields.io/github/last-commit/${repository}?label=last%20change"></a>` +
        `</p>`,
    );
  }

  const live = await store.readJson<LiveVersions>(LIVE_FILE);
  if (live) {
    const rows = (Object.keys(BINARIES) as BinaryType[]).flatMap((binary) => {
      const v = live[binary];
      return v ? [[BINARIES[binary], mdCode(v.version), mdCode(v.clientVersionUpload)]] : [];
    });
    parts.push('### 🚀 Live builds', renderTable(['Binary', 'Version', 'Upload'], rows));
  }

  const highlights: string[][] = [];
  const api = await store.readJson<ApiDumpMeta>(META_FILE);
  if (api) {
    highlights.push([
      '🧩 API dump',
      `${formatNumber(api.classes)} classes · ${formatNumber(api.members)} members · ${formatNumber(api.enums)} enums`,
      '[`data/api-dump`](data/api-dump)',
    ]);
  }

  let flagTotal = 0;
  let flagApps = 0;
  for (const app of Object.keys(FFLAG_APPS)) {
    const flags = await store.readJson<Flags>(flagFile(app));
    if (!flags) continue;
    flagApps++;
    flagTotal += Object.keys(flags).length;
  }
  if (flagApps) {
    highlights.push(['🚩 Fast flags', `${formatNumber(flagTotal)} values across ${flagApps} apps`, '[`data/fflags`](data/fflags)']);
  }

  const topPlaying = await store.readJson<Chart>('games/charts/top-playing-now.json');
  if (topPlaying?.entries.length) {
    const top = topPlaying.entries
      .slice(0, 3)
      .map((e) => mdLink(e.name, `https://www.roblox.com/games/${e.placeId}`))
      .join(' · ');
    highlights.push(['🎮 Top playing now', top, '[`data/games`](data/games)']);
  }

  const items = await store.readJson<TrackedItem[]>(CATALOG_FILE);
  if (items?.length) {
    const latest = items
      .slice(0, 3)
      .map((i) => mdLink(i.name, `https://www.roblox.com/${i.itemType === 'Bundle' ? 'bundles' : 'catalog'}/${i.id}`))
      .join(' · ');
    highlights.push(['🛍️ Latest Roblox items', latest, '[`data/catalog`](data/catalog)']);
  }

  if (highlights.length) parts.push('### 📊 Tracked right now', renderTable(['', 'Snapshot', 'Data'], highlights));
  parts.push(`<sub>Last change detected ${utcStamp(now)}. This block is rewritten by the miner.</sub>`);
  return parts.join('\n\n');
}

/** Replaces the status block between the markers. Returns false when the README has no markers or nothing changed. */
export async function updateReadme(path: string, store: Store, now: Date): Promise<boolean> {
  let readme: string;
  try {
    readme = await readFile(path, 'utf8');
  } catch {
    return false;
  }
  const start = readme.indexOf(START);
  const end = readme.indexOf(END);
  if (start === -1 || end < start) return false;

  const next = `${readme.slice(0, start + START.length)}\n${await buildStatus(store, now)}\n${readme.slice(end)}`;
  if (next === readme) return false;
  await writeFile(path, next);
  return true;
}
