import assert from 'node:assert/strict';
import { test } from 'node:test';
import { extractBundles } from './web.ts';

const HTML = `
<link href="https://css.rbxcdn.com/abcdef0123456789abcdef-Navigation.css" rel="stylesheet">
<link href="https://css.rbxcdn.com/0000111122223333-Footer.css">
<script src="https://js.rbxcdn.com/deadbeefdeadbeef-CoreUtilities.js"></script>
<link href="https://css.rbxcdn.com/9999888877776666.css">        <!-- unnamed: ignored -->
<img src="https://images.rbxcdn.com/xyz.png">                      <!-- wrong host: ignored -->
`;

test('extracts named, hashed css/js bundles and ignores unnamed or off-host urls', () => {
  const bundles = extractBundles([HTML]);
  assert.deepEqual(
    [...bundles.keys()].sort(),
    ['css.rbxcdn.com/Footer.css', 'css.rbxcdn.com/Navigation.css', 'js.rbxcdn.com/CoreUtilities.js'],
  );
  const nav = bundles.get('css.rbxcdn.com/Navigation.css')!;
  assert.equal(nav.hash, 'abcdef0123456789abcdef');
  assert.equal(nav.ext, 'css');
});

test('the same bundle seen on two pages is de-duplicated', () => {
  assert.equal(extractBundles([HTML, HTML]).size, 3);
});
