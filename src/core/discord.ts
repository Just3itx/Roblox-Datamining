import { readFile } from 'node:fs/promises';
import type { Block, RunProblem, Section } from './report.ts';
import { truncate } from './text.ts';

/**
 * Maps each tracker to a Discord webhook URL. Keep this file OFF GitHub (it holds secrets):
 * it lives locally and is read by the miner when run with --discord.
 */
export interface DiscordConfig {
  /** Fallback webhook for any tracker without its own mapping. */
  default?: string;
  /** Per-tracker webhook URLs, keyed by tracker id (versions, deploy-history, api-dump, luau, fflags, games, catalog). */
  trackers?: Record<string, string>;
  /** Optional webhook for run problems / errors. */
  log?: string;
  username?: string;
  avatarUrl?: string;
}

/** Roblox-ish accent colors per tracker (Discord embed color is a decimal int). */
const COLORS: Record<string, number> = {
  versions: 0x00a2ff,
  'deploy-history': 0x3b82f6,
  'api-dump': 0x22c55e,
  luau: 0xa855f7,
  fflags: 0xef4444,
  games: 0xf59e0b,
  catalog: 0xec4899,
  limiteds: 0xdc2626,
  watchlist: 0x14b8a6,
};

// Discord "Components V2": a Container (type 17) with an accent bar, holding Text Displays
// (type 10) and Separators (type 14). Requires the IS_COMPONENTS_V2 flag and ?with_components=true.
const V2_FLAG = 1 << 15;
const TEXT_DISPLAY = 10;
const SEPARATOR = 14;
const CONTAINER = 17;
const TOTAL_BUDGET = 3600; // keep well under Discord's 4000-char components limit
const sleep = (ms: number) => new Promise<void>((r) => setTimeout(r, ms));

export async function loadDiscordConfig(path: string): Promise<DiscordConfig | undefined> {
  try {
    return JSON.parse(await readFile(path, 'utf8')) as DiscordConfig;
  } catch (error) {
    if ((error as NodeJS.ErrnoException).code === 'ENOENT') return undefined;
    throw error;
  }
}

export function webhookFor(config: DiscordConfig, trackerId: string): string | undefined {
  return config.trackers?.[trackerId] ?? config.default;
}

const stripHtml = (text: string) =>
  text
    .replace(/<sub>|<\/sub>/g, '')
    .replace(/<\/?details[^>]*>|<\/?summary>/g, '')
    .trim();

/** Undo the markdown-table escaping so cells read cleanly in a Discord text display. */
const uncell = (cell: string) => cell.replace(/\\([|\\])/g, '$1');

// ── ANSI colouring (Discord renders ```ansi code blocks) ────────────────────────
const ESC = '\u001b';
const GREEN = `${ESC}[0;32m`;
const RED = `${ESC}[0;31m`;
const YELLOW = `${ESC}[0;33m`;
const RESET = `${ESC}[0m`;
const fence = (text: string) => text.replace(/```/g, 'ˋˋˋ');

function ansiLine(op: ' ' | '+' | '-', text: string): string {
  const t = fence(text);
  if (op === '+') return `${GREEN}+ ${t}${RESET}`;
  if (op === '-') return `${RED}- ${t}${RESET}`;
  if (t.includes('→')) return `${YELLOW}${t}${RESET}`;
  return t;
}

/** Renders diff lines as an ```ansi block, trimmed to fit `budget` characters. */
export function ansiDiff(lines: Array<{ op: ' ' | '+' | '-'; text: string }>, title: string, budget: number): string {
  const out: string[] = [];
  let used = title.length + 20;
  let shown = 0;
  for (const line of lines) {
    const rendered = ansiLine(line.op, line.text);
    if (used + rendered.length > budget && shown > 0) break;
    out.push(rendered);
    used += rendered.length + 1;
    shown++;
  }
  const hidden = lines.length - shown;
  if (hidden > 0) out.push(`${YELLOW}… +${hidden} more (see commit)${RESET}`);
  return `**${title}**\n\`\`\`ansi\n${out.join('\n')}\n\`\`\``;
}

function tableToText(block: Extract<Block, { type: 'table' }>): string {
  const headerless = block.columns[0] === '';
  const rows = block.rows.slice(0, 16).map((r) => `• ${r.map(uncell).filter(Boolean).join('  ·  ')}`);
  const extra = block.rows.length > 16 ? [`• … +${block.rows.length - 16} more`] : [];
  const head = headerless ? [] : [`-# ${block.columns.filter(Boolean).join('  ·  ')}`];
  return [...head, ...rows, ...extra].join('\n');
}

function td(content: string): { type: number; content: string } {
  return { type: TEXT_DISPLAY, content };
}

/** Builds a Components V2 Container for one section, within the char budget. */
export function sectionToContainer(section: Section, options: { now: Date; version?: string }): object {
  const children: Array<object> = [td(`## ${section.icon} ${section.title}\n**${section.headline}**`)];
  let budget = TOTAL_BUDGET - section.title.length - section.headline.length;

  for (const block of section.blocks) {
    if (budget <= 0) break;
    let content: string;
    if (block.type === 'text') content = stripHtml(block.text);
    else if (block.type === 'table') content = tableToText(block);
    else content = ansiDiff(block.lines, block.title, Math.min(budget, 1700));
    if (!content.trim()) continue;
    content = truncate(content, budget);
    children.push({ type: SEPARATOR }, td(content));
    budget -= content.length;
  }

  const footer = `-# 🛰️ Roblox Datamining${options.version ? ` · ${options.version}` : ''} · <t:${Math.floor(options.now.getTime() / 1000)}:R>`;
  children.push({ type: SEPARATOR }, td(footer));
  return { type: CONTAINER, accent_color: COLORS[section.id] ?? 0x5865f2, components: children };
}

async function post(url: string, payload: unknown): Promise<void> {
  for (let attempt = 0; attempt < 5; attempt++) {
    const response = await fetch(url, {
      method: 'POST',
      headers: { 'content-type': 'application/json' },
      body: JSON.stringify(payload),
      signal: AbortSignal.timeout(30_000),
    });
    if (response.status === 429) {
      const body = (await response.json().catch(() => ({}))) as { retry_after?: number };
      await sleep(Math.min((body.retry_after ?? 1) * 1000 + 250, 10_000));
      continue;
    }
    if (!response.ok && response.status >= 500) {
      await sleep(1000 * (attempt + 1));
      continue;
    }
    if (!response.ok) throw new Error(`Discord ${response.status}: ${(await response.text().catch(() => '')).slice(0, 200)}`);
    return;
  }
  throw new Error('Discord: giving up after repeated rate limits');
}

/** Webhooks must opt into Components V2 with this query param. */
const withComponents = (url: string) => `${url}${url.includes('?') ? '&' : '?'}with_components=true`;

export interface DiscordResult {
  posted: number;
  skipped: string[];
}

/** Posts one accent-coloured container per changed section to its mapped webhook. */
export async function postSections(
  sections: Section[],
  config: DiscordConfig,
  options: { now: Date; version?: string },
): Promise<DiscordResult> {
  const result: DiscordResult = { posted: 0, skipped: [] };
  const base = { username: config.username ?? 'Roblox Datamining', ...(config.avatarUrl ? { avatar_url: config.avatarUrl } : {}) };

  for (const section of sections) {
    const url = webhookFor(config, section.id);
    if (!url) {
      result.skipped.push(section.id);
      continue;
    }
    await post(withComponents(url), { ...base, flags: V2_FLAG, components: [sectionToContainer(section, options)] });
    result.posted++;
  }
  return result;
}

export async function postProblems(problems: RunProblem[], config: DiscordConfig, now: Date): Promise<void> {
  if (!problems.length || !config.log) return;
  const body = truncate(problems.map((p) => `• **${p.tracker}** — ${p.message}`).join('\n'), TOTAL_BUDGET);
  const container = {
    type: CONTAINER,
    accent_color: 0xf59e0b,
    components: [{ type: TEXT_DISPLAY, content: `## ⚠️ ${problems.length} problem(s) during mining\n${body}` }],
  };
  await post(withComponents(config.log), {
    username: config.username ?? 'Roblox Datamining',
    flags: V2_FLAG,
    components: [container],
  });
}
