import assert from 'node:assert/strict';
import { test } from 'node:test';
import { diffRecords } from '../core/diff.ts';
import { aggregateFlagChanges } from './fflags.ts';

test('merges identical flag changes across apps', () => {
  const before = { FFlagA: 'False', FIntB: '10', FStringGone: 'x' };
  const pc = diffRecords(before, { FFlagA: 'True', FIntB: '10', FFlagNew: 'True' });
  const mac = diffRecords(before, { FFlagA: 'True', FIntB: '20', FFlagNew: 'True' });

  const changes = aggregateFlagChanges([
    { app: 'PC', diff: pc },
    { app: 'Mac', diff: mac },
  ]);

  assert.deepEqual(changes, [
    { op: 'changed', key: 'FFlagA', before: 'False', after: 'True', apps: ['PC', 'Mac'] },
    { op: 'added', key: 'FFlagNew', after: 'True', apps: ['PC', 'Mac'] },
    { op: 'removed', key: 'FStringGone', before: 'x', apps: ['PC', 'Mac'] },
    { op: 'changed', key: 'FIntB', before: '10', after: '20', apps: ['Mac'] },
  ].sort((a, b) => (a.key < b.key ? -1 : a.key > b.key ? 1 : 0)));
});
