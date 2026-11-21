-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceUIKit = script:FindFirstAncestor("AvatarExperienceUIKit")
local AvatarExperienceUIKitParent = AvatarExperienceUIKit.Parent
local React = require(AvatarExperienceUIKitParent.React)
local ReactOtter = require(AvatarExperienceUIKitParent.ReactOtter)
local useAnimatedBinding = ReactOtter.useAnimatedBinding
local Foundation = require(AvatarExperienceUIKitParent.Foundation)
local Responsive = require(AvatarExperienceUIKitParent.Responsive)
local useTokens = Foundation.Hooks.useTokens
local View = Foundation.View
local IconButton = Foundation.IconButton
local InputSize = Foundation.Enums.InputSize
local IconName = Foundation.Enums.IconName
local IconVariant = Foundation.Enums.IconVariant

local makeOtterSpringValue = require(AvatarExperienceUIKit.Utils.makeOtterSpringValue)
local shouldShowScrollArrowsForInputType = require(AvatarExperienceUIKit.Utils.shouldShowScrollArrowsForInputType)
local getFixedTabHeight = require(AvatarExperienceUIKit.Utils.getFixedTabHeight)
local gradientTransparency = require(script.Parent.gradientTransparency)

local AvatarExperienceFlags = require(AvatarExperienceUIKitParent.AvatarExperienceFlags)
local FFlagAXCategoryMenuVisualFixes = AvatarExperienceFlags.FFlagAXCategoryMenuVisualFixes
local FFlagAXFixScrollingFrameGradientOverlap = AvatarExperienceFlags.FFlagAXFixScrollingFrameGradientOverlap
local FFlagAXTabGroupScrollOnlyWhenClipped = AvatarExperienceFlags.FFlagAXTabGroupScrollOnlyWhenClipped

local tbl1 = { dampingRatio = 1, frequency = 5 }

local icon = {
    name = IconName.ChevronLargeLeft,
    variant = IconVariant.Filled
}

local tbl2 = {
    name = IconName.ChevronLargeRight,
    variant = IconVariant.Filled
}

local function scrollingFrameCanScrollLeft(arg1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return arg1.CanvasPosition.X > 0
end

local function scrollingFrameCanScrollRight(arg1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return arg1.AbsoluteCanvasSize.X - arg1.CanvasPosition.X > arg1.AbsoluteSize.X
end

local function getCanvasPosition(x: number): Vector2
    return Vector2.new(x, 0)
end

local function gradientTransparency2(tbl4, num1: number, num2: number)
    local num3 = 1 - num2
    local var1 = num3 * tbl4[1]
    local var2 = num3 * tbl4[2]
    local var3 = tbl4[3]
    if var3 < 1 then
        return nil
    end

    local var4 = if var3 < num1 then 1 else num1 / var3
    local keypoints = {}
    if var1 > 0 then
        table.insert(keypoints, NumberSequenceKeypoint.new(0, 1 - var1))
        table.insert(keypoints, NumberSequenceKeypoint.new(var4, 1 - var1))
        table.insert(keypoints, NumberSequenceKeypoint.new(var4 + var4 * var1, 1))
    else
        table.insert(keypoints, NumberSequenceKeypoint.new(0, 1))
    end
    if var2 > 0 then
        table.insert(keypoints, NumberSequenceKeypoint.new(1 - var4 * var2 - var4, 1))

        table.insert(keypoints, NumberSequenceKeypoint.new(1 - var4, 1 - var2))
        table.insert(keypoints, NumberSequenceKeypoint.new(1, 1 - var2))
    else
        table.insert(keypoints, NumberSequenceKeypoint.new(1, 1))
    end

    return NumberSequence.new(keypoints)
end

local function makeGradientTransparency(num1: number, num2: number) -- Luacid: Inlined by compiler; 1 call site recovered
    return function(tbl4)
        if FFlagAXFixScrollingFrameGradientOverlap then
            return gradientTransparency.fittedGradientTransparency(tbl4, num1, num2)
        end
        return gradientTransparency2(tbl4, num1, num2)
    end
end

local function makeButtonTransparency(tbl4)
    return 1 - tbl4[1] * tbl4[2]
end

local function isVisibleFromTransparency(num1: number): boolean
    return num1 < 1
end

return React.forwardRef(function(tbl4, ref) -- name: ScrollingFrameWithIndicators
    local var1 = useTokens()

    local backgroundTransparency = tbl4.BackgroundTransparency or var1.Color.Common.NavigationBar.Transparency
    local backgroundColor3 = tbl4.BackgroundColor3 or var1.Color.Common.NavigationBar.Color3
    local offset = if FFlagAXCategoryMenuVisualFixes then var1.Size.Size_150 else var1.Size.Size_100
    local offset2 = if FFlagAXCategoryMenuVisualFixes then offset * 2 else offset
    local var4 = var1.Size.Size_300 * 2

    local var5, var6 = useAnimatedBinding(0)
    local var7, var8 = useAnimatedBinding(0)
    local var9, var10 = React.useBinding(0)
    local var11, var12 = useAnimatedBinding(0)
    local var13, var14 = React.useState(false)
    local var15 = nil
    if FFlagAXCategoryMenuVisualFixes then
        local var16 = Responsive.useLastInput()
        var15 = shouldShowScrollArrowsForInputType(var16)
    end

    local var16 = nil
    local var17

    if FFlagAXTabGroupScrollOnlyWhenClipped then
        local var18 = React.useRef(nil)
        var16 = var18
        var17 = React.useCallback(function()
            var18.current = nil
        end, {})
    else
        var17 = nil
    end

    local var18, var19 = useAnimatedBinding(0, var17)
    local var2 = React.useRef(nil)

    local canvasPosition = React.useMemo(function()
        return var18:map(getCanvasPosition)
    end, {})

    local var22 = React.useMemo(function()
        return React.joinBindings({ var5, var7, var9 }):map((makeGradientTransparency(var4, backgroundTransparency)))
    end, FFlagAXTabGroupScrollOnlyWhenClipped and { var4, backgroundTransparency } or { var1, backgroundTransparency })

    local groupTransparency = React.useMemo(function()
        return React.joinBindings({ var7, var11 }):map(makeButtonTransparency)
    end, {})

    local var3 = React.useMemo(function()
        return React.joinBindings({ var5, var11 }):map(makeButtonTransparency)
    end, {})

    local var25 = React.useMemo(function()
        return var3:map(isVisibleFromTransparency)
    end, {})

    local var26 = React.useMemo(function()
        return groupTransparency:map(isVisibleFromTransparency)
    end, {})

    local onActivated = React.useCallback(function()
        local current = var2.current
        if not current then
            return
        end

        var19(ReactOtter.instant(current.CanvasPosition.X))
        var19(makeOtterSpringValue(current.AbsoluteCanvasSize.X - current.AbsoluteSize.X, tbl1))

        if FFlagAXTabGroupScrollOnlyWhenClipped and var16 then
            var16.current = current.AbsoluteCanvasSize.X - current.AbsoluteSize.X
        end
    end, {})

    local var20 = React.useCallback(function()
        local current = var2.current
        if not current then
            return
        end

        var19(ReactOtter.instant(current.CanvasPosition.X))
        var19(makeOtterSpringValue(0, tbl1))
        if FFlagAXTabGroupScrollOnlyWhenClipped and var16 then
            var16.current = 0
        end
    end, {})

    local function onMouseEnter()
        if FFlagAXCategoryMenuVisualFixes and not var15 then
            return
        end
        var12(makeOtterSpringValue(1, tbl1))
        var14(true)
    end

    local function onMouseLeave()
        if FFlagAXCategoryMenuVisualFixes and not var15 then
            return
        end
        var12(makeOtterSpringValue(0, tbl1))
        var14(false)
    end

    if FFlagAXCategoryMenuVisualFixes then
        React.useEffect(function()
            if not var15 then
                var12(ReactOtter.instant(0))
                var14(false)
            end
        end, { var15 })
    end

    local function onCanvasChanged(arg1)
        local num1 = if scrollingFrameCanScrollLeft(arg1) then 1 else 0

        var6(makeOtterSpringValue(num1, tbl1))
        local num2 = if scrollingFrameCanScrollRight(arg1) then 1 else 0

        var8(makeOtterSpringValue(num2, tbl1))
    end

    local function onSizeChanged(arg1)
        var10(arg1.AbsoluteSize.X)
    end

    React.useEffect(function()
        local current = var2.current
        if current then
            local num1 = if scrollingFrameCanScrollLeft(current) then 1 else 0

            var6(ReactOtter.instant(num1))
            local bool1 = not not scrollingFrameCanScrollRight(current)
            var8(ReactOtter.instant(if bool1 then 1 else 0))
        end
    end, {})

    if FFlagAXCategoryMenuVisualFixes then
        local scrollToOffset = React.useCallback(function(current: number)
            local current2 = var2.current
            if not current2 then
                return
            end

            var19(ReactOtter.instant(current2.CanvasPosition.X))
            var19(makeOtterSpringValue(current, tbl1))
            if FFlagAXTabGroupScrollOnlyWhenClipped and var16 then
                var16.current = current
            end
        end, {})

        local setOffset = React.useCallback(function(num1: number)
            if not var2.current then
                return
            end

            var19(ReactOtter.instant(num1))
            if FFlagAXTabGroupScrollOnlyWhenClipped and var16 then
                var16.current = nil
            end
        end, {})

        React.useImperativeHandle(tbl4.controllerRef, function()
            return {
                scrollToOffset = scrollToOffset,
                setOffset = setOffset,
                getScrollingFrame = function()
                    return var2.current
                end,
                getScrollTarget = function()
                    return if var16 then var16.current else nil
                end,
                getObscuredEdgeInset = function()
                    return var4 * 2
                end
            }
        end, FFlagAXTabGroupScrollOnlyWhenClipped and { scrollToOffset, setOffset, var4 } or { scrollToOffset, setOffset })
    end

    local size1000 = var1.Size.Size_1000
    local fixedTabHeight = getFixedTabHeight(var1)

    local yOffset = offset + fixedTabHeight + offset2

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl5 = {
        Size = if FFlagAXCategoryMenuVisualFixes then UDim2.new(1, 0, 0, size1000) else UDim2.fromScale(1, 0),
        AutomaticSize = if FFlagAXCategoryMenuVisualFixes then Enum.AutomaticSize.None else Enum.AutomaticSize.Y,
        ClipsDescendants = not FFlagAXCategoryMenuVisualFixes and nil,
        BackgroundTransparency = backgroundTransparency,
        BackgroundColor3 = backgroundColor3,
        LayoutOrder = tbl4.LayoutOrder,
        ZIndex = tbl4.ZIndex,
        Position = tbl4.Position,
        BorderSizePixel = 0,
        ref = ref
    }
    local tbl6 = {
        ScrollingFrame = React.createElement(
            "ScrollingFrame",
            {
                ClipsDescendants = true,
                Size = if FFlagAXCategoryMenuVisualFixes then UDim2.new(1, 0, 0, yOffset) else UDim2.fromScale(1, 0),
                Position = if FFlagAXCategoryMenuVisualFixes then UDim2.fromOffset(0, -offset) else nil,
                AutomaticSize = if FFlagAXCategoryMenuVisualFixes then Enum.AutomaticSize.None else Enum.AutomaticSize.Y,
                Selectable = false,
                CanvasSize = UDim2.fromScale(1, 0),
                AutomaticCanvasSize = Enum.AutomaticSize.XY,
                ScrollBarThickness = 0,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                ElasticBehavior = if FFlagAXCategoryMenuVisualFixes then Enum.ElasticBehavior.Never else Enum.ElasticBehavior.Always,
                ScrollingDirection = Enum.ScrollingDirection.X,
                CanvasPosition = canvasPosition,
                [React.Change.AbsoluteSize] = onSizeChanged,
                [React.Change.CanvasSize] = onCanvasChanged,
                [React.Change.AbsoluteCanvasSize] = onCanvasChanged,
                [React.Change.CanvasPosition] = onCanvasChanged,
                [React.Event.MouseEnter] = onMouseEnter,
                [React.Event.MouseLeave] = onMouseLeave,
                ref = var2
            },
            FFlagAXCategoryMenuVisualFixes
                and {
                    FocusCursorInset = React.createElement("UIPadding", {
                        PaddingTop = UDim.new(0, offset),
                        PaddingBottom = UDim.new(0, offset2),
                        PaddingLeft = UDim.new(0, offset),
                        PaddingRight = UDim.new(0, offset)
                    }),
                    Content = React.createElement(React.Fragment, nil, tbl4.children)
                }
                or React.createElement(React.Fragment, nil, tbl4.children)
        ),
        OverlayFrame = 0
    }
    local createElement2 = React.createElement
    local str2 = "Frame"
    local tbl7 = {
        Size = UDim2.fromScale(1, 1),
        ZIndex = 2,
        BorderSizePixel = 0,
        BackgroundColor3 = backgroundColor3
    }
    local tbl8 = {
        Gradient = React.createElement("UIGradient", { Transparency = var22 }),
        LeftButton = React.createElement(
            View,
            {
                Position = if FFlagAXCategoryMenuVisualFixes then UDim2.new(0, 0, 0, fixedTabHeight / 2) else UDim2.fromScale(0, 0.5),
                AnchorPoint = Vector2.new(0, 0.5),
                AutomaticSize = Enum.AutomaticSize.XY,
                BackgroundTransparency = 1,
                GroupTransparency = var3,
                Visible = var25
            },
            React.createElement(IconButton, { isDisabled = not var13, size = InputSize.Small, icon = icon, onActivated = var20 })
        ),
        RightButton = React.createElement(
            View,
            {
                Position = if FFlagAXCategoryMenuVisualFixes then UDim2.new(1, 0, 0, fixedTabHeight / 2) else UDim2.fromScale(1, 0.5),
                AnchorPoint = Vector2.new(1, 0.5),
                AutomaticSize = Enum.AutomaticSize.XY,
                BackgroundTransparency = 1,
                GroupTransparency = groupTransparency,
                Visible = var26
            },
            React.createElement(
                IconButton,
                {
                    isDisabled = not var13,
                    size = InputSize.Small,
                    icon = tbl2,
                    onActivated = onActivated
                }
            )
        )
    }
    tbl6.OverlayFrame = createElement2(str2, tbl7, tbl8)
    return createElement(str1, tbl5, tbl6)
end)
