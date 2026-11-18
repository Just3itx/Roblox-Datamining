<div align="center">

# 🛰️ Roblox Datamining

**Every Roblox build, API change, fast flag flip, and chart shake-up, tracked automatically.**

Written in TypeScript · runs on GitHub Actions · every change lands as a readable commit

</div>

<!-- status:start -->
<p align="center"><a href="https://github.com/Just3itx/Roblox-Datamining/actions/workflows/mine.yml"><img alt="Mine" src="https://github.com/Just3itx/Roblox-Datamining/actions/workflows/mine.yml/badge.svg"></a> <a href="https://github.com/Just3itx/Roblox-Datamining/actions/workflows/ci.yml"><img alt="CI" src="https://github.com/Just3itx/Roblox-Datamining/actions/workflows/ci.yml/badge.svg"></a> <a href="https://github.com/Just3itx/Roblox-Datamining/commits/main"><img alt="Last change" src="https://img.shields.io/github/last-commit/Just3itx/Roblox-Datamining?label=last%20change"></a></p>

### 🚀 Live builds

| Binary | Version | Upload |
| --- | --- | --- |
| 🪟 Windows Player | `0.748.0.7481526` | `version-2c6fd5e09aaf4cfa` |
| 🪟 Windows Studio | `0.748.0.7481526` | `version-8d7a1009c17e4ff8` |
| 🍎 Mac Player | `0.748.0.7481526` | `version-445548190fe44ee2` |
| 🍎 Mac Studio | `0.748.0.7481526` | `version-c5c97d45b6614310` |

### 📊 Tracked right now

|  | Snapshot | Data |
| --- | --- | --- |
| 🧩 API dump | 960 classes · 8,927 members · 664 enums | [`data/api-dump`](data/api-dump) |
| 🚩 Fast flags | 206,592 values across 9 apps | [`data/fflags`](data/fflags) |
| 🎮 Top playing now | [Steal An Egg](https://www.roblox.com/games/107778070777162) · [Brookhaven 🏡RP](https://www.roblox.com/games/4924922222) · [Throw Food For Animals](https://www.roblox.com/games/120219252362013) | [`data/games`](data/games) |
| 🛍️ Latest Roblox items | [Shedletsekkar](https://www.roblox.com/catalog/93762663362787) · [Courtside Golden Hour](https://www.roblox.com/catalog/81421947324360) · [Moonlight Meadow](https://www.roblox.com/catalog/95681420685521) | [`data/catalog`](data/catalog) |

<sub>Last change detected 2026-11-18 16:19 UTC. This block is rewritten by the miner.</sub>
<!-- status:end -->

---

## ✨ What gets tracked

| | Tracker | What you get | Source | Cadence |
| --- | --- | --- | --- | --- |
| 🚀 | **Client versions** | Live Player and Studio builds for Windows and Mac, plus a history log | `clientsettings.roblox.com` | every 10 min |
| 📦 | **Deploy history** | Full deploy log across the LIVE, zcanary and znext channels | `setup.rbxcdn.com` | every 10 min |
| 🧩 | **API dump** | `Full-API-Dump.json` per Studio build, with a class-by-class diff of every member, enum and tag | `setup.rbxcdn.com` | every 10 min (downloads only on new builds) |
| 📜 | **CoreScripts (Luau)** | Which client Luau/CoreScript files changed each build, with links to the diff | `MaximumADHD/Roblox-Client-Tracker` | every 10 min |
| 🚩 | **Fast flags** | Every FFlag / FInt / FString / FLog for 9 apps, merged so one change across many apps is listed once | `clientsettingscdn.roblox.com` | every 10 min |
| 🎮 | **Experience charts** | Top Trending, Up-and-Coming, Top Playing Now, …: who entered and who left | `apis.roblox.com/explore-api` | every 3 h |
| 🛍️ | **Roblox catalog** | New items from the Roblox account, plus price and stock changes | `catalog.roblox.com` | every 3 h |

Each change produces:

- 📦 a commit with a summary subject, e.g. `🚀 0.749.0.7491234 · 🧩 API +41 −2 ~5 · 🚩 FFlags +12 −3 ~5`
- 💬 a **commit comment** with the full report: tables, collapsible `diff` blocks and links
- 🗂️ updated snapshots under [`data/`](data), so `git log -p` and GitHub's history view work as a changelog
- 📝 an archived API changelog per build in [`data/api-dump/changes/`](data/api-dump/changes)
- 🔔 an optional **Discord** post per tracker, to its own channel (see below)

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

## 🔔 Discord webhooks (runs on your computer)

The miner posts each change to a Discord channel, one colour-coded embed per tracker. Webhook URLs are **secrets**, so they never live in the repo.

First, in Discord, make a category with one channel per tracker group and a webhook in each (**Channel → Edit → Integrations → Webhooks**), then fill a config from [`discord.config.example.json`](discord.config.example.json). A tracker with no URL (and no `default`) is simply skipped.

**On GitHub Actions (default):** store the whole config as a repo secret named `DISCORD_CONFIG`, and the [Mine workflow](.github/workflows/mine.yml) writes it out and runs with `--discord` automatically:

```bash
gh secret set DISCORD_CONFIG < discord.config.json
```

**Locally:** save the config as `discord.config.json` (git-ignored) and run `node src/cli.ts --discord`. [`scripts/run-local.ps1`](scripts/run-local.ps1) + [`scripts/install-task.ps1`](scripts/install-task.ps1) can schedule it via Windows Task Scheduler if you ever want to mine from your own PC instead.

> Run the miner from **one** place to avoid double posts — the Actions cron **or** local tasks, not both.

## 🤖 Working with GitHub Copilot

This repo is set up for the [Copilot coding agent](https://docs.github.com/en/copilot/concepts/agents/coding-agent):

- [`.github/copilot-instructions.md`](.github/copilot-instructions.md) explains the architecture and the rules
- [`.github/workflows/copilot-setup-steps.yml`](.github/workflows/copilot-setup-steps.yml) gives the agent Node 24 and the dependencies
- the **New tracker** issue template is written so you can assign the issue straight to `Copilot`
- [CI](.github/workflows/ci.yml) typechecks and tests every pull request it opens

## 📁 Layout

```
src/
  cli.ts               entry point: runs trackers, writes out/, posts to Discord
  readme.ts            rewrites the status block above
  core/                http · store · diff · report rendering · discord
  trackers/            one file (or folder) per data source
scripts/               run-local.ps1 + install-task.ps1 (local scheduling)
data/                  mined snapshots (generated, never hand-edited)
.github/               workflows, Copilot instructions, issue templates
```

## ⚖️ Notes

This project only reads public, unauthenticated endpoints, at a low rate. It is not affiliated with or endorsed by Roblox Corporation.
