-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:31:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")
local DiscoveryAnalyticsParent = script:FindFirstAncestor("DiscoveryAnalytics").Parent

local t = require(DiscoveryAnalyticsParent.t)
local DiscoveryEventErrorLogger = require(DiscoveryAnalyticsParent.DiscoveryUtils).DiscoveryEventErrorLogger

local config = {
    eventName = "openSearchResultsWithQueryDeeplink",
    backends = { "EventIngest" },
    throttlingPercentage = game:DefineFastInt("OpenSearchResultsWithQueryDeeplinkEventThrottlingHundredthsPercent", 10000),
    lastUpdated = { 26, 6, 17 },
    description = "User opened Search Results via SDUI OpenSearchResultsWithQuery"
}

local var1 = t.strictInterface({ kwd = t.string, searchType = t.string })

return function(eventContext: string, customFields)
    local var2, var3 = var1(customFields)
    if not var2 then
        DiscoveryEventErrorLogger.reportError("OpenSearchResultsWithQueryDeeplinkInvalidInterface", var3)
    end

    TelemetryService:LogEvent(config, {
        eventContext = eventContext,
        standardizedFields = { "addSessionInfo", "addSessionId", "addOSInfo" },
        customFields = customFields
    })
end
