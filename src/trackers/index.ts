import { apiDumpTracker } from './api-dump/index.ts';
import { catalogTracker } from './catalog.ts';
import { deployHistoryTracker } from './deploy-history.ts';
import { fflagsTracker } from './fflags.ts';
import { gamesTracker } from './games.ts';
import { limitedsTracker } from './limiteds.ts';
import { luauTracker } from './luau.ts';
import type { Tracker } from './types.ts';
import { versionsTracker } from './versions.ts';
import { watchlistTracker } from './watchlist.ts';

/** Every tracker, in the order they run and appear in reports. */
export const TRACKERS: readonly Tracker[] = [
  versionsTracker,
  deployHistoryTracker,
  apiDumpTracker,
  luauTracker,
  fflagsTracker,
  gamesTracker,
  catalogTracker,
  limitedsTracker,
  watchlistTracker,
];
