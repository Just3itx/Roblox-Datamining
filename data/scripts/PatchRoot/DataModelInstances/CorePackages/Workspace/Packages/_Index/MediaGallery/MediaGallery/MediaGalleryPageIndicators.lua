-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:00:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MediaGallery = script:FindFirstAncestor("MediaGallery")
local MediaGalleryParent = MediaGallery.Parent

local React = require(MediaGalleryParent.React)
local _ReactOtter = require(MediaGalleryParent.ReactOtter)
local _AppCommonLib = require(MediaGalleryParent.AppCommonLib)

local useTokens = require(MediaGalleryParent.Foundation).Hooks.useTokens

local useIndicatorScrollAnimation = require(MediaGallery.Hooks.useIndicatorScrollAnimation)
local MAX_VISIBLE_INDICATORS = require(MediaGallery.MediaGalleryConstants).MAX_VISIBLE_INDICATORS

local FFlagLuaAppMediaGalleryPageIndicatorOpacity = require(MediaGalleryParent.SharedFlags).FFlagLuaAppMediaGalleryPageIndicatorOpacity

local function getDotAnchorPointAtIndex(num1: number, previousItemIndex: number, currentItemIndex: number)
    if currentItemIndex < previousItemIndex then
        if num1 == previousItemIndex then
            return Vector2.new(1, 0.5)
        end

        if num1 == currentItemIndex then
            return Vector2.new(0, 0.5)
        end
    elseif previousItemIndex < currentItemIndex then
        if num1 == previousItemIndex then
            return Vector2.new(0, 0.5)
        end

        if num1 == currentItemIndex then
            return Vector2.new(1, 0.5)
        end
    end

    return Vector2.new(0.5, 0.5)
end

local function getDotPositionAtIndex(num1: number, previousItemIndex: number, currentItemIndex: number)
    if currentItemIndex < previousItemIndex then
        if num1 == previousItemIndex then
            return UDim2.fromScale(1, 0.5)
        end

        if num1 == currentItemIndex then
            return UDim2.fromScale(0, 0.5)
        end
    elseif previousItemIndex < currentItemIndex then
        if num1 == previousItemIndex then
            return UDim2.fromScale(0, 0.5)
        end

        if num1 == currentItemIndex then
            return UDim2.fromScale(1, 0.5)
        end
    end

    return UDim2.fromScale(0.5, 0.5)
end

return React.memo(function(tbl1) -- name: MediaGalleryPageIndicators
    local var1 = useTokens()

    local size100 = var1.Size.Size_100
    local size150 = var1.Size.Size_150
    local size200 = var1.Size.Size_200
    local xOffset = if FFlagLuaAppMediaGalleryPageIndicatorOpacity then var1.Size.Size_600 else var1.Size.Size_800
    local indicatorPadding = if FFlagLuaAppMediaGalleryPageIndicatorOpacity then var1.Size.Size_150 else var1.Padding.Small
    local muted = var1.DarkMode.Content.Muted
    local emphasis = var1.DarkMode.Content.Emphasis
    local white = if FFlagLuaAppMediaGalleryPageIndicatorOpacity then var1.Color.Extended.White else nil
    local var2 = useIndicatorScrollAnimation({
        numberOfItems = tbl1.numberOfItems,
        startIndex = tbl1.startIndex,
        scrolledSignal = tbl1.mediaGalleryScrolledSignal,
        useSpring = tbl1.useSpring,
        springConfig = tbl1.springConfig,
        indicatorSize = size200,
        indicatorPadding = indicatorPadding
    })

    local num1 = math.min(tbl1.numberOfItems, MAX_VISIBLE_INDICATORS)

    local xOffset2 = React.useMemo(function()
        return (num1 - 1) * (size200 + indicatorPadding) + xOffset
    end, {
        num1,
        size200,
        indicatorPadding,
        xOffset
    })
    local var3 = React.useRef({})

    local var4 = React.useCallback(function(num2: number)
        local num3 = math.min(var2.firstVisibleIndex + num1 - 1, tbl1.numberOfItems)
        local bool1 = var2.firstVisibleIndex > 1
        local bool2 = num3 < tbl1.numberOfItems

        if num2 == var2.currentItemIndex then
            return UDim2.fromOffset(xOffset, size200)
        end

        if bool1 then
            if num2 < var2.firstVisibleIndex then
                return UDim2.fromOffset(0, 0)
            end

            if num2 == var2.firstVisibleIndex then
                return UDim2.fromOffset(size100, size100)
            end

            if num2 == var2.firstVisibleIndex + 1 then
                return UDim2.fromOffset(size150, size150)
            end
        end

        if bool2 then
            if num3 < num2 then
                return UDim2.fromOffset(0, 0)
            end

            if num2 == num3 then
                return UDim2.fromOffset(size100, size100)
            end

            if num2 == num3 - 1 then
                return UDim2.fromOffset(size150, size150)
            end
        end

        return UDim2.fromOffset(size200, size200)
    end, {
        tbl1.numberOfItems,
        num1,
        var2.firstVisibleIndex,
        var2.currentItemIndex,
        size100,
        size150,
        size200,
        xOffset
    })

    local useMemo = React.useMemo
    local function func1()
        local result = ({})

        for layoutOrder = 1, tbl1.numberOfItems do
            local var5 = var3.current[layoutOrder]
            local var6 = var4(layoutOrder)
            local var7 = if FFlagLuaAppMediaGalleryPageIndicatorOpacity then if layoutOrder ~= var2.currentItemIndex then white.White_20 elseif tbl1.currentItemProgressBinding then muted else white.White_100 else muted
            local str1 = "Indicator" .. layoutOrder
            local createElement = React.createElement
            local str2 = "Frame"
            local tbl2 = {
                Size = UDim2.fromOffset(if layoutOrder == var2.currentItemIndex then xOffset else size200, size200),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                LayoutOrder = layoutOrder
            }
            local tbl3 = { Dot = 0 }
            local createElement2 = React.createElement
            local str3 = "Frame"

            local tbl4 = {
                AnchorPoint = getDotAnchorPointAtIndex(layoutOrder, var2.previousItemIndex, var2.currentItemIndex),
                Position = getDotPositionAtIndex(layoutOrder, var2.previousItemIndex, var2.currentItemIndex),
                Size = var2.animationProgressBinding:map(function(num2: number)
                    if var5 == nil then
                        return var6
                    end
                    return var5:Lerp(var6, num2)
                end),
                BackgroundColor3 = var7.Color3,
                BackgroundTransparency = var7.Transparency,
                BorderSizePixel = 0
            }
            local tbl5 = {
                UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(1, 0) }),
                ProgressBar = 0
            }
            local var8

            if layoutOrder == var2.currentItemIndex and tbl1.currentItemProgressBinding then
                local createElement3 = React.createElement

                local tbl6 = {
                    Size = tbl1.currentItemProgressBinding:map(function(num2: number): UDim2
                        return UDim2.fromOffset(size200 + num2 * (xOffset - size200), size200)
                    end),
                    BackgroundColor3 = emphasis.Color3,
                    BackgroundTransparency = emphasis.Transparency,
                    BorderSizePixel = 0
                }
                local tbl7 = {
                    UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(1, 0) })
                }
                var8 = createElement3("Frame", tbl6, tbl7)
            else
                var8 = nil
            end

            tbl5.ProgressBar = var8
            tbl3.Dot = createElement2(str3, tbl4, tbl5)
            result[str1] = createElement(str2, tbl2, tbl3)
        end

        return result
    end

    local numberOfItems = tbl1.numberOfItems
    local currentItemProgressBinding = tbl1.currentItemProgressBinding
    local previousItemIndex = var2.previousItemIndex
    local currentItemIndex = var2.currentItemIndex

    local animationProgressBinding = var2.animationProgressBinding
    local var5 = if FFlagLuaAppMediaGalleryPageIndicatorOpacity then white else nil
    local var6 = useMemo(func1, {
        numberOfItems,
        currentItemProgressBinding,
        previousItemIndex,
        currentItemIndex,
        var4,
        size200,
        xOffset,
        muted,
        emphasis,
        animationProgressBinding,
        var5
    })

    React.useEffect(function()
        for i = 1, tbl1.numberOfItems do
            var3.current[i] = var4(i)
        end
    end, { tbl1.numberOfItems, var4 })

    return React.createElement("ScrollingFrame", {
        AnchorPoint = tbl1.AnchorPoint,
        Position = tbl1.Position,
        Size = UDim2.fromOffset(xOffset2, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = tbl1.ZIndex,
        ClipsDescendants = true,
        ScrollingDirection = Enum.ScrollingDirection.X,
        ScrollingEnabled = false,
        ScrollBarThickness = 0,
        CanvasSize = UDim2.fromOffset(0, size200),
        AutomaticCanvasSize = Enum.AutomaticSize.X,
        CanvasPosition = var2.canvasPositionBinding,
        Selectable = false
    }, {
        UIListLayout = React.createElement("UIListLayout", {
            Padding = UDim.new(0, indicatorPadding),
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder
        }),
        Items = React.createElement(React.Fragment, {}, var6)
    })
end)
