-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:10:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local Charts = require(ServerDrivenUiParent.Charts)
local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiSharedUtilities = require(ServerDrivenUiParent.SduiSharedUtilities)

local SduiActionType = SduiCoreSystem.SduiActionType
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local SduiLoadTimer = SduiSharedUtilities.SduiLoadTimer
local refreshChartsSortDetailGenre = Charts.refreshChartsSortDetailGenre

local function reportInvalidActionParams(arg1, message: string, propName: string?) -- Luacid: Inlined by compiler; 3 call sites recovered
    arg1.dependencies.logger.reportError(
        SduiErrorType.InvalidActionParams,
        {
            name = SduiActionType.RefreshChartsSortDetail,
            message = message,
            propName = propName
        },
        arg1.appPage
    )
end

local function SduiRefreshChartsSortDetailAction(arg1, _, arg2)
    local actionParams = if arg1 then arg1.actionParams or nil else nil

    if actionParams == nil then
        reportInvalidActionParams(arg2, "Missing actionParams", nil)
        return
    end
    assert(actionParams, "actionParams must exist")

    local configKey = arg2.configKey
    if typeof(configKey) ~= "string" or configKey == "" then
        configKey = actionParams.configKey
    end
    if typeof(configKey) ~= "string" or configKey == "" then
        reportInvalidActionParams(arg2, `Invalid or missing configKey: {configKey}`, "configKey")
        return
    end

    local selectedOption = actionParams.selectedOption
    if typeof(selectedOption) ~= "string" or selectedOption == "" then
        reportInvalidActionParams(arg2, `Invalid or missing selectedOption: {selectedOption}`, "selectedOption")
        return
    end

    local loadTimer = SduiLoadTimer.createLoadTimer("ChartsSortDetail")
    loadTimer.start("refresh")

    local var1 = refreshChartsSortDetailGenre({ configKey = configKey, selectedGenre = selectedOption, loadTimer = loadTimer })

    if not var1 then
        return nil
    end
    var1:finally(function()
        loadTimer.logRefreshComplete()
    end)
    return var1
end

return SduiRefreshChartsSortDetailAction
