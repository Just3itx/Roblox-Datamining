<div align="center">

# 🛰️ Roblox Datamining

**Every Roblox build, API change, fast flag flip, and chart shake-up, tracked automatically.**

Written in TypeScript · runs on GitHub Actions · every change lands as a readable commit

</div>

<!-- status:start -->
_No data yet. The first run of the **Mine** workflow fills this in._
<!-- status:end -->

---

## ✨ What gets tracked

| | Tracker | What you get | Source | Cadence |
| --- | --- | --- | --- | --- |
| 🚀 | **Client versions** | Live Player and Studio builds for Windows and Mac, plus a history log | `clientsettings.roblox.com` | every 10 min |
| 🧩 | **API dump** | `Full-API-Dump.json` per Studio build, with a class-by-class diff of every member, enum and tag | `setup.rbxcdn.com` | every 10 min (downloads only on new builds) |
| 🚩 | **Fast flags** | Every FFlag / FInt / FString / FLog for 9 apps, merged so one change across many apps is listed once | `clientsettingscdn.roblox.com` | every 10 min |
| 🎮 | **Experience charts** | Top Trending, Up-and-Coming, Top Playing Now, …: who entered and who left | `apis.roblox.com/explore-api` | every 3 h |
| 🛍️ | **Roblox catalog** | New items from the Roblox account, plus price and stock changes | `catalog.roblox.com` | every 3 h |

Each change produces:

- 📦 a commit with a summary subject, e.g. `🚀 0.749.0.7491234 · 🧩 API +41 −2 ~5 · 🚩 FFlags +12 −3 ~5`
- 💬 a **commit comment** with the full report: tables, collapsible `diff` blocks and links
- 🗂️ updated snapshots under [`data/`](data), so `git log -p` and GitHub's history view work as a changelog
- 📝 an archived API changelog per build in [`data/api-dump/changes/`](data/api-dump/changes)

<details>
<summary><b>Example: an API dump change</b></summary>

```diff
  Class Instance [NotCreatable, NotBrowsable]
+     Event Instance.Destroying()
-     Property Instance.Name: string
+     Property Instance.Name: string [NotReplicated]
+ Class Sparkle : Instance
+     Property Sparkle.Color: Color3
```

</details>

## 🧭 How it works

```
 ┌──────────────── GitHub Actions (cron) ────────────────┐
 │                                                       │
 │  node src/cli.ts versions api-dump fflags             │
 │      │                                                │
 │      ├─ fetch ─▶ Roblox endpoints                     │
 │      ├─ diff  ─▶ previous snapshot in data/           │
 │      ├─ write ─▶ data/**  +  README status block      │
 │      └─ out/  ─▶ report.md · commit-message.txt       │
 │                                                       │
 │  git commit -F out/commit-message.txt && git push     │
 │  gh api …/comments  -F body=@out/report.md            │
 └───────────────────────────────────────────────────────┘
```

Every tracker uses the same small contract ([`src/trackers/types.ts`](src/trackers/types.ts)): fetch, compare with the stored snapshot, write the new one, and return a `Section` describing what changed (or `null`). The report renderer turns sections into markdown and keeps commit comments under GitHub's size limit.

## 🛠️ Running locally

Requires **Node.js 24+**. There's no build step: Node runs the TypeScript directly.

```bash
npm install
npm run mine                 # every tracker
npm run mine -- fflags       # just one
npm run mine:fast            # versions, api-dump, fflags
npm run mine:slow            # games, catalog
npm run check                # typecheck + tests
```

Output goes to `data/` (snapshots) and `out/` (the report, the commit message and `result.json`). Use `--data-dir` and `--out` to point them somewhere else.

## 🤖 Working with GitHub Copilot

This repo is set up for the [Copilot coding agent](https://docs.github.com/en/copilot/concepts/agents/coding-agent):

- [`.github/copilot-instructions.md`](.github/copilot-instructions.md) explains the architecture and the rules
- [`.github/workflows/copilot-setup-steps.yml`](.github/workflows/copilot-setup-steps.yml) gives the agent Node 24 and the dependencies
- the **New tracker** issue template is written so you can assign the issue straight to `Copilot`
- [CI](.github/workflows/ci.yml) typechecks and tests every pull request it opens

## 📁 Layout

```
src/
  cli.ts               entry point: runs trackers, writes out/
  readme.ts            rewrites the status block above
  core/                http (retries, rate limits) · store · diff · report rendering
  trackers/            one file (or folder) per data source
data/                  mined snapshots (generated, never hand-edited)
.github/               workflows, Copilot instructions, issue templates
```

## ⚖️ Notes

This project only reads public, unauthenticated endpoints, at a low rate. It is not affiliated with or endorsed by Roblox Corporation.
