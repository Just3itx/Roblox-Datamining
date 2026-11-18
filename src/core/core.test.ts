import assert from 'node:assert/strict';
import { test } from 'node:test';
import { diffRecords } from './diff.ts';
import { renderCommitMessage, renderReport, type Section } from './report.ts';
import { countLabel, escapeCell, mdLink } from './text.ts';

test('diffRecords sorts added, removed and changed keys', () => {
  const diff = diffRecords({ b: 1, a: 1, gone: 0 }, { a: 2, c: 3, b: 1 });
  assert.deepEqual(diff, { added: [['c', 3]], removed: [['gone', 0]], changed: [['a', 1, 2]] });
});

test('countLabel skips zero parts', () => {
  assert.equal(countLabel({ added: 3, removed: 0, changed: 1 }), '+3 ~1');
  assert.equal(countLabel({ added: 0, removed: 0, changed: 0 }), 'no changes');
});

test('markdown helpers escape table and link syntax', () => {
  assert.equal(escapeCell('a|b\nc'), 'a\\|b ⏎ c');
  assert.equal(mdLink('[🎃] Blox Fruits', 'https://x'), '[\\[🎃\\] Blox Fruits](https://x)');
});

const section = (lines: number): Section => ({
  id: 'fflags',
  icon: '🚩',
  title: 'Fast flags',
  short: '🚩 FFlags +1',
  headline: '+1 flags',
  blocks: [{ type: 'diff', title: 'Added', lines: Array.from({ length: lines }, (_, i) => ({ op: '+', text: `FFlag${i} = True` })) }],
});

test('renderReport shrinks diffs to fit the size limit', () => {
  const report = renderReport([section(5000)], { now: new Date('2026-01-01T00:00:00Z'), maxChars: 20_000 });
  assert.ok(report.length <= 20_000);
  assert.match(report, /more lines in the commit diff/);
  assert.match(report, /```diff\n\+ FFlag0 = True/);
});

test('renderReport keeps mined text from closing the code fence', () => {
  const s = section(0);
  s.blocks = [{ type: 'diff', title: 'x', lines: [{ op: '+', text: 'FStringEvil = ```' }] }];
  const report = renderReport([s], { now: new Date(0) });
  assert.equal(report.split('```').length - 1, 2);
});

test('renderCommitMessage joins shorts into the subject', () => {
  const message = renderCommitMessage([section(1), { ...section(1), short: '🚀 0.749.0', icon: '🚀', title: 'Client versions' }]);
  assert.equal(message.split('\n')[0], '🚩 FFlags +1 · 🚀 0.749.0');
});
