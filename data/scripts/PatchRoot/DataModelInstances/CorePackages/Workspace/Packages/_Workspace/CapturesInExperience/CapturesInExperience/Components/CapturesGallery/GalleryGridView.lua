-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:41:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Dash = require(scriptParentParentParentParent.Dash)
local React = require(scriptParentParentParentParent.React)
local RoactUtils = require(scriptParentParentParentParent.RoactUtils)
local RobloxAppHooks = require(scriptParentParentParentParent.RobloxAppHooks)
local UIBlox = require(scriptParentParentParentParent.UIBlox)

local useEffectOnce = RoactUtils.Hooks.useEffectOnce
local useScreenSize = RobloxAppHooks.useScreenSize

local GridView = UIBlox.App.Grid.GridView

local GalleryActionContainer = require(scriptParentParentParent.Components.CapturesGallery.GalleryActionContainer)
local GalleryItem = require(scriptParentParentParent.Components.CapturesGallery.GalleryItem)
local ShowMoreButton = require(scriptParentParentParent.Components.Common.ShowMoreButton)
local _Types = require(scriptParentParentParent.Types)

local function getItemsPerRow(num1: number): number -- Luacid: Inlined by compiler; 6 call sites recovered
    return math.clamp(math.floor(num1 / 120), 1, 4)
end

local function getGalleryItemSize(num1: number, num2: number): Vector2 -- Luacid: Inlined by compiler; 2 call sites recovered
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

local function renderGalleryItem(capture, captureIndex: number)
    return React.createElement(GalleryItem, { capture = capture, captureIndex = captureIndex })
end

return function(tbl1)
    local var1, var2 = React.useState(Vector2.new(0, 0))
    local var3, var4 = React.useState(0)
    local var5 = useScreenSize()

    local bool1 = var3 < #tbl1.captures
    local bool2 = var1.X > 0 and var1.Y > 0

    local var6 = React.useCallback(function(arg1)
        var2(arg1.AbsoluteSize)
    end, {})

    local num1 = math.clamp(var5.Y / var5.X, 3 / 7, 1)

    local var7 = var1.Y - 12 - 40 - 36
    local x = var1.X
    local vector2 = getGalleryItemSize(num1, x)
    local num2

    if var7 <= 0 then
        num2 = 0
    else
        local num3 = math.floor(var7 / vector2.Y)
        if var7 < vector2.Y * num3 + (num3 - 1) * 4 then
            num3 -= 1
        end

        num2 = math.max(num3 * getItemsPerRow(x), 8)
    end

    if num2 < var3 then
        local var8 = x - 9
        vector2 = getGalleryItemSize(num1, var8)

        if var7 <= 0 then
            num2 = 0
        else
            local num3 = math.floor(var7 / vector2.Y)
            if var7 < vector2.Y * num3 + (num3 - 1) * 4 then
                num3 -= 1
            end

            num2 = math.max(num3 * getItemsPerRow(var8), 8)
        end
    end

    useEffectOnce(function()
        var4(num2)
    end, num2 ~= 0)

    React.useEffect(function()
        if var3 < num2 then
            var4(num2)
        end
    end, { var1 })

    local onActivated = React.useCallback(function()
        var4(var3 + num2)
    end, { var3, num2 })

    local items = React.useMemo(function()
        local num3 = math.min(#tbl1.captures, var3)
        return Dash.slice(tbl1.captures, 1, num3)
    end, { tbl1.captures, var3 })

    return React.createElement("Frame", {
        BackgroundTransparency = 1,
        LayoutOrder = tbl1.LayoutOrder,
        Size = tbl1.Size or UDim2.fromScale(1, 1),
        [React.Change.AbsoluteSize] = var6
    }, {
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Top
        }),
        GalleryActionContainer = React.createElement(GalleryActionContainer, { isDisabled = false, itemCount = #tbl1.captures, LayoutOrder = 1 }),
        ScrollingFrame = React.createElement("ScrollingFrame", {
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            CanvasSize = UDim2.fromScale(1, 0),
            LayoutOrder = 2,
            ScrollBarThickness = 1,
            ScrollingDirection = Enum.ScrollingDirection.Y,
            Size = UDim2.new(1, 0, 1, -36)
        }, {
            UIListLayout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Top,
                Padding = UDim.new(0, 12)
            }),
            GridView = bool2
                and React.createElement(
                    GridView,
                    {
                        itemPadding = Vector2.new(4, 4),
                        items = items,
                        itemSize = vector2,
                        LayoutOrder = 1,
                        renderItem = renderGalleryItem
                    }
                ),
            ShowMoreButton = bool1 and React.createElement(ShowMoreButton, { LayoutOrder = 2, buttonHeight = 40, onActivated = onActivated })
        })
    })
end
