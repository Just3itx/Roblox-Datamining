-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:20:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent
local React = require(AppBloxParent.React)
local useLocalization = require(AppBloxParent.Localization).Hooks.useLocalization
local Foundation = require(AppBloxParent.Foundation)
local FocusNavigationUtils = require(AppBloxParent.FocusNavigationUtils)
local InputHandlers = require(AppBloxParent.InputHandlers)
local ReactFocusNavigation = require(AppBloxParent.ReactFocusNavigation)
local Dialog = Foundation.Dialog
local ButtonVariant = Foundation.Enums.ButtonVariant
local EnumsOrientation = Foundation.Enums.Orientation
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local useFocusRoot = FocusNavigationUtils.useFocusRoot
local useDefaultFocusBehavior = ReactFocusNavigation.useDefaultFocusBehavior

local SharedFlags = require(AppBloxParent.SharedFlags)
local FFlagLuaAppPlayButtonPrivatePT = SharedFlags.FFlagLuaAppPlayButtonPrivatePT
local FFlagAppBloxConfirmationDialogFocusNav = SharedFlags.FFlagAppBloxConfirmationDialogFocusNav
local FFlagAppBloxConfirmationDialogBackCloses = SharedFlags.FFlagAppBloxConfirmationDialogBackCloses
local FFlagSplitPaneUnsavedDialogAlertStyle = SharedFlags.FFlagSplitPaneUnsavedDialogAlertStyle

local eventMap = {
    [Enum.KeyCode.ButtonB] = FocusNavigationEventNameEnum.NavigateBack,
    [Enum.KeyCode.Escape] = FocusNavigationEventNameEnum.NavigateBack
}

local FFlagEnableSplitPane = require(AppBloxParent.SharedFlags).FFlagEnableSplitPane

return function(tbl2)
    local var1 = useLocalization(
        {
            confirmButtonText = "CommonUI.Controls.Action.Confirm",
            cancelButtonText = "CommonUI.Controls.Action.Cancel"
        }
    )
    local var2, var3

    if FFlagAppBloxConfirmationDialogFocusNav then
        local var4 = if FFlagAppBloxConfirmationDialogBackCloses then tbl2.onClose or tbl2.onCancel else tbl2.onCancel

        local eventHandlers = React.useMemo(function()
            return {
                [FocusNavigationEventNameEnum.NavigateBack] = {
                    handler = InputHandlers.onRelease(function(arg1)
                        var4()
                        arg1:cancel()
                    end)
                }
            }
        end, { var4 })

        local var6 = useFocusRoot({
            surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp,
            isAutoFocusRoot = true,
            shouldRestoreFocus = false,
            eventMap = eventMap,
            eventHandlers = eventHandlers
        })
        var2, var3 = useDefaultFocusBehavior(var6)
    else
        var2 = nil
        var3 = nil
    end

    local tbl3

    if FFlagLuaAppPlayButtonPrivatePT then
        local tbl4 = {
            variant = ButtonVariant.Emphasis,
            text = tbl2.confirmButtonText or var1.confirmButtonText,
            onActivated = tbl2.onConfirm,
            ref = var2
        }
        local tbl5 = {
            variant = if FFlagSplitPaneUnsavedDialogAlertStyle and tbl2.cancelButtonVariant then tbl2.cancelButtonVariant else ButtonVariant.Standard,
            text = tbl2.cancelButtonText or var1.cancelButtonText,
            onActivated = tbl2.onCancel,
            ref = if tbl2.hideConfirmButton then var2 else nil
        }

        tbl3 = tbl2.hideConfirmButton and { tbl5 } or { tbl4, tbl5 }
    else
        tbl3 = nil
    end

    local createElement = React.createElement
    local root = Dialog.Root
    local tbl4 = {
        hasBackdrop = not FFlagEnableSplitPane or tbl2.hasBackdrop == nil or tbl2.hasBackdrop,
        disablePortal = tbl2.disablePortal,
        size = if FFlagLuaAppPlayButtonPrivatePT then tbl2.size else nil,
        ref = var3,
        onClose = if (FFlagEnableSplitPane or FFlagAppBloxConfirmationDialogBackCloses) and tbl2.onClose ~= nil then tbl2.onClose elseif tbl2.showCloseButton then tbl2.onCancel else nil
    }

    local tbl5 = {
        DialogTitle = React.createElement(Dialog.Title, { text = tbl2.title }),
        DialogContent = React.createElement(Dialog.Content, nil, { DialogText = React.createElement(Dialog.Text, { Text = tbl2.body }) }),
        DialogActions = 0
    }

    local createElement2 = React.createElement
    local actions = Dialog.Actions
    local tbl6 = {
        orientation = if FFlagLuaAppPlayButtonPrivatePT and tbl2.orientButtonsVertically then EnumsOrientation.Vertical else nil,
        actions = 0
    }

    if not FFlagLuaAppPlayButtonPrivatePT then
        tbl3 = {
            {
                variant = ButtonVariant.Emphasis,
                text = tbl2.confirmButtonText or var1.confirmButtonText,
                onActivated = tbl2.onConfirm,
                ref = var2
            },
            {
                variant = if FFlagSplitPaneUnsavedDialogAlertStyle and tbl2.cancelButtonVariant then tbl2.cancelButtonVariant else ButtonVariant.Standard,
                text = tbl2.cancelButtonText or var1.cancelButtonText,
                onActivated = tbl2.onCancel
            }
        }
    end

    tbl6.actions = tbl3
    tbl5.DialogActions = createElement2(actions, tbl6)
    return createElement(root, tbl4, tbl5)
end
