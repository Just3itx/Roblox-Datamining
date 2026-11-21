-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:10:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CollectionViewsParent = script:FindFirstAncestor("CollectionViews").Parent
local React = require(CollectionViewsParent.React)
local ArgCheck = require(CollectionViewsParent.ArgCheck)

return React.memo(function(tbl1) -- name: RowOfCollectionItems
    local var1 = React.useMemo(function()
        if tbl1.numToRender == 0 or tbl1.numItemsForSizing == 0 then
            return nil
        end

        local var1 = tbl1.startingIndex - 1
        local result = {}

        local numItemsForSizing = tbl1.numItemsForSizing
        local var2 = numItemsForSizing - 1

        local num1 = math.floor(var2 / numItemsForSizing * tbl1.columnGap)
        local uDim2 = UDim2.new(1 / numItemsForSizing, -num1, 1, 0)

        local var3 = num1 * numItemsForSizing - tbl1.columnGap * var2
        local offset = tbl1.columnGap + var3 / var2

        result.Layout = React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Horizontal,
            Padding = UDim.new(0, offset),
            HorizontalAlignment = Enum.HorizontalAlignment.Left
        })

        if var1 > 0 then
            result.Padding = React.createElement("Frame", {
                BackgroundTransparency = 1,
                Size = UDim2.new(var1 * uDim2.X.Scale, (var1 - 1) * offset + var1 * uDim2.X.Offset, 0, 0),
                LayoutOrder = 0
            })
        end

        ArgCheck.assert(tbl1.startingIndex >= 1 and tbl1.startingIndex <= #tbl1.items)
        ArgCheck.assert(tbl1.endingIndex >= tbl1.startingIndex and tbl1.endingIndex <= #tbl1.items)

        for i = tbl1.startingIndex, tbl1.endingIndex do
            if i >= 1 and i <= #tbl1.items then
                local item = tbl1.items[i]
                local var4, var5 = tbl1.renderItem(item, i, uDim2)
                local var6 = i % tbl1.numToRender + 1
                result[var5 .. tostring(var6)] = var4
            end
        end

        return result
    end, {
        tbl1.columnGap,
        tbl1.startingIndex,
        tbl1.endingIndex,
        tbl1.items,
        tbl1.numToRender,
        tbl1.renderItem,
        tbl1.sideMargin,
        tbl1.totalItemsOnCanvas,
        tbl1.numItemsForSizing
    })

    return React.createElement(React.Fragment, nil, var1)
end)
