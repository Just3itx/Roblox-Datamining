-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:40:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")

local DiscoveryAnalyticsParent = script:FindFirstAncestor("DiscoveryAnalytics").Parent

local getPlatformTarget = require(DiscoveryAnalyticsParent.Analytics).getPlatformTarget

local throttlingPercentage = game:DefineFastInt("LuaAppSduiGameDwellThrottlingPercentage", 10000)

local tbl1 = {
    gameDwellStart = {
        eventName = "gameDwellStart",
        backends = { "EventIngest" },
        throttlingPercentage = throttlingPercentage,
        lastUpdated = { 26, 11, 3 },
        description = "Starts observed game tile dwell on opted-in SDUI collections"
    },
    gameDwellEnd = {
        eventName = "gameDwellEnd",
        backends = { "EventIngest" },
        throttlingPercentage = throttlingPercentage,
        lastUpdated = { 26, 11, 3 },
        description = "Ends observed game tile dwell on opted-in SDUI collections"
    }
}

return function(str1: string, customFields, eventContext: string)
    TelemetryService:LogEvent(tbl1[str1], {
        eventContext = eventContext,
        standardizedFields = { "addSessionInfo", "addSessionId", "addOSInfo" },
        customFields = customFields,
        legacyOverrideTargetForEventIngest = getPlatformTarget()
    })
end
