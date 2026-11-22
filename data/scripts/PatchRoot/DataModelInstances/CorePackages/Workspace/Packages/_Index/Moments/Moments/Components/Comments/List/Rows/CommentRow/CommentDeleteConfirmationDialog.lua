-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local FocusNavigationUtils = require(MomentsParent.FocusNavigationUtils)
local Foundation = require(MomentsParent.Foundation)
local InputHandlers = require(MomentsParent.InputHandlers)
local Localization = require(MomentsParent.Localization)
local React = require(MomentsParent.React)
local _ReactFocusNavigation = require(MomentsParent.ReactFocusNavigation)

local useLocalization = Localization.Hooks.useLocalization

local Dialog = Foundation.Dialog
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local useFocusRoot = FocusNavigationUtils.useFocusRoot

local eventMap = {
    [Enum.KeyCode.ButtonB] = FocusNavigationEventNameEnum.NavigateBack,
    [Enum.KeyCode.Escape] = FocusNavigationEventNameEnum.NavigateBack
}

local tbl2 = {
    title = "Feature.Moments.Label.DeleteCommentTitle",
    body = "Feature.Moments.Label.DeleteCommentBody",
    delete = "Feature.Moments.Action.Delete",
    cancel = "Feature.Moments.Action.Cancel"
}

local function CommentDeleteConfirmationDialog(tbl3)
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
        size = Foundation.Enums.DialogSize.Medium,
        hasBackdrop = true,
        testId = `moments-comment-delete-dialog-{tbl3.commentId}`
    }, {
        DialogTitle = React.createElement(Dialog.Title, { text = var1.title, LayoutOrder = 1 }),
        DialogContent = React.createElement(
            Dialog.Content,
            { LayoutOrder = 2 },
            {
                DialogText = React.createElement(Dialog.Text, { Text = var1.body })
            }
        ),
        DialogActions = React.createElement(Dialog.Actions, {
            LayoutOrder = 3,
            actions = {
                {
                    text = var1.delete,
                    variant = Foundation.Enums.ButtonVariant.Emphasis,
                    onActivated = tbl3.onConfirm,
                    testId = `moments-comment-delete-confirm-{tbl3.commentId}`
                },
                {
                    text = var1.cancel,
                    variant = Foundation.Enums.ButtonVariant.Standard,
                    onActivated = tbl3.onCancel,
                    testId = `moments-comment-delete-cancel-{tbl3.commentId}`
                }
            }
        })
    })
end

return CommentDeleteConfirmationDialog
