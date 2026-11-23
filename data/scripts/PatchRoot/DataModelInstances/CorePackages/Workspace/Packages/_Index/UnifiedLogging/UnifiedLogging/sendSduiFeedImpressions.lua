-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:20:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")
local UnifiedLoggingParent = script:FindFirstAncestor("UnifiedLogging").Parent

local t = require(UnifiedLoggingParent.t)
local DiscoveryEventErrorLogger = require(UnifiedLoggingParent.DiscoveryUtils).DiscoveryEventErrorLogger

local config = {
    eventName = "sduiFeedImpressions",
    backends = { "EventIngest" },
    throttlingPercentage = game:DefineFastInt("LuaAppFeedImpressionsHundredthsPercent", 10000),
    lastUpdated = { 26, 5, 11 },
    description = "Feed-level section impressions for SDUI feed containers (e.g. SduiVerticalFeed)"
}

local var1 = t.strictInterface(
    {
        pageContext = t.string,
        feedItemPositions = t.string,
        feedCollectionIds = t.string,
        feedComponentTypes = t.string
    }
)
local function sendSduiFeedImpressions(tbl1, tbl2, tbl3, str1: string)
    if #tbl1 == 0 then
        return
    end

    if #tbl1 ~= #tbl2 or #tbl1 ~= #tbl3 then
        DiscoveryEventErrorLogger.reportError(
            "SendSduiFeedImpressionsArrayLengthMismatch",
            `feedItemPositions ({#tbl1}), feedCollectionIds ({#tbl2}), and feedComponentTypes ({#tbl3}) must have equal length`,
            {
                feedItemPositionsCount = #tbl1,
                feedCollectionIdsCount = #tbl2,
                feedComponentTypesCount = #tbl3
            }
        )
        return
    end

    local customFields = {
        pageContext = str1,
        feedItemPositions = table.concat(tbl1, ","),
        feedCollectionIds = table.concat(tbl2, ","),
        feedComponentTypes = table.concat(tbl3, ",")
    }

    local var2, var3 = var1(customFields)
    if not var2 then
        DiscoveryEventErrorLogger.reportError("SduiFeedImpressionsEventInvalidInterface", var3)
        return
    end

    TelemetryService:LogEvent(config, {
        eventContext = str1,
        standardizedFields = { "addSessionInfo", "addSessionId", "addOSInfo" },
        customFields = customFields
    })
end

return sendSduiFeedImpressions
