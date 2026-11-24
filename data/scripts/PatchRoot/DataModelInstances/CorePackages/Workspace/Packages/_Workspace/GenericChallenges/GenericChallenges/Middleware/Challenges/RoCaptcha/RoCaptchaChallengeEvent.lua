-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
local GenericChallengesParent = script:FindFirstAncestor("GenericChallenges").Parent

return {
    eventName = "accountSecurityChallengeRoCaptchaEvent",
    backends = { require(GenericChallengesParent.LoggingProtocol).TelemetryBackends.EventIngest },
    throttlingPercentage = 10000,
    lastUpdated = { 26, 10, 27 },
    description = "Tracks lifecycle events for the RoCaptcha GCS challenge",
    links = "https://docs.google.com/document/d/10lZvtSW6yN8uhNzo6628hYpHi_61YeHrGxjaqWum6Ko"
}
