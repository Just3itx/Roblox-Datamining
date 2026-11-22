-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:01:15Z
-- Luau bytecode version: 14 | Luau type version: 3
local IAPExperienceParent = script:FindFirstAncestor("IAPExperience").Parent
local _LoggingProtocol = require(IAPExperienceParent.LoggingProtocol)

return {
    EconomicRestrictionsPromptCounter = {
        eventName = "InAppEconomicRestrictionPromptShown",
        backends = { "RobloxTelemetryCounter" },
        lastUpdated = { 2025, 8, 19 },
        description = "Counter for tracking the number of times the in-app economic restriction prompt is shown"
    },
    UniversalEconomicRestrictionsCounter = {
        eventName = "UniversalEconomicRestrictionPromptShown",
        backends = { "RobloxTelemetryCounter" },
        lastUpdated = { 2025, 8, 25 },
        description = "Counter for tracking the number of times economic restriction prompt is shown for all surfaces"
    },
    EconomicRestrictionsSurface = {
        InExperience = "InExperience",
        Gamepass = "Gamepass",
        DeveloperProduct = "DeveloperProduct",
        BulkPurchase = "BulkPurchase",
        AvatarExperience = "AvatarExperience",
        AvatarExperienceLook = "AvatarExperienceLook"
    }
}
