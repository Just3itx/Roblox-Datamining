-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:01:16Z
-- Luau bytecode version: 14 | Luau type version: 3
local IAPExperienceParent = script:FindFirstAncestor("IAPExperience").Parent

return {
    LegacyUpsellShownCounter = {
        eventName = "LegacyUpsellShownCounter",
        backends = { require(IAPExperienceParent.LoggingProtocol).TelemetryBackends.Counter },
        lastUpdated = { 2025, 7, 15 },
        throttlingPercentage = 100,
        description = "Counter on all legacy upsell shown",
        links = ""
    }
}
