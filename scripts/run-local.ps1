<#
.SYNOPSIS
  Runs the miner on this computer, posts changes to Discord, and pushes snapshots to GitHub.

.DESCRIPTION
  Intended to be driven by Windows Task Scheduler (see install-task.ps1). It pulls the
  latest data, mines the requested trackers with --discord (reading discord.config.json),
  commits any changed snapshots and pushes them.

.PARAMETER Trackers
  Space-separated tracker ids, or "all". Default: all.

.EXAMPLE
  pwsh scripts/run-local.ps1 -Trackers "versions deploy-history api-dump fflags"
#>
[CmdletBinding()]
param(
  [string]$Trackers = "all"
)

$ErrorActionPreference = "Stop"
$repo = Split-Path -Parent $PSScriptRoot
Set-Location $repo

$argList = @("src/cli.ts")
if ($Trackers -and $Trackers -ne "all") { $argList += $Trackers.Split(" ", [StringSplitOptions]::RemoveEmptyEntries) }
$argList += "--discord"

Write-Host "[$(Get-Date -Format o)] mining: $($argList -join ' ')"

# Stay in sync with whatever else pushes to main (e.g. a GitHub Actions run).
git pull --ff-only --quiet 2>$null

# A GitHub token lets the luau tracker call the GitHub API at the higher authenticated rate.
if (-not $env:GITHUB_TOKEN) {
  try { $env:GITHUB_TOKEN = (gh auth token 2>$null) } catch {}
}

node @argList
$mineExit = $LASTEXITCODE

git add -A
if (git diff --cached --quiet) {
  Write-Host "No snapshot changes to commit."
} else {
  git commit --quiet -F out/commit-message.txt
  for ($i = 1; $i -le 3; $i++) {
    git pull --rebase --quiet
    if (git push --quiet) { break }
    Write-Host "push attempt $i failed, retrying..."
    Start-Sleep -Seconds ($i * 5)
  }
  Write-Host "Pushed $(git rev-parse --short HEAD)."
}

exit $mineExit
