-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:21:30Z
-- Luau bytecode version: 14 | Luau type version: 3
local GenericChallengesParent = script:FindFirstAncestor("GenericChallenges").Parent

return {
    eventName = "accountSecurityChallengeBiometricEvent",
    backends = { require(GenericChallengesParent.LoggingProtocol).TelemetryBackends.EventIngest },
    throttlingPercentage = 10000,
    lastUpdated = { 25, 9, 11 },
    description = "Tracks lifecycle events for the Biometric GCS challenge",
    links = "https://roblox.atlassian.net/wiki/x/rQR02"
}
