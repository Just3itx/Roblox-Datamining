-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent

local CentralOverlay = require(AppBloxParent.CentralOverlay)
local _Foundation = require(AppBloxParent.Foundation)
local Localization = require(AppBloxParent.Localization)
local React = require(AppBloxParent.React)
local RoactUtils = require(AppBloxParent.RoactUtils)
local RobloxAppEnums = require(AppBloxParent.RobloxAppEnums)

local CloseCentralOverlay = CentralOverlay.Thunks.CloseCentralOverlay
local SetCentralOverlay = CentralOverlay.Actions.SetCentralOverlay
local useLocalization = Localization.Hooks.useLocalization
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local CentralOverlayType = RobloxAppEnums.CentralOverlayType

local _CheckboxFeedbackFormModal = require(script.Parent.CheckboxFeedbackFormModal)
local SnackbarWrapper = require(script.Parent.SnackbarWrapper)

return React.memo(function(tbl1) -- name: ProvideFeedbackToast
    local var1 = useDispatch()
    local var2 = useLocalization({
        giveFeedback = "Feature.GameDetails.Action.GiveFeedback",
        helpUsImprove = "Feature.GameDetails.Message.HelpImproveExperience"
    })

    local onButtonActivated = React.useCallback(function()
        if tbl1.onToastActivated then
            task.spawn(tbl1.onToastActivated)
        end
        var1(SetCentralOverlay(CentralOverlayType.CheckboxFeedbackFormModal, tbl1.feedbackFormProps))
    end, { tbl1.onToastActivated, var1, tbl1.feedbackFormProps })

    local closeSnackbar = React.useCallback(function()
        if tbl1.onToastDismissed then
            task.spawn(tbl1.onToastDismissed)
        end
        var1(CloseCentralOverlay())
    end, { tbl1.onToastDismissed, var1 })

    return React.createElement(SnackbarWrapper, {
        titleText = tbl1.toastTitle or var2.helpUsImprove,
        icon = tbl1.toastIcon,
        buttonText = tbl1.toastButtonText or var2.giveFeedback,
        onButtonActivated = onButtonActivated,
        closeSnackbar = closeSnackbar,
        autoDismissDelaySeconds = 5
    })
end)
