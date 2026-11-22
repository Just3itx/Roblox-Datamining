-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:01:17Z
-- Luau bytecode version: 14 | Luau type version: 3
local IAPExperienceParent = script:FindFirstAncestor("IAPExperience").Parent
local LoggingProtocol = require(IAPExperienceParent.LoggingProtocol)

return {
    MultiplePackageUpsellShownCounter = {
        eventName = "MultiplePackageUpsellShownCounter",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        lastUpdated = { 2025, 5, 1 },
        throttlingPercentage = 100,
        description = "Counter on all multiple package upsell shown",
        links = ""
    },
    MultiplePackageUpsellSelectedCounter = {
        eventName = "MultiplePackageUpsellSelectedCounter",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        lastUpdated = { 2025, 5, 1 },
        throttlingPercentage = 100,
        description = "Counter on all multiple package upsell selections"
    },
    MultiplePackageUpsellModalClosedCounter = {
        eventName = "MultiplePackageUpsellModalClosedCounter",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        lastUpdated = { 2025, 5, 1 },
        throttlingPercentage = 100,
        description = "Counter on all multiple package upsell modal closed"
    },
    MultiplePackageUpsellModalBuyClickedCounter = {
        eventName = "MultiplePackageUpsellModalBuyClickedCounter",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        lastUpdated = { 2025, 5, 1 },
        throttlingPercentage = 100,
        description = "Counter on all multiple package upsell modal buy clicked"
    }
}
