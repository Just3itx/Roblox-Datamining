-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:31:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local TelemetryService = game:GetService("TelemetryService")

local SduiErrors = require(ServerDrivenUiParent.SduiCoreSystem).SduiErrors

local throttlingPercentage = game:DefineFastInt("SduiQueryImpressionsThrottlingHundredthsPercent", 10000)

local function SduiQueryImpressionsHandler(arg1, tbl1, tbl2, arg2, _: number?)
    if not arg2 then
        arg1.dependencies.logger.reportError(
            SduiErrors.SduiErrorType.FailedToLogQueryImpressions,
            { name = "SduiQueryImpressionsHandler", message = "Missing collectionAnalyticsData" },
            arg1.appPage
        )
        return
    end

    if #tbl1 == 0 or #tbl2 == 0 then
        return
    end

    local tbl3 = {}
    local tbl4 = {}

    for _, value in tbl1 do
        local var1 = tbl2[value]
        if var1 then
            table.insert(tbl3, value)
            table.insert(tbl4, var1.queryText or "")
        else
            arg1.dependencies.logger.reportError(
                SduiErrors.SduiErrorType.FailedToLogQueryImpressions,
                {
                    name = "SduiQueryImpressionsHandler",
                    message = `Missing itemData at index {value}`
                },
                arg1.appPage
            )
        end
    end
    if #tbl4 == 0 then
        return
    end

    local config = {
        eventName = "queryImpressions",
        backends = { "EventIngest" },
        throttlingPercentage = throttlingPercentage,
        lastUpdated = { 26, 6, 24 },
        description = "Fired when query suggestion items are visible in an SDUI collection"
    }

    TelemetryService:LogEvent(config, {
        eventContext = arg1.appPage,
        standardizedFields = { "addSessionInfo", "addSessionId", "addOSInfo" },
        customFields = {
            absPositions = table.concat(tbl3, ","),
            queryTexts = table.concat(tbl4, ","),
            sortPos = arg2.collectionPosition,
            sortId = tostring(arg2.collectionId),
            componentType = arg2.collectionComponentType or "Pill"
        }
    })
end

return SduiQueryImpressionsHandler
