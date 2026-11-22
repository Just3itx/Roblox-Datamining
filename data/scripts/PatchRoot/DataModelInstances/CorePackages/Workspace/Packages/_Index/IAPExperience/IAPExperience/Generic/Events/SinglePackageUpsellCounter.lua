-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
local IAPExperienceParent = script:FindFirstAncestor("IAPExperience").Parent
local LoggingProtocol = require(IAPExperienceParent.LoggingProtocol)

return {
    SinglePackageUpsellShownCounter = {
        eventName = "SinglePackageUpsellShownCounter",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        lastUpdated = { 2025, 5, 1 },
        throttlingPercentage = 100,
        description = "Counter on all multiple package upsell shown",
        links = ""
    },
    SinglePackageUpsellModalClosedCounter = {
        eventName = "SinglePackageUpsellModalClosedCounter",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        lastUpdated = { 2025, 5, 1 },
        throttlingPercentage = 100,
        description = "Counter on all single package upsell modal closed"
    },
    SinglePackageUpsellModalBuyClickedCounter = {
        eventName = "SinglePackageUpsellModalBuyClickedCounter",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        lastUpdated = { 2025, 5, 1 },
        throttlingPercentage = 100,
        description = "Counter on all single package upsell modal buy clicked"
    }
}
