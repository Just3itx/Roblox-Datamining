import assert from 'node:assert/strict';
import { test } from 'node:test';
import { mapLimit } from './economy.ts';

test('mapLimit preserves order and respects the concurrency cap', async () => {
  let active = 0;
  let peak = 0;
  const out = await mapLimit([1, 2, 3, 4, 5, 6, 7], 3, async (n) => {
    active++;
    peak = Math.max(peak, active);
    await new Promise((r) => setTimeout(r, 5));
    active--;
    return n * 2;
  });
  assert.deepEqual(out, [2, 4, 6, 8, 10, 12, 14]);
  assert.ok(peak <= 3, `peak concurrency ${peak} exceeded 3`);
});
