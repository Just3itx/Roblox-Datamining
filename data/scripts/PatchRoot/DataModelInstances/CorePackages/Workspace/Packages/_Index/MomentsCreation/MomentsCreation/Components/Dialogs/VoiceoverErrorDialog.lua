-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationParent = script:FindFirstAncestor("MomentsCreation").Parent

local Foundation = require(MomentsCreationParent.Foundation)
local Localization = require(MomentsCreationParent.Localization)
local React = require(MomentsCreationParent.React)

local Dialog = Foundation.Dialog
local useLocalization = Localization.Hooks.useLocalization

local function VoiceoverErrorDialog(tbl1)
    local var1 = useLocalization(
        {
            title = "CommonUI.Messages.Response.SomethingWentWrong",
            tryAgain = "Feature.Moments.Action.TryAgain"
        }
    )

    return React.createElement(
        Dialog.Root,
        {
            size = Foundation.Enums.DialogSize.Small,
            hasBackdrop = true,
            onClose = tbl1.onDismiss
        },
        {
            DialogTitle = React.createElement(Dialog.Title, { text = var1.title, LayoutOrder = 1 }),
            DialogContent = React.createElement(
                Dialog.Content,
                { LayoutOrder = 2 },
                {
                    DialogText = React.createElement(Dialog.Text, { Text = tbl1.message })
                }
            ),
            DialogActions = React.createElement(Dialog.Actions, {
                LayoutOrder = 3,
                actions = {{
                    text = var1.tryAgain,
                    variant = Foundation.Enums.ButtonVariant.Standard,
                    onActivated = tbl1.onTryAgain
                }}
            })
        }
    )
end

return VoiceoverErrorDialog
