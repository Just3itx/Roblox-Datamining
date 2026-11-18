import assert from 'node:assert/strict';
import { test } from 'node:test';
import { proxyCandidates } from './http.ts';

test('no proxies configured: only the direct url', () => {
  assert.deepEqual(proxyCandidates('https://catalog.roblox.com/v2/x?y=1', []), ['https://catalog.roblox.com/v2/x?y=1']);
});

test('proxyable host: each proxy first, then direct, preserving path and query', () => {
  assert.deepEqual(proxyCandidates('https://catalog.roblox.com/v2/x?y=1', ['roproxy.com', 'rotunnel.com']), [
    'https://catalog.roproxy.com/v2/x?y=1',
    'https://catalog.rotunnel.com/v2/x?y=1',
    'https://catalog.roblox.com/v2/x?y=1',
  ]);
});

test('non-proxyable hosts are left direct', () => {
  // clientsettingscdn isn't mirrored; rbxcdn and github aren't roblox.com at all.
  for (const url of [
    'https://clientsettingscdn.roblox.com/v2/settings/application/PCDesktopClient',
    'https://setup.rbxcdn.com/version-abc-Full-API-Dump.json',
    'https://api.github.com/repos/x/y/commits/main',
  ]) {
    assert.deepEqual(proxyCandidates(url, ['roproxy.com']), [url]);
  }
});

test('economy host is proxied', () => {
  assert.deepEqual(proxyCandidates('https://economy.roblox.com/v2/assets/1/details', ['roproxy.com']), [
    'https://economy.roproxy.com/v2/assets/1/details',
    'https://economy.roblox.com/v2/assets/1/details',
  ]);
});
