# Copilot instructions: Roblox Datamining

A TypeScript tool that polls public Roblox endpoints, stores snapshots under `data/`, and describes every change in a markdown report. GitHub Actions (`.github/workflows/mine.yml`) runs it on a schedule, commits the snapshots, and posts the report as a commit comment.

## Commands

- `npm ci`: install. The only dependencies are `typescript` and `@types/node` (dev).
- `npm run check`: typecheck (`tsc`) and run the tests (`node --test`). **Run it before you finish any change.**
- `node src/cli.ts <tracker…> --data-dir /tmp/data --out /tmp/out --readme /dev/null`: a live run that leaves the repo untouched. Use this to check a tracker against the real endpoints.

## How the TypeScript runs

Node 24 runs `.ts` files directly through type stripping. There is no build step and no `dist/`. That means:

- Only **erasable** TypeScript: no `enum`, no `namespace`, no constructor parameter properties, no decorators. Use `as const` objects and union types instead. (`erasableSyntaxOnly` in `tsconfig.json` enforces this.)
- Relative imports **must** end in `.ts`, e.g. `import { Store } from '../core/store.ts'`.
- Type-only imports must use `import type` / `type` modifiers (`verbatimModuleSyntax`).
- `noUncheckedIndexedAccess` is on, so handle `undefined` from indexing.

## Architecture

```
src/cli.ts              parses args, runs trackers in order, writes out/report.md, commit-message.txt, result.json
src/readme.ts           rewrites the README block between <!-- status:start --> and <!-- status:end -->
src/core/http.ts        fetch with retries, 429 handling, and per-run de-duplication of identical URLs
src/core/store.ts       read/write JSON under data/; skips writes when content is unchanged
src/core/diff.ts        generic record diff (sorted, deterministic)
src/core/report.ts      Section/Block model → markdown (keeps output under GitHub's 65,536-char comment limit)
src/core/text.ts        formatting and markdown-escaping helpers
src/trackers/*.ts       one tracker per data source, registered in src/trackers/index.ts
```

### Adding a tracker

1. Create `src/trackers/<name>.ts` that exports a `Tracker` (see `src/trackers/types.ts`).
2. In `run()`: fetch with `context.http`, read the previous snapshot with `context.store.readJson`, write the new one with `context.store.writeJson`, and return a `Section`, or `null` if nothing changed.
3. Handle the **first run** (no previous snapshot) with a short "First snapshot" section. Never list thousands of "added" lines.
4. Register it in `src/trackers/index.ts`, schedule it in `.github/workflows/mine.yml`, and add a row to the README's "What gets tracked" table.
5. Put pure diff/format logic in exported functions and add `*.test.ts` tests next to them.

### Rules for mined data

- Snapshots must be **deterministic**: sort keys/lists with `compareStrings` (never `localeCompare`), and leave out values that change every minute (player counts, timestamps, session ids). Otherwise every run makes a commit.
- Never hand-edit anything under `data/`. The workflow owns it.
- Use `context.warn()` for partial failures (one app or endpoint down) so the rest of the run still commits.
- Keep report text escaped with the helpers in `src/core/text.ts` (`escapeCell`, `mdLink`, `mdCode`). Mined strings can contain `|`, `[`, newlines, and backticks.

## Etiquette with Roblox endpoints

- Public, unauthenticated endpoints only. Never add cookies (`.ROBLOSECURITY`), API keys, or login flows.
- Keep request volume low and sequential where a rate limit exists (catalog: about 12 requests a minute). `http.ts` already backs off on 429.
- Don't add anything that decompiles, modifies, or redistributes the Roblox client binaries.

## Style

- Small, pure, exported functions. Prefer `const` and early returns.
- User-facing report text: short, emoji section icons, `+`/`−`/`~` counts via `countLabel`.
- Don't add runtime dependencies without a strong reason. Node 24's built-ins (fetch, `node:test`, `node:util` parseArgs) cover almost everything.
