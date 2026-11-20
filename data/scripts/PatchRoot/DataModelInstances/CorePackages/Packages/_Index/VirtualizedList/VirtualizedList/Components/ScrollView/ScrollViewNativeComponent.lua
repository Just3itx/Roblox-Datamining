-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:51:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)
local console = LuauPolyfill.console
local Array = LuauPolyfill.Array
local Object = LuauPolyfill.Object

local React = require(scriptParentParentParentParent.React)
local Change = React.Change
local Event = React.Event

local Otter = require(scriptParentParentParentParent.Otter)

local tbl1 = { restingPositionLimit = 1, restingVelocityLimit = 10 }

local var1 = React.Component:extend("ScrollViewNativeComponent")
function var1.init(tbl2, props)
    tbl2.props = props
    tbl2._nativeRef = React.createRef()
    tbl2.lastScrollEventTime = 0

    tbl2.animationConfig = if tbl2.props.animationConfig then tbl2.props.animationConfig else tbl1

    tbl2.motor = Otter.createGroupMotor({ x = 0, y = 0 })

    tbl2.motorStepDisconnect = tbl2.motor:onStep(function(arg1)
        tbl2._nativeRef.current.CanvasPosition = Vector2.new(arg1.x, arg1.y)
    end)

    function tbl2._nativeRef.animateScrollTo(arg1, arg2)
        tbl2:_startAnimatedScroll(arg1, arg2)
    end
end

function var1._validateAnimatedScrollInputs(tbl2, num1: number, num2: number)
    if not tbl2._nativeRef.current then
        console.error("scrollTo animation failed: ScrollViewNativeComponent._nativeRef instance is undefined")
    end

    if tbl2._nativeRef.current.ScrollingDirection == Enum.ScrollingDirection.X then
        if tbl2._nativeRef.current.AbsoluteCanvasSize.X < num1 then
            console.warn(
                "scrollTo animation goal out of bounds, setting X goal to: " .. tostring(tbl2._nativeRef.current.AbsoluteCanvasSize.X - tbl2._nativeRef.current.AbsoluteWindowSize.X)
            )
            return
        end

        if num1 < 0 then
            console.warn("scrollTo animation goal out of bounds, setting X goal to: 0")
        end
    else
        if tbl2._nativeRef.current.AbsoluteCanvasSize.Y < num2 then
            console.warn(
                "scrollTo animation goal out of bounds, setting Y goal to: " .. tostring(tbl2._nativeRef.current.AbsoluteCanvasSize.Y - tbl2._nativeRef.current.AbsoluteWindowSize.Y)
            )
            return
        end

        if num2 < 0 then
            console.warn("scrollTo animation goal out of bounds, setting Y goal to: 0")
        end
    end
end

function var1._startAnimatedScroll(arg1, arg2, arg3)
    if _G.__DEV__ then
        arg1:_validateAnimatedScrollInputs(arg2, arg3)
    end
    local canvasPosition = arg1._nativeRef.current.CanvasPosition

    arg1.motor:setGoal({ x = Otter.instant(canvasPosition.X), y = Otter.instant(canvasPosition.Y) })

    arg1.motor:step(0)

    arg1.motor:setGoal({ x = Otter.spring(arg2, arg1.animationConfig), y = Otter.spring(arg3, arg1.animationConfig) })
end

function var1.render(arg1)
    local var2 = if Array.isArray(arg1.props.style) then Array.reduce(arg1.props.style, function(arg2, arg3)
        return Object.assign(arg2, arg3)
    end, {}) else arg1.props.style

    local assign = Object.assign
    local tbl2 = {
        Name = "RCTScrollView",
        ScrollingEnabled = arg1.props.scrollEnabled == nil or arg1.props.scrollEnabled,
        Size = UDim2.new(1, 0, 1, 0),
        CanvasPosition = arg1.props.CanvasPosition,
        CanvasSize = arg1.props.CanvasSize or UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = arg1.props.AutomaticCanvasSize or Enum.AutomaticSize.XY,
        ScrollBarThickness = if arg1.props.horizontal and arg1.props.showsHorizontalScrollIndicator == false
            or not arg1.props.horizontal and arg1.props.showsVerticalScrollIndicator == false then 0 else nil,
        ref = arg1._nativeRef,
        [Change.AbsoluteWindowSize] = arg1.props.onLayout
    }

    tbl2[Change.CanvasPosition] = function(arg2)
        local lastScrollEventTime = os.clock() * 1000
        if (arg1.props.scrollEventThrottle or 0) < lastScrollEventTime - arg1.lastScrollEventTime then
            arg1.props.onScroll(arg2)
            arg1.lastScrollEventTime = lastScrollEventTime
        end
    end
    tbl2[Event.InputBegan] = function(arg2, arg3)
        if (arg3.UserInputType == Enum.UserInputType.MouseWheel or arg3.UserInputType == Enum.UserInputType.Touch)
            and arg1.motor ~= nil
        then
            arg1.motor:stop()
        end

        if arg3.UserInputType == Enum.UserInputType.Touch then
            arg1.props.onTouchStart(arg2, arg3)
        end
    end
    tbl2[Event.InputEnded] = function(arg2, arg3)
        if arg3.UserInputType == Enum.UserInputType.Touch then
            arg1.props.onTouchEnd(arg2, arg3)
        end
    end
    tbl2[Event.InputChanged] = function(arg2, arg3)
        if arg3.UserInputType == Enum.UserInputType.Touch then
            arg1.props.onTouchMove(arg2, arg3)
        end
    end
    tbl2[Event.SelectionChanged] = arg1.props.onSelectionChanged and function(arg2, arg3, arg4, arg5)
        arg1.props.onSelectionChanged(arg2, arg3, arg4, arg5)
    end or nil

    local var3 = assign(tbl2, var2)

    local createElement = React.createElement
    local str1 = "ScrollingFrame"
    local tbl3 = { [1] = nil, nil }
    local element

    if arg1.props.inverted and not arg1.props.getItemLayout then
        element = React.createElement("UIListLayout", {
            HorizontalAlignment = if arg1.props.horizontal then Enum.HorizontalAlignment.Right else Enum.HorizontalAlignment.Center,
            VerticalAlignment = if arg1.props.horizontal then Enum.VerticalAlignment.Center else Enum.VerticalAlignment.Bottom
        })
    else
        element = nil
    end

    tbl3.Layout = element

    tbl3[1] = arg1.props.children
    return createElement(str1, var3, tbl3)
end

function var1.willUnmount(arg1)
    if arg1.motor ~= nil then
        arg1.motor:destroy()
    end

    if arg1.motorStepDisconnect ~= nil then
        arg1.motorStepDisconnect()
    end
end

return var1
