import type { Block, Section } from '../core/report.ts';
import { compareStrings, errorMessage, escapeCell, mdCode, plural } from '../core/text.ts';
import type { Tracker } from './types.ts';

/**
 * Deploy channels to follow. LIVE is production; zcanary and znext get builds first (leaks).
 * zintegration is left out on purpose: it's ~6 MB of internal RccService test spam.
 */
export const CHANNELS = {
  LIVE: { label: '🟢 LIVE', base: 'https://setup.rbxcdn.com' },
  zcanary: { label: '🐤 zcanary', base: 'https://setup.rbxcdn.com/channel/zcanary' },
  znext: { label: '⏭️ znext', base: 'https://setup.rbxcdn.com/channel/znext' },
} as const;

export type Channel = keyof typeof CHANNELS;

export interface DeployEntry {
  binary: string;
  version: string;
  fileVersion: string;
  date: string;
}

const LINE = /^New (\S+) \S+ at (.+?), file version: ([\d, ]+?)(?:, git hash:|\s*\.\.\.|$)/;

export function parseDeployHistory(text: string): DeployEntry[] {
  const entries: DeployEntry[] = [];
  for (const raw of text.split('\n')) {
    const match = LINE.exec(raw.trim());
    if (!match) continue;
    const [, binary, date, fileVersion] = match;
    entries.push({
      binary: binary!,
      version: fileVersion!.split(',').map((p) => p.trim()).join('.'),
      fileVersion: fileVersion!,
      date: date!.trim(),
    });
  }
  return entries;
}

const rawFile = (channel: string) => `deploy-history/${channel}.txt`;

/** Lines present in `after` that weren't in `before` (the history file only ever grows). */
function newLines(before: string | undefined, after: string): string[] {
  const seen = new Set((before ?? '').split('\n').map((l) => l.trim()));
  return after.split('\n').map((l) => l.trim()).filter((l) => l && !seen.has(l));
}

export const deployHistoryTracker: Tracker = {
  id: 'deploy-history',
  title: 'Deploy history',
  icon: '📦',
  description: 'Full Roblox deploy log across the LIVE, zcanary, zintegration and znext channels.',

  async run({ http, store, warn }) {
    const overview: string[][] = [];
    const detail: Block[] = [];
    let totalNew = 0;
    let firstSnapshots = 0;
    const freshVersions = new Set<string>();

    for (const channel of Object.keys(CHANNELS) as Channel[]) {
      const { label, base } = CHANNELS[channel];
      let text: string;
      try {
        text = await http.text(`${base}/DeployHistory.txt`);
      } catch (error) {
        warn(`deploy-history: could not read ${channel}: ${errorMessage(error)}`);
        continue;
      }

      const previous = await store.readText(rawFile(channel));
      if (!(await store.writeText(rawFile(channel), text))) continue;

      if (previous === undefined) {
        firstSnapshots++;
        overview.push([label, String(parseDeployHistory(text).length), '🆕']);
        continue;
      }

      const fresh = parseDeployHistory(newLines(previous, text).join('\n'));
      if (!fresh.length) continue;
      totalNew += fresh.length;
      overview.push([label, String(parseDeployHistory(text).length), String(fresh.length)]);
      for (const entry of fresh) freshVersions.add(entry.version);

      const rows = fresh
        .slice()
        .reverse()
        .map((e) => [escapeCell(e.binary), mdCode(e.version), escapeCell(e.date)]);
      detail.push(
        { type: 'text', text: `### ${label}` },
        { type: 'table', columns: ['Binary', 'Version', 'Deployed'], rows },
      );
    }

    if (!totalNew && !firstSnapshots) return null;

    const versions = [...freshVersions].sort(compareStrings);
    const headline = totalNew
      ? `${plural(totalNew, 'new deploy')}${versions.length ? ` → ${versions.join(', ')}` : ''}`
      : `First snapshot of ${plural(firstSnapshots, 'channel')}`;

    return {
      id: 'deploy-history',
      icon: '📦',
      title: 'Deploy history',
      short: totalNew ? `📦 ${plural(totalNew, 'deploy')}` : '📦 Deploys snapshot',
      headline,
      blocks: [
        { type: 'table', columns: ['Channel', 'Total', 'New'], rows: overview },
        ...detail,
      ],
    } satisfies Section;
  },
};
