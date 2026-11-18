import assert from 'node:assert/strict';
import { test } from 'node:test';
import { parseWatchlist } from './watchlist.ts';

test('parses an {items:[...]} watchlist and ignores the comment field', () => {
  const entries = parseWatchlist(JSON.stringify({ _comment: 'ignore me', items: [{ id: 1, type: 'Asset' }, { id: 2, type: 'Bundle', note: 'x' }] }));
  assert.deepEqual(entries, [{ id: 1, type: 'Asset' }, { id: 2, type: 'Bundle', note: 'x' }]);
});

test('accepts a bare array and defaults an unknown type to Asset', () => {
  const entries = parseWatchlist(JSON.stringify([{ id: 5 }, { id: 6, type: 'Weird' }, { note: 'no id' }]));
  assert.deepEqual(entries, [{ id: 5, type: 'Asset' }, { id: 6, type: 'Asset' }]);
});
