-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:50:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local SduiCoreSystem = require(SduiSharedContentParent.SduiCoreSystem)
local getSduiClientPageScope = SduiCoreSystem.getSduiClientPageScope
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local SduiActionType = SduiCoreSystem.SduiActionType

local SduiActionParams = SduiCoreSystem.SduiActionParams
local getStringParam = SduiActionParams.getStringParam
local getBooleanParam = SduiActionParams.getBooleanParam

local function SduiSetPageScopeFieldAction(arg1, _, arg2, _)
    local actionParams = arg1 and arg1.actionParams or nil
    if actionParams == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.SetPageScopeField,
                message = "Missing actionParams"
            },
            arg2.appPage
        )
        return
    end

    local stringParam = getStringParam(actionParams, "fieldName")
    if stringParam == nil or stringParam == "" then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.SetPageScopeField,
                message = "Missing actionParam: fieldName",
                propName = "fieldName"
            },
            arg2.appPage
        )
        return
    end

    local stringParam2 = getStringParam(actionParams, "value")
    if stringParam2 == nil and actionParams.value ~= nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.SetPageScopeField,
                message = "actionParam value must be a string",
                propName = "value"
            },
            arg2.appPage
        )
        return
    end

    local configKey = arg2.configKey
    if configKey == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.FailedToExecuteAction,
            {
                name = SduiActionType.SetPageScopeField,
                message = "Missing sduiContext.configKey; no client page scope to write to"
            },
            arg2.appPage
        )
        return
    end

    local sduiClientPageScope = getSduiClientPageScope(configKey)
    if not getBooleanParam(actionParams, "setIfUnset", false) then
        sduiClientPageScope.set(stringParam, stringParam2)
        return
    end

    local var1 = sduiClientPageScope.get(stringParam)

    if var1 == nil or var1 == "" then
        sduiClientPageScope.set(stringParam, stringParam2)
    end
end

return SduiSetPageScopeFieldAction
