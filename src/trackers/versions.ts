import type { Http } from '../core/http.ts';
import type { Section } from '../core/report.ts';
import { errorMessage, mdCode, plural } from '../core/text.ts';
import type { Tracker } from './types.ts';

/** "0.748.0.7481526" → "0.748.0 · build 7481526" for human-readable display. */
export function prettyVersion(version: string): string {
  const parts = version.split('.');
  return parts.length === 4 ? `${parts[0]}.${parts[1]}.${parts[2]} · build ${parts[3]}` : version;
}

export const BINARIES = {
  WindowsPlayer: '🪟 Windows Player',
  WindowsStudio64: '🪟 Windows Studio',
  MacPlayer: '🍎 Mac Player',
  MacStudio: '🍎 Mac Studio',
} as const;

export type BinaryType = keyof typeof BINARIES;

export interface ClientVersion {
  version: string;
  clientVersionUpload: string;
}

export type LiveVersions = Partial<Record<BinaryType, ClientVersion>>;

export interface VersionHistoryEntry extends ClientVersion {
  date: string;
  binary: BinaryType;
}

export const LIVE_FILE = 'versions/live.json';
const HISTORY_FILE = 'versions/history.json';
const MAX_HISTORY = 1000;

export async function fetchClientVersion(http: Http, binary: BinaryType): Promise<ClientVersion> {
  const response = await http.json<ClientVersion>(`https://clientsettings.roblox.com/v2/client-version/${binary}`);
  return { version: response.version, clientVersionUpload: response.clientVersionUpload };
}

export const versionsTracker: Tracker = {
  id: 'versions',
  title: 'Client versions',
  icon: '🚀',
  description: 'Live Roblox Player and Studio builds for Windows and Mac.',

  async run({ http, store, now, warn }) {
    const previous = (await store.readJson<LiveVersions>(LIVE_FILE)) ?? {};
    const current: LiveVersions = { ...previous };
    const updated: BinaryType[] = [];

    for (const binary of Object.keys(BINARIES) as BinaryType[]) {
      try {
        const latest = await fetchClientVersion(http, binary);
        if (previous[binary]?.clientVersionUpload !== latest.clientVersionUpload) updated.push(binary);
        current[binary] = latest;
      } catch (error) {
        warn(`versions: could not read ${binary}: ${errorMessage(error)}`);
      }
    }

    if (!updated.length) return null;

    await store.writeJson(LIVE_FILE, current);
    const history = (await store.readJson<VersionHistoryEntry[]>(HISTORY_FILE)) ?? [];
    const date = now.toISOString();
    const entries = updated.map((binary): VersionHistoryEntry => ({ date, binary, ...current[binary]! }));
    await store.writeJson(HISTORY_FILE, [...entries, ...history].slice(0, MAX_HISTORY));

    const rows = (Object.keys(BINARIES) as BinaryType[]).flatMap((binary) => {
      const latest = current[binary];
      if (!latest) return [];
      const before = previous[binary];
      let status = '—';
      if (updated.includes(binary)) {
        if (!before) status = '🆕 first seen';
        else if (before.version !== latest.version) status = `⬆️ from ${mdCode(prettyVersion(before.version))}`;
        else status = `🔁 rebuild`;
      }
      return [[BINARIES[binary], mdCode(prettyVersion(latest.version)), status]];
    });

    const versions = [...new Set(updated.map((binary) => current[binary]!.version))];
    return {
      id: 'versions',
      icon: '🚀',
      title: 'Client versions',
      short: `🚀 ${versions.map(prettyVersion).join(', ')}`,
      headline: `${plural(updated.length, 'build')} updated → ${versions.map(prettyVersion).join(', ')}`,
      blocks: [{ type: 'table', columns: ['Binary', 'Version', 'Status'], rows }],
    } satisfies Section;
  },
};
