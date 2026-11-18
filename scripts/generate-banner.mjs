import { mkdir, readFile, stat, writeFile } from 'node:fs/promises';
import { dirname, join, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';
import { inflateSync } from 'node:zlib';
import { Resvg } from '@resvg/resvg-js';

const width = 1280;
const height = 360;
const root = resolve(dirname(fileURLToPath(import.meta.url)), '..');
const output = join(root, 'assets', 'banner.png');

function mix(hex, other, amount) {
  const a = hex.match(/[\da-f]{2}/gi).map((part) => parseInt(part, 16));
  const b = other.match(/[\da-f]{2}/gi).map((part) => parseInt(part, 16));
  return `#${a.map((value, i) => Math.round(value * (1 - amount) + b[i] * amount)
    .toString(16).padStart(2, '0')).join('')}`;
}

const poly = (points, fill) => `<polygon points="${points}" fill="${fill}"/>`;

function cube(x, y, w, h, d, color, withStud = true) {
  const mid = x + w / 2;
  const top = mix(color, '#ffffff', 0.34);
  const side = mix(color, '#000000', 0.31);
  const faces = [
    poly(`${x},${y} ${mid},${y-d} ${x+w},${y} ${mid},${y+d}`, top),
    poly(`${x},${y} ${mid},${y+d} ${mid},${y+h+d} ${x},${y+h}`, color),
    poly(`${mid},${y+d} ${x+w},${y} ${x+w},${y+h} ${mid},${y+h+d}`, side),
  ];
  if (withStud) {
    const sw = w * 0.28;
    const sx = mid - sw / 2;
    const sy = y - d * 0.22;
    const sd = d * 0.28;
    const sh = Math.max(5, h * 0.15);
    faces.push(
      poly(`${sx},${sy} ${mid},${sy-sd} ${sx+sw},${sy} ${mid},${sy+sd}`,
        mix(color, '#ffffff', 0.58)),
      poly(`${sx},${sy} ${mid},${sy+sd} ${mid},${sy+sd+sh} ${sx},${sy+sh}`,
        mix(color, '#ffffff', 0.29)),
      poly(`${mid},${sy+sd} ${sx+sw},${sy} ${sx+sw},${sy+sh} ${mid},${sy+sd+sh}`,
        mix(color, '#000000', 0.12)),
    );
  }
  return `<g>${faces.join('')}</g>`;
}

// A small, drawn satellite: faceted panels, body, dish, and a short orbital arc.
function satellite() {
  return `<g transform="translate(1122 57) rotate(-24)">
    <path d="M-74 28 A80 80 0 0 1 37 -72" fill="none" stroke="#334155" stroke-width="2" stroke-linecap="round"/>
    <circle cx="-67" cy="23" r="3" fill="#14b8a6"/>
    ${poly('-43,-12 -17,-12 -17,12 -43,12', '#3b82f6')}
    ${poly('-43,-12 -30,-18 -4,-18 -17,-12', '#93c5fd')}
    ${poly('-17,-12 -4,-18 -4,6 -17,12', '#1d4ed8')}
    ${poly('17,-12 43,-12 43,12 17,12', '#3b82f6')}
    ${poly('17,-12 30,-18 56,-18 43,-12', '#93c5fd')}
    ${poly('43,-12 56,-18 56,6 43,12', '#1d4ed8')}
    <path d="M-17 0H-9 M9 0H17" stroke="#94a3b8" stroke-width="4"/>
    ${poly('-9,-12 0,-17 9,-12 9,10 0,15 -9,10', '#dbeafe')}
    ${poly('0,-17 9,-12 9,10 0,15', '#94a3b8')}
    <path d="M0 -17V-27" stroke="#dbeafe" stroke-width="3"/>
    <circle cx="0" cy="-29" r="4" fill="#f59e0b"/>
    <path d="M0 15V25 M-12 28Q0 14 12 28Z" fill="#e2e8f0" stroke="#e2e8f0" stroke-width="2"/>
  </g>`;
}

const title = 'Roblox Datamining';
const subtitle = 'Every build, API change, flag flip & limited — tracked automatically.';

// Used only if system font lookup fails. Rectangles are SVG vector shapes.
const glyphs = {
  R: ['11110','10001','10001','11110','10100','10010','10001'],
  D: ['11110','10001','10001','10001','10001','10001','11110'],
  a: ['00000','01110','00001','01111','10001','10011','01101'],
  b: ['10000','10000','11110','10001','10001','10001','11110'],
  g: ['00000','01111','10001','10001','01111','00001','11110'],
  i: ['00100','00000','01100','00100','00100','00100','01110'],
  l: ['01100','00100','00100','00100','00100','00100','01110'],
  m: ['00000','11010','10101','10101','10101','10101','10101'],
  n: ['00000','11110','10001','10001','10001','10001','10001'],
  o: ['00000','01110','10001','10001','10001','10001','01110'],
  t: ['00100','00100','11111','00100','00100','00100','00011'],
  x: ['00000','10001','01010','00100','01010','10001','10001'],
};

function vectorTitle() {
  const size = 7.3;
  let cursor = 74;
  const parts = [];
  for (const letter of title) {
    if (letter === ' ') { cursor += size * 3.2; continue; }
    glyphs[letter].forEach((row, y) => [...row].forEach((cell, x) => {
      if (cell === '1') parts.push(`<rect x="${cursor + x * size}" y="${111 + y * size}" width="${size}" height="${size}" fill="#ffffff"/>`);
    }));
    cursor += size * 6;
  }
  return parts.join('');
}

function svg(useVectorTitle = false) {
  const cubes = [
    cube(867, 239, 74, 47, 21, '#dc2626'),
    cube(932, 247, 76, 42, 21, '#14b8a6'),
    cube(1010, 237, 87, 51, 23, '#ec4899'),
    cube(1094, 232, 78, 49, 21, '#f59e0b'),
    cube(834, 177, 90, 57, 24, '#22c55e'),
    cube(918, 171, 105, 68, 28, '#00a2ff'),
    cube(1014, 172, 96, 61, 26, '#a855f7'),
    cube(1099, 171, 82, 55, 23, '#ef4444'),
    cube(950, 110, 92, 54, 25, '#3b82f6'),
  ].join('');
  return `<svg xmlns="http://www.w3.org/2000/svg" width="${width}" height="${height}" viewBox="0 0 ${width} ${height}">
    <rect x="0" y="0" width="${width}" height="${height}" rx="28" fill="#0b0f1a"/>
    <path d="M70 82H135" stroke="#00a2ff" stroke-width="5" stroke-linecap="round"/>
    <path d="M144 82H166" stroke="#22c55e" stroke-width="5" stroke-linecap="round"/>
    ${useVectorTitle ? vectorTitle() : `<text x="72" y="164" fill="#ffffff" font-family="Segoe UI, Arial, sans-serif" font-size="62" font-weight="700" letter-spacing="-1.8">${title}</text>`}
    <text x="74" y="211" fill="#cbd5e1" font-family="Segoe UI, Arial, sans-serif" font-size="19" font-weight="400">${subtitle.replace('&', '&amp;')}</text>
    <path d="M73 250H731" stroke="#243044" stroke-width="1"/>
    <circle cx="76" cy="278" r="3" fill="#00a2ff"/>
    <circle cx="92" cy="278" r="3" fill="#22c55e"/>
    <circle cx="108" cy="278" r="3" fill="#a855f7"/>
    <path d="M807 304H1190" stroke="#1e293b" stroke-width="2" stroke-linecap="round"/>
    ${cubes}
    ${satellite()}
  </svg>`;
}

const options = {
  fitTo: { mode: 'width', value: width },
  font: { loadSystemFonts: true, defaultFontFamily: 'Arial' },
};
let rendered = new Resvg(svg(), options).render();
function titlePixels(pixels) {
  let count = 0;
  for (let y = 100; y < 176; y++) {
    for (let x = 72; x < 780; x++) {
      const offset = (y * width + x) * 4;
      if (pixels[offset] > 230 && pixels[offset + 1] > 230 && pixels[offset + 2] > 230 && pixels[offset + 3] > 200) count++;
    }
  }
  return count;
}
if (titlePixels(rendered.pixels) < 500) {
  rendered = new Resvg(svg(true), options).render();
  if (titlePixels(rendered.pixels) < 500) throw new Error('Banner title did not render');
}

await mkdir(dirname(output), { recursive: true });
await writeFile(output, rendered.asPng());

// Re-open the output and inspect its PNG header and decompressed image payload.
const png = await readFile(output);
const signature = Buffer.from([137, 80, 78, 71, 13, 10, 26, 10]);
if (!png.subarray(0, 8).equals(signature)) throw new Error('Output is not a PNG');
const actualWidth = png.readUInt32BE(16);
const actualHeight = png.readUInt32BE(20);
if (actualWidth !== width || actualHeight !== height) throw new Error('Wrong PNG dimensions');
const idat = [];
for (let offset = 8; offset < png.length;) {
  const length = png.readUInt32BE(offset);
  const type = png.toString('ascii', offset + 4, offset + 8);
  if (type === 'IDAT') idat.push(png.subarray(offset + 8, offset + 8 + length));
  offset += 12 + length;
  if (type === 'IEND') break;
}
if (!idat.length || inflateSync(Buffer.concat(idat)).length < width * height) {
  throw new Error('PNG image content is empty');
}
const { size } = await stat(output);
console.log(`${output}  ${actualWidth}x${actualHeight}  ${size} bytes`);
