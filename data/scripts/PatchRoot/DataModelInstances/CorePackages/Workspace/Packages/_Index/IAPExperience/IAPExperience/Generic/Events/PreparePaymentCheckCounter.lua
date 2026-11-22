-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:01:19Z
-- Luau bytecode version: 14 | Luau type version: 3
local IAPExperienceParent = script:FindFirstAncestor("IAPExperience").Parent

return {
    eventName = "PreparePaymentCheckCounter",
    backends = { require(IAPExperienceParent.LoggingProtocol).TelemetryBackends.Counter },
    lastUpdated = { 2024, 9, 27 },
    throttlingPercentage = 100,
    description = "Counter on all preparePayment check",
    links = ""
}
