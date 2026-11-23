-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:31:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseApp = script:FindFirstAncestor("BulkPurchaseApp")
local BulkPurchaseAppParent = BulkPurchaseApp.Parent
local React = require(BulkPurchaseAppParent.React)
local useDesignTokens = require(BulkPurchaseAppParent.Style).useDesignTokens
local StyledTextLabel = require(BulkPurchaseAppParent.UIBlox).App.Text.StyledTextLabel

local LineItemLayout = require(script.Parent.LineItemLayout)
local Price_DEPRECATED = require(script.Parent.Price_DEPRECATED)
local PriceBoxLineVariantEnum = require(BulkPurchaseApp.Enums.PriceBoxLineVariantEnum)

local function PriceBoxLine_DEPRECATED(tbl1)
    local var1 = useDesignTokens()
    local fontStyle = tbl1.variant == PriceBoxLineVariantEnum.Danger
        and {
            LineHeight = var1.Typography.BodyLarge.LineHeight,
            Font = var1.Typography.TitleLarge.Font,
            FontSize = var1.Typography.BodyLarge.FontSize,
            LetterSpacing = var1.Typography.BodyLarge.LetterSpacing
        }
        or var1.Typography.BodyLarge
    local default = var1.Color.Content.Default
    if tbl1.variant == PriceBoxLineVariantEnum.Highlight then
        default = var1.Color.Content.Emphasis
    elseif tbl1.variant == PriceBoxLineVariantEnum.Danger then
        default = var1.Color.System.Alert
    end

    return React.createElement(LineItemLayout, {
        LayoutOrder = tbl1.LayoutOrder,
        startSlot = React.createElement(StyledTextLabel, { fontStyle = fontStyle, colorStyle = default, text = tbl1.text }),
        endSlot = React.createElement(Price_DEPRECATED, { colorStyle = default, fontStyle = fontStyle, amount = tbl1.amount })
    })
end

return PriceBoxLine_DEPRECATED
