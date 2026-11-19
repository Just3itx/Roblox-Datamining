-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local LoggingProtocol = require(CorePackages.Workspace.Packages.LoggingProtocol)

local RobloxGui = CoreGui:WaitForChild("RobloxGui")

local FIntMenuButtonsThrottleHundredthsPercent = require(RobloxGui.Modules.Settings.Flags.FIntMenuButtonsThrottleHundredthsPercent)

return {
    eventName = "experienceMenuResetCharacter",
    backends = { LoggingProtocol.TelemetryBackends.Counter },
    throttlingPercentage = FIntMenuButtonsThrottleHundredthsPercent,
    lastUpdated = { 25, 4, 23 },
    description = "Report when respawn button in experience menu is activated"
}
