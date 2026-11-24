-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShopParent = script:FindFirstAncestor("InExperienceShop").Parent

local React = require(InExperienceShopParent.React)
local Foundation = require(InExperienceShopParent.Foundation)
local FocusNavigationUtils = require(InExperienceShopParent.FocusNavigationUtils)

local Dialog = Foundation.Dialog
local DialogSize = Foundation.Enums.DialogSize
local ButtonVariant = Foundation.Enums.ButtonVariant

local useFocusRoot = FocusNavigationUtils.useFocusRoot
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum

local function ShopErrorDialog(tbl1)
    local ref = useFocusRoot({ surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp, isAutoFocusRoot = true })

    return React.createElement(
        Dialog.Root,
        {
            ref = ref,
            size = DialogSize.Medium,
            hasBackdrop = true,
            disablePortal = false,
            onClose = tbl1.onClose
        },
        {
            Title = React.createElement(Dialog.Title, { text = tbl1.title, LayoutOrder = 1 }),
            Content = React.createElement(
                Dialog.Content,
                { LayoutOrder = 2 },
                {
                    BodyText = React.createElement(Dialog.Text, { Text = tbl1.body })
                }
            ),
            Actions = React.createElement(Dialog.Actions, {
                LayoutOrder = 3,
                actions = {{
                    text = tbl1.actionText,
                    variant = ButtonVariant.Emphasis,
                    onActivated = tbl1.onAction
                }}
            })
        }
    )
end

return ShopErrorDialog
