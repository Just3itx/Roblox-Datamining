import { mkdir, writeFile } from 'node:fs/promises';
import { join } from 'node:path';
import { parseArgs } from 'node:util';
import { loadDiscordConfig, postProblems, postSections } from './core/discord.ts';
import { createHttp } from './core/http.ts';
import { renderCommitMessage, renderReport, type RunProblem, type Section } from './core/report.ts';
import { Store } from './core/store.ts';
import { errorMessage } from './core/text.ts';
import { LIVE_FILE, type LiveVersions } from './trackers/versions.ts';
import { updateReadme } from './readme.ts';
import { TRACKERS } from './trackers/index.ts';
import type { TrackerContext } from './trackers/types.ts';

const HELP = `Usage: node src/cli.ts [tracker ...] [options]

Runs the given trackers (all of them when none are named), updates the
snapshots under the data directory, and writes a report to the out directory.

Trackers:
${TRACKERS.map((t) => `  ${t.id.padEnd(10)} ${t.description}`).join('\n')}

Options:
  --data-dir <dir>  Snapshot directory (default: data)
  --out <dir>       Where report.md, commit-message.txt and result.json go (default: out)
  --readme <file>   README whose status block is refreshed on changes (default: README.md)
  --discord         Post each change to its Discord webhook (reads --discord-config)
  --discord-config  Path to the webhook config (default: discord.config.json)
  -h, --help        Show this help
`;

const inActions = process.env.GITHUB_ACTIONS === 'true';
const escapeAnnotation = (text: string) => text.replace(/%/g, '%25').replace(/\r/g, '%0D').replace(/\n/g, '%0A');

function runFooter(): string | undefined {
  const { GITHUB_SERVER_URL: server, GITHUB_REPOSITORY: repo, GITHUB_RUN_ID: runId } = process.env;
  if (!server || !repo || !runId) return undefined;
  return `<sub>🤖 Mined by [workflow run ${runId}](${server}/${repo}/actions/runs/${runId}).</sub>`;
}

async function main(): Promise<number> {
  const { values, positionals } = parseArgs({
    allowPositionals: true,
    options: {
      'data-dir': { type: 'string', default: 'data' },
      out: { type: 'string', default: 'out' },
      readme: { type: 'string', default: 'README.md' },
      discord: { type: 'boolean', default: false },
      'discord-config': { type: 'string', default: 'discord.config.json' },
      help: { type: 'boolean', short: 'h', default: false },
    },
  });

  if (values.help) {
    process.stdout.write(HELP);
    return 0;
  }

  const unknown = positionals.filter((id) => !TRACKERS.some((t) => t.id === id));
  if (unknown.length) {
    process.stderr.write(`Unknown tracker(s): ${unknown.join(', ')}\n\n${HELP}`);
    return 2;
  }
  const selected = positionals.length ? TRACKERS.filter((t) => positionals.includes(t.id)) : TRACKERS;

  // ROBLOX_PROXY: comma-separated proxy hosts (e.g. "roproxy.com,rotunnel.com"), or "1" for roproxy.com.
  const proxies = (process.env.ROBLOX_PROXY ?? '')
    .split(',')
    .map((host) => host.trim())
    .filter(Boolean)
    .map((host) => (host === '1' || host === 'true' ? 'roproxy.com' : host));
  if (proxies.length) console.log(`🛰️ Using proxy chain: ${proxies.join(' → ')} → direct`);

  const problems: RunProblem[] = [];
  let current = 'cli';
  const context: TrackerContext = {
    http: createHttp({ proxies }),
    store: new Store(values['data-dir']),
    now: new Date(),
    log: (message) => console.log(`  ${message}`),
    warn: (message) => {
      problems.push({ tracker: current, message });
      if (inActions) console.log(`::warning title=${current}::${escapeAnnotation(message)}`);
      else console.warn(`  ⚠️  ${message}`);
    },
  };

  const sections: Section[] = [];
  for (const tracker of selected) {
    current = tracker.id;
    const started = performance.now();
    console.log(`${tracker.icon} ${tracker.title}`);
    try {
      const section = await tracker.run(context);
      const seconds = ((performance.now() - started) / 1000).toFixed(1);
      if (section) sections.push(section);
      console.log(`  ${section ? `→ ${section.headline}` : '→ no changes'} (${seconds}s)`);
    } catch (error) {
      context.warn(`failed: ${errorMessage(error)}`);
    }
  }

  if (sections.length && (await updateReadme(values.readme, context.store, context.now))) {
    console.log(`📝 Refreshed status block in ${values.readme}`);
  }

  const footer = runFooter();
  await mkdir(values.out, { recursive: true });
  await writeFile(join(values.out, 'report.md'), renderReport(sections, { now: context.now, problems, ...(footer ? { footer } : {}) }));
  await writeFile(join(values.out, 'commit-message.txt'), renderCommitMessage(sections, problems));
  await writeFile(
    join(values.out, 'result.json'),
    `${JSON.stringify(
      {
        date: context.now.toISOString(),
        trackers: selected.map((t) => t.id),
        changed: sections.map((s) => s.id),
        files: [...context.store.changedFiles].sort(),
        problems,
      },
      null,
      2,
    )}\n`,
  );

  if (values.discord && (sections.length || problems.length)) {
    const config = await loadDiscordConfig(values['discord-config']);
    if (!config) {
      console.warn(`  ⚠️  --discord set but no config at ${values['discord-config']}`);
    } else {
      const version = (await context.store.readJson<LiveVersions>(LIVE_FILE))?.WindowsPlayer?.version;
      try {
        const result = await postSections(sections, config, { now: context.now, ...(version ? { version } : {}) });
        await postProblems(problems, config, context.now);
        console.log(`📣 Discord: posted ${result.posted}${result.skipped.length ? `, no webhook for ${result.skipped.join(', ')}` : ''}`);
      } catch (error) {
        console.warn(`  ⚠️  Discord posting failed: ${errorMessage(error)}`);
      }
    }
  }

  console.log(
    `\n✨ ${sections.length ? `${sections.length} tracker(s) found changes` : 'Nothing new'} · ` +
      `${context.store.changedFiles.size} file(s) written · ${problems.length} problem(s)`,
  );

  // Fail only when every selected tracker failed outright, so partial results still get committed.
  const failedTrackers = new Set(problems.filter((p) => p.message.startsWith('failed:')).map((p) => p.tracker));
  return failedTrackers.size === selected.length ? 1 : 0;
}

process.exitCode = await main();
