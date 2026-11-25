-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:01:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local navigateToChartsSortDetailPage = require(ServerDrivenUiParent.Charts).navigateToChartsSortDetailPage

local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local SduiActionType = SduiCoreSystem.SduiActionType

return function(arg1, _, arg2, _)
    local actionParams = arg1 and arg1.actionParams or nil
    if actionParams == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.OpenChartsSortDetail,
                message = "Missing actionParams"
            },
            arg2.appPage
        )
        return
    end

    local sortId = actionParams.sortId or actionParams.sort_id
    if sortId == nil or sortId == "" then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.OpenChartsSortDetail,
                message = "Missing sortId"
            },
            arg2.appPage
        )
        return
    end

    navigateToChartsSortDetailPage(arg2.dependencies.getNavigation(), { sortId = sortId, pageContext = arg2.appPage })
end
