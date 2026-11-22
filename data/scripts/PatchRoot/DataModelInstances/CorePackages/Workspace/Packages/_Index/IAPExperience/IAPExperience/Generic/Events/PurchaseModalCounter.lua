-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:01:22Z
-- Luau bytecode version: 14 | Luau type version: 3
local IAPExperienceParent = script:FindFirstAncestor("IAPExperience").Parent
local LoggingProtocol = require(IAPExperienceParent.LoggingProtocol)

return {
    PurchaseModalV1ShownCounter = {
        eventName = "PurchaseModalV1ShownCounter",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        lastUpdated = { 2025, 8, 4 },
        throttlingPercentage = 100,
        description = "Counter fired when In Experience Purchase Modal v1 is shown",
        links = ""
    },
    PurchaseModalV2ShownCounter = {
        eventName = "PurchaseModalV2ShownCounter",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        lastUpdated = { 2025, 8, 4 },
        throttlingPercentage = 100,
        description = "Counter fired when In Experience Purchase Modal v2 is shown",
        links = ""
    }
}
