-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContent = script:FindFirstAncestor("SduiSharedContent")
local SduiSharedContentParent = SduiSharedContent.Parent

local SduiCoreSystem = require(SduiSharedContentParent.SduiCoreSystem)
local ToastRodux = require(SduiSharedContentParent.ToastRodux)

local SetCurrentToastMessage = ToastRodux.Actions.SetCurrentToastMessage
local ToastType = ToastRodux.Enums.ToastType

local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local SduiActionType = SduiCoreSystem.SduiActionType
local getSduiActionHandlerRegistry = SduiCoreSystem.getSduiActionHandlerRegistry

local SduiActionParams = SduiCoreSystem.SduiActionParams
local getStringParam = SduiActionParams.getStringParam
local getBooleanParam = SduiActionParams.getBooleanParam

local SduiDismissPromptAction = require(SduiSharedContent.Actions.SduiDismissPromptAction)

local FFlagSduiDismissPromptAction = require(SduiSharedContentParent.SharedFlags).FFlagSduiDismissPromptAction
local FFlagLuaAppSduiMovePromptsActions = require(SduiSharedContentParent.SharedFlags).FFlagLuaAppSduiMovePromptsActions

local function SduiShowToastAction(arg1, arg2, arg3, _)
    local actionParams = arg1 and arg1.actionParams or nil
    if actionParams == nil then
        arg3.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.ShowToast,
                message = "Missing actionParams"
            },
            arg3.appPage
        )
        return
    end

    local toastMessage = getStringParam(actionParams, "toastMessage")
    if toastMessage == nil then
        arg3.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.ShowToast,
                message = "Missing actionParam: toastMessage",
                propName = "toastMessage"
            },
            arg3.appPage
        )
        return
    end

    local stringParam2 = getStringParam(actionParams, "toastType")
    local toastType = if stringParam2 and ToastType[stringParam2] then ToastType[stringParam2] else ToastType.SuccessConfirmation
    arg3.dependencies.dispatch(
        SetCurrentToastMessage({ toastMessage = toastMessage, isLocalized = true, toastType = toastType })
    )

    if not FFlagSduiDismissPromptAction or not getBooleanParam(actionParams, "dismissPrompt", false) then
        return
    end

    local tbl1 = {
        actionType = SduiActionType.DismissPrompt,
        actionParams = {
            promptType = actionParams.promptType,
            promptId = actionParams.promptId
        }
    }
    if not FFlagLuaAppSduiMovePromptsActions then
        SduiDismissPromptAction(tbl1, arg2, arg3)
        return
    end

    local var2 = getSduiActionHandlerRegistry().getActionHandlerConfig(SduiActionType.DismissPrompt)
    if var2 and var2.handler then
        var2.handler(tbl1, arg2, arg3)
        return
    end
    arg3.dependencies.logger.reportError(
        SduiErrorType.FailedToExecuteAction,
        {
            name = SduiActionType.ShowToast,
            message = "DismissPrompt handler is not registered",
            propName = "dismissPrompt"
        },
        arg3.appPage
    )
end

return SduiShowToastAction
