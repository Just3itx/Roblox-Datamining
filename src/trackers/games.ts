import { randomUUID } from 'node:crypto';
import type { Block, Section } from '../core/report.ts';
import { escapeCell, formatCompact, formatNumber, mdLink, plural } from '../core/text.ts';
import type { Tracker } from './types.ts';

interface ExploreGame {
  universeId: number;
  rootPlaceId: number;
  name: string;
  playerCount?: number;
  totalUpVotes?: number;
  totalDownVotes?: number;
  isSponsored?: boolean;
}

interface ExploreSort {
  contentType: string;
  sortId: string;
  sortDisplayName: string;
  games?: ExploreGame[];
}

export interface ChartEntry {
  rank: number;
  universeId: number;
  placeId: number;
  name: string;
}

/** Stored chart. Player counts are left out on purpose: they change every minute. */
export interface Chart {
  sortId: string;
  title: string;
  entries: ChartEntry[];
}

export interface ChartDiff {
  entered: ChartEntry[];
  left: ChartEntry[];
  moved: number;
}

export function diffChart(before: Chart | undefined, after: Chart): ChartDiff {
  const old = new Map((before?.entries ?? []).map((e) => [e.universeId, e]));
  const next = new Set(after.entries.map((e) => e.universeId));
  return {
    entered: after.entries.filter((e) => !old.has(e.universeId)),
    left: (before?.entries ?? []).filter((e) => !next.has(e.universeId)),
    moved: after.entries.filter((e) => {
      const prev = old.get(e.universeId);
      return prev !== undefined && prev.rank !== e.rank;
    }).length,
  };
}

const gameUrl = (placeId: number) => `https://www.roblox.com/games/${placeId}`;

function rating(game: ExploreGame | undefined): string {
  const up = game?.totalUpVotes ?? 0;
  const down = game?.totalDownVotes ?? 0;
  return up + down > 0 ? `${Math.round((up / (up + down)) * 100)}%` : '—';
}

function gameTable(entries: ChartEntry[], live: Map<number, ExploreGame>): Block {
  return {
    type: 'table',
    columns: ['#', 'Experience', 'Playing', 'Rating'],
    rows: entries.map((e) => {
      const game = live.get(e.universeId);
      return [
        String(e.rank),
        mdLink(e.name, gameUrl(e.placeId)),
        game?.playerCount !== undefined ? formatCompact(game.playerCount) : '—',
        rating(game),
      ];
    }),
  };
}

export const gamesTracker: Tracker = {
  id: 'games',
  title: 'Experience charts',
  icon: '🎮',
  description: 'Discover-page charts (Top Trending, Up-and-Coming, …): who entered and who left.',

  async run({ http, store }) {
    const url = `https://apis.roblox.com/explore-api/v1/get-sorts?sessionId=${randomUUID()}`;
    const { sorts } = await http.json<{ sorts: ExploreSort[] }>(url);
    const gameSorts = sorts.filter((s) => s.contentType === 'Games' && s.games?.length);

    const overview: string[][] = [];
    const details: Block[] = [];
    let entered = 0;
    let left = 0;
    let moved = 0;
    let firstSnapshots = 0;

    for (const sort of gameSorts) {
      const live = new Map((sort.games ?? []).map((g) => [g.universeId, g]));
      const chart: Chart = {
        sortId: sort.sortId,
        title: sort.sortDisplayName,
        entries: (sort.games ?? [])
          .filter((g) => !g.isSponsored)
          .map((g, index) => ({ rank: index + 1, universeId: g.universeId, placeId: g.rootPlaceId, name: g.name.trim() })),
      };
      const file = `games/charts/${sort.sortId}.json`;
      const previous = await store.readJson<Chart>(file);
      const changed = await store.writeJson(file, chart);
      if (!changed) continue;

      if (!previous) {
        firstSnapshots++;
        overview.push([escapeCell(chart.title), formatNumber(chart.entries.length), '🆕', '', '']);
        details.push({ type: 'text', text: `### ${escapeCell(chart.title)} — top 10` }, gameTable(chart.entries.slice(0, 10), live));
        continue;
      }

      const diff = diffChart(previous, chart);
      entered += diff.entered.length;
      left += diff.left.length;
      moved += diff.moved;
      overview.push([
        escapeCell(chart.title),
        formatNumber(chart.entries.length),
        formatNumber(diff.entered.length),
        formatNumber(diff.left.length),
        formatNumber(diff.moved),
      ]);
      if (diff.entered.length) {
        details.push({ type: 'text', text: `### 🆕 New in ${escapeCell(chart.title)}` }, gameTable(diff.entered, live));
      }
      if (diff.left.length) {
        details.push({
          type: 'diff',
          title: `Dropped out of ${chart.title} (${diff.left.length})`,
          lines: diff.left.map((e) => ({ op: '-', text: `#${e.rank} ${e.name}` })),
        });
      }
    }

    if (!overview.length) return null;

    const headline =
      entered || left
        ? `${plural(entered, 'experience')} entered and ${formatNumber(left)} left across ${plural(overview.length, 'chart')}`
        : firstSnapshots
          ? `First snapshot of ${plural(firstSnapshots, 'chart')}`
          : `Rankings reshuffled (${plural(moved, 'move')})`;

    return {
      id: 'games',
      icon: '🎮',
      title: 'Experience charts',
      short: entered || left ? `🎮 Charts +${entered} −${left}` : firstSnapshots ? '🎮 Charts snapshot' : '🎮 Charts reshuffled',
      headline,
      blocks: [{ type: 'table', columns: ['Chart', 'Size', 'Entered', 'Left', 'Moved'], rows: overview }, ...details],
    } satisfies Section;
  },
};
