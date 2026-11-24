-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:30:55Z
-- Luau bytecode version: 14 | Luau type version: 3
local GenericChallengesParent = script:FindFirstAncestor("GenericChallenges").Parent

return {
    eventName = "accountSecurityChallengeDeniedEvent",
    backends = { require(GenericChallengesParent.LoggingProtocol).TelemetryBackends.EventIngest },
    throttlingPercentage = 10000,
    lastUpdated = { 26, 11, 4 },
    description = "Tracks lifecycle events for the native Denied GCS challenge"
}
