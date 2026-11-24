-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:31:07Z
-- Luau bytecode version: 14 | Luau type version: 3
local GenericChallengesParent = script:FindFirstAncestor("GenericChallenges").Parent

return {
    eventName = "accountSecurityChallengeDeviceIntegrityEvent",
    backends = { require(GenericChallengesParent.LoggingProtocol).TelemetryBackends.EventIngest },
    throttlingPercentage = 10000,
    lastUpdated = { 24, 1, 22 },
    description = "Tracks lifecycle events for the Device Integrity GCS challenge",
    links = "https://roblox.atlassian.net/wiki/spaces/BaS/pages/2184872709/Bypassing+Challenges+for+Xbox+PS+Quest+etc+Requests#Event-Tracking"
}
