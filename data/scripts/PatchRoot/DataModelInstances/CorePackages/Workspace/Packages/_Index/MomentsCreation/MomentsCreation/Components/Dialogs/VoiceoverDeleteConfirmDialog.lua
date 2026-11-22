-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationParent = script:FindFirstAncestor("MomentsCreation").Parent

local Foundation = require(MomentsCreationParent.Foundation)
local Localization = require(MomentsCreationParent.Localization)
local React = require(MomentsCreationParent.React)

local Dialog = Foundation.Dialog
local useLocalization = Localization.Hooks.useLocalization

local function VoiceoverDeleteConfirmDialog(tbl1)
    local var1 = useLocalization({
        title = "Feature.Moments.Label.DeleteVoiceoverTitle",
        body = "Feature.Moments.Label.DeleteVoiceoverBody",
        delete = "Feature.Moments.Action.Delete",
        cancel = "Feature.Moments.Action.Cancel"
    })

    return React.createElement(Dialog.Root, {
        size = Foundation.Enums.DialogSize.Small,
        hasBackdrop = true
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
            orientation = Foundation.Enums.Orientation.Vertical,
            actions = {
                {
                    text = var1.delete,
                    variant = Foundation.Enums.ButtonVariant.Alert,
                    onActivated = tbl1.onConfirm
                },
                {
                    text = var1.cancel,
                    variant = Foundation.Enums.ButtonVariant.Standard,
                    onActivated = tbl1.onCancel
                }
            }
        })
    })
end

return VoiceoverDeleteConfirmDialog
