-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:30:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeopleReactViewParent = script:FindFirstAncestor("PeopleReactView").Parent

local React = require(PeopleReactViewParent.React)
local Signals = require(PeopleReactViewParent.Signals)

local View = require(PeopleReactViewParent.Foundation).View

return React.memo(function(tbl1) -- name: VirtualizedItem
    local var1, var2 = React.useState(-1)

    local var3 = React.useMemo(function()
        return React.joinBindings({ itemWidth = tbl1.itemWidth, itemHeight = tbl1.itemHeight }):map(function(arg1): UDim2
            return UDim2.fromOffset(arg1.itemWidth, arg1.itemHeight)
        end)
    end, {})

    local var4 = React.joinBindings({ numColumns = tbl1.numColumns, itemWidth = tbl1.itemWidth, itemHeight = tbl1.itemHeight })

    local var5 = React.useMemo(function()
        return var4:map(function(tbl2)
            return UDim2.fromOffset(
                (var1 - 1) % tbl2.numColumns * (tbl2.itemWidth + tbl1.gapSize),
                math.floor((var1 - 1) / tbl2.numColumns) * (tbl2.itemHeight + tbl1.gapSize)
            )
        end)
    end, { var1, tbl1.gapSize })

    React.useEffect(function()
        local effect = Signals.createEffect(function(arg1)
            local minVirtualizedIndex = tbl1.getMinVirtualizedIndex(arg1)
            local var6 = tbl1.getMaxVirtualizedIndex(arg1) - minVirtualizedIndex + 1
            local var7 = (minVirtualizedIndex - 1) % var6 + 1
            local var8 = minVirtualizedIndex + (tbl1.relativeIndex - var7) % var6
            var2(var8)
        end)

        return function()
            effect()
        end
    end, { tbl1.relativeIndex, tbl1.getMinVirtualizedIndex, tbl1.getMaxVirtualizedIndex })

    return React.createElement(
        View,
        {
            Size = var3,
            Position = var5,
            ZIndex = if var1 == 1 then 2 else 1
        },
        {
            Item = tbl1.getElement(var1)
        }
    )
end)
