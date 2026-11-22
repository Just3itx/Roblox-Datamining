-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:50:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialServerDrivenUiParent = script:FindFirstAncestor("SocialServerDrivenUi").Parent
local AppPage = require(SocialServerDrivenUiParent.RobloxAppEnums).AppPage

local SduiCoreSystem = require(SocialServerDrivenUiParent.SduiCoreSystem)
local SocialUpsell = require(SocialServerDrivenUiParent.SocialUpsell)

local startFacialAgeEstimation = SocialUpsell.Thunks.startFacialAgeEstimation
local SocialUpsellType = SocialUpsell.Enums.SocialUpsellType
local UpsellEntrySurfaceType = SocialUpsell.Analytics.Enum.UpsellEntrySurfaceType

local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local SduiActionType = SduiCoreSystem.SduiActionType

return function(arg1, _, arg2, _)
    local actionParams = arg1 and arg1.actionParams or nil
    if actionParams == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.OpenFacialAgeEstimation,
                message = "Missing actionParams"
            },
            arg2.appPage
        )
        return
    end

    assert(actionParams, "actionParams must exist")
    local source = actionParams.source
    if source == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.OpenFacialAgeEstimation,
                message = "Missing actionParam: source",
                propName = "source"
            },
            arg2.appPage
        )
    end

    local var1 = if source == AppPage.ProfilePlatform then SocialUpsellType.FacialAgeEstimation .. UpsellEntrySurfaceType.ProfileCompletion else SocialUpsellType.FacialAgeEstimation .. UpsellEntrySurfaceType.Unknown
    arg2.dependencies.dispatch(startFacialAgeEstimation(var1, nil, nil, source, false))
end
