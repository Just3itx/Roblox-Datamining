import assert from 'node:assert/strict';
import { test } from 'node:test';
import { extractScripts } from './rbxm.ts';

test('rejects input that is not an rbxm', () => {
  assert.throws(() => extractScripts(Buffer.from('not a roblox model at all')), /bad magic/);
});

test('an rbxm header with no chunks yields no scripts', () => {
  // magic(8) + signature(6) + version(2) + classCount(4) + instanceCount(4) + reserved(8)
  const header = Buffer.concat([
    Buffer.from('<roblox!', 'latin1'),
    Buffer.from([0x89, 0xff, 0x0d, 0x0a, 0x1a, 0x0a]),
    Buffer.alloc(2 + 4 + 4 + 8),
  ]);
  assert.deepEqual(extractScripts(header), []);
});
