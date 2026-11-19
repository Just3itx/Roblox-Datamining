-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:21:07Z
-- Luau bytecode version: 14 | Luau type version: 3
local CorePackages = game:GetService("CorePackages")
local LoggingProtocol = require(CorePackages.Workspace.Packages.LoggingProtocol)

game:DefineFastInt("AvatarChatSubsessionInputEventThrottleHundrethsPercent", 0)

return {
    eventName = "avatarChatSubsessionInput",
    backends = { LoggingProtocol.TelemetryBackends.EventIngest },
    throttlingPercentage = game:GetFastInt("AvatarChatSubsessionInputEventThrottleHundrethsPercent"),
    lastUpdated = { 22, 10, 17 },
    description = "Report user camera/mic settings for Avatar Chat to EventIngest.",
    links = "https://roblox.atlassian.net/wiki/spaces/DA/pages/1857851197/Logging+Specs+Subsession+Analytics"
}
