-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:40:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")
local DiscoveryAnalyticsParent = script:FindFirstAncestor("DiscoveryAnalytics").Parent

local t = require(DiscoveryAnalyticsParent.t)
local DiscoveryEventErrorLogger = require(DiscoveryAnalyticsParent.DiscoveryUtils).DiscoveryEventErrorLogger

local config = {
    eventName = "querySuggestionClicked",
    backends = { "EventIngest" },
    throttlingPercentage = game:DefineFastInt("QuerySuggestionClickedEventThrottlingHundredthsPercent", 10000),
    lastUpdated = { 26, 8, 13 },
    description = "User clicked a query suggestion"
}

local var1 = t.strictInterface({
    pos = t.optional(t.number),
    sortPos = t.optional(t.number),
    sortId = t.optional(t.string),
    queryText = t.string,
    componentType = t.string
})

return function(eventContext: string, customFields)
    local var2, var3 = var1(customFields)
    if not var2 then
        DiscoveryEventErrorLogger.reportError("QuerySuggestionClickedInvalidInterface", var3)
    end

    TelemetryService:LogEvent(config, {
        eventContext = eventContext,
        standardizedFields = { "addSessionInfo", "addSessionId", "addOSInfo" },
        customFields = customFields
    })
end
