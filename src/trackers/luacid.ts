import { execFile } from 'node:child_process';
import { mkdtemp, rm, writeFile } from 'node:fs/promises';
import { tmpdir } from 'node:os';
import { join } from 'node:path';
import { promisify } from 'node:util';

/**
 * Client for the Luacid Luau-bytecode decompiler (https://luacid.dev).
 * POST raw bytecode to api.luacid.dev/decompile, get readable Luau back.
 * The keyless tier is Cloudflare-gated for automated clients, so a key is normally required.
 */
const run = promisify(execFile);
const ENDPOINT = 'https://api.luacid.dev/decompile';
const UA = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120 Safari/537.36';

export interface LuacidOptions {
  /** API key (Authorization: Bearer …). Needed to get past Cloudflare for automated calls. */
  key?: string;
  /** Optional proxy (http://user:pass@host:port). */
  proxy?: string;
  timeoutMs?: number;
}

/** Thrown when Cloudflare (or auth) blocks the request — the caller should stop for this run. */
export class LuacidBlocked extends Error {}

const looksChallenged = (body: string) => /just a moment|cloudflare|cf-chl|challenge-platform|__cf/i.test(body);

/** Decompiles one Luau bytecode blob into source. Throws LuacidBlocked when Cloudflare/auth refuses. */
export async function decompile(bytecode: Uint8Array, options: LuacidOptions = {}): Promise<string> {
  const dir = await mkdtemp(join(tmpdir(), 'luacid-'));
  const inFile = join(dir, 'in.bin');
  try {
    await writeFile(inFile, bytecode);
    const args = [
      ...(options.proxy ? ['-x', options.proxy] : []),
      '-s', '-m', String(Math.ceil((options.timeoutMs ?? 30_000) / 1000)),
      '-A', UA,
      '-H', 'content-type: application/octet-stream',
      '-H', 'accept: text/plain, */*',
      ...(options.key ? ['-H', `authorization: Bearer ${options.key}`] : []),
      '--data-binary', `@${inFile}`,
      '-w', '\n%{http_code}',
      ENDPOINT,
    ];
    const { stdout } = await run('curl', args, { maxBuffer: 1 << 26 });
    const nl = stdout.lastIndexOf('\n');
    const body = nl >= 0 ? stdout.slice(0, nl) : stdout;
    const status = (nl >= 0 ? stdout.slice(nl + 1) : '').trim();

    if (status === '200' && !looksChallenged(body)) return body;
    if (status === '403' || status === '503' || status === '429' || looksChallenged(body)) {
      throw new LuacidBlocked(`Luacid refused (${status || 'challenge'})${options.key ? '' : ' — no key set'}`);
    }
    throw new Error(`Luacid ${status}: ${body.slice(0, 160)}`);
  } finally {
    await rm(dir, { recursive: true, force: true }).catch(() => {});
  }
}
