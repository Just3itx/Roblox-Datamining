import { execFile } from 'node:child_process';
import { mkdtemp, readFile, rm } from 'node:fs/promises';
import { tmpdir } from 'node:os';
import { join } from 'node:path';
import { promisify } from 'node:util';
import { unzipSync, strFromU8 } from 'fflate';
import { diffRecords } from '../core/diff.ts';
import type { Block, DiffLine, Section } from '../core/report.ts';
import { sortKeys } from '../core/store.ts';
import { compareStrings, countLabel, errorMessage, formatNumber, plural } from '../core/text.ts';
import type { Tracker } from './types.ts';

const UA = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/120 Safari/537.36';
// APKPure serves a direct 302 to the APK; the redirect filename carries the version.
const APK_URL = 'https://d.apkpure.com/b/APK/com.roblox.client?version=latest';

const META_FILE = 'android/meta.json';
const MANIFEST_FILE = 'android/files.json';

/** Asset paths whose text content is archived and diffed (the rest is tracked by size in files.json). */
const TEXT_RE = /\.(json|csv|txt|properties|version|lua|luau|md)$/i;
const STORE_RE = /\.(json|csv|txt|properties|version|lua|luau|md|rbxm)$/i;

interface AndroidMeta {
  version: string;
}

// APKPure fingerprints and 403s Node's fetch (TLS), but serves curl fine, so we shell out to curl.
// APKPure also blocks datacenter IPs (incl. GitHub Actions), so an optional proxy list lets it run there.
const run = promisify(execFile);

/** Parses "host:port:user:pass" lines (env APK_PROXIES) into curl -x proxy URLs. "" = direct. */
export function parseProxies(raw: string | undefined): string[] {
  const list = (raw ?? '')
    .split(/[\n,]+/)
    .map((line) => line.trim())
    .filter(Boolean)
    .map((line) => {
      const [host, port, user, pass] = line.split(':');
      if (!host || !port) return undefined;
      return user && pass ? `http://${user}:${pass}@${host}:${port}` : `http://${host}:${port}`;
    })
    .filter((p): p is string => !!p);
  return [...list, '']; // try each proxy, then direct
}

const proxyArgs = (proxy: string) => (proxy ? ['-x', proxy] : []);

function parseVersion(text: string): string | undefined {
  // Only a real download redirect carries "filename=Roblox_2.747.1486…"; a bounce to the homepage doesn't.
  if (!/winudf|filename=Roblox/i.test(text)) return undefined;
  return /Roblox[_ ]([0-9][0-9.]+)/.exec(text)?.[1];
}

/** Finds a proxy (or direct) that APKPure serves, returning it with the current version. */
async function resolveSource(proxies: string[]): Promise<{ proxy: string; version: string } | undefined> {
  for (const proxy of proxies) {
    try {
      const { stdout } = await run(
        'curl',
        [...proxyArgs(proxy), '-s', '-m', '40', '-A', UA, '-o', process.platform === 'win32' ? 'NUL' : '/dev/null', '-w', '%{redirect_url}', APK_URL],
        { maxBuffer: 1 << 20 },
      );
      const version = parseVersion(decodeURIComponent(stdout));
      if (version) return { proxy, version };
    } catch {
      /* try the next proxy */
    }
  }
  return undefined;
}

async function downloadApk(proxy: string): Promise<Uint8Array> {
  const dir = await mkdtemp(join(tmpdir(), 'rbx-apk-'));
  const file = join(dir, 'roblox.apk');
  try {
    await run('curl', [...proxyArgs(proxy), '-sL', '-m', '600', '-A', UA, '-o', file, APK_URL], { maxBuffer: 1 << 20 });
    return new Uint8Array(await readFile(file));
  } finally {
    await rm(dir, { recursive: true, force: true }).catch(() => {});
  }
}

export const androidTracker: Tracker = {
  id: 'android',
  title: 'Android APK',
  icon: '🤖',
  description: 'Roblox Android app assets (configs, translations, .rbxm models, file manifest) from the APK.',

  async run({ store, now, log, warn }) {
    const proxies = parseProxies(process.env.APK_PROXIES);
    const source = await resolveSource(proxies).catch(() => undefined);
    if (!source) {
      warn('android: APKPure unreachable (datacenter IP blocked and no working proxy in APK_PROXIES)');
      return null;
    }
    const { proxy, version } = source;

    const meta = await store.readJson<AndroidMeta>(META_FILE);
    if (meta?.version === version) return null;

    log(`android: new APK ${version} (was ${meta?.version ?? 'none'}) — downloading${proxy ? ' via proxy' : ''}`);
    let apk: Uint8Array;
    try {
      apk = await downloadApk(proxy);
    } catch (error) {
      warn(`android: download failed: ${errorMessage(error)}`);
      return null;
    }

    const entries = unzipSync(apk, { filter: (f) => !f.name.endsWith('/') });
    const names = Object.keys(entries).sort(compareStrings);

    // Full manifest: path → size, so added/removed/resized assets (incl. binaries) are all diffable.
    const sizes: Record<string, string> = {};
    for (const name of names) sizes[name] = String(entries[name]!.length);

    const firstRun = meta === undefined;
    let stored = 0;
    for (const name of names) {
      if (!STORE_RE.test(name)) continue;
      const bytes = entries[name]!;
      const path = `android/apk/${name}`;
      if (TEXT_RE.test(name)) {
        if (await store.writeText(path, strFromU8(bytes))) stored++;
      } else if (await store.writeBytes(path, bytes)) {
        stored++;
      }
    }

    const prevSizes = (await store.readJson<Record<string, string>>(MANIFEST_FILE)) ?? {};
    await store.writeJson(MANIFEST_FILE, sortKeys(sizes));
    await store.writeJson(META_FILE, { version } satisfies AndroidMeta);

    if (firstRun) {
      return {
        id: 'android',
        icon: '🤖',
        title: 'Android APK',
        short: `🤖 Android ${version}`,
        headline: `First snapshot — APK ${version}, ${plural(names.length, 'file')}`,
        blocks: [{ type: 'text', text: `Archived ${formatNumber(stored)} text/model assets + a full manifest under [\`data/android\`](data/android).` }],
      } satisfies Section;
    }

    const diff = diffRecords(prevSizes, sizes);
    const counts = { added: diff.added.length, removed: diff.removed.length, changed: diff.changed.length };
    const line = (op: DiffLine['op'], path: string, extra = '') => ({ op, text: `${path}${extra}` });
    const lines: DiffLine[] = [
      ...diff.added.map(([p, s]) => line('+', p, ` (${formatNumber(Number(s))} b)`)),
      ...diff.removed.map(([p]) => line('-', p)),
      ...diff.changed.map(([p, a, b]) => line(' ', p, `: ${formatNumber(Number(a))} → ${formatNumber(Number(b))} b`)),
    ];

    const blocks: Block[] = [{ type: 'text', text: `APK **${version}** (was ${meta?.version})` }];
    if (lines.length) blocks.push({ type: 'diff', title: `Asset changes (${lines.length})`, lines, open: lines.length <= 50 });

    return {
      id: 'android',
      icon: '🤖',
      title: 'Android APK',
      short: `🤖 Android ${version}`,
      headline: `APK ${version}: ${countLabel(counts)} files`,
      blocks,
    } satisfies Section;
  },
};
