-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:41:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarWorkshopParent = script:FindFirstAncestor("AvatarWorkshop").Parent

local React = require(AvatarWorkshopParent.React)
local Foundation = require(AvatarWorkshopParent.Foundation)

local FlatList = require(AvatarWorkshopParent.VirtualizedList).FlatList

local useTokens = Foundation.Hooks.useTokens

local function getItemMetrics(num1: number, offset: number, tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    local itemsPerRow = math.max(tbl1.minimumItemsPerRow, math.floor((num1 + offset) / (tbl1.minimumItemWidth + offset)))
    return {
        itemsPerRow = itemsPerRow,
        itemWidth = math.floor((num1 - (itemsPerRow - 1) * offset) / itemsPerRow)
    }
end

local function chunkIntoRows(data, num1: number)
    local var1 = table.create(math.ceil(math.max(#data, 1) / num1))
    for i = 1, #data, num1 do
        local num2 = math.min(i + num1 - 1, #data)
        table.insert(var1, { unpack(data, i, num2) })
    end
    return var1
end

local function VirtualizedGrid(tbl1)
    local var1 = useTokens()

    local minItemWidth = tbl1.minItemWidth
    local minColumns = tbl1.minColumns or 1
    local fallbackNumColumns = tbl1.fallbackNumColumns or 3
    local offset = tbl1.columnGap or var1.Gap.Small
    local offset2 = tbl1.rowGap or var1.Gap.Small

    local offset3 = tbl1.contentPaddingTop or var1.Padding.XSmall
    local contentPaddingBottom = tbl1.contentPaddingBottom
    local bool1 = tbl1.ListFooterSlot ~= nil

    local var2 = var1.Padding.XSmall * 2
    local keyExtractor = tbl1.keyExtractor

    local var3, var4 = React.useState(tbl1.lastMeasuredGridWidth or 0)

    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        local absoluteSizeX = arg1.AbsoluteSize.X

        if absoluteSizeX == 0 then
            return
        end
        var4(absoluteSizeX)
        if tbl1.onGridWidthChanged then
            tbl1.onGridWidthChanged(absoluteSizeX)
        end
    end, { tbl1.onGridWidthChanged })

    local bool2 = not (minItemWidth == nil) and var3 == 0

    if minItemWidth ~= nil and var3 > 0 then
        fallbackNumColumns = (getItemMetrics(var3 - var2, offset, { minimumItemWidth = minItemWidth, minimumItemsPerRow = minColumns })).itemsPerRow
    end

    local var6 = React.useMemo(function()
        return (chunkIntoRows(tbl1.data, fallbackNumColumns))
    end, { tbl1.data, fallbackNumColumns })

    local renderItem = React.useCallback(function(arg1)
        local item = arg1.item
        local index = arg1.index
        local var7 = (index - 1) * fallbackNumColumns
        local bool3 = index == #var6

        local tbl2 = ({})
        for layoutOrder, value2 in item do
            local var8 = var7 + layoutOrder
            local var9 = if keyExtractor then keyExtractor(value2, var8) else `Item{var8}`
            local createElement = React.createElement
            local view = Foundation.View

            local tbl3 = {
                Cell = tbl1.renderItem(value2, var8)
            }
            tbl2[var9] = createElement(view, { tag = "size-full-0 auto-y", LayoutOrder = layoutOrder }, tbl3)
        end

        for layoutOrder = #item + 1, fallbackNumColumns do
            tbl2[`Filler{layoutOrder}`] = React.createElement(Foundation.View, { tag = "size-full-0", LayoutOrder = layoutOrder })
        end

        return React.createElement(Foundation.View, {
            tag = "row flex-x-fill size-full-0 auto-y padding-x-xsmall",
            layout = {
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, offset)
            },
            padding = {
                top = if index == 1 then UDim.new(0, offset3) else UDim.new(0, 0),
                bottom = if bool3 and not bool1 and contentPaddingBottom ~= nil then UDim.new(0, contentPaddingBottom) else UDim.new(0, offset2)
            },
            LayoutOrder = index
        }, tbl2)
    end, {
        var6,
        fallbackNumColumns,
        offset,
        offset2,
        offset3,
        contentPaddingBottom,
        bool1,
        tbl1.renderItem,
        keyExtractor
    })

    local var5 = React.useCallback(function(tbl2, num1: number)
        local var8 = tbl2[1]
        if var8 ~= nil and keyExtractor then
            return keyExtractor(var8, (num1 - 1) * fallbackNumColumns + 1)
        end
        return `Row{num1}`
    end, { keyExtractor, fallbackNumColumns })

    local listFooterComponent = if tbl1.ListFooterSlot then React.createElement(
        Foundation.View,
        {
            tag = "size-full-0 auto-y",
            padding = {
                bottom = UDim.new(0, contentPaddingBottom or var1.Padding.Medium)
            }
        },
        {
            Footer = tbl1.ListFooterSlot
        }
    ) else nil
    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = { tag = "size-full clip", onAbsoluteSizeChanged = onAbsoluteSizeChanged }
    local tbl3 = { List = 0 }
    local element2

    if bool2 then
        element2 = nil
    else
        element2 = React.createElement(FlatList, {
            data = var6,
            renderItem = renderItem,
            keyExtractor = var5,
            ListEmptyComponent = tbl1.ListEmptySlot,
            ListHeaderComponent = tbl1.ListHeaderSlot,
            ListFooterComponent = listFooterComponent,
            onEndReached = tbl1.onEndReached,
            onEndReachedThreshold = tbl1.onEndReachedThreshold or 2,
            windowSize = tbl1.windowSize or 10,
            initialNumToRender = tbl1.initialNumToRender or 8,
            maxToRenderPerBatch = tbl1.maxToRenderPerBatch or 1,
            updateCellsBatchingPeriod = tbl1.updateCellsBatchingPeriod or 30,
            contentContainerStyle = { BackgroundTransparency = 1, BorderSizePixel = 0 },
            style = {
                BackgroundTransparency = 1,
                ScrollBarThickness = 0,
                BorderSizePixel = 0,
                ClipsDescendants = false
            }
        })
    end

    tbl3.List = element2
    return createElement(view, tbl2, tbl3)
end

return VirtualizedGrid
