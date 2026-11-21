-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")
local DiscoveryAnalyticsParent = script:FindFirstAncestor("DiscoveryAnalytics").Parent

local t = require(DiscoveryAnalyticsParent.t)
local DiscoveryEventErrorLogger = require(DiscoveryAnalyticsParent.DiscoveryUtils).DiscoveryEventErrorLogger

local FFlagLuaAppAddUniverseIdToEngagementEvents = require(DiscoveryAnalyticsParent.SharedFlags).FFlagLuaAppAddUniverseIdToEngagementEvents

local throttlingPercentage = game:DefineFastInt("GameVoteThrottleHundrethsPercent", 0)

local var1 = t.strictInterface({
    placeId = t.string,
    vote = t.union(t.literal("UpVoted"), t.literal("DownVoted"), t.literal("NotVoted")),
    prevVote = t.union(t.literal("UpVoted"), t.literal("DownVoted"), t.literal("NotVoted")),
    uid = t.string,
    targetId = if FFlagLuaAppAddUniverseIdToEngagementEvents then t.optional(t.string) else nil
})

return function(customFields, eventContext: string)
    local var2, var3 = var1(customFields)
    if not var2 then
        DiscoveryEventErrorLogger.reportError("GameVoteInvalidInterface", var3)
    end

    TelemetryService:LogEvent(
        {
            eventName = "vote",
            backends = { "EventIngest" },
            throttlingPercentage = throttlingPercentage,
            lastUpdated = { 25, 11, 11 },
            description = "User has voted on a game"
        },
        {
            eventContext = eventContext,
            standardizedFields = { "addSessionInfo" },
            customFields = customFields
        }
    )
end
