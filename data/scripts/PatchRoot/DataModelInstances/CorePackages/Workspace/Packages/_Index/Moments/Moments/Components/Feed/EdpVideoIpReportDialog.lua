-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:01:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local FocusNavigationUtils = require(MomentsParent.FocusNavigationUtils)
local Foundation = require(MomentsParent.Foundation)
local InputHandlers = require(MomentsParent.InputHandlers)
local Localization = require(MomentsParent.Localization)
local React = require(MomentsParent.React)
local _ReactFocusNavigation = require(MomentsParent.ReactFocusNavigation)

local Dialog = Foundation.Dialog
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local useFocusRoot = FocusNavigationUtils.useFocusRoot
local useLocalization = Localization.Hooks.useLocalization

local eventMap = {
    [Enum.KeyCode.ButtonB] = FocusNavigationEventNameEnum.NavigateBack,
    [Enum.KeyCode.Escape] = FocusNavigationEventNameEnum.NavigateBack
}

local tbl2 = {
    continue = "Feature.Moments.Action.Continue",
    cancel = "Feature.Moments.Action.Cancel",
    dialogTitle = "Feature.Moments.Title.EDPMomentIPReportInstructions",
    dialogBody = "Feature.Moments.Body.EDPMomentIPReportInstructions"
}

local function EdpVideoIpReportDialog(tbl3)
    local var1 = useLocalization(tbl2)
    local onCancel = tbl3.onCancel
    local eventHandlers = React.useMemo(function()
        return {
            [FocusNavigationEventNameEnum.NavigateBack] = {
                handler = InputHandlers.onRelease(function(arg1)
                    onCancel()
                    arg1:cancel()
                end)
            }
        }
    end, { onCancel })
    local ref = useFocusRoot({
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp,
        isAutoFocusRoot = true,
        eventMap = eventMap,
        eventHandlers = eventHandlers
    })

    return React.createElement(Dialog.Root, {
        ref = ref,
        disablePortal = false,
        hasBackdrop = true,
        onClose = tbl3.onCancel,
        size = Foundation.Enums.DialogSize.Medium,
        testId = "moments-edp-video-ip-report-dialog"
    }, {
        DialogTitle = React.createElement(Dialog.Title, { text = var1.dialogTitle, LayoutOrder = 1 }),
        DialogContent = React.createElement(
            Dialog.Content,
            { LayoutOrder = 2 },
            {
                DialogText = React.createElement(Dialog.Text, { Text = var1.dialogBody })
            }
        ),
        DialogActions = React.createElement(Dialog.Actions, {
            LayoutOrder = 3,
            actions = {
                {
                    text = var1.continue,
                    variant = Foundation.Enums.ButtonVariant.Emphasis,
                    onActivated = tbl3.onContinue,
                    testId = "moments-edp-video-ip-report-continue"
                },
                {
                    text = var1.cancel,
                    variant = Foundation.Enums.ButtonVariant.Standard,
                    onActivated = tbl3.onCancel,
                    testId = "moments-edp-video-ip-report-cancel"
                }
            }
        })
    })
end

return EdpVideoIpReportDialog
