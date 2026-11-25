-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:31:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local VirtualEvents = require(ServerDrivenUiParent.VirtualEvents)

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiErrors = SduiCoreSystem.SduiErrors
local SduiLogger = SduiCoreSystem.SduiLogger
local findAnalyticsFieldInAncestors = SduiCoreSystem.findAnalyticsFieldInAncestors

local tbl1 = {}

local function SduiVirtualEventImpressionsHandler(arg1, tbl2, tbl3, analyticsData, _: number?)
    if #tbl2 == 0 or #(tbl3 or tbl1) == 0 then
        SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToLogVirtualEventImpressions, {
            name = "SduiVirtualEventImpressionsHandler",
            message = `No entries to log: impressionIndexes={#tbl2}, itemAnalyticsDatas={#(tbl3 or tbl1)}`
        }, arg1.appPage)
        return
    end

    local channel = tostring(findAnalyticsFieldInAncestors("channel", { analyticsData = analyticsData }, arg1.appPage))

    local num1 = 0

    for _, value in tbl2 do
        local var1 = tbl3[value]
        if var1 == nil then
            continue
        end

        local eventId = var1.eventId
        if eventId == nil or eventId == "" then
            continue
        end

        VirtualEvents.fireVirtualEventImpression(
            {
                virtualEventId = tostring(eventId),
                universeId = tostring(var1.universeId or ""),
                channel = channel
            }
        )
        num1 += 1
    end

    if num1 == 0 then
        SduiLogger.reportError(
            SduiErrors.SduiErrorType.FailedToLogVirtualEventImpressions,
            {
                name = "SduiVirtualEventImpressionsHandler",
                message = "No valid items found for impression indexes"
            },
            arg1.appPage
        )
    end
end
return SduiVirtualEventImpressionsHandler
