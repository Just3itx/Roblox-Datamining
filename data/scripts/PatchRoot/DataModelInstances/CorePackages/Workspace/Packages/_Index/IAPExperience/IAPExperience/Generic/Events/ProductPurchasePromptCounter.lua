-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:01:20Z
-- Luau bytecode version: 14 | Luau type version: 3
local IAPExperienceParent = script:FindFirstAncestor("IAPExperience").Parent

return {
    ProductPurchasePromptCounter = {
        eventName = "ProductPurchaseErrorPromptShownCounter",
        backends = { require(IAPExperienceParent.LoggingProtocol).TelemetryBackends.Counter },
        lastUpdated = { 2025, 8, 26 },
        throttlingPercentage = 100,
        description = "Counter on all product purchase error prompt shown",
        links = ""
    }
}
