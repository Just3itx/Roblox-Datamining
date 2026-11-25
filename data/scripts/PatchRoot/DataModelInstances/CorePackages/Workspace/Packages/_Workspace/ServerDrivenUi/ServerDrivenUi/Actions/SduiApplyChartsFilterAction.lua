-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:00:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiLoadTimer = require(ServerDrivenUiParent.SduiSharedUtilities).SduiLoadTimer
local getSduiClientPageScope = SduiCoreSystem.getSduiClientPageScope
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local SduiActionType = SduiCoreSystem.SduiActionType

return function(arg1, _, arg2)
    local actionParams = arg1 and arg1.actionParams or nil
    if actionParams == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.ApplyChartsFilter,
                message = "Missing actionParams"
            },
            arg2.appPage
        )
        return
    end

    if arg2.configKey == nil then
        arg2.dependencies.logger.reportError(SduiErrorType.InvalidActionParams, {
            name = SduiActionType.ApplyChartsFilter,
            message = "Missing sduiContext.configKey; filter selections cannot be persisted in client page scope"
        }, arg2.appPage)
        return
    end

    local filterSelections = actionParams.filterSelections

    local charts = require(ServerDrivenUiParent.Charts)
    getSduiClientPageScope(arg2.configKey).set(charts.ChartsPageScopeFields.FilterSelections, filterSelections)

    local loadTimer = SduiLoadTimer.createLoadTimer("ChartsPage")
    loadTimer.start("filter_refetch")
    local var1 = charts.fetchChartsPage(loadTimer, true)
    if var1 then
        var1:finally(function()
            loadTimer.logRefreshComplete()
        end)
    end
    return var1
end
