-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Foundation = require(MomentsParent.Foundation)
local Localization = require(MomentsParent.Localization)
local React = require(MomentsParent.React)

local Dialog = Foundation.Dialog
local useLocalization = Localization.Hooks.useLocalization

local tbl1 = {
    title = "Feature.Moments.Label.DeleteMomentTitle",
    body = "Feature.Moments.Label.DeleteMomentBody",
    delete = "Feature.Moments.Action.Delete",
    cancel = "Feature.Moments.Action.Cancel"
}

local function DeletionConfirmationDialog(tbl2)
    local var1 = useLocalization(tbl1)

    return React.createElement(
        Dialog.Root,
        {
            disablePortal = false,
            size = Foundation.Enums.DialogSize.Medium,
            hasBackdrop = true
        },
        {
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
                        onActivated = tbl2.onConfirm
                    },
                    {
                        text = var1.cancel,
                        variant = Foundation.Enums.ButtonVariant.Standard,
                        onActivated = tbl2.onCancel
                    }
                }
            })
        }
    )
end

return DeletionConfirmationDialog
