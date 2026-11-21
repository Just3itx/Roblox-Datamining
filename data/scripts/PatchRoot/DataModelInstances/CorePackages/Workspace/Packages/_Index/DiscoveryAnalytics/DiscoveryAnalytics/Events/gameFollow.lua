-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")
local DiscoveryAnalyticsParent = script:FindFirstAncestor("DiscoveryAnalytics").Parent

local t = require(DiscoveryAnalyticsParent.t)
local DiscoveryEventErrorLogger = require(DiscoveryAnalyticsParent.DiscoveryUtils).DiscoveryEventErrorLogger

local FFlagLuaAppAddUniverseIdToEngagementEvents = require(DiscoveryAnalyticsParent.SharedFlags).FFlagLuaAppAddUniverseIdToEngagementEvents

local throttlingPercentage = game:DefineFastInt("GameFollowThrottleHundrethsPercent", 10000)

local var1 = t.strictInterface({
    placeId = t.string,
    state = t.union(t.literal("on"), t.literal("off")),
    ctx = t.string,
    uid = t.string,
    universeId = if FFlagLuaAppAddUniverseIdToEngagementEvents then t.optional(t.string) else nil
})

return function(customFields, eventContext: string)
    local var2, var3 = var1(customFields)
    if not var2 then
        DiscoveryEventErrorLogger.reportError("GameFollowInvalidInterface", var3)
    end

    TelemetryService:LogEvent(
        {
            eventName = "follow",
            backends = { "EventIngest" },
            throttlingPercentage = throttlingPercentage,
            lastUpdated = { 25, 11, 11 },
            description = "User has followed/unfollowed a game"
        },
        {
            eventContext = eventContext,
            standardizedFields = { "addSessionInfo" },
            customFields = customFields
        }
    )
end
