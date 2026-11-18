import { mkdir, writeFile, stat } from 'node:fs/promises';
import { fileURLToPath } from 'node:url';
import { dirname, join, resolve } from 'node:path';
import { Resvg } from '@resvg/resvg-js';

const projectRoot = resolve(dirname(fileURLToPath(import.meta.url)), '..');
const iconDir = join(projectRoot, 'assets', 'icons');
const emojiDir = join(projectRoot, 'assets', 'emoji');

// All glyphs share a 128 px visual area and the same rounded 14 px stroke.
const icons = [
  {
    id: 'versions', color: '#00a2ff',
    glyph: `
      <path d="M128 57c-24 17-31 45-27 90l27 17 27-17c4-45-3-73-27-90Z"/>
      <path d="m100 120-21 19-6 27 29-16m54-30 21 19 6 27-29-16M116 166v17l12 19 12-19v-17"/>
      <circle cx="128" cy="106" r="13"/>`,
  },
  {
    id: 'deploy-history', color: '#3b82f6',
    glyph: `
      <path d="m128 66 52 27v67l-52 27-52-27V93Z"/>
      <path d="m76 93 52 27 52-27m-52 27v67m-26-107 52 27m-26 13 26-13v27"/>`,
  },
  {
    id: 'api-dump', color: '#22c55e',
    glyph: `
      <path d="M76 75h35c-2 4-3 8-3 12a20 20 0 0 0 40 0c0-4-1-8-3-12h35v38c-4-2-8-3-12-3a20 20 0 0 0 0 40c4 0 8-1 12-3v34h-35c2-4 3-8 3-12a20 20 0 0 0-40 0c0 4 1 8 3 12H76v-34c4 2 8 3 12 3a20 20 0 0 0 0-40c-4 0-8 1-12 3Z"/>`,
  },
  {
    id: 'luau', color: '#a855f7',
    glyph: `
      <path d="M91 68h78v98a20 20 0 0 1-20 20H88a19 19 0 0 1-19-19c0-10 8-18 18-18h7V82a14 14 0 0 0-14-14 14 14 0 0 0-14 14v12h28"/>
      <path d="M94 149h59m-39-45h35m-35 23h35m-61 59a19 19 0 0 0 19-19v-18"/>`,
  },
  {
    id: 'fflags', color: '#ef4444',
    glyph: `
      <path d="M76 190V65m0 8c17-12 34-12 51-3s34 9 53-2v75c-19 11-36 11-53 2s-34-9-51 3"/>`,
  },
  {
    id: 'games', color: '#f59e0b',
    glyph: `
      <path d="M87 98h82c19 0 29 11 34 35l8 36c3 15-12 24-24 15l-24-20H93l-24 20c-12 9-27 0-24-15l8-36c5-24 15-35 34-35Z"/>
      <path d="M80 130h32m-16-16v32"/>
      <circle cx="159" cy="124" r="4" fill="currentColor" stroke="none"/>
      <circle cx="179" cy="142" r="4" fill="currentColor" stroke="none"/>`,
  },
  {
    id: 'catalog', color: '#ec4899',
    glyph: `
      <path d="M77 104h102l9 83H68Z"/>
      <path d="M102 111V91a26 26 0 0 1 52 0v20"/>`,
  },
  {
    id: 'limiteds', color: '#dc2626',
    glyph: `
      <path d="m94 74 68 0 29 40-63 78-63-78Z"/>
      <path d="M65 114h126M94 74l-18 40 52 78 52-78-18-40m-68 0 34 40 34-40"/>`,
  },
  {
    id: 'watchlist', color: '#14b8a6',
    glyph: `
      <path d="M44 128c22-32 50-48 84-48s62 16 84 48c-22 32-50 48-84 48s-62-16-84-48Z"/>
      <circle cx="128" cy="128" r="24"/>`,
  },
];

function svgFor({ color, glyph }) {
  return `<svg xmlns="http://www.w3.org/2000/svg" width="256" height="256" viewBox="0 0 256 256">
    <rect width="256" height="256" rx="56" fill="${color}"/>
    <g color="#fff" fill="none" stroke="#fff" stroke-width="14" stroke-linecap="round" stroke-linejoin="round">${glyph}</g>
  </svg>`;
}

function emojiSvgFor({ color, glyph }) {
  return `<svg xmlns="http://www.w3.org/2000/svg" width="128" height="128" viewBox="0 0 256 256">
    <g transform="translate(128 128) scale(0.9) translate(-128 -128)"
       color="${color}" fill="none" stroke="${color}" stroke-width="18"
       stroke-linecap="round" stroke-linejoin="round">${glyph}</g>
  </svg>`;
}

await Promise.all([mkdir(iconDir, { recursive: true }), mkdir(emojiDir, { recursive: true })]);
for (const icon of icons) {
  for (const [dir, svg, size] of [
    [iconDir, svgFor(icon), 256],
    [emojiDir, emojiSvgFor(icon), 128],
  ]) {
    const png = new Resvg(svg, { fitTo: { mode: 'width', value: size } }).render().asPng();
    const path = join(dir, `${icon.id}.png`);
    await writeFile(path, png);
    const { size: bytes } = await stat(path);
    console.log(`${dir === iconDir ? 'assets/icons' : 'assets/emoji'}/${icon.id}.png  ${bytes} bytes`);
  }
}
