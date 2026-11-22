-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:01:25Z
-- Luau bytecode version: 14 | Luau type version: 3
local IAPExperienceParent = script:FindFirstAncestor("IAPExperience").Parent
local LoggingProtocol = require(IAPExperienceParent.LoggingProtocol)

return {
    TooExpensiveUpsellShownCounter = {
        eventName = "TooExpensiveUpsellShownCounter",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        lastUpdated = { 2025, 7, 29 },
        throttlingPercentage = 100,
        description = "Counter fired when Robux too expensive upsell modal shown",
        links = ""
    },
    TooExpensiveUpsellFallbackShownCounter = {
        eventName = "TooExpensiveUpsellFallbackShownCounter",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        lastUpdated = { 2025, 7, 29 },
        throttlingPercentage = 100,
        description = "Counter fired when Robux too expensive fallback modal shown",
        links = ""
    },
    TooExpensiveUnifiedUpsellShownCounter = {
        eventName = "TooExpensiveUnifiedUpsellShownCounter",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        lastUpdated = { 2025, 9, 29 },
        throttlingPercentage = 100,
        description = "Counter fired when Robux too expensive unified upsell modal shown",
        links = ""
    }
}
