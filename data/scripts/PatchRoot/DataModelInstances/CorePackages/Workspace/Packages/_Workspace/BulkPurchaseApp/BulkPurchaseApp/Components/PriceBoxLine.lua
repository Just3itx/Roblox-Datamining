-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:31:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseApp = script:FindFirstAncestor("BulkPurchaseApp")
local BulkPurchaseAppParent = BulkPurchaseApp.Parent
local React = require(BulkPurchaseAppParent.React)
local Foundation = require(BulkPurchaseAppParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text
local useTokens = Foundation.Hooks.useTokens

local PriceBoxLineLayout = require(script.Parent.PriceBoxLineLayout)
local Price = require(script.Parent.Price)
local PriceBoxLineVariantEnum = require(BulkPurchaseApp.Enums.PriceBoxLineVariantEnum)

local function PriceBoxLine(tbl1)
    local var1 = useTokens()
    local fontStyle = {
        LineHeight = var1.Typography.BodyLarge.LineHeight,
        FontSize = var1.Typography.BodyLarge.FontSize,
        Font = if tbl1.variant == PriceBoxLineVariantEnum.Danger then var1.Typography.TitleLarge.Font else var1.Typography.BodyLarge.Font
    }

    local default = var1.Color.Content.Default
    if tbl1.variant == PriceBoxLineVariantEnum.Highlight then
        default = var1.Color.Content.Emphasis
    elseif tbl1.variant == PriceBoxLineVariantEnum.Danger then
        default = var1.Color.System.Alert
    end

    local createElement = React.createElement
    local var2 = PriceBoxLineLayout
    local tbl3 = {
        LayoutOrder = tbl1.LayoutOrder,
        startSlot = React.createElement(FoundationText, { fontStyle = fontStyle, textStyle = default, Text = tbl1.text, tag = "auto-xy" }),
        endSlot = 0
    }
    local element

    if tbl1.originalPrice then
        element = React.createElement(View, { tag = "row align-y-center gap-small auto-xy" }, {
            OriginalPrice = React.createElement(
                Price,
                {
                    textStyle = default,
                    fontStyle = fontStyle,
                    amount = tbl1.originalPrice,
                    strikethrough = true,
                    LayoutOrder = 1
                }
            ),
            CurrentPrice = React.createElement(Price, { textStyle = default, fontStyle = fontStyle, amount = tbl1.amount, LayoutOrder = 2 })
        })
    else
        element = React.createElement(Price, { textStyle = default, fontStyle = fontStyle, amount = tbl1.amount })
    end

    tbl3.endSlot = element
    return createElement(var2, tbl3)
end

return PriceBoxLine
