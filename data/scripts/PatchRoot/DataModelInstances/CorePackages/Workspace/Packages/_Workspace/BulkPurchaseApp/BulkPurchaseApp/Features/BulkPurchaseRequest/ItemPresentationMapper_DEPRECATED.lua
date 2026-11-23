-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:41:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseApp = script:FindFirstAncestor("BulkPurchaseApp")
local BulkPurchaseAppParent = BulkPurchaseApp.Parent
local React = require(BulkPurchaseAppParent.React)
local StyledTextLabel = require(BulkPurchaseAppParent.UIBlox).App.Text.StyledTextLabel

local Price_DEPRECATED = require(BulkPurchaseApp.Components.Price_DEPRECATED)
local ItemStatus = require(BulkPurchaseApp.Components.ItemStatus)

return {
    mapItemsToPresentation_DEPRECATED = function(arg1, fontStyle, colorStyle)
        local result = {}
        for _, value in arg1 do
            local tbl1 = {
                id = value.id,
                name = value.name,
                image = value.image,
                endSlot = React.createElement(Price_DEPRECATED, { amount = value.cost, fontStyle = fontStyle, colorStyle = colorStyle })
            }
            table.insert(result, tbl1)
        end

        return result
    end,
    mapOwnedItemsToPresentation_DEPRECATED = function(arg1, fontStyle, colorStyle, arg2)
        local result = {}
        for _, value in arg1 do
            local tbl1 = {
                id = value.id,
                name = value.name,
                image = value.image,
                endSlot = 0
            }
            local createElement = React.createElement
            local var1 = StyledTextLabel
            local tbl2 = {
                fontStyle = fontStyle,
                colorStyle = colorStyle,
                textXAlignment = Enum.TextXAlignment.Right,
                textYAlignment = Enum.TextYAlignment.Top,
                lineHeight = fontStyle.LineHeight,
                size = UDim2.fromScale(1, 1),
                text = 0
            }
            local itemOwned = arg2.itemOwned
            local ownedCount = value.ownedCount
            tbl2.text = itemOwned:gsub("{.*}", tostring(ownedCount))
            tbl1.endSlot = createElement(var1, tbl2)
            table.insert(result, tbl1)
        end

        return result
    end,
    mapUnpurchasableItemsToPresentation_DEPRECATED = function(arg1)
        local result = {}
        for _, value in arg1 do
            local tbl1 = {
                id = value.id,
                name = value.name,
                image = value.image,
                endSlot = React.createElement(ItemStatus, { status = value.status })
            }
            table.insert(result, tbl1)
        end

        return result
    end
}
