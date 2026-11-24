-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:10:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local React = require(InExperienceShopParent.React)
local Foundation = require(InExperienceShopParent.Foundation)

local useRemainingTimeText = require(InExperienceShopParent.InExperienceOffers).Hooks.useRemainingTimeText

local useOfferModalText = require(InExperienceShop.Hooks.useOfferModalText)

local Dialog = Foundation.Dialog
local View = Foundation.View
local FoundationText = Foundation.Text
local DialogSize = Foundation.Enums.DialogSize
local ButtonVariant = Foundation.Enums.ButtonVariant

local function OfferDetailsDialog(tbl1)
    local modal = tbl1.modal
    local bool1 = modal.termsAndConditions ~= nil

    local var1 = useRemainingTimeText(tbl1.expirationTimeInUTC)
    local var2 = useOfferModalText(modal.body, var1)

    local createElement = React.createElement
    local root = Dialog.Root
    local tbl2 = {
        size = DialogSize.Medium,
        hasBackdrop = true,
        disablePortal = false,
        onClose = tbl1.onClose
    }
    local tbl3 = {
        Title = React.createElement(Dialog.Title, { text = modal.title, LayoutOrder = 1 }),
        Content = 0,
        Actions = 0
    }

    local createElement2 = React.createElement
    local content = Dialog.Content
    local tbl4 = { LayoutOrder = 2 }
    local tbl5 = {
        Body = React.createElement(View, { tag = "col gap-small size-full-0 auto-y" }, {
            BodyText = React.createElement(Dialog.Text, { Text = var2.bodyText, LayoutOrder = 1 }),
            ViewTermsLink = if bool1 then React.createElement(FoundationText, {
                tag = "auto-xy text-body-medium text-wrap text-align-x-left content-muted",
                Text = `<u>{var2.viewTermsText}</u>`,
                RichText = true,
                onActivated = tbl1.onViewTerms,
                LayoutOrder = 2,
                testId = "OfferViewTermsLink"
            }) else nil
        })
    }
    tbl3.Content = createElement2(content, tbl4, tbl5)

    tbl3.Actions = React.createElement(Dialog.Actions, {
        LayoutOrder = 3,
        actions = {{
            text = modal.buttonText,
            variant = ButtonVariant.Emphasis,
            onActivated = tbl1.onShopNow
        }}
    })
    return createElement(root, tbl2, tbl3)
end

return OfferDetailsDialog
