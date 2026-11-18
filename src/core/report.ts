import { escapeCell, escapeHtml, plural, utcStamp } from './text.ts';

export interface DiffLine {
  /** "+" added, "-" removed, " " unchanged context (e.g. the class a member belongs to). */
  op: '+' | '-' | ' ';
  text: string;
}

export type Block =
  | { type: 'text'; text: string }
  | { type: 'table'; columns: string[]; rows: string[][] }
  | { type: 'diff'; title: string; lines: DiffLine[]; open?: boolean };

/** What one tracker found in one run. */
export interface Section {
  id: string;
  icon: string;
  title: string;
  /** Few words for the commit subject, e.g. "🚩 FFlags +12 −3 ~5". */
  short: string;
  /** One sentence for the report and the commit body. */
  headline: string;
  blocks: Block[];
}

export interface RunProblem {
  tracker: string;
  message: string;
}

export interface ReportOptions {
  now: Date;
  problems?: RunProblem[];
  /** Markdown appended at the very end, e.g. a link to the workflow run. */
  footer?: string;
  /** GitHub commit comments cap out at 65,536 characters. */
  maxChars?: number;
}

export function renderTable(columns: string[], rows: string[][]): string {
  const header = `| ${columns.join(' | ')} |`;
  const divider = `| ${columns.map(() => '---').join(' | ')} |`;
  const body = rows.map((row) => `| ${row.join(' | ')} |`);
  return [header, divider, ...body].join('\n');
}

function renderDiff(block: Extract<Block, { type: 'diff' }>, maxLines: number): string {
  const shown = block.lines.slice(0, maxLines);
  const hidden = block.lines.length - shown.length;
  // Never let mined text close the surrounding code fence.
  const body = shown.map((line) => `${line.op} ${line.text.replace(/`{3,}/g, (m) => '´'.repeat(m.length))}`);
  if (hidden > 0) body.push(`@@ … ${plural(hidden, 'more line')} in the commit diff @@`);
  return [
    `<details${block.open ? ' open' : ''}>`,
    `<summary><b>${escapeHtml(block.title)}</b></summary>`,
    '',
    '```diff',
    ...body,
    '```',
    '',
    '</details>',
  ].join('\n');
}

function renderBlock(block: Block, maxDiffLines: number): string {
  switch (block.type) {
    case 'text':
      return block.text;
    case 'table':
      return renderTable(block.columns, block.rows);
    case 'diff':
      return renderDiff(block, maxDiffLines);
  }
}

export function renderSection(section: Section, maxDiffLines = Number.POSITIVE_INFINITY): string {
  const parts = [`## ${section.icon} ${section.title}`, `**${section.headline}**`];
  for (const block of section.blocks) parts.push(renderBlock(block, maxDiffLines));
  return `${parts.join('\n\n')}\n`;
}

function renderProblems(problems: RunProblem[]): string {
  const rows = problems.map((p) => [`\`${p.tracker}\``, escapeCell(p.message)]);
  return `## ⚠️ Problems\n\n${renderTable(['Tracker', 'Error'], rows)}\n`;
}

function buildReport(sections: Section[], options: ReportOptions, maxDiffLines: number): string {
  const problems = options.problems ?? [];
  const parts = ['# 🛰️ Roblox Datamining Report', `<sub>${utcStamp(options.now)}</sub>`];

  if (sections.length) {
    const rows = sections.map((s) => [s.icon, s.title, escapeCell(s.headline)]);
    parts.push(renderTable(['', 'Tracker', 'What changed'], rows));
  } else {
    parts.push('_No changes detected._');
  }

  for (const section of sections) parts.push('---', renderSection(section, maxDiffLines).trimEnd());
  if (problems.length) parts.push('---', renderProblems(problems).trimEnd());
  if (options.footer) parts.push('---', options.footer);
  return `${parts.join('\n\n')}\n`;
}

/** Renders the full markdown report, shrinking diff blocks until it fits within maxChars. */
export function renderReport(sections: Section[], options: ReportOptions): string {
  const maxChars = options.maxChars ?? 60_000;
  for (const maxDiffLines of [Number.POSITIVE_INFINITY, 600, 250, 100, 40, 15, 5]) {
    const report = buildReport(sections, options, maxDiffLines);
    if (report.length <= maxChars) return report;
  }
  const note = '\n\n… report truncated, see the commit diff for everything.\n';
  return buildReport(sections, options, 0).slice(0, maxChars - note.length) + note;
}

export function renderCommitMessage(sections: Section[], problems: RunProblem[] = []): string {
  const subject = sections.length ? sections.map((s) => s.short).join(' · ') : '🔄 Refresh data';
  const body = sections.map((s) => `- ${s.icon} ${s.title}: ${s.headline}`);
  if (problems.length) body.push('', ...problems.map((p) => `- ⚠️ ${p.tracker}: ${p.message}`));
  return body.length ? `${subject}\n\n${body.join('\n')}\n` : `${subject}\n`;
}
