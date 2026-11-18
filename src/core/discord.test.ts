import assert from 'node:assert/strict';
import { test } from 'node:test';
import { sectionToEmbed, sectionToText, webhookFor } from './discord.ts';
import type { Section } from './report.ts';

const section: Section = {
  id: 'fflags',
  icon: '🚩',
  title: 'Fast flags',
  short: '🚩 FFlags +1',
  headline: '+1 flags across 1 app',
  blocks: [
    { type: 'table', columns: ['App', 'Added'], rows: [['PC', '1']] },
    { type: 'diff', title: 'Added (1)', lines: [{ op: '+', text: 'FFlagNew = True' }] },
  ],
};

test('webhookFor prefers the per-tracker URL, falls back to default', () => {
  assert.equal(webhookFor({ trackers: { fflags: 'A' }, default: 'B' }, 'fflags'), 'A');
  assert.equal(webhookFor({ default: 'B' }, 'fflags'), 'B');
  assert.equal(webhookFor({ trackers: { games: 'A' } }, 'fflags'), undefined);
});

test('sectionToText renders tables and diff code blocks', () => {
  const text = sectionToText(section);
  assert.match(text, /App · Added/);
  assert.match(text, /```diff\n\+ FFlagNew = True/);
});

test('sectionToEmbed builds a titled, colored embed within Discord limits', () => {
  const embed = sectionToEmbed(section, { now: new Date('2026-01-01T00:00:00Z'), commitUrl: 'https://x', version: '0.748' });
  assert.equal(embed.title, '🚩 Fast flags — +1 flags across 1 app');
  assert.equal(embed.url, 'https://x');
  assert.equal(embed.color, 0xef4444);
  assert.ok(embed.description.length <= 4096);
  assert.match(embed.footer.text, /0\.748/);
});
