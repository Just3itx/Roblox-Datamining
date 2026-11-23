-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseAppParent = script:FindFirstAncestor("BulkPurchaseApp").Parent
local React = require(BulkPurchaseAppParent.React)

local useDesignTokens = require(BulkPurchaseAppParent.Style).useDesignTokens

local Item = require(script.Parent.Item)

local function ItemList_DEPRECATED(tbl1)
    local var1 = useDesignTokens()

    local tbl2 = {
        Layout = React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Bottom,
            Padding = UDim.new(0, var1.Size.Size_300)
        })
    }
    for layoutOrder, item in tbl1.items do
        local id = item.id
        tbl2[id] = React.createElement(Item, { name = item.name, image = item.image, endSlot = item.endSlot, LayoutOrder = layoutOrder })
    end

    return React.createElement("Frame", {
        LayoutOrder = tbl1.LayoutOrder,
        Size = UDim2.fromScale(1, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        BorderSizePixel = 0
    }, tbl2)
end

return ItemList_DEPRECATED
