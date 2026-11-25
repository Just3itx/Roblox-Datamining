-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:01:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent

local OpenAmpWizardContainer = require(ServerDrivenUiParent.AmpUpsell).OpenAmpWizardContainer

local onAmpWizardCompletion = require(ServerDrivenUi.Actions.onAmpWizardCompletion)

local FFlagLuaAppDismissUnlockUpsell = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppDismissUnlockUpsell

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local SduiActionType = SduiCoreSystem.SduiActionType

local function noopCompletion(_, _) end

return function(arg1, _, arg2, _)
    local actionParams = arg1 and arg1.actionParams or nil
    if actionParams == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.OpenAmpWizard,
                message = "Missing actionParams"
            },
            arg2.appPage
        )
        return
    end
    assert(actionParams, "actionParams must exist")

    local featureName = actionParams.featureName
    if featureName == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.OpenAmpWizard,
                message = "Missing actionParam: featureName",
                propName = "featureName"
            },
            arg2.appPage
        )
        return
    end

    local entryPointEventCtx = actionParams.entryPointEventCtx
    local nameSpace = actionParams.nameSpace
    local skipFacialAgeEstimationWebLinkModal = actionParams.skipFacialAgeEstimationWebLinkModal

    local dispatch = arg2.dependencies.dispatch
    local var1 = if FFlagLuaAppDismissUnlockUpsell then onAmpWizardCompletion else noopCompletion
    dispatch(
        OpenAmpWizardContainer(featureName, var1, nil, entryPointEventCtx, nil, nameSpace, skipFacialAgeEstimationWebLinkModal)
    )
end
