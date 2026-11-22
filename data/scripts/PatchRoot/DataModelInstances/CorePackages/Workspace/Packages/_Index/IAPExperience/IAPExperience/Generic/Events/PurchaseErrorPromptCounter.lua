-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
local IAPExperienceParent = script:FindFirstAncestor("IAPExperience").Parent
local LoggingProtocol = require(IAPExperienceParent.LoggingProtocol)

return {
    PurchaseErrorPromptShownCounter = {
        eventName = "PurchaseErrorPromptShownCounter",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        lastUpdated = { 2025, 5, 20 },
        throttlingPercentage = 100,
        description = "Counter on all purchase error prompt shown",
        links = ""
    },
    EconomicRestrictionsPromptShownCounter = {
        eventName = "EconomicRestrictionsPromptShownCounter",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        lastUpdated = { 2025, 5, 20 },
        throttlingPercentage = 100,
        description = "Counter on all economic restrictions prompt shown",
        links = ""
    }
}
