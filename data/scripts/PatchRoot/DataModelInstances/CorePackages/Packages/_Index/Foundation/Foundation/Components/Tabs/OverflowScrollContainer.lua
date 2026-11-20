-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:41:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local BuilderIcons = require(FoundationParent.BuilderIcons)
local Dash = require(FoundationParent.Dash)
local Otter = require(FoundationParent.Otter)
local React = require(FoundationParent.React)
local ReactOtter = require(FoundationParent.ReactOtter)

local Icon = BuilderIcons.Icon

local IconButton = require(Foundation.Components.IconButton)
local InputSize = require(Foundation.Enums.InputSize)
local ScrollView = require(Foundation.Components.ScrollView)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local Visibility = require(Foundation.Enums.Visibility)
local withCommonProps = require(Foundation.Utility.withCommonProps)

local numberSequence = NumberSequence.new(
    { NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.8, 0), NumberSequenceKeypoint.new(1, 1) }
)

local numberSequence2 = NumberSequence.new(
    { NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.2, 0), NumberSequenceKeypoint.new(1, 0) }
)

local function OverflowButton(arg1)
    local createElement = React.createElement
    local var1 = View
    local var2 = withCommonProps(arg1, { tag = `col align-y-center size-0-full auto-x bg-surface-0 {arg1.tag}` })

    local tbl1 = {
        UIGradient = React.createElement("UIGradient", { Transparency = arg1.gradient }),
        Button = React.createElement(IconButton, {
            onActivated = arg1.onActivated,
            size = if arg1.size == InputSize.Large or arg1.size == InputSize.Medium then InputSize.Small else InputSize.XSmall,
            icon = {
                name = arg1.icon
            }
        })
    }
    return createElement(var1, var2, tbl1)
end

local function OverflowScrollContainer(arg1)
    local var1, var2 = React.useBinding(false)
    local var3, var4 = React.useBinding(false)
    local scrollingFrameRef = React.useRef(nil)
    local var6 = ReactOtter.useMotor(0, function(x: number?)
        local current = scrollingFrameRef.current
        if not current then
            return
        end
        current.CanvasPosition = Vector2.new(x, 0)
    end)

    local var7 = React.useCallback(Dash.throttle(function(arg2)
        if arg2.AbsoluteWindowSize.X == 0 then
            return
        end

        var2(arg2.AbsoluteWindowSize.X + arg2.CanvasPosition.X < arg2.AbsoluteCanvasSize.X - 1)
        var4(arg2.CanvasPosition.X ~= 0)
    end, 0.2), {})

    local var8 = React.useCallback(function(num1: number)
        local current = scrollingFrameRef.current
        if not current then
            return
        end

        var6(Otter.ease(current.CanvasPosition.X + num1, { duration = 0.2, easingStyle = Enum.EasingStyle.Quad }))
    end, {})

    React.useEffect(function()
        if scrollingFrameRef.current then
            var7(scrollingFrameRef.current)
        end
    end, {})

    local onActivated = React.useCallback(function()
        var8(-90)
    end, { var8 })

    local var5 = React.useCallback(function()
        var8(90)
    end, { var8 })

    return React.createElement(View, withCommonProps(arg1, { tag = "auto-y", Size = UDim2.fromScale(1, 0) }), {
        Scroll = React.createElement(ScrollView, {
            LayoutOrder = 1,
            Size = UDim2.fromScale(1, 1),
            onCanvasPositionChanged = var7,
            onAbsoluteWindowSizeChanged = var7,
            scrollingFrameRef = scrollingFrameRef,
            selection = { Selectable = false },
            scroll = {
                AutomaticSize = Enum.AutomaticSize.Y,
                AutomaticCanvasSize = Enum.AutomaticSize.X,
                ScrollingDirection = Enum.ScrollingDirection.X,
                scrollBarVisibility = Visibility.None
            }
        }, arg1.children),
        OverflowStart = React.createElement(OverflowButton, {
            LayoutOrder = 3,
            Position = UDim2.fromScale(0, 0),
            size = arg1.size,
            isStart = true,
            ZIndex = 2,
            Visible = var3,
            onActivated = onActivated,
            gradient = numberSequence,
            tag = "padding-right-small",
            icon = Icon.ChevronLargeLeft,
            testId = `{arg1.testId}--overflow-start`
        }),
        OverflowEnd = React.createElement(OverflowButton, {
            LayoutOrder = 4,
            Position = UDim2.fromScale(1, 0),
            size = arg1.size,
            ZIndex = 2,
            Visible = var1,
            onActivated = var5,
            gradient = numberSequence2,
            tag = "anchor-top-right padding-left-small",
            icon = Icon.ChevronLargeRight,
            testId = `{arg1.testId}--overflow-end`
        })
    })
end

return OverflowScrollContainer
