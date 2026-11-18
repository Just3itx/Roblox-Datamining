import type { Http } from '../core/http.ts';
import type { Section } from '../core/report.ts';
import type { Store } from '../core/store.ts';

export interface TrackerContext {
  http: Http;
  store: Store;
  /** One timestamp shared by every tracker in a run. */
  now: Date;
  log(message: string): void;
  /** A non-fatal problem: shown in the report and as a GitHub Actions warning. */
  warn(message: string): void;
}

/**
 * A tracker fetches one kind of data, compares it with the snapshot under data/,
 * writes the new snapshot, and describes what changed.
 */
export interface Tracker {
  /** CLI name, e.g. "fflags". */
  id: string;
  title: string;
  icon: string;
  description: string;
  /** Returns null when nothing changed. */
  run(context: TrackerContext): Promise<Section | null>;
}
