import { compareStrings } from './text.ts';

export interface RecordDiff<V> {
  added: Array<[key: string, value: V]>;
  removed: Array<[key: string, value: V]>;
  changed: Array<[key: string, before: V, after: V]>;
}

/** Key-by-key diff of two records. Every list comes back sorted by key. */
export function diffRecords<V>(
  before: Readonly<Record<string, V>>,
  after: Readonly<Record<string, V>>,
  equals: (a: V, b: V) => boolean = Object.is,
): RecordDiff<V> {
  const diff: RecordDiff<V> = { added: [], removed: [], changed: [] };

  for (const key of Object.keys(after).sort(compareStrings)) {
    const next = after[key] as V;
    if (!Object.hasOwn(before, key)) {
      diff.added.push([key, next]);
      continue;
    }
    const prev = before[key] as V;
    if (!equals(prev, next)) diff.changed.push([key, prev, next]);
  }

  for (const key of Object.keys(before).sort(compareStrings)) {
    if (!Object.hasOwn(after, key)) diff.removed.push([key, before[key] as V]);
  }

  return diff;
}

export function isEmptyDiff(diff: RecordDiff<unknown>): boolean {
  return diff.added.length === 0 && diff.removed.length === 0 && diff.changed.length === 0;
}

export function diffCounts(diff: RecordDiff<unknown>): { added: number; removed: number; changed: number } {
  return { added: diff.added.length, removed: diff.removed.length, changed: diff.changed.length };
}
