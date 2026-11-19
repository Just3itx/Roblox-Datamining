import { diffRecords, type RecordDiff } from '../core/diff.ts';
import type { DiffLine, Section } from '../core/report.ts';
import { sortKeys } from '../core/store.ts';
import { compareStrings, countLabel, errorMessage, formatNumber, oneLine, plural, truncate } from '../core/text.ts';
import type { Tracker } from './types.ts';

/** Client settings applications, with short labels for reports. */
export const FFLAG_APPS = {
  PCDesktopClient: 'PC',
  PCStudioApp: 'Studio',
  PCClientBootstrapper: 'Bootstrapper',
  MacDesktopClient: 'Mac',
  MacStudioApp: 'Mac Studio',
  AndroidApp: 'Android',
  iOSApp: 'iOS',
  XboxClient: 'Xbox',
  UWPApp: 'UWP',
} as const;

export type FFlagApp = keyof typeof FFLAG_APPS;
export type Flags = Record<string, string>;

export const flagFile = (app: string) => `fflags/${app}.json`;

/**
 * Flags excluded from snapshots and diffs — deploy metadata that changes on every push
 * (git hash + timestamp of the flag deploy), so they'd otherwise spam every run.
 * Add more patterns here to mute other noisy flags.
 */
export const IGNORED_FLAG_PATTERNS: RegExp[] = [/FlagRepoGitHash/i, /FlipTimeStamp/i];

const isIgnored = (key: string) => IGNORED_FLAG_PATTERNS.some((re) => re.test(key));

/** Drops ignored flags before they're stored or diffed. */
export function filterFlags(flags: Flags): Flags {
  const kept: Flags = {};
  for (const [key, value] of Object.entries(flags)) if (!isIgnored(key)) kept[key] = value;
  return kept;
}

export interface FlagChange {
  op: 'added' | 'removed' | 'changed';
  key: string;
  before?: string;
  after?: string;
  /** Short labels of every app with this exact change. */
  apps: string[];
}

/** Merges per-app diffs so a flag that changed the same way in many apps is listed once. */
export function aggregateFlagChanges(perApp: Array<{ app: string; diff: RecordDiff<string> }>): FlagChange[] {
  const byIdentity = new Map<string, FlagChange>();
  const add = (change: Omit<FlagChange, 'apps'>, app: string) => {
    const identity = [change.op, change.key, change.before ?? '', change.after ?? ''].join('\u0000');
    const existing = byIdentity.get(identity);
    if (existing) existing.apps.push(app);
    else byIdentity.set(identity, { ...change, apps: [app] });
  };

  for (const { app, diff } of perApp) {
    for (const [key, after] of diff.added) add({ op: 'added', key, after }, app);
    for (const [key, before] of diff.removed) add({ op: 'removed', key, before }, app);
    for (const [key, before, after] of diff.changed) add({ op: 'changed', key, before, after }, app);
  }

  return [...byIdentity.values()].sort((a, b) => compareStrings(a.key, b.key));
}

const showValue = (value: string | undefined) => truncate(oneLine(value ?? ''), 240);

function changeLines(change: FlagChange, appCount: number): DiffLine[] {
  const where = change.apps.length === appCount ? '' : `   [${change.apps.join(', ')}]`;
  switch (change.op) {
    case 'added':
      return [{ op: '+', text: `${change.key} = ${showValue(change.after)}${where}` }];
    case 'removed':
      return [{ op: '-', text: `${change.key} = ${showValue(change.before)}${where}` }];
    case 'changed':
      return [
        { op: '-', text: `${change.key} = ${showValue(change.before)}` },
        { op: '+', text: `${change.key} = ${showValue(change.after)}${where}` },
      ];
  }
}

const uniqueKeys = (changes: FlagChange[], op: FlagChange['op']) =>
  new Set(changes.filter((c) => c.op === op).map((c) => c.key)).size;

export const fflagsTracker: Tracker = {
  id: 'fflags',
  title: 'Fast flags',
  icon: '🚩',
  description: 'Every FFlag/FInt/FString/FLog served by clientsettingscdn for each Roblox app.',

  async run({ http, store, warn }) {
    const apps = Object.keys(FFLAG_APPS) as FFlagApp[];
    const fetched = await Promise.all(
      apps.map(async (app) => {
        try {
          const url = `https://clientsettingscdn.roblox.com/v2/settings/application/${app}`;
          const { applicationSettings } = await http.json<{ applicationSettings: Flags }>(url);
          return { app, flags: sortKeys(filterFlags(applicationSettings)) };
        } catch (error) {
          warn(`fflags: could not read ${app}: ${errorMessage(error)}`);
          return null;
        }
      }),
    );

    const perApp: Array<{ app: string; diff: RecordDiff<string> }> = [];
    const rows: string[][] = [];
    let firstSnapshots = 0;

    for (const result of fetched) {
      if (!result) continue;
      const label = FFLAG_APPS[result.app];
      const previous = await store.readJson<Flags>(flagFile(result.app));
      await store.writeJson(flagFile(result.app), result.flags);
      const total = formatNumber(Object.keys(result.flags).length);

      if (!previous) {
        firstSnapshots++;
        rows.push([label, total, '🆕', '', '']);
        continue;
      }
      const diff = diffRecords(previous, result.flags);
      perApp.push({ app: label, diff });
      rows.push([label, total, formatNumber(diff.added.length), formatNumber(diff.removed.length), formatNumber(diff.changed.length)]);
    }

    const changes = aggregateFlagChanges(perApp);
    if (!changes.length && !firstSnapshots) return null;

    const appCount = fetched.filter(Boolean).length;
    const counts = {
      added: uniqueKeys(changes, 'added'),
      removed: uniqueKeys(changes, 'removed'),
      changed: uniqueKeys(changes, 'changed'),
    };

    const blocks: Section['blocks'] = [
      { type: 'table', columns: ['App', 'Flags', 'Added', 'Removed', 'Changed'], rows },
    ];
    const groups = [
      { op: 'added', title: 'Added' },
      { op: 'removed', title: 'Removed' },
      { op: 'changed', title: 'Changed' },
    ] as const;
    for (const { op, title } of groups) {
      const group = changes.filter((c) => c.op === op);
      if (!group.length) continue;
      const lines = group.flatMap((c) => changeLines(c, appCount));
      blocks.push({ type: 'diff', title: `${title} (${formatNumber(counts[op])})`, lines, open: lines.length <= 60 });
    }
    if (changes.some((c) => c.apps.length !== appCount)) {
      blocks.push({ type: 'text', text: '<sub>Lines without [apps] apply to every app.</sub>' });
    }

    const headline = changes.length
      ? `${countLabel(counts)} flags across ${plural(new Set(changes.flatMap((c) => c.apps)).size, 'app')}`
      : `First snapshot of ${plural(firstSnapshots, 'app')}`;
    return {
      id: 'fflags',
      icon: '🚩',
      title: 'Fast flags',
      short: changes.length ? `🚩 FFlags ${countLabel(counts)}` : '🚩 FFlags snapshot',
      headline,
      blocks,
    };
  },
};
