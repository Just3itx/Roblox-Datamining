-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:01:26Z
-- Luau bytecode version: 14 | Luau type version: 3
local IAPExperienceParent = script:FindFirstAncestor("IAPExperience").Parent

return {
    UnifiedProductPurchaseCompletionModalShownCounter = {
        eventName = "UnifiedProductPurchaseCompletionModalShownCounter",
        backends = { require(IAPExperienceParent.LoggingProtocol).TelemetryBackends.Counter },
        lastUpdated = { 2025, 10, 8 },
        throttlingPercentage = 100,
        description = "Counter fired when Unified Purchase Completion Modal is shown."
    }
}
