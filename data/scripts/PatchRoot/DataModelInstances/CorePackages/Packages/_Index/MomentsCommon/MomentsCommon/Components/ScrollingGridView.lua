-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:01:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommonParent = script:FindFirstAncestor("MomentsCommon").Parent

local Dash = require(MomentsCommonParent.Dash)
local Foundation = require(MomentsCommonParent.Foundation)
local React = require(MomentsCommonParent.React)

local Button = Foundation.Button
local ScrollBarVisibility = Foundation.Enums.ScrollBarVisibility
local ScrollView = Foundation.ScrollView
local View = Foundation.View

local useTokens = Foundation.Hooks.useTokens

local function GridItems(tbl1)
    local tbl2 = ({})
    for layoutOrder, item in tbl1.items do
        local createElement = React.createElement
        local var1 = View
        local tbl3 = {
            LayoutOrder = layoutOrder,
            Size = UDim2.fromOffset(tbl1.itemSize.X, tbl1.itemSize.Y)
        }
        local tbl4 = {
            Content = tbl1.renderItem(item, layoutOrder)
        }
        tbl2[layoutOrder] = createElement(var1, tbl3, tbl4)
    end

    return React.createElement(
        View,
        {
            AutomaticSize = Enum.AutomaticSize.Y,
            LayoutOrder = tbl1.LayoutOrder,
            tag = "auto-y size-full-0"
        },
        {
            UIGridLayout = React.createElement("UIGridLayout", {
                CellPadding = UDim2.fromOffset(tbl1.itemPadding.X, tbl1.itemPadding.Y),
                CellSize = UDim2.fromOffset(tbl1.itemSize.X, tbl1.itemSize.Y),
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                SortOrder = Enum.SortOrder.LayoutOrder
            }),
            Children = React.createElement(React.Fragment, nil, tbl2)
        }
    )
end

return function(tbl1)
    local var1, var2 = React.useState(Vector2.new(0, 0))
    local var3, var4 = React.useState(0)

    local var5 = useTokens()

    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        var2(arg1.AbsoluteSize)
    end, {})

    local itemsPerRow = React.useMemo(function(): number
        return math.clamp(math.floor(var1.X / tbl1.itemConfig.minItemWidth), 1, tbl1.itemConfig.maxItemsPerRow)
    end, { var1, tbl1.itemConfig })

    local itemSize = React.useMemo(function(): Vector2
        local var8 = var1.X - tbl1.itemConfig.padding * (itemsPerRow - 1)

        local num1 = math.min(var8 / itemsPerRow, var8)
        local var9 = num1 * tbl1.aspectRatio

        return Vector2.new(math.floor(num1), math.floor(var9))
    end, {
        var1,
        itemsPerRow,
        tbl1.aspectRatio,
        tbl1.itemConfig
    })
    local var9 = React.useMemo(function(): number
        if var1.Y <= 0 then
            return 0
        end

        return math.max(math.floor(var1.Y / itemSize.Y) * itemsPerRow, tbl1.itemConfig.minItemsPerPage)
    end, {
        var1,
        itemSize,
        itemsPerRow,
        tbl1.itemConfig
    })

    local bool1 = var1.X > 0 and var1.Y > 0
    local var10 = tbl1.shouldShowShowMoreButton or var3 < #tbl1.items

    React.useEffect(function()
        if var3 < var9 then
            var4(var9)
        end
    end, { var1, var9, var3 })

    local onActivated = React.useCallback(function()
        if var3 + var9 > #tbl1.items and tbl1.shouldShowShowMoreButton then
            tbl1.onShowMoreCallback()
        end

        var4(var3 + var9)
    end, {
        var3,
        var9,
        tbl1.items,
        tbl1.onShowMoreCallback
    })
    local items = React.useMemo(function()
        if not var10 then
            return tbl1.items
        end

        local num1 = math.min(#tbl1.items, var3)
        return Dash.slice(tbl1.items, 1, num1)
    end, { tbl1.items, var10, var3 })

    if tbl1.items == nil or #tbl1.items == 0 then
        return React.createElement(
            View,
            { onAbsoluteSizeChanged = onAbsoluteSizeChanged, tag = "shrink size-full" },
            {
                EmptyState = tbl1.renderEmptyState()
            }
        )
    end
    local createElement = React.createElement
    local var13 = View
    local tbl2 = { onAbsoluteSizeChanged = onAbsoluteSizeChanged, tag = "shrink size-full" }

    local tbl3 = { GridViewContainer = 0 }
    local createElement2 = React.createElement
    local var14 = View
    local tbl4 = { tag = "size-full" }

    local tbl5 = {
        ScrollView = React.createElement(ScrollView, {
            BorderSizePixel = 0,
            layout = {
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Top,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, var5.Padding.Large)
            },
            LayoutOrder = if tbl1.layoutOrder then tbl1.layoutOrder else 1,
            scroll = {
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                CanvasSize = UDim2.fromScale(1, 0),
                ScrollingDirection = Enum.ScrollingDirection.Y,
                scrollBarVisibility = ScrollBarVisibility.None
            },
            tag = "size-full"
        }, {
            UIPadding = if tbl1.padding then React.createElement("UIPadding", {
                PaddingBottom = tbl1.padding.bottom,
                PaddingTop = tbl1.padding.top,
                PaddingLeft = tbl1.padding.left,
                PaddingRight = tbl1.padding.right
            }) else nil,
            GridView = if #tbl1.items > 0 and bool1 then React.createElement(GridItems, {
                itemPadding = Vector2.new(tbl1.itemConfig.padding, tbl1.itemConfig.padding),
                items = items,
                itemsPerRow = itemsPerRow,
                itemSize = itemSize,
                LayoutOrder = 1,
                renderItem = tbl1.renderItem
            }) else nil,
            ShowMore = if var10 then React.createElement(
                Button,
                {
                    LayoutOrder = 2,
                    onActivated = onActivated,
                    size = Foundation.Enums.InputSize.Small,
                    text = tbl1.showMoreButtonText
                }
            ) else nil
        })
    }
    tbl3.GridViewContainer = createElement2(var14, tbl4, tbl5)
    return createElement(var13, tbl2, tbl3)
end
