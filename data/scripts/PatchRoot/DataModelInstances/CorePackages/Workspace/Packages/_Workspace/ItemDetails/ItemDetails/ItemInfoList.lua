-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:11:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ItemDetailsParent = script:FindFirstAncestor("ItemDetails").Parent

local React = require(ItemDetailsParent.React)
local ItemInfoRow = require(script.Parent.ItemInfoRow)
local Cryo = require(ItemDetailsParent.Cryo)

local function ItemInfoList(tbl1)
    local tbl2 = {
        layout = React.createElement("UIListLayout", {
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Vertical
        })
    }
    for layoutOrder, value2 in tbl1.rowData do
        local join = Cryo.Dictionary.join
        local tbl3 = {
            LayoutOrder = layoutOrder,
            hideDivider = next(tbl1.rowData, layoutOrder) == nil
        }
        local var1 = join(value2, tbl3)

        table.insert(tbl2, React.createElement(ItemInfoRow, var1))
    end
    return React.createElement("Frame", {
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.fromScale(1, 0),
        BackgroundTransparency = 1,
        LayoutOrder = tbl1.LayoutOrder
    }, tbl2)
end

return ItemInfoList
