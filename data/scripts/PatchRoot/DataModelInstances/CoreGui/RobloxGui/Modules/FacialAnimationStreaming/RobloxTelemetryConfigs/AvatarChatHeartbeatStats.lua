-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:21:05Z
-- Luau bytecode version: 14 | Luau type version: 3
local CorePackages = game:GetService("CorePackages")
local LoggingProtocol = require(CorePackages.Workspace.Packages.LoggingProtocol)

game:DefineFastInt("AvatarChatHeartbeatStatsEventThrottleHundrethsPercent", 0)

return {
    eventName = "avatarChatHeartbeatStats",
    backends = { LoggingProtocol.TelemetryBackends.Points },
    throttlingPercentage = game:GetFastInt("AvatarChatHeartbeatStatsEventThrottleHundrethsPercent"),
    lastUpdated = { 23, 3, 15 },
    description = "Report Avatar Chat session heartbeat to EventIngest.",
    links = "https://roblox.atlassian.net/wiki/spaces/DA/pages/2025358355/Logging+Specs+Avatar+Chat+Heartbeat+Stats"
}
