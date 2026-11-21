-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:40:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")
local DiscoveryAnalyticsParent = script:FindFirstAncestor("DiscoveryAnalytics").Parent

local t = require(DiscoveryAnalyticsParent.t)
local DiscoveryEventErrorLogger = require(DiscoveryAnalyticsParent.DiscoveryUtils).DiscoveryEventErrorLogger

local config = {
    eventName = "showMoreClick",
    backends = { "EventIngest", "Points" },
    throttlingPercentage = game:DefineFastInt("LuaAppShowMoreClickEventThrottlingHundredthsPercent", 10000),
    lastUpdated = { 26, 5, 12 },
    description = "User clicked the show more button to reveal additional rows in a home game grid"
}

local var1 = t.strictInterface({
    topicId = t.string,
    sortIndex = t.number,
    previousVisibleRows = t.number,
    newVisibleRows = t.number,
    visibleRowsPerReveal = t.number,
    totalNumberOfRows = t.number
})

return function(eventContext, customFields)
    local var2, var3 = var1(customFields)
    if not var2 then
        DiscoveryEventErrorLogger.reportError("ShowMoreClickEventInvalidInterface", var3)
    end

    TelemetryService:LogEvent(config, {
        eventContext = eventContext,
        standardizedFields = { "addSessionInfo", "addSessionId", "addOSInfo" },
        customFields = customFields
    })
end
