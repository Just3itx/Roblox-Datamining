-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:31:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")
local DiscoveryAnalyticsParent = script:FindFirstAncestor("DiscoveryAnalytics").Parent

local t = require(DiscoveryAnalyticsParent.t)
local DiscoveryEventErrorLogger = require(DiscoveryAnalyticsParent.DiscoveryUtils).DiscoveryEventErrorLogger

local throttlingPercentage = game:DefineFastInt("GameJoinFriendsInGameThrottleHundrethsPercent", 10000)

local var1 = t.strictInterface({ placeId = t.string, uid = t.string, ctx = t.string })

local config = {
    eventName = "joinFriendsInGame",
    backends = { "EventIngest" },
    throttlingPercentage = throttlingPercentage,
    lastUpdated = { 26, 4, 29 },
    description = "User joined friends in game from experience details overflow"
}

local standardizedFields = { "addSessionInfo" }

return function(customFields, eventContext: string)
    local var2, var3 = var1(customFields)
    if not var2 then
        DiscoveryEventErrorLogger.reportError("GameJoinFriendsInGameInvalidInterface", var3)
    end

    TelemetryService:LogEvent(
        config,
        {
            eventContext = eventContext,
            standardizedFields = standardizedFields,
            customFields = customFields
        }
    )
end
