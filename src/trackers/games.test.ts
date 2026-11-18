import assert from 'node:assert/strict';
import { test } from 'node:test';
import { diffChart, type Chart } from './games.ts';

const chart = (ids: number[]): Chart => ({
  sortId: 'top-trending',
  title: 'Top Trending',
  entries: ids.map((id, i) => ({ rank: i + 1, universeId: id, placeId: id * 10, name: `Game ${id}` })),
});

test('finds experiences that entered, left and moved', () => {
  const diff = diffChart(chart([1, 2, 3]), chart([2, 1, 4]));
  assert.deepEqual(diff.entered.map((e) => e.universeId), [4]);
  assert.deepEqual(diff.left.map((e) => e.universeId), [3]);
  assert.equal(diff.moved, 2);
});

test('a first snapshot counts everything as entered', () => {
  const diff = diffChart(undefined, chart([1, 2]));
  assert.equal(diff.entered.length, 2);
  assert.equal(diff.left.length, 0);
});
