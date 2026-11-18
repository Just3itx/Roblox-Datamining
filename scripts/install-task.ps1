<#
.SYNOPSIS
  Registers Windows Scheduled Tasks that run the local miner on a schedule.

.DESCRIPTION
  Creates two tasks under the \RobloxDatamining\ folder:
    - "Fast"  : versions, deploy-history, api-dump, luau, fflags   (every FastMinutes)
    - "Slow"  : games, catalog                                     (every SlowMinutes)
  Both run run-local.ps1, which posts to Discord and pushes to GitHub.

.PARAMETER FastMinutes
  Interval for the fast trackers. Default: 15.

.PARAMETER SlowMinutes
  Interval for the slow trackers. Default: 180.

.EXAMPLE
  pwsh scripts/install-task.ps1
  # Remove them later with:  pwsh scripts/install-task.ps1 -Uninstall
#>
[CmdletBinding()]
param(
  [int]$FastMinutes = 15,
  [int]$SlowMinutes = 180,
  [switch]$Uninstall
)

$ErrorActionPreference = "Stop"
$folder = "\RobloxDatamining\"
$repo = Split-Path -Parent $PSScriptRoot
$runner = Join-Path $PSScriptRoot "run-local.ps1"
$pwsh = (Get-Command pwsh -ErrorAction SilentlyContinue)?.Source ?? (Get-Command powershell).Source

function Remove-TaskIfPresent([string]$name) {
  $existing = Get-ScheduledTask -TaskPath $folder -TaskName $name -ErrorAction SilentlyContinue
  if ($existing) { Unregister-ScheduledTask -TaskPath $folder -TaskName $name -Confirm:$false }
}

Remove-TaskIfPresent "Fast"
Remove-TaskIfPresent "Slow"
if ($Uninstall) { Write-Host "Removed RobloxDatamining scheduled tasks."; return }

function Register-MinerTask([string]$name, [string]$trackers, [int]$minutes) {
  $action = New-ScheduledTaskAction -Execute $pwsh `
    -Argument "-NoProfile -ExecutionPolicy Bypass -File `"$runner`" -Trackers `"$trackers`"" `
    -WorkingDirectory $repo
  $trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) `
    -RepetitionInterval (New-TimeSpan -Minutes $minutes)
  $settings = New-ScheduledTaskSettingsSet -StartWhenAvailable `
    -DontStopOnIdleEnd -MultipleInstances IgnoreNew -ExecutionTimeLimit (New-TimeSpan -Minutes 20)
  Register-ScheduledTask -TaskPath $folder -TaskName $name -Action $action `
    -Trigger $trigger -Settings $settings -Description "Roblox Datamining ($trackers)" | Out-Null
  Write-Host "Registered $folder$name every $minutes min: $trackers"
}

Register-MinerTask "Fast" "versions deploy-history api-dump luau fflags" $FastMinutes
Register-MinerTask "Slow" "games catalog" $SlowMinutes
Write-Host "`nDone. The tasks run as your user while you're logged in. Check them in Task Scheduler under RobloxDatamining."
