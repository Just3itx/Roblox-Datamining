-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:01:27Z
-- Luau bytecode version: 14 | Luau type version: 3
local IAPExperienceParent = script:FindFirstAncestor("IAPExperience").Parent

return {
    VirtualItemBadgeShownCounter = {
        eventName = "VirtualItemBadgeShownCounter",
        backends = { require(IAPExperienceParent.LoggingProtocol).TelemetryBackends.Counter },
        lastUpdated = { 2025, 5, 15 },
        throttlingPercentage = 100,
        description = "Counter on all virtual item badge shown",
        links = ""
    }
}
