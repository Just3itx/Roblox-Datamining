-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:21:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GiftingParent = script:FindFirstAncestor("Gifting").Parent

local React = require(GiftingParent.React)
local Foundation = require(GiftingParent.Foundation)

local Dialog = Foundation.Dialog
local ButtonVariant = Foundation.Enums.ButtonVariant
local DialogSize = Foundation.Enums.DialogSize
local EnumsOrientation = Foundation.Enums.Orientation

return React.memo(function(tbl1) -- name: GiftRejectConfirmationView
    if not tbl1.isOpen then
        return nil
    end

    local actions = {
        {
            text = tbl1.rejectLabel,
            variant = ButtonVariant.Alert,
            isLoading = tbl1.isRejectLoading,
            onActivated = tbl1.onReject
        },
        {
            text = tbl1.cancelLabel,
            variant = ButtonVariant.Standard,
            onActivated = tbl1.onCancel
        }
    }

    return React.createElement(
        Dialog.Root,
        {
            size = DialogSize.Small,
            hasBackdrop = true,
            disablePortal = false,
            testId = "GiftRejectConfirmationView"
        },
        {
            Title = React.createElement(Dialog.Title, { text = tbl1.titleText }),
            Content = React.createElement(
                Dialog.Content,
                { LayoutOrder = 1 },
                {
                    Body = React.createElement(Dialog.Text, { Text = tbl1.bodyText })
                }
            ),
            Actions = React.createElement(Dialog.Actions, { LayoutOrder = 2, orientation = EnumsOrientation.Horizontal, actions = actions })
        }
    )
end)
