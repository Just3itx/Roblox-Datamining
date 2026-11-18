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
};

const DISCORD_DESC_LIMIT = 4096;
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

/** Renders a section's blocks into a compact plain-text body for a Discord embed. */
export function sectionToText(section: Section): string {
  const parts: string[] = [];
  for (const block of section.blocks) parts.push(blockToText(block));
  return truncate(parts.join('\n\n').trim(), DISCORD_DESC_LIMIT);
}

function blockToText(block: Block): string {
  switch (block.type) {
    case 'text':
      return stripHtml(block.text);
    case 'table':
      return block.columns[0] === ''
        ? block.rows.map((r) => `• ${r.filter(Boolean).join(' — ')}`).join('\n')
        : `${block.columns.join(' · ')}\n${block.rows.map((r) => r.join(' · ')).join('\n')}`;
    case 'diff': {
      const body = block.lines
        .slice(0, 60)
        .map((l) => `${l.op} ${l.text}`)
        .join('\n');
      const more = block.lines.length > 60 ? `\n… +${block.lines.length - 60} more` : '';
      return `**${block.title}**\n\`\`\`diff\n${truncate(body, 1800)}${more}\n\`\`\``;
    }
  }
}

const stripHtml = (text: string) =>
  text
    .replace(/<sub>|<\/sub>/g, '')
    .replace(/<\/?details[^>]*>|<\/?summary>/g, '')
    .replace(/\*\*/g, '**')
    .trim();

interface Embed {
  title: string;
  description: string;
  color: number;
  url?: string;
  timestamp: string;
  footer: { text: string };
}

export function sectionToEmbed(section: Section, options: { commitUrl?: string; now: Date; version?: string }): Embed {
  return {
    title: truncate(`${section.icon} ${section.title} — ${section.headline}`, 256),
    description: sectionToText(section),
    color: COLORS[section.id] ?? 0x5865f2,
    ...(options.commitUrl ? { url: options.commitUrl } : {}),
    timestamp: options.now.toISOString(),
    footer: { text: truncate(`Roblox Datamining${options.version ? ` · ${options.version}` : ''}`, 2048) },
  };
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

export interface DiscordResult {
  posted: number;
  skipped: string[];
}

/** Posts one embed per changed section to its mapped webhook. Returns a small summary. */
export async function postSections(
  sections: Section[],
  config: DiscordConfig,
  options: { commitUrl?: string; now: Date; version?: string },
): Promise<DiscordResult> {
  const result: DiscordResult = { posted: 0, skipped: [] };
  const base = { username: config.username ?? 'Roblox Datamining', ...(config.avatarUrl ? { avatar_url: config.avatarUrl } : {}) };

  for (const section of sections) {
    const url = webhookFor(config, section.id);
    if (!url) {
      result.skipped.push(section.id);
      continue;
    }
    await post(url, { ...base, embeds: [sectionToEmbed(section, options)] });
    result.posted++;
  }
  return result;
}

export async function postProblems(problems: RunProblem[], config: DiscordConfig, now: Date): Promise<void> {
  if (!problems.length || !config.log) return;
  await post(config.log, {
    username: config.username ?? 'Roblox Datamining',
    embeds: [
      {
        title: `⚠️ ${problems.length} problem(s) during mining`,
        description: truncate(problems.map((p) => `• **${p.tracker}** — ${p.message}`).join('\n'), DISCORD_DESC_LIMIT),
        color: 0xf59e0b,
        timestamp: now.toISOString(),
      },
    ],
  });
}
