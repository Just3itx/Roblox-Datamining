import type { Http } from '../core/http.ts';
import type { Block, Section } from '../core/report.ts';
import { sortKeys } from '../core/store.ts';
import { compareStrings, countLabel, errorMessage, escapeCell, formatNumber, mdLink, plural } from '../core/text.ts';
import { mapLimit } from './economy.ts';
import type { Tracker } from './types.ts';

const UA = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120 Safari/537.36';

/** Public Roblox pages to scrape for CSS/JS bundle URLs. */
const PAGES = [
  'https://www.roblox.com/',
  'https://www.roblox.com/discover',
  'https://www.roblox.com/login',
  'https://create.roblox.com/',
];

/** Only these CDN hosts, and only content-hashed, named bundles (…/<hash>-<Name>.<css|js>). */
const BUNDLE_RE =
  /https:\/\/(css\.rbxcdn\.com|js\.rbxcdn\.com|static\.rbxcdn\.com|www-assets\.roblox\.com|assets\.create\.roblox\.com)\/([0-9a-f]{16,})-([A-Za-z0-9_.]+)\.(css|js)/g;

const MANIFEST_FILE = 'web/manifest.json';
const MAX_BYTES = 4 * 1024 * 1024; // don't archive a single bundle larger than this
const CONCURRENCY = 8;

interface Bundle {
  key: string; // "<host>/<Name>.<ext>" — stable across content changes
  host: string;
  name: string;
  ext: 'css' | 'js';
  hash: string;
  url: string;
}

/** Collects the unique named bundles referenced across all the given page HTML blobs. */
export function extractBundles(htmls: string[]): Map<string, Bundle> {
  const bundles = new Map<string, Bundle>();
  for (const html of htmls) {
    for (const match of html.matchAll(BUNDLE_RE)) {
      const [url, host, hash, name, ext] = match;
      const key = `${host}/${name}.${ext}`;
      // Keep the first seen; pages agree on the current hash for a given bundle.
      if (!bundles.has(key)) bundles.set(key, { key, host: host!, name: name!, ext: ext as 'css' | 'js', hash: hash!, url: url! });
    }
  }
  return bundles;
}

const filePath = (b: Bundle) => `web/${b.host}/${b.name}.${b.ext}`;

export const webTracker: Tracker = {
  id: 'web',
  title: 'Website CSS/JS',
  icon: '🌐',
  description: 'Roblox website CSS and JS bundles (css/js.rbxcdn.com, create.roblox.com): content changes per deploy.',

  async run({ http, store, warn, log }) {
    const headers = { 'user-agent': UA };
    const htmls = await Promise.all(
      PAGES.map((page) => http.text(page, headers).catch((error) => (warn(`web: ${page}: ${errorMessage(error)}`), ''))),
    );
    const bundles = extractBundles(htmls);
    if (!bundles.size) {
      warn('web: no bundles found on any page');
      return null;
    }
    log(`web: ${bundles.size} named bundles across ${PAGES.length} pages`);

    const previous = (await store.readJson<Record<string, string>>(MANIFEST_FILE)) ?? {};
    const current: Record<string, string> = {};
    const added: Bundle[] = [];
    const changed: Bundle[] = [];

    await mapLimit([...bundles.values()], CONCURRENCY, async (bundle) => {
      current[bundle.key] = bundle.hash;
      const old = previous[bundle.key];
      if (old === bundle.hash) return; // unchanged — don't re-download
      try {
        const body = await http.text(bundle.url, headers);
        if (body.length <= MAX_BYTES) await store.writeText(filePath(bundle), body);
      } catch (error) {
        warn(`web: ${bundle.name}.${bundle.ext}: ${errorMessage(error)}`);
      }
      (old === undefined ? added : changed).push(bundle);
    });

    await store.writeJson(MANIFEST_FILE, sortKeys(current));
    const removed = Object.keys(previous).filter((key) => !(key in current));

    const firstRun = Object.keys(previous).length === 0;
    if (firstRun) {
      return {
        id: 'web',
        icon: '🌐',
        title: 'Website CSS/JS',
        short: '🌐 Web snapshot',
        headline: `First snapshot of ${plural(bundles.size, 'bundle')}`,
        blocks: [{ type: 'text', text: `Archived ${formatNumber(bundles.size)} named CSS/JS bundles under [\`data/web\`](data/web).` }],
      } satisfies Section;
    }
    if (!added.length && !changed.length && !removed.length) return null;

    const counts = { added: added.length, removed: removed.length, changed: changed.length };
    const row = (b: Bundle) => `${b.host} · ${mdLink(`${b.name}.${b.ext}`, b.url)}`;
    const blocks: Block[] = [];
    if (changed.length) {
      changed.sort((a, b) => compareStrings(a.key, b.key));
      blocks.push({ type: 'text', text: `**Updated**\n${changed.map((b) => `- ${row(b)}`).join('\n')}` });
    }
    if (added.length) {
      added.sort((a, b) => compareStrings(a.key, b.key));
      blocks.push({ type: 'text', text: `**New**\n${added.map((b) => `- ${row(b)}`).join('\n')}` });
    }
    if (removed.length) {
      blocks.push({ type: 'text', text: `**Removed**\n${removed.sort(compareStrings).map((k) => `- ${escapeCell(k)}`).join('\n')}` });
    }

    return {
      id: 'web',
      icon: '🌐',
      title: 'Website CSS/JS',
      short: `🌐 Web ${countLabel(counts)}`,
      headline: `${plural(changed.length, 'bundle')} updated, ${plural(added.length, 'new')}, ${plural(removed.length, 'removed')}`,
      blocks,
    } satisfies Section;
  },
};
