-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:10:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShopParent = script:FindFirstAncestor("InExperienceShop").Parent

local React = require(InExperienceShopParent.React)
local Foundation = require(InExperienceShopParent.Foundation)

local _InExperienceOffers = require(InExperienceShopParent.InExperienceOffers)

local Dialog = Foundation.Dialog
local DialogSize = Foundation.Enums.DialogSize
local ButtonVariant = Foundation.Enums.ButtonVariant

local function OfferTermsDialog(tbl1)
    local terms = tbl1.terms

    return React.createElement(
        Dialog.Root,
        {
            size = DialogSize.Medium,
            hasBackdrop = true,
            disablePortal = false,
            onClose = tbl1.onClose
        },
        {
            Title = React.createElement(Dialog.Title, { text = terms.title, LayoutOrder = 1 }),
            Content = React.createElement(
                Dialog.Content,
                { LayoutOrder = 2 },
                {
                    BodyText = React.createElement(Dialog.Text, { Text = terms.body })
                }
            ),
            Actions = React.createElement(Dialog.Actions, {
                LayoutOrder = 3,
                actions = {{
                    text = terms.buttonText,
                    variant = ButtonVariant.Emphasis,
                    onActivated = tbl1.onClose
                }}
            })
        }
    )
end

return OfferTermsDialog
