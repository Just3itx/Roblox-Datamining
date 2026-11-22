-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:50:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialServerDrivenUiParent = script:FindFirstAncestor("SocialServerDrivenUi").Parent

local SduiCoreSystem = require(SocialServerDrivenUiParent.SduiCoreSystem)
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local SduiActionType = SduiCoreSystem.SduiActionType

local createProfileCompletionPromptsConfig = require(SocialServerDrivenUiParent.ProfilePlatformCommon).Utils.createProfileCompletionPromptsConfig

local ServerTriggeredModals = require(SocialServerDrivenUiParent.ServerTriggeredModals)
local fetchPrompts = ServerTriggeredModals.fetchPrompts
local reportPromptImpression = ServerTriggeredModals.reportPromptImpression

local SetCurrentToastMessage = require(SocialServerDrivenUiParent.ToastRodux).Actions.SetCurrentToastMessage

return function(arg1, _, arg2, _)
    local actionParams = arg1 and arg1.actionParams or nil
    if actionParams == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.HideProfileCompletion,
                message = "Missing actionParams"
            },
            arg2.appPage
        )
        return
    end

    local promptType = actionParams.promptType
    if promptType == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.HideProfileCompletion,
                message = "Missing actionParam: promptType",
                propName = "promptType"
            },
            arg2.appPage
        )
        return
    end

    local promptId = actionParams.promptId

    reportPromptImpression(promptType, promptId):andThen(function()
        fetchPrompts(createProfileCompletionPromptsConfig(), true)
    end):catch(function()
        arg2.dependencies.dispatch(SetCurrentToastMessage({ toastMessage = "Feature.Toast.NetworkingError.SomethingIsWrong" }))
    end)
end
