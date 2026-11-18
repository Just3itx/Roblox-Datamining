import { renderSection, type Section } from '../../core/report.ts';
import { countLabel, formatNumber, mdCode, plural } from '../../core/text.ts';
import type { Tracker } from '../types.ts';
import { fetchClientVersion } from '../versions.ts';
import { apiStats, diffApiDump, isEmptyApiDiff, type ApiDiff, type ApiDump, type Counts } from './diff.ts';

export const DUMP_FILE = 'api-dump/Full-API-Dump.json';
export const META_FILE = 'api-dump/meta.json';

export interface ApiDumpMeta {
  version: string;
  clientVersionUpload: string;
  classes: number;
  members: number;
  enums: number;
  enumItems: number;
}

const TITLE = 'API dump';
const ICON = '🧩';

function headline(diff: ApiDiff): string {
  const parts: string[] = [];
  const add = (counts: Counts, noun: string) => {
    if (counts.added || counts.removed || counts.changed) parts.push(`${countLabel(counts)} ${noun}`);
  };
  add(diff.classes, 'classes');
  add(diff.members, 'members');
  add(diff.enums, 'enums');
  add(diff.enumItems, 'enum items');
  return parts.join(' · ');
}

function diffSection(diff: ApiDiff, version: string, upload: string): Section {
  const row = (label: string, c: Counts) => [label, formatNumber(c.added), formatNumber(c.removed), formatNumber(c.changed)];
  const blocks: Section['blocks'] = [
    { type: 'text', text: `Studio ${mdCode(version)} · ${mdCode(upload)}` },
    {
      type: 'table',
      columns: ['', 'Added', 'Removed', 'Changed'],
      rows: [
        row('Classes', diff.classes),
        row('Members', diff.members),
        row('Enums', diff.enums),
        row('Enum items', diff.enumItems),
      ],
    },
  ];
  if (diff.classLines.length) {
    blocks.push({ type: 'diff', title: 'Classes & members', lines: diff.classLines, open: diff.classLines.length <= 80 });
  }
  if (diff.enumLines.length) {
    blocks.push({ type: 'diff', title: 'Enums', lines: diff.enumLines, open: diff.enumLines.length <= 40 });
  }

  const members = diff.members.added + diff.members.removed + diff.members.changed;
  return {
    id: 'api-dump',
    icon: ICON,
    title: TITLE,
    short: `${ICON} API ${members ? countLabel(diff.members) : headline(diff)}`,
    headline: headline(diff),
    blocks,
  };
}

export const apiDumpTracker: Tracker = {
  id: 'api-dump',
  title: TITLE,
  icon: ICON,
  description: "Studio's Full-API-Dump.json: classes, members, enums, with readable diffs per build.",

  async run({ http, store, log }) {
    const studio = await fetchClientVersion(http, 'WindowsStudio64');
    const meta = await store.readJson<ApiDumpMeta>(META_FILE);
    if (meta?.clientVersionUpload === studio.clientVersionUpload) return null;

    log(`api-dump: downloading dump for ${studio.clientVersionUpload}`);
    const dump = await http.json<ApiDump>(`https://setup.rbxcdn.com/${studio.clientVersionUpload}-Full-API-Dump.json`);
    const previous = await store.readJson<ApiDump>(DUMP_FILE);
    const stats = apiStats(dump);

    await store.writeJson(DUMP_FILE, dump);
    await store.writeJson(META_FILE, { ...studio, ...stats } satisfies ApiDumpMeta);

    if (!previous) {
      return {
        id: 'api-dump',
        icon: ICON,
        title: TITLE,
        short: `${ICON} API snapshot`,
        headline: `First snapshot: ${plural(stats.classes, 'class', 'classes')}, ${plural(stats.members, 'member')}, ${plural(stats.enums, 'enum')}`,
        blocks: [{ type: 'text', text: `Studio ${mdCode(studio.version)} · ${mdCode(studio.clientVersionUpload)}` }],
      };
    }

    const diff = diffApiDump(previous, dump);
    if (isEmptyApiDiff(diff)) {
      log('api-dump: new build, API unchanged');
      return null;
    }

    const section = diffSection(diff, studio.version, studio.clientVersionUpload);
    // A browsable archive of every API change, one file per Studio build.
    await store.writeText(`api-dump/changes/${studio.version}-${studio.clientVersionUpload}.md`, renderSection(section));
    return section;
  },
};
