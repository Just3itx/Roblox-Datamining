import type { Http } from '../core/http.ts';
import type { Block, DiffLine, Section } from '../core/report.ts';
import { compareStrings, escapeCell, formatNumber, mdCode, mdLink, plural } from '../core/text.ts';
import type { Tracker } from './types.ts';

/**
 * Desktop CoreScripts/Luau aren't shipped as source on the Roblox CDN (they're compiled
 * into the client), so this tracks the long-running community mirror that extracts them,
 * and reports which script files changed with links back to the source.
 */
const MIRROR = { owner: 'MaximumADHD', repo: 'Roblox-Client-Tracker', branch: 'roblox' } as const;

/** Directories in the mirror that hold Luau / CoreScript source. */
const SCRIPT_DIRS = ['scripts/', 'LuaPackages/', 'CompiledPackages/', 'BuiltInPlugins/', 'BuiltInStandalonePlugins/'];

const STATE_FILE = 'luau/state.json';
const MAX_LISTED = 80;

interface LuauState {
  commit: string;
  version: string;
}

interface GhCommit {
  sha: string;
  commit: { author: { date: string } };
}

interface GhCompareFile {
  filename: string;
  status: 'added' | 'removed' | 'modified' | 'renamed' | 'changed';
  previous_filename?: string;
  blob_url?: string;
}

interface GhCompare {
  files?: GhCompareFile[];
  total_commits: number;
}

function ghHeaders(): Record<string, string> {
  const token = process.env.GITHUB_TOKEN ?? process.env.GH_TOKEN;
  return {
    accept: 'application/vnd.github+json',
    'x-github-api-version': '2022-11-28',
    ...(token ? { authorization: `Bearer ${token}` } : {}),
  };
}

const apiBase = `https://api.github.com/repos/${MIRROR.owner}/${MIRROR.repo}`;
const isScript = (path: string) => SCRIPT_DIRS.some((dir) => path.startsWith(dir));

async function readVersion(http: Http, sha: string): Promise<string> {
  try {
    const raw = `https://raw.githubusercontent.com/${MIRROR.owner}/${MIRROR.repo}/${sha}/version.txt`;
    return (await http.text(raw)).trim();
  } catch {
    return '';
  }
}

const statusMark = (status: GhCompareFile['status']): DiffLine['op'] =>
  status === 'added' ? '+' : status === 'removed' ? '-' : ' ';

export const luauTracker: Tracker = {
  id: 'luau',
  title: 'CoreScripts (Luau)',
  icon: '📜',
  description: "Roblox client Luau/CoreScript changes, via the MaximumADHD client-tracker mirror.",

  async run({ http, store, log }) {
    const head = await http.json<GhCommit>(`${apiBase}/commits/${MIRROR.branch}`, ghHeaders());
    const state = await store.readJson<LuauState>(STATE_FILE);
    if (state?.commit === head.sha) return null;

    const version = await readVersion(http, head.sha);
    await store.writeJson(STATE_FILE, { commit: head.sha, version } satisfies LuauState);

    const compareUrl = `https://github.com/${MIRROR.owner}/${MIRROR.repo}/compare/${state?.commit ?? ''}...${head.sha}`;
    if (!state) {
      return {
        id: 'luau',
        icon: '📜',
        title: 'CoreScripts (Luau)',
        short: '📜 CoreScripts snapshot',
        headline: `Tracking mirror at ${mdCode(head.sha.slice(0, 7))}${version ? ` (Roblox ${version})` : ''}`,
        blocks: [{ type: 'text', text: `Source: ${mdLink(`${MIRROR.owner}/${MIRROR.repo}@${MIRROR.branch}`, `https://github.com/${MIRROR.owner}/${MIRROR.repo}/tree/${MIRROR.branch}`)}` }],
      } satisfies Section;
    }

    log(`luau: comparing ${state.commit.slice(0, 7)}…${head.sha.slice(0, 7)}`);
    const diff = await http.json<GhCompare>(
      `${apiBase}/compare/${state.commit}...${head.sha}?per_page=300`,
      ghHeaders(),
    );
    const scriptFiles = (diff.files ?? []).filter((f) => isScript(f.filename)).sort((a, b) => compareStrings(a.filename, b.filename));
    if (!scriptFiles.length) {
      log('luau: mirror moved but no script files changed');
      return null;
    }

    const counts = { added: 0, removed: 0, changed: 0 };
    for (const file of scriptFiles) {
      if (file.status === 'added') counts.added++;
      else if (file.status === 'removed') counts.removed++;
      else counts.changed++;
    }

    const lines: DiffLine[] = scriptFiles.slice(0, MAX_LISTED).map((f) => ({ op: statusMark(f.status), text: f.filename }));
    const blocks: Block[] = [
      { type: 'text', text: `Roblox ${version ? mdCode(version) : '(unknown)'} · ${mdLink('full diff', compareUrl)}` },
      {
        type: 'table',
        columns: ['Added', 'Removed', 'Modified'],
        rows: [[formatNumber(counts.added), formatNumber(counts.removed), formatNumber(counts.changed)]],
      },
      { type: 'diff', title: `Changed script files (${formatNumber(scriptFiles.length)})`, lines, open: scriptFiles.length <= 40 },
    ];
    if (scriptFiles.length > MAX_LISTED) {
      blocks.push({ type: 'text', text: `<sub>Showing ${MAX_LISTED} of ${formatNumber(scriptFiles.length)} — see the ${mdLink('full diff', compareUrl)}.</sub>` });
    }

    const headline = `${[counts.added && `+${counts.added}`, counts.removed && `−${counts.removed}`, counts.changed && `~${counts.changed}`].filter(Boolean).join(' ')} script files${version ? ` (Roblox ${version})` : ''}`;
    return {
      id: 'luau',
      icon: '📜',
      title: 'CoreScripts (Luau)',
      short: `📜 CoreScripts ${escapeCell(headline.split(' script')[0]!)}`,
      headline,
      blocks,
    } satisfies Section;
  },
};
