-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:31:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")

local BulkPurchaseAppParent = script:FindFirstAncestor("BulkPurchaseApp").Parent
local React = require(BulkPurchaseAppParent.React)
local NumberLocalization = require(BulkPurchaseAppParent.Localization).NumberLocalization

local Foundation = require(BulkPurchaseAppParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text
local getIconRichText = Foundation.Utility.getIconRichText
local IconName = Foundation.Enums.IconName

local function Price(tbl1)
    local var1 = NumberLocalization.localize(tbl1.amount, LocalizationService.RobloxLocaleId)
    local str1 = `{getIconRichText(IconName.Robux)} {var1}`

    local content = React.createElement(FoundationText, {
        Text = str1,
        RichText = true,
        fontStyle = tbl1.fontStyle,
        textStyle = tbl1.textStyle,
        tag = "auto-xy text-align-x-right"
    })

    if not tbl1.strikethrough then
        return React.createElement(View, { LayoutOrder = tbl1.LayoutOrder, tag = "auto-xy" }, { Content = content })
    end

    return React.createElement(View, {
        LayoutOrder = tbl1.LayoutOrder,
        tag = "auto-xy"
    }, {
        Content = content,
        Strikethrough = React.createElement(
            View,
            {
                backgroundStyle = tbl1.textStyle,
                tag = "position-center-center anchor-center-center size-full-50"
            }
        )
    })
end

return Price
