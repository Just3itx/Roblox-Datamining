/** Code-point string comparison: deterministic across machines, unlike localeCompare. */
export function compareStrings(a: string, b: string): number {
  return a < b ? -1 : a > b ? 1 : 0;
}

export function plural(count: number, singular: string, pluralForm = `${singular}s`): string {
  return `${formatNumber(count)} ${count === 1 ? singular : pluralForm}`;
}

const numberFormat = new Intl.NumberFormat('en-US');
const compactFormat = new Intl.NumberFormat('en-US', { notation: 'compact', maximumFractionDigits: 1 });

export function formatNumber(value: number): string {
  return numberFormat.format(value);
}

export function formatCompact(value: number): string {
  return compactFormat.format(value);
}

/** "+12 −3 ~5", leaving out zero parts. */
export function countLabel(counts: { added: number; removed: number; changed: number }): string {
  const parts: string[] = [];
  if (counts.added) parts.push(`+${formatNumber(counts.added)}`);
  if (counts.removed) parts.push(`−${formatNumber(counts.removed)}`);
  if (counts.changed) parts.push(`~${formatNumber(counts.changed)}`);
  return parts.length ? parts.join(' ') : 'no changes';
}

export function truncate(text: string, max: number): string {
  return text.length <= max ? text : `${text.slice(0, Math.max(0, max - 1))}…`;
}

export function oneLine(text: string): string {
  return text.replace(/\r\n|\r|\n/g, ' ⏎ ');
}

export function escapeHtml(text: string): string {
  return text.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
}

/** Makes text safe inside a markdown table cell. */
export function escapeCell(text: string): string {
  return oneLine(text).replace(/\\/g, '\\\\').replace(/\|/g, '\\|');
}

export function mdLink(text: string, url: string): string {
  const safe = oneLine(text).replace(/\\/g, '\\\\').replace(/([[\]|])/g, '\\$1');
  return `[${safe}](${url})`;
}

export function mdCode(text: string): string {
  const clean = oneLine(text);
  const fence = clean.includes('`') ? '``' : '`';
  return `${fence}${clean}${fence}`;
}

export function utcStamp(date: Date): string {
  return `${date.toISOString().slice(0, 16).replace('T', ' ')} UTC`;
}

export function errorMessage(error: unknown): string {
  return error instanceof Error ? error.message : String(error);
}
