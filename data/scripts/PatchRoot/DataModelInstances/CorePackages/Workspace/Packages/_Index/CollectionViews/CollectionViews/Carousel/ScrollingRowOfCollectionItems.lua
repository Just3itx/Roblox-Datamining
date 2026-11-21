-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:10:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CollectionViews = script:FindFirstAncestor("CollectionViews")
local CollectionViewsParent = CollectionViews.Parent
local React = require(CollectionViewsParent.React)
local ArgCheck = require(CollectionViewsParent.ArgCheck)

local useHorizontalScrolledToEndThreshold = require(CollectionViews.Carousel.useHorizontalScrolledToEndThreshold)
local useHorizontalWindowStartIndex = require(CollectionViews.Carousel.useHorizontalWindowStartIndex)
local RowOfCollectionItems = require(CollectionViews.Carousel.RowOfCollectionItems)

local function getNumToRenderWithVirtualization(totalItemsOnCanvas: number, numColumns: number, numItemsToRenderOffScreen: number?): number -- Luacid: Inlined by compiler; 1 call site recovered
    if numColumns == 0 then
        return 0
    end

    return math.min(numColumns + (numItemsToRenderOffScreen or 6), totalItemsOnCanvas)
end

return React.memo(function(tbl1) -- name: ScrollingRowOfCollectionItems
    local var1 = React.useRef(nil)
    local ref = React.useCallback(function(current)
        var1.current = current

        if tbl1.onScrollingFrameRefCallback then
            tbl1.onScrollingFrameRefCallback(current)
        end
    end, { tbl1.onScrollingFrameRefCallback })

    useHorizontalScrolledToEndThreshold(var1, tbl1.thresholdFromEnd, tbl1.onReachedThresholdFromEnd, tbl1.ScrollingEnabled)

    ArgCheck.assert(tbl1.totalItemsOnCanvas >= 0)
    ArgCheck.assert(tbl1.numColumns >= 1)
    ArgCheck.assert(tbl1.columnGap >= 0)
    local var3 = not (tbl1.numItemsToRenderOffScreen == -1) and tbl1.ScrollingEnabled and tbl1.totalItemsOnCanvas > tbl1.numColumns * 2
    local numToRenderWithVirtualization = if var3 then getNumToRenderWithVirtualization(tbl1.totalItemsOnCanvas, tbl1.numColumns, tbl1.numItemsToRenderOffScreen) else math.min(tbl1.totalItemsOnCanvas, #tbl1.items)
    local numItemsForSizing = math.max(tbl1.numColumns, tbl1.totalItemsOnCanvas)
    ArgCheck.assert(numToRenderWithVirtualization >= 0)

    local startingIndex = math.min(useHorizontalWindowStartIndex(var1, tbl1.itemSizeBinding, tbl1.columnGap, var3), #tbl1.items)

    local endingIndex = math.max(0, math.min(tbl1.totalItemsOnCanvas, startingIndex + numToRenderWithVirtualization - 1))

    ArgCheck.assert(
        startingIndex >= 0 and startingIndex <= #tbl1.items,
        `startingIndex: {startingIndex} failed check >= 0 and <= {#tbl1.items}`
    )
    ArgCheck.assert(
        startingIndex <= endingIndex and endingIndex <= #tbl1.items,
        `endingIndex: {endingIndex} failed check >= {startingIndex} and <= {#tbl1.items}`
    )

    React.useEffect(function()
        if tbl1.onViewableItemsChanged then
            tbl1.onViewableItemsChanged(startingIndex, endingIndex)
        end
    end, { startingIndex, endingIndex, tbl1.onViewableItemsChanged })

    local createElement = React.createElement
    local str1 = "ScrollingFrame"

    local tbl2 = {
        Size = if tbl1.Size then tbl1.Size else tbl1.itemSizeBinding:map(function(vector2: Vector2): UDim2
            return UDim2.new(1, 0, 0, vector2.Y)
        end),
        Position = tbl1.Position,
        LayoutOrder = tbl1.LayoutOrder,
        ScrollBarThickness = 0,
        BackgroundTransparency = 1,
        ClipsDescendants = false,
        CanvasSize = tbl1.itemSizeBinding:map(function(vector2: Vector2): UDim2
            local xOffset = math.max(0, numItemsForSizing * (vector2.X + tbl1.columnGap) - tbl1.columnGap)
            return UDim2.new(0, xOffset, 0, vector2.Y)
        end),
        ScrollingEnabled = tbl1.ScrollingEnabled and tbl1.totalItemsOnCanvas > tbl1.numColumns,
        ScrollingDirection = Enum.ScrollingDirection.X,
        ElasticBehavior = Enum.ElasticBehavior.Always,
        Selectable = false,
        [React.Change.CanvasPosition] = tbl1.onChangeCanvasPosition,
        ref = ref,
        AutomaticSize = tbl1.AutomaticSize
    }

    return createElement(str1, tbl2, {
        RowOfCollectionItems = React.createElement(RowOfCollectionItems, {
            startingIndex = startingIndex,
            endingIndex = endingIndex,
            numToRender = numToRenderWithVirtualization,
            items = tbl1.items,
            totalItemsOnCanvas = tbl1.totalItemsOnCanvas,
            columnGap = tbl1.columnGap,
            renderItem = tbl1.renderItem,
            sideMargin = tbl1.sideMargin,
            numItemsForSizing = numItemsForSizing
        })
    })
end)
