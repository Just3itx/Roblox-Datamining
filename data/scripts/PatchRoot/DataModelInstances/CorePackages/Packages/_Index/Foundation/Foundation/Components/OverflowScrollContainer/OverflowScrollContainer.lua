-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:31:04Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local Otter = require(FoundationParent.Otter)
local React = require(FoundationParent.React)
local ReactOtter = require(FoundationParent.ReactOtter)

local ControlState = require(Foundation.Enums.ControlState)
local Flags = require(Foundation.Utility.Flags)
local InputSize = require(Foundation.Enums.InputSize)
local Scrim = require(script.Parent.Scrim)
local ScrollView = require(Foundation.Components.ScrollView)
local StateLayerAffordance = require(Foundation.Enums.StateLayerAffordance)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local Visibility = require(Foundation.Enums.Visibility)
local useClippingRect = require(script.Parent.useClippingRect)
local usePreferredInput = require(Foundation.Utility.usePreferredInput)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local tbl1 = {
    size = InputSize.Medium,
    scrimBottomInset = 0,
    testId = "--foundation-overflow-scroll-container"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: OverflowScrollContainer
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useTokens()
    local var3, var4 = React.useState(false)
    local var5, var6 = React.useState(false)
    local var7, var8 = React.useState(false)
    local var9, var10 = React.useState(false)
    local var11, var12 = React.useState(false)
    local isHovered = var1.forceHovered or var7 or var9 or var11
    local var14 = usePreferredInput()
    local preferredInput = var1.forcePreferredInput or var14
    local scrollingFrameRef = React.useRef(nil)
    local var17, var18 = useClippingRect(scrollingFrameRef)

    local rowHeight, var20 = React.useBinding(0)

    local var21 = ReactOtter.useMotor(0, function(x: number?)
        local current = scrollingFrameRef.current
        if not current then
            return
        end
        current.CanvasPosition = Vector2.new(x, 0)
    end)

    local var22 = React.useCallback(function(arg2)
        var20(arg2.AbsoluteWindowSize.Y)

        if arg2.AbsoluteWindowSize.X == 0 then
            return
        end

        var6(arg2.CanvasPosition.X > 0)
        var4(arg2.AbsoluteWindowSize.X + arg2.CanvasPosition.X < arg2.AbsoluteCanvasSize.X - 1)
    end, {})

    local var23 = React.useCallback(function(num1: number)
        local current = scrollingFrameRef.current
        if not current then
            return
        end

        local num2 = math.max(current.AbsoluteCanvasSize.X - current.AbsoluteWindowSize.X, 0)
        local var23 = current.AbsoluteWindowSize.X * 0.8
        local var24 = current.AbsoluteWindowSize.X * 0.19999999999999996
        local var25 = current.CanvasPosition.X + num1 * var23

        local num3 = math.clamp(
            if num1 > 0 and num2 - var25 <= var24 then num2 elseif num1 < 0 and var25 <= var24 then 0 else var25,
            0,
            num2
        )
        var21(
            Otter.ease(
                num3,
                {
                    duration = var2.Time.Time_200,
                    easingStyle = Enum.EasingStyle.Quad,
                    startingValue = current.CanvasPosition.X
                }
            )
        )
    end, { var2 })

    local onActivated = React.useCallback(function()
        var23(-1)
    end, { var23 })

    local var13 = React.useCallback(function()
        var23(1)
    end, { var23 })

    local onStateChanged = React.useCallback(function(arg2)
        var8(arg2 == ControlState.Hover or arg2 == ControlState.Pressed)
    end, {})

    local var15 = React.useCallback(function(arg2)
        var10(arg2 == ControlState.Hover or arg2 == ControlState.Pressed)
    end, {})

    local var16 = React.useCallback(function(arg2)
        var12(arg2 == ControlState.Hover or arg2 == ControlState.Pressed)
    end, {})

    React.useEffect(function()
        if scrollingFrameRef.current then
            var22(scrollingFrameRef.current)
        end
    end, {})

    local createElement = React.createElement
    local var29 = View
    local var30 = withCommonProps(var1, { ref = ref, tag = "size-full-0 auto-y" })

    local tbl2 = {
        Scroll = React.createElement(ScrollView, {
            tag = "size-full-0 auto-y",
            ClipsDescendants = if Flags.FoundationUnifiedScrimScrolling then not var18 else false,
            onStateChanged = onStateChanged,
            stateLayer = {
                affordance = StateLayerAffordance.None
            },
            onCanvasPositionChanged = var22,
            onAbsoluteCanvasSizeChanged = var22,
            onAbsoluteWindowSizeChanged = var22,
            scrollingFrameRef = scrollingFrameRef,
            selection = { Selectable = false },
            layout = {
                FillDirection = Enum.FillDirection.Horizontal
            },
            scroll = {
                AutomaticSize = Enum.AutomaticSize.Y,
                AutomaticCanvasSize = Enum.AutomaticSize.X,
                CanvasSize = UDim2.fromScale(0, 1),
                ScrollingDirection = Enum.ScrollingDirection.X,
                scrollBarVisibility = Visibility.None
            },
            testId = `{var1.testId}--scroll`
        }, var1.children),
        ScrimLayer = React.createElement(View, {
            tag = "row flex-between",
            Position = var17:map(function(rect: Rect): UDim2
                return UDim2.fromOffset(rect.Min.X, 0)
            end),
            Size = var17:map(function(rect: Rect): UDim2
                return UDim2.new(0, rect.Max.X - rect.Min.X, 1, -var1.scrimBottomInset)
            end),
            ZIndex = 2,
            testId = `{var1.testId}--scrim-layer`
        }, {
            ScrimStart = React.createElement(Scrim, {
                LayoutOrder = 1,
                size = var1.size,
                rowHeight = rowHeight,
                alignment = Enum.HorizontalAlignment.Left,
                isHovered = isHovered,
                preferredInput = preferredInput,
                isVisible = var1.forceScrimsVisible or var5,
                onActivated = onActivated,
                onStateChanged = var15,
                testId = `{var1.testId}--scrim-start`
            }),
            ScrimEnd = React.createElement(Scrim, {
                LayoutOrder = 2,
                size = var1.size,
                rowHeight = rowHeight,
                alignment = Enum.HorizontalAlignment.Right,
                isHovered = isHovered,
                preferredInput = preferredInput,
                isVisible = var1.forceScrimsVisible or var3,
                onActivated = var13,
                onStateChanged = var16,
                testId = `{var1.testId}--scrim-end`
            })
        })
    }

    return createElement(var29, var30, tbl2)
end))
