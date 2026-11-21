-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:31:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")
local DiscoveryAnalyticsParent = script:FindFirstAncestor("DiscoveryAnalytics").Parent

local t = require(DiscoveryAnalyticsParent.t)
local DiscoveryEventErrorLogger = require(DiscoveryAnalyticsParent.DiscoveryUtils).DiscoveryEventErrorLogger

local throttlingPercentage = game:DefineFastInt("GameDetailsSubpageThrottleHundrethsPercent", 10000)

local var1 = t.strictInterface({
    universeId = t.string,
    placeId = t.string,
    subpage = t.string,
    action = t.optional(t.string),
    uid = t.string,
    ctx = t.string
})

return function(customFields, eventContext: string)
    local var2, var3 = var1(customFields)
    if not var2 then
        DiscoveryEventErrorLogger.reportError("GameDetailsSubpageInvalidInterface", var3)
    end

    TelemetryService:LogEvent(
        {
            eventName = "gameDetailsSubpage",
            backends = { "EventIngest" },
            throttlingPercentage = throttlingPercentage,
            lastUpdated = { 25, 11, 11 },
            description = "User has navigated to a game details subpage"
        },
        {
            eventContext = eventContext,
            standardizedFields = { "addSessionInfo" },
            customFields = customFields
        }
    )
end
