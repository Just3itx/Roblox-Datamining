-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:31:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local filterImpressionsEvent = require(ServerDrivenUiParent.GameFilters).filterImpressionsEvent

local SduiErrors = require(ServerDrivenUiParent.SduiCoreSystem).SduiErrors

local function SduiFilterImpressionsHandler(arg1, tbl1, tbl2, arg2, _: number?)
    if not arg2 then
        arg1.dependencies.logger.reportError(
            SduiErrors.SduiErrorType.FailedToLogFilterImpressions,
            { name = "SduiFilterImpressionsHandler", message = "Missing collectionAnalyticsData" },
            arg1.appPage
        )
        return
    end

    if #tbl1 == 0 or #tbl2 == 0 then
        return
    end

    local tbl3 = {}
    local tbl4 = {}
    local tbl5 = {}
    local tbl6 = {}

    for _, value in tbl1 do
        local var1 = tbl2[value]
        if var1 then
            table.insert(tbl3, value)
            table.insert(tbl4, var1.filterId or var1.id)
            table.insert(tbl5, var1.selectedOptionId or "")
            table.insert(tbl6, var1.selectedOptionContextTag or "0")
        else
            arg1.dependencies.logger.reportError(
                SduiErrors.SduiErrorType.FailedToLogFilterImpressions,
                {
                    name = "SduiFilterImpressionsHandler",
                    message = `Missing itemData at index {value}`
                },
                arg1.appPage
            )
        end
    end
    if #tbl4 == 0 then
        return
    end

    filterImpressionsEvent(arg1.dependencies.eventIngest, arg1.appPage, {
        absPositions = table.concat(tbl3, ","),
        filterIds = table.concat(tbl4, ","),
        selectedOptionIds = table.concat(tbl5, ","),
        selectedOptionContextTags = table.concat(tbl6, ","),
        gameSetTypeId = tostring(arg2.collectionId),
        gameSetTargetId = arg2.gameSetTargetId,
        sortPos = arg2.collectionPosition
    })
end

return SduiFilterImpressionsHandler
