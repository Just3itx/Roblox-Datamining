-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:20:55Z
-- Luau bytecode version: 14 | Luau type version: 3
local InExperienceShopParent = script:FindFirstAncestor("InExperienceShop").Parent

return {
    eventName = "InExperienceShop_GlobalIconClick",
    backends = { require(InExperienceShopParent.LoggingProtocol).TelemetryBackends.EventIngest },
    lastUpdated = { 2026, 7, 6 },
    throttlingPercentage = 10000,
    description = "EventIngest event fired when the in-experience shop global top-bar icon is clicked.",
    links = ""
}
