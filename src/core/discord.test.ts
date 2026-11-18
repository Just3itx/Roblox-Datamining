import assert from 'node:assert/strict';
import { test } from 'node:test';
import { ansiDiff, sectionToContainer, webhookFor } from './discord.ts';
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

test('ansiDiff colours added green, removed red, and changes yellow', () => {
  const block = ansiDiff(
    [
      { op: '+', text: 'added' },
      { op: '-', text: 'removed' },
      { op: ' ', text: 'resale 10 → 20' },
    ],
    'Changes',
    1000,
  );
  assert.match(block, /```ansi/);
  assert.match(block, /\u001b\[0;32m\+ added/);
  assert.match(block, /\u001b\[0;31m- removed/);
  assert.match(block, /\u001b\[0;33mresale 10 → 20/);
});

test('ansiDiff truncates to the budget and notes the remainder', () => {
  const lines = Array.from({ length: 500 }, (_, i) => ({ op: '+' as const, text: `FFlag${i}` }));
  const block = ansiDiff(lines, 'Added', 300);
  assert.ok(block.length < 500);
  assert.match(block, /more \(see commit\)/);
});

test('sectionToContainer builds a Components V2 container with the tracker accent colour', () => {
  const container = sectionToContainer(section, { now: new Date('2026-01-01T00:00:00Z'), version: '0.748' }) as {
    type: number;
    accent_color: number;
    components: Array<{ type: number; content?: string }>;
  };
  assert.equal(container.type, 17);
  assert.equal(container.accent_color, 0xef4444);
  assert.equal(container.components[0]!.type, 10);
  assert.match(container.components[0]!.content!, /## 🚩 Fast flags/);
  // the diff child carries an ansi block
  assert.ok(container.components.some((c) => c.content?.includes('```ansi')));
  // footer mentions the version
  assert.ok(container.components.at(-1)!.content!.includes('0.748'));
});

test('diff code fences inside mined text cannot break the ansi block', () => {
  const block = ansiDiff([{ op: '+', text: 'evil ```' }], 'x', 500);
  assert.equal(block.split('```').length - 1, 2); // only the opening and closing fence
});
