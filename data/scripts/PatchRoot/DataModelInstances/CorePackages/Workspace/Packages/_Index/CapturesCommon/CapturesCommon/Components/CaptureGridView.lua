-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Dash = require(scriptParentParentParent.Dash)
local Foundation = require(scriptParentParentParent.Foundation)
local React = require(scriptParentParentParent.React)
local GridView = require(scriptParentParentParent.UIBlox).App.Grid.GridView

local ScrollBarVisibility = Foundation.Enums.ScrollBarVisibility
local ScrollView = Foundation.ScrollView
local View = Foundation.View

local MenuButton = require(scriptParentParent.Components.MenuButton)
local _Types = require(scriptParentParent.Types)
local useScreenSize = require(scriptParentParent.Hooks.useScreenSize)

local function getItemsPerRow(num1: number): number -- Luacid: Inlined by compiler; 3 call sites recovered
    return math.clamp(math.floor(num1 / 120), 1, 4)
end

local function getGalleryItemSize(num1: number, num2: number): Vector2
    local itemsPerRow = getItemsPerRow(num2)
    num2 -= 4 * (itemsPerRow - 1)

    local num3 = math.min(num2 / itemsPerRow, num2)
    local num4 = num3 * num1

    return Vector2.new(math.floor(num3), math.floor(num4))
end

local function getItemsPerPage(num1: number, num2: number, vector2: Vector2): number -- Luacid: unused: defined but never referenced
    if num1 <= 0 then
        return 0
    end

    local num3 = math.floor(num1 / vector2.Y)
    if num1 < vector2.Y * num3 + (num3 - 1) * 4 then
        num3 -= 1
    end

    return math.max(num3 * getItemsPerRow(num2), 8)
end

return function(tbl1)
    local var1, var2 = React.useState(Vector2.new(0, 0))
    local var3, var4 = React.useState(0)
    local var5 = useScreenSize()

    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        var2(arg1.AbsoluteSize)
    end, {})

    local bool1 = var1.X > 0 and var1.Y > 0
    local var7 = tbl1.shouldShowShowMoreButton and var3 < #tbl1.captures
    local num1 = math.clamp(var5.Y / var5.X, 3 / 7, 1)

    local var8 = var1.Y - 12 - 40 - 36
    local var9 = var1.X - 12 - 8

    local itemSize = React.useMemo(function(): Vector2
        return getGalleryItemSize(num1, var9)
    end, { num1, var9 })

    local var11 = React.useMemo(function(): number
        local var11 = var8
        local var12 = var9
        local var13 = itemSize

        if var11 <= 0 then
            return 0
        end

        local num2 = math.floor(var11 / var13.Y)
        if var11 < var13.Y * num2 + (num2 - 1) * 4 then
            num2 -= 1
        end

        return math.max(num2 * getItemsPerRow(var12), 8)
    end, { var8, var9, itemSize })

    React.useEffect(function()
        if var3 < var11 then
            var4(var11)
        end
    end, { var1, var11, var3 })

    local onActivated = React.useCallback(function()
        var4(var3 + var11)
    end, { var3, var11 })

    local items = React.useMemo(function()
        if not var7 then
            return tbl1.captures
        end

        local num2 = math.min(#tbl1.captures, var3)
        return Dash.slice(tbl1.captures, 1, num2)
    end, { tbl1.captures, var7, var3 })

    local createElement = React.createElement
    local var14 = View
    local tbl2 = {
        BorderSizePixel = 0,
        onAbsoluteSizeChanged = onAbsoluteSizeChanged,
        Position = if tbl1.position then tbl1.position else UDim2.fromOffset(0, 0),
        Size = if tbl1.size then tbl1.size else UDim2.fromScale(1, 1),
        tag = "bg-surface-0"
    }
    local tbl3 = { CaptureGridViewContainer = 0 }
    local createElement2 = React.createElement
    local var15 = View
    local tbl4 = {
        tag = "bg-action-subtle size-full gap-xsmall col align-x-center align-y-top shrink"
    }
    local tbl5 = {
        Header = tbl1.header,
        ScrollView = React.createElement(ScrollView, {
            BorderSizePixel = 0,
            LayoutOrder = if tbl1.layoutOrder then tbl1.layoutOrder else 1,
            scroll = {
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                CanvasSize = UDim2.fromScale(1, 0),
                ScrollingDirection = Enum.ScrollingDirection.Y,
                scrollBarVisibility = ScrollBarVisibility.Auto
            },
            tag = "auto-y size-full-0 gap-xsmall col align-x-center align-y-top shrink padding-x-xsmall"
        }, {
            GridView = if bool1 then React.createElement(
                GridView,
                {
                    itemPadding = Vector2.new(4, 4),
                    items = items,
                    itemSize = itemSize,
                    LayoutOrder = 1,
                    renderItem = tbl1.renderItem
                }
            ) else nil,
            ShowMore = if var7 then React.createElement(MenuButton, { buttonHeight = 40, LayoutOrder = 2, onActivated = onActivated, text = "Show More" }) else nil
        })
    }
    tbl3.CaptureGridViewContainer = createElement2(var15, tbl4, tbl5)
    return createElement(var14, tbl2, tbl3)
end
