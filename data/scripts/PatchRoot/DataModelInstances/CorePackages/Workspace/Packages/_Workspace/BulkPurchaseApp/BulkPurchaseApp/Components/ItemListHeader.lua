-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:31:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseAppParent = script:FindFirstAncestor("BulkPurchaseApp").Parent
local React = require(BulkPurchaseAppParent.React)
local useDesignTokens = require(BulkPurchaseAppParent.Style).useDesignTokens
local StyledTextLabel = require(BulkPurchaseAppParent.UIBlox).App.Text.StyledTextLabel

local LineItemLayout = require(script.Parent.LineItemLayout)

local function ItemListHeader(tbl1)
    local var1 = useDesignTokens()
    local fontStyle = {
        LineHeight = var1.Typography.BodyLarge.LineHeight,
        Font = var1.Typography.TitleLarge.Font,
        FontSize = var1.Typography.BodyLarge.FontSize,
        LetterSpacing = var1.Typography.BodyLarge.LetterSpacing
    }
    local emphasis = var1.Color.Content.Emphasis

    return React.createElement(LineItemLayout, {
        startSlot = React.createElement(StyledTextLabel, { fontStyle = fontStyle, colorStyle = emphasis, text = tbl1.heading }),
        endSlot = React.createElement(StyledTextLabel, { fontStyle = fontStyle, colorStyle = emphasis, text = tbl1.itemCount }),
        LayoutOrder = tbl1.LayoutOrder
    })
end

return ItemListHeader
