import { mkdir, writeFile, stat } from 'node:fs/promises';
import { fileURLToPath } from 'node:url';
import { dirname, join, resolve } from 'node:path';
import { Resvg } from '@resvg/resvg-js';

const root = resolve(dirname(fileURLToPath(import.meta.url)), '..');
const iconDir = join(root, 'assets', 'icons');
const emojiDir = join(root, 'assets', 'emoji');
const poly = (points, face) => `<polygon points="${points}" fill="${face}"/>`;
const rect = (x, y, w, h, face, rx = 0) =>
  `<rect x="${x}" y="${y}" width="${w}" height="${h}" rx="${rx}" fill="${face}"/>`;
const cube = (x, y, w, h, d = 14) => `
  ${poly(`${x},${y} ${x+w/2},${y-d} ${x+w},${y} ${x+w/2},${y+d}`, 'top')}
  ${poly(`${x},${y} ${x+w/2},${y+d} ${x+w/2},${y+h+d} ${x},${y+h}`, 'mid')}
  ${poly(`${x+w/2},${y+d} ${x+w},${y} ${x+w},${y+h} ${x+w/2},${y+h+d}`, 'side')}`;
const stud = (x, y, w = 20, h = 9) => `
  ${poly(`${x},${y} ${x+w/2},${y-5} ${x+w},${y} ${x+w/2},${y+5}`, 'shine')}
  ${poly(`${x},${y} ${x+w/2},${y+5} ${x+w/2},${y+h+5} ${x},${y+h}`, 'top')}
  ${poly(`${x+w/2},${y+5} ${x+w},${y} ${x+w},${y+h} ${x+w/2},${y+h+5}`, 'mid')}`;

// Filled, faceted glyphs share geometry between the two output sets.
const icons = [
  { id: 'versions', color: '#00a2ff', glyph: `
    ${poly('103,149 78,162 65,194 106,181','side')}
    ${poly('153,149 178,162 191,194 150,181','mid')}
    ${poly('109,169 128,184 147,169 147,193 128,210 109,193','shine')}
    ${poly('110,82 128,54 146,82 146,166 128,182 110,166','top')}
    ${poly('110,82 128,95 128,182 110,166','mid')}
    ${poly('128,95 146,82 146,166 128,182','side')}
    ${poly('110,82 128,54 128,95','shine')}
    ${poly('119,114 128,108 137,114 137,134 128,140 119,134','shine')}
    ${poly('128,108 137,114 137,134 128,140','top')}` },
  { id: 'deploy-history', color: '#3b82f6', glyph: `
    ${cube(59,130,74,53,18)}${cube(123,130,74,53,18)}${cube(91,79,74,53,18)}
    ${poly('117,68 129,64 129,98 117,103','shine')}
    ${poly('91,79 128,97 165,79 153,73 128,85 103,73','shine')}
    ${poly('80,139 91,134 91,164 80,169','top')}
    ${poly('144,139 155,134 155,164 144,169','top')}` },
  { id: 'api-dump', color: '#22c55e', glyph: `
    ${cube(65,103,126,75,29)}${stud(89,76,29,12)}${stud(139,76,29,12)}
    ${poly('65,103 128,132 191,103 172,95 128,114 84,95','shine')}
    ${poly('108,145 128,155 128,190 108,180','top')}
    ${poly('128,155 148,145 148,180 128,190','dark')}
    ${poly('160,145 177,137 177,163 160,171','mid')}` },
  { id: 'luau', color: '#a855f7', glyph: `
    ${cube(62,89,132,90,22)}
    ${poly('62,89 128,111 194,89 176,83 128,99 80,83','shine')}
    ${poly('82,125 103,116 103,126 92,131 103,136 103,146 82,137','shine')}
    ${poly('110,147 119,114 130,119 121,152','top')}
    ${poly('137,125 158,134 137,145 137,135 148,133 137,128','shine')}
    ${poly('153,151 176,140 176,149 153,160','top')}` },
  { id: 'fflags', color: '#ef4444', glyph: `
    ${cube(61,160,134,35,19)}${stud(77,144,25,9)}${stud(154,144,25,9)}
    ${rect(92,62,14,106,'shine')}
    ${poly('106,66 174,79 162,110 174,137 106,124','top')}
    ${poly('106,66 126,70 126,128 106,124','mid')}
    ${poly('126,70 174,79 162,110 174,137 126,128','side')}` },
  { id: 'games', color: '#f59e0b', glyph: `
    ${poly('62,110 87,96 169,96 194,110 207,159 194,183 171,170 85,170 62,183 49,159','top')}
    ${poly('49,159 62,183 85,170 171,170 194,183 207,159 207,174 194,198 171,185 85,185 62,198 49,174','side')}
    ${poly('62,110 87,96 169,96 194,110 177,126 79,126','shine')}
    ${rect(83,130,45,14,'dark',2)}${rect(99,114,14,46,'dark',2)}
    ${poly('154,128 164,123 174,128 164,133','dark')}
    ${poly('175,147 185,142 195,147 185,152','dark')}
    ${poly('145,150 155,145 165,150 155,155','mid')}` },
  { id: 'catalog', color: '#ec4899', glyph: `
    ${poly('72,91 128,69 184,91 184,178 128,201 72,178','top')}
    ${poly('72,91 128,113 128,201 72,178','mid')}
    ${poly('128,113 184,91 184,178 128,201','side')}
    ${poly('72,91 128,69 184,91 128,113','shine')}
    ${poly('98,78 98,61 112,52 126,57 140,52 155,60 155,80 143,85 143,66 128,63 110,66 110,83','top')}
    ${poly('146,133 169,122 183,133 183,153 160,165 146,154','shine')}
    ${poly('160,165 183,153 183,164 160,176 146,165 146,154','mid')}
    ${poly('157,139 164,136 168,140 164,144','dark')}` },
  { id: 'limiteds', color: '#dc2626', glyph: `
    ${poly('91,75 165,75 194,111 128,198 62,111','mid')}
    ${poly('91,75 128,92 165,75 194,111 128,124 62,111','shine')}
    ${poly('62,111 98,116 128,198','side')}
    ${poly('98,116 128,124 128,198','top')}
    ${poly('128,124 158,116 128,198','mid')}
    ${poly('158,116 194,111 128,198','dark')}
    ${poly('91,75 128,92 98,116 62,111','top')}
    ${poly('128,92 165,75 194,111 158,116','side')}` },
  { id: 'watchlist', color: '#14b8a6', glyph: `
    ${cube(65,99,126,74,24)}${stud(90,72,26,10)}${stud(142,72,26,10)}
    ${poly('72,147 105,119 128,115 151,119 184,147 151,175 128,179 105,175','shine')}
    ${poly('72,147 105,175 128,179 128,147','mid')}
    ${poly('128,147 128,179 151,175 184,147','top')}
    ${poly('106,147 128,130 150,147 128,164','dark')}
    ${poly('118,142 128,135 138,142 128,149','shine')}` },
];

function mix(hex, other, amount) {
  const a = hex.match(/[\da-f]{2}/gi).map((part) => parseInt(part, 16));
  const b = other.match(/[\da-f]{2}/gi).map((part) => parseInt(part, 16));
  return `#${a.map((value, i) => Math.round(value * (1 - amount) + b[i] * amount)
    .toString(16).padStart(2, '0')).join('')}`;
}

function svgFor({ color, glyph }, emoji) {
  const palette = emoji
    ? { shine: mix(color, '#ffffff', 0.55), top: mix(color, '#ffffff', 0.32),
        mid: color, side: mix(color, '#000000', 0.24), dark: mix(color, '#000000', 0.43) }
    : { shine: '#ffffff', top: '#f4f8ff', mid: '#e3edfa',
        side: '#c8d9ee', dark: '#9cb9dc' };
  const shapes = glyph.replace(/fill="(shine|top|mid|side|dark)"/g,
    (_, face) => `fill="${palette[face]}"`);
  const background = emoji ? '' : `<rect width="256" height="256" rx="56" fill="${color}"/>`;
  const transform = emoji ? ' transform="translate(128 128) scale(0.82) translate(-128 -128)"' : '';
  return `<svg xmlns="http://www.w3.org/2000/svg" width="${emoji ? 128 : 256}"
    height="${emoji ? 128 : 256}" viewBox="0 0 256 256">${background}<g${transform}>${shapes}</g></svg>`;
}

await Promise.all([mkdir(iconDir, { recursive: true }), mkdir(emojiDir, { recursive: true })]);
for (const icon of icons) {
  for (const [dir, emoji, size] of [[iconDir, false, 256], [emojiDir, true, 128]]) {
    const png = new Resvg(svgFor(icon, emoji), { fitTo: { mode: 'width', value: size } }).render().asPng();
    const path = join(dir, `${icon.id}.png`);
    await writeFile(path, png);
    const { size: bytes } = await stat(path);
    console.log(`${dir === iconDir ? 'assets/icons' : 'assets/emoji'}/${icon.id}.png  ${bytes} bytes`);
  }
}
