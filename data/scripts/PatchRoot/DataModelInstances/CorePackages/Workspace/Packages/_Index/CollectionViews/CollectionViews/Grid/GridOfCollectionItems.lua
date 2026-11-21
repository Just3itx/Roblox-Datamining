-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:11:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CollectionViews = script:FindFirstAncestor("CollectionViews")
local CollectionViewsParent = CollectionViews.Parent
local React = require(CollectionViewsParent.React)
local Cryo = require(CollectionViewsParent.Cryo)
local ArgCheck = require(CollectionViewsParent.ArgCheck)
local calculateRelativeColumnGap = require(CollectionViews.Grid.calculateRelativeColumnGap)

local bool1 = game:DefineFastFlag("LuaAppFixCollectionGridWindowAbsoluteCanvasSize", false)
local bool2 = game:DefineFastFlag("LuaAppGridReuseUnchangedTileElements", false)
local FFlagLuaAppCollectionGridRemeasureOnMove = require(CollectionViewsParent.SharedFlags).FFlagLuaAppCollectionGridRemeasureOnMove

local num1 = game:DefineFastInt("LuaAppCollectionGridScrollSettleMs", 150)

local tbl1 = {
    maxNumRows = math.huge,
    numColumns = 1,
    bufferRowsBelowScreen = 4,
    bufferRowsAboveScreen = 4,
    columnGap = 0,
    sideMargin = 0,
    verticalPadding = 0,
    thresholdRowsFromBottom = 0
}

return React.memo(function(tbl2) -- name: GridOfCollectionItems
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)
    local ref = React.useRef(nil)

    local num2 = math.min(math.ceil(#var1.items / var1.numColumns), var1.maxNumRows)

    local var3 = var1.itemSizeBinding:map(function(vector2: Vector2)
        return num2 * (vector2.Y + var1.verticalPadding) - var1.verticalPadding
    end)

    local var4, var5 = React.useState(-1)
    local var6, var7 = React.useState(-1)

    local var8, var9 = React.useState(var1.bufferRowsBelowScreen + var1.bufferRowsAboveScreen)

    React.useEffect(function()
        local tbl3 = {}
        local var10 = nil
        if var1.verticalScrollingFrameRef and var1.verticalScrollingFrameRef.current and ref.current then
            local current = ref.current
            local current2 = var1.verticalScrollingFrameRef.current
            local y = var1.itemSizeBinding:getValue().Y

            local absolutePositionY = current2.AbsolutePosition.Y

            local absoluteWindowSizeY = current2.AbsoluteWindowSize.Y

            local num3 = math.max(1, y + var1.verticalPadding)
            local num4 = math.ceil(absoluteWindowSizeY / num3) + 1

            local function calculateOffsetOfGrid() -- Luacid: Inlined by compiler; 2 call sites recovered
                return current.AbsolutePosition.Y + current2.CanvasPosition.Y - absolutePositionY
            end

            local var11 = calculateOffsetOfGrid()

            local function updateRowsToRender()
                local canvasPositionY = current2.CanvasPosition.Y
                local y2 = var1.itemSizeBinding:getValue().Y
                local num5 = math.max(1, y2 + var1.verticalPadding)
                local var12 = num2 * (y2 + var1.verticalPadding) - var1.verticalPadding

                local var13 = var11 - canvasPositionY

                local var14 = var1.bufferRowsAboveScreen * num5
                local var15 = var1.bufferRowsBelowScreen * num5
                local var16, var17

                if absoluteWindowSizeY + var15 < var13 or var13 + var12 < -var14 then
                    var16 = -1
                    var17 = -1
                else
                    local num6 = math.floor(-var13 / num5)

                    var16 = math.max(1, num6 + 1 - var1.bufferRowsAboveScreen)

                    local var18 = num4 + var1.bufferRowsBelowScreen
                    local var19 = if num6 <= 0 then var18 + num6 else var18 + math.min(num6, var1.bufferRowsAboveScreen)
                    local num7 = math.max(1, var19)
                    var17 = math.min(num2, var16 + num7 - 1)
                end

                var5(var16)
                var7(var17)
            end

            local function updateWindowParams()
                local num5 = math.max(1, var1.itemSizeBinding:getValue().Y + var1.verticalPadding)
                absolutePositionY = current2.AbsolutePosition.Y
                absoluteWindowSizeY = current2.AbsoluteWindowSize.Y
                var11 = calculateOffsetOfGrid()
                num4 = math.ceil(absoluteWindowSizeY / num5) + 1
                var9(math.min(num2, num4 + var1.bufferRowsBelowScreen + var1.bufferRowsAboveScreen))

                updateRowsToRender()
            end

            local absolutePositionChanged = current2:GetPropertyChangedSignal("AbsolutePosition")
            table.insert(tbl3, absolutePositionChanged:Connect(updateWindowParams))

            local absoluteWindowSizeChanged = current2:GetPropertyChangedSignal("AbsoluteWindowSize")
            table.insert(tbl3, absoluteWindowSizeChanged:Connect(updateWindowParams))

            local var12 = current2:GetPropertyChangedSignal(if bool1 then "AbsoluteCanvasSize" else "CanvasSize")
            table.insert(tbl3, var12:Connect(updateWindowParams))

            if FFlagLuaAppCollectionGridRemeasureOnMove then
                local num5 = num1 / 1000
                local num6 = 0

                local function onSettleTimer()
                    local num7 = num5 - (os.clock() - num6)
                    if num7 > 0 then
                        var10 = task.delay(num7, onSettleTimer)
                        return
                    end
                    var10 = nil
                    if current.Parent and current2.Parent then
                        updateWindowParams()
                    end
                end

                local canvasPositionChanged = current2:GetPropertyChangedSignal("CanvasPosition")

                table.insert(tbl3, canvasPositionChanged:Connect(function()
                    num6 = os.clock()

                    var10 = var10 or task.delay(num5, onSettleTimer)

                    updateRowsToRender()
                end))
            else
                local canvasPositionChanged = current2:GetPropertyChangedSignal("CanvasPosition")
                table.insert(tbl3, canvasPositionChanged:Connect(updateRowsToRender))
            end

            updateWindowParams()
        else
            var5(1)
            var7(num2)
            var9(num2)
        end
        return function()
            if FFlagLuaAppCollectionGridRemeasureOnMove and var10 then
                task.cancel(var10)
                var10 = nil
            end

            for _, value in tbl3 do
                value:Disconnect()
            end
        end
    end, {
        ref,
        num2,
        var1.itemSizeBinding,
        var1.verticalScrollingFrameRef,
        var1.verticalPadding,
        var1.bufferRowsAboveScreen,
        var1.bufferRowsBelowScreen,
        var1.onViewableItemsChanged
    })

    local num3 = math.min(var6, num2)

    local num4 = math.max(-1, (var4 - 1) * var1.numColumns + 1)
    local itemsLen = #var1.items
    local numColumns = var1.numColumns
    local num5 = math.max(-1, math.min(itemsLen, num3 * numColumns))

    React.useEffect(function()
        if var1.onViewableItemsChanged then
            var1.onViewableItemsChanged(num4, num5)
        end
    end, { num4, num5, var1.onViewableItemsChanged })

    local var10 = React.useRef(nil)
    React.useEffect(function()
        if num3 >= num2 - var1.thresholdRowsFromBottom and var10.current ~= var1.items and var1.onReachedThresholdFromEnd then
            var1.onReachedThresholdFromEnd()
            var10.current = var1.items
        end
    end, {
        num3,
        num2,
        var1.thresholdRowsFromBottom,
        var1.onReachedThresholdFromEnd,
        var1.items
    })

    local var11 = if bool2 then React.useRef({}) else nil

    local var12 = React.useMemo(function()
        local result = {}
        if var4 <= 0 or num3 < var4 then
            return nil
        end
        if num4 <= 0 or num5 < num4 then
            return nil
        end
        if var1.numColumns <= 0 or num2 - var4 < 0 then
            return nil
        end

        ArgCheck.assert(var4 >= 1)
        ArgCheck.assert(var4 <= num3 and num3 <= num2)

        if var4 > 1 then
            local var12 = var4 - 1
            result.Padding = React.createElement("UIPadding", {
                PaddingTop = var1.itemSizeBinding:map(function(vector2: Vector2): UDim
                    return UDim.new(0, var12 * (vector2.Y + var1.verticalPadding))
                end)
            })
        end

        local var12 = num2 - var4 + 1

        ArgCheck.assert(var12 >= 1)
        ArgCheck.assert(var1.numColumns >= 1)

        local var13 = var1.numColumns - 1
        local var14 = var12 - 1
        local cellSize = UDim2.new(
            1 / var1.numColumns,
            math.floor(-(var13 / var1.numColumns) * var1.columnGap),
            1 / var12,
            math.floor(-(var14 / var12) * var1.verticalPadding)
        )
        local var16 = math.floor(var13 / var1.numColumns * var1.columnGap) * var1.numColumns - var1.columnGap * var13
        local xOffset = var1.columnGap + var16 / var13

        local cellPadding = if var1.disableRelativeGap then UDim2.new(0, xOffset, 0, var1.verticalPadding) else var1.itemSizeBinding:map(function(vector2: Vector2): UDim2
            local relativeColumnGap = calculateRelativeColumnGap(var1.numColumns, var1.columnGap, vector2.X, var1.sideMargin)
            return UDim2.new(relativeColumnGap, 0, 0, var1.verticalPadding)
        end)

        result.Layout = React.createElement("UIGridLayout", {
            FillDirectionMaxCells = var1.numColumns,
            CellPadding = cellPadding,
            CellSize = cellSize,
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            SortOrder = Enum.SortOrder.LayoutOrder
        })

        ArgCheck.assert(num4 >= 1)
        ArgCheck.assert(num4 <= num5 and num5 <= #var1.items)
        if not bool2 then
            for i = num4, num5 do
                if i <= #var1.items then
                    local num6 = math.ceil(i / var1.numColumns)
                    local item = var1.items[i]
                    local var18, var19 = var1.renderItem(item, i, UDim2.fromScale(1, 1), num6)
                    result[`{var19}{i % (var8 * var1.numColumns)}`] = var18
                end
            end

            return result
        end

        local current = var11.current
        local tbl3 = ({})
        for i = num4, num5 do
            if not (i <= #var1.items) then
                continue
            end

            local rowNum = math.ceil(i / var1.numColumns)
            local entry = var1.items[i]
            local var18 = current[i]
            local element, keyPrefix

            if var18 and var18.entry == entry and var18.renderItem == var1.renderItem and var18.rowNum == rowNum then
                element = var18.element
                keyPrefix = var18.keyPrefix
            else
                element, keyPrefix = var1.renderItem(entry, i, UDim2.fromScale(1, 1), rowNum)
            end
            local tbl4 = {
                entry = entry,
                renderItem = var1.renderItem,
                rowNum = rowNum,
                element = element,
                keyPrefix = keyPrefix
            }
            tbl3[i] = tbl4

            result[`{keyPrefix}{i % (var8 * var1.numColumns)}`] = element
        end

        var11.current = tbl3
        return result
    end, {
        var1.columnGap,
        var1.numColumns,
        var1.itemSizeBinding,
        var4,
        num3,
        var1.items,
        var1.renderItem,
        var1.verticalPadding,
        var8,
        num2,
        var1.sideMargin,
        num4,
        num5,
        var1.disableRelativeGap
    })

    return React.createElement("Frame", {
        ref = ref,
        Size = var3:map(function(yOffset: number?): UDim2
            return UDim2.new(1, 0, 0, yOffset)
        end),
        BackgroundTransparency = 1,
        LayoutOrder = var1.LayoutOrder,
        Position = var1.Position
    }, var12)
end)
