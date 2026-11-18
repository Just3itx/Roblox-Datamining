import { createHash } from 'node:crypto';
import { readdirSync } from 'node:fs';
import { readFile } from 'node:fs/promises';
import { join } from 'node:path';
import { diffRecords } from '../core/diff.ts';
import type { Block, Section } from '../core/report.ts';
import { compareStrings, countLabel, errorMessage, escapeCell, formatNumber, plural } from '../core/text.ts';
import { sortKeys } from '../core/store.ts';
import { extractScripts } from './rbxm.ts';
import type { Tracker } from './types.ts';

// Reads the .rbxm models the Android tracker archived and extracts their scripts.
const RBXM_ROOT = 'android/apk';
// path -> "L:<hash>" (plaintext) or "B:<hash>" (bytecode, pending decompile). Small + fully diffable.
const MANIFEST_FILE = 'scripts/manifest.json';

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
    let plaintext = 0;
    let bytecode = 0;

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
        if (script.kind === 'lua') {
          plaintext++;
          manifest[key] = `L:${hash12(script.content)}`;
          await store.writeText(luaPath(script.path), new TextDecoder().decode(script.content));
        } else {
          bytecode++;
          manifest[key] = `B:${hash12(script.content)}`; // decompiled .lua filled in later by Luacid
        }
      }
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
    if (!added.length && !removed.length && !changedContent.length) return null;

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
      blocks,
    } satisfies Section;
  },
};
