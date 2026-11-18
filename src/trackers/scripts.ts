import { createHash } from 'node:crypto';
import { readdirSync } from 'node:fs';
import { readFile } from 'node:fs/promises';
import { join } from 'node:path';
import { diffRecords } from '../core/diff.ts';
import type { Block, Section } from '../core/report.ts';
import { compareStrings, countLabel, errorMessage, escapeCell, formatNumber, plural } from '../core/text.ts';
import { sortKeys } from '../core/store.ts';
import { parseProxies } from './android.ts';
import { decompile, LuacidBlocked } from './luacid.ts';
import { extractScripts } from './rbxm.ts';
import type { Tracker } from './types.ts';

// Reads the .rbxm models the Android tracker archived and extracts their scripts.
const RBXM_ROOT = 'android/apk';
// path -> "L:<hash>" (plaintext) or "B:<hash>" (bytecode, pending decompile). Small + fully diffable.
const MANIFEST_FILE = 'scripts/manifest.json';
// path -> hash of the bytecode we've already decompiled to .lua (so unchanged scripts are never redone).
const DECOMPILED_FILE = 'scripts/decompiled.json';
const LUACID_MAX_BYTES = 512 * 1024; // keyless file cap
const sleep = (ms: number) => new Promise<void>((r) => setTimeout(r, ms));

/** Safe path segment: no "..", no leading slash, collapse odd chars. */
const safe = (segment: string) => segment.replace(/[\\/]+/g, '_').replace(/\.\.+/g, '.').trim() || '_';
const luaPath = (treePath: string) => `scripts/${treePath.split('/').map(safe).join('/')}.lua`;
const hash12 = (content: Uint8Array) => createHash('sha256').update(content).digest('hex').slice(0, 12);

function findRbxm(root: string): string[] {
  try {
    return readdirSync(root, { recursive: true, encoding: 'utf8' })
      .filter((f) => f.endsWith('.rbxm'))
      .map((f) => f.replace(/\\/g, '/'));
  } catch {
    return [];
  }
}

export const scriptsTracker: Tracker = {
  id: 'scripts',
  title: 'Client scripts',
  icon: '📜',
  description: 'Scripts extracted from the Android .rbxm models: plaintext as .lua, bytecode tracked by hash (decompiled via Luacid).',

  async run({ store, log, warn }) {
    const rbxmFiles = findRbxm(store.path(RBXM_ROOT));
    if (!rbxmFiles.length) return null; // android tracker hasn't run yet
    log(`scripts: scanning ${rbxmFiles.length} rbxm models`);

    // Manifest keeps the repo small: raw bytecode (hundreds of MB) is NOT stored, only its hash.
    const manifest: Record<string, string> = {};
    const decompiled = (await store.readJson<Record<string, string>>(DECOMPILED_FILE)) ?? {};
    const budget = Math.max(0, Number(process.env.LUACID_BUDGET ?? '40') || 0);
    const pending: Array<{ key: string; treePath: string; hash: string; content: Uint8Array }> = [];
    let plaintext = 0;
    let bytecode = 0;
    let pendingTotal = 0;

    for (const rel of rbxmFiles) {
      let scripts: ReturnType<typeof extractScripts>;
      try {
        scripts = extractScripts(await readFile(join(store.path(RBXM_ROOT), rel)));
      } catch (error) {
        // Some .rbxm (e.g. avatar character models) aren't binary-format — skip quietly.
        if (!errorMessage(error).includes('bad magic')) warn(`scripts: ${rel}: ${errorMessage(error)}`);
        continue;
      }
      for (const script of scripts) {
        const key = script.path.split('/').map(safe).join('/');
        if (key in manifest) continue; // duplicate tree path across models — keep first
        const hash = hash12(script.content);
        if (script.kind === 'lua') {
          plaintext++;
          manifest[key] = `L:${hash}`;
          await store.writeText(luaPath(script.path), new TextDecoder().decode(script.content));
        } else {
          bytecode++;
          manifest[key] = `B:${hash}`;
          // Needs (re)decompiling if we haven't produced its current .lua yet.
          // Strip the 8-byte header before the raw Luau bytecode that Luacid expects.
          if (decompiled[key] !== hash && script.content.length > 8 && script.content.length <= LUACID_MAX_BYTES) {
            pendingTotal++;
            if (pending.length < budget) pending.push({ key, treePath: script.path, hash, content: script.content.subarray(8) });
          }
        }
      }
    }

    // Decompile a bounded batch per run (Luacid keyless ~60/min), newest changes first.
    let decompiledNow = 0;
    if (budget > 0 && pending.length > 0) {
      const key = process.env.LUACID_KEY;
      const [proxy] = parseProxies(process.env.LUACID_PROXY); // default '' (direct); set to route past Cloudflare
      log(`scripts: decompiling up to ${pending.length} script(s) via Luacid${key ? ' (keyed)' : ' (keyless)'}`);
      for (const item of pending) {
        try {
          const source = await decompile(item.content, { ...(key ? { key } : {}), ...(proxy ? { proxy } : {}) });
          await store.writeText(luaPath(item.treePath), source.endsWith('\n') ? source : `${source}\n`);
          decompiled[item.key] = item.hash;
          decompiledNow++;
          await sleep(key ? 550 : 1100); // stay under the rate limit
        } catch (error) {
          if (error instanceof LuacidBlocked) {
            warn(`scripts: Luacid unavailable, skipping decompile this run (${errorMessage(error)}). Set LUACID_KEY.`);
            break;
          }
          warn(`scripts: decompile ${item.key}: ${errorMessage(error)}`);
        }
      }
      if (decompiledNow > 0) await store.writeJson(DECOMPILED_FILE, sortKeys(decompiled));
    }

    const previous = (await store.readJson<Record<string, string>>(MANIFEST_FILE)) ?? {};
    await store.writeJson(MANIFEST_FILE, sortKeys(manifest));
    const diff = diffRecords(previous, manifest);
    const added = diff.added.map(([k]) => k);
    const changedContent = diff.changed.map(([k]) => k);
    const removed = diff.removed.map(([k]) => k);
    // Clean up plaintext .lua files for scripts that are gone.
    for (const key of removed) await store.writeText(`scripts/${key}.lua`, '').catch(() => {});

    const firstRun = Object.keys(previous).length === 0;
    if (firstRun) {
      return {
        id: 'scripts',
        icon: '📜',
        title: 'Client scripts',
        short: `📜 ${formatNumber(Object.keys(manifest).length)} scripts`,
        headline: `First snapshot — ${formatNumber(Object.keys(manifest).length)} scripts (${formatNumber(plaintext)} plaintext, ${formatNumber(bytecode)} bytecode pending decompile)`,
        blocks: [{ type: 'text', text: `Tracked in [\`scripts/manifest.json\`](data/scripts/manifest.json); plaintext under [\`data/scripts\`](data/scripts). Bytecode is decompiled via Luacid incrementally.` }],
      } satisfies Section;
    }

    const counts = { added: added.length, removed: removed.length, changed: changedContent.length };
    const decompileNote = pendingTotal
      ? `\n\n🔓 Decompiled ${formatNumber(decompiledNow)} this run · ${formatNumber(Math.max(0, pendingTotal - decompiledNow))} still pending.`
      : '';
    if (!added.length && !removed.length && !changedContent.length) {
      if (decompiledNow === 0) return null;
      return {
        id: 'scripts', icon: '📜', title: 'Client scripts', short: `📜 Decompiled ${formatNumber(decompiledNow)}`,
        headline: `Decompiled ${formatNumber(decompiledNow)} script(s), ${formatNumber(Math.max(0, pendingTotal - decompiledNow))} pending`,
        blocks: [{ type: 'text', text: 'Backfilling readable Luau via Luacid.' }],
      } satisfies Section;
    }

    const sample = (paths: string[], n = 25) =>
      paths.slice(0, n).map((p) => `- ${escapeCell(p.replace(/^scripts\//, ''))}`).join('\n') +
      (paths.length > n ? `\n- …and ${formatNumber(paths.length - n)} more` : '');
    const blocks: Block[] = [];
    if (added.length) blocks.push({ type: 'text', text: `**🆕 Added (${formatNumber(added.length)})**\n${sample(added.sort(compareStrings))}` });
    if (changedContent.length) blocks.push({ type: 'text', text: `**✏️ Changed (${formatNumber(changedContent.length)})**\n${sample(changedContent.sort(compareStrings))}` });
    if (removed.length) blocks.push({ type: 'text', text: `**🗑️ Removed (${formatNumber(removed.length)})**\n${sample(removed.sort(compareStrings))}` });

    return {
      id: 'scripts',
      icon: '📜',
      title: 'Client scripts',
      short: `📜 Scripts ${countLabel(counts)}`,
      headline: `${plural(added.length, 'script')} added, ${plural(changedContent.length, 'changed')}, ${plural(removed.length, 'removed')}`,
      blocks: decompileNote ? [...blocks, { type: 'text', text: decompileNote.trim() }] : blocks,
    } satisfies Section;
  },
};
