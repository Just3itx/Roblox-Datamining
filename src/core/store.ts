import { mkdir, readFile, writeFile } from 'node:fs/promises';
import { dirname, join } from 'node:path';
import { compareStrings } from './text.ts';

/** Reads and writes the mined snapshots under the data directory. Writes are skipped when content is unchanged. */
export class Store {
  readonly root: string;
  readonly changedFiles = new Set<string>();

  constructor(root: string) {
    this.root = root;
  }

  path(relativePath: string): string {
    return join(this.root, relativePath);
  }

  async readText(relativePath: string): Promise<string | undefined> {
    try {
      return await readFile(this.path(relativePath), 'utf8');
    } catch (error) {
      if ((error as NodeJS.ErrnoException).code === 'ENOENT') return undefined;
      throw error;
    }
  }

  async readJson<T>(relativePath: string): Promise<T | undefined> {
    const text = await this.readText(relativePath);
    return text === undefined ? undefined : (JSON.parse(text) as T);
  }

  /** Returns true when the file was created or its content changed. */
  async writeText(relativePath: string, text: string): Promise<boolean> {
    if ((await this.readText(relativePath)) === text) return false;
    const fullPath = this.path(relativePath);
    await mkdir(dirname(fullPath), { recursive: true });
    await writeFile(fullPath, text);
    this.changedFiles.add(relativePath.replace(/\\/g, '/'));
    return true;
  }

  writeJson(relativePath: string, value: unknown): Promise<boolean> {
    return this.writeText(relativePath, toJson(value));
  }

  /** Writes binary content, skipping the write when bytes are unchanged. Returns true on create/change. */
  async writeBytes(relativePath: string, bytes: Uint8Array): Promise<boolean> {
    const fullPath = this.path(relativePath);
    try {
      const existing = await readFile(fullPath);
      if (existing.length === bytes.length && existing.equals(bytes)) return false;
    } catch (error) {
      if ((error as NodeJS.ErrnoException).code !== 'ENOENT') throw error;
    }
    await mkdir(dirname(fullPath), { recursive: true });
    await writeFile(fullPath, bytes);
    this.changedFiles.add(relativePath.replace(/\\/g, '/'));
    return true;
  }
}

/** Pretty JSON with LF endings and a trailing newline, so git diffs stay line-oriented. */
export function toJson(value: unknown): string {
  return `${JSON.stringify(value, null, 2)}\n`;
}

export function sortKeys<T>(record: Readonly<Record<string, T>>): Record<string, T> {
  return Object.fromEntries(Object.entries(record).sort(([a], [b]) => compareStrings(a, b)));
}
