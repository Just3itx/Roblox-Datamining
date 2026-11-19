-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:51:18Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local _Types = require(Foundation.Components.Types)

local withCommonProps = require(Foundation.Utility.withCommonProps)

local Knob = require(Foundation.Components.Knob)
local View = require(Foundation.Components.View)

local ColorNamespace = require(Foundation.Enums.ColorNamespace)
local PresentationContext = require(Foundation.Providers.Style.PresentationContext)

local _InputSize = require(Foundation.Enums.InputSize)

local calculateSliderFraction = require(script.Parent.calculateSliderFraction)
local getGuiInputPosition = require(script.Parent.getGuiInputPosition)

local value = {
    colorNamespace = ColorNamespace.Inverse
}

local function SliderThumb(arg1)
    local var1 = React.useRef(arg1.fraction:getValue())

    local var2 = React.useCallback(function()
        var1.current = arg1.fraction:getValue()
        if arg1.onDragStarted then
            arg1.onDragStarted()
        end
    end, { arg1.fraction, arg1.onDragStarted })

    local var3 = React.useCallback(function(_, vector2: Vector2)
        local current = arg1.trackRef.current
        if not current then
            return
        end
        local sliderFraction = calculateSliderFraction(getGuiInputPosition(vector2, current), current, arg1.isVertical)
        local var3, var4 = arg1.getBounds()
        local num1 = math.clamp(sliderFraction, var3, var4)
        if num1 ~= var1.current then
            var1.current = num1
            arg1.onSeek(num1)
        end
    end, {
        arg1.trackRef,
        arg1.isVertical,
        arg1.getBounds,
        arg1.onSeek
    })
    local var4 = React.useCallback(function()
        if arg1.onDragEnded then
            arg1.onDragEnded()
        end
    end, { arg1.onDragEnded })

    local var5 = arg1.fraction:map(function(xScale: number): UDim2
        if arg1.isVertical then
            return UDim2.fromScale(0.5, 1 - xScale)
        end

        return UDim2.fromScale(xScale, 0.5)
    end)

    local var6 = if arg1.isContained then arg1.fraction:map(function(x: number): Vector2
        if arg1.isVertical then
            return Vector2.new(0.5, 1 - x)
        end

        return Vector2.new(x, 0.5)
    end) else Vector2.new(0.5, 0.5)

    local knob = if arg1.knobAppearance then React.createElement(Knob, {
        size = arg1.knobAppearance.size,
        style = arg1.knobAppearance.style,
        stroke = arg1.knobAppearance.stroke,
        hasShadow = arg1.knobAppearance.hasShadow,
        testId = `{arg1.testId}--knob`
    }) else nil
    local tbl2 = {
        AnchorPoint = arg1.AnchorPoint or var6,
        Position = arg1.Position or var5,
        ZIndex = arg1.ZIndex or 2,
        Visible = arg1.Visible,
        LayoutOrder = arg1.LayoutOrder,
        onAbsoluteSizeChanged = arg1.onAbsoluteSizeChanged,
        onAbsolutePositionChanged = arg1.onAbsolutePositionChanged,
        testId = arg1.testId
    }

    local createElement = React.createElement
    local var7 = View
    local var8 = withCommonProps(tbl2, { tag = "size-0-0 auto-xy" })

    local tbl3 = { DragTarget = 0, Knob = 0 }
    local createElement2 = React.createElement
    local var9 = View
    local tbl4 = {
        tag = "size-full",
        ZIndex = 2,
        testId = `{arg1.testId}--drag-target`
    }
    local tbl5 = {
        DragDetector = if arg1.isDragEnabled == false then nil else React.createElement("UIDragDetector", {
            DragStyle = Enum.UIDragDetectorDragStyle.Scriptable,
            [React.Event.DragStart] = var2,
            [React.Event.DragContinue] = var3,
            [React.Event.DragEnd] = var4,
            Enabled = not arg1.isDisabled
        })
    }
    tbl3.DragTarget = createElement2(var9, tbl4, tbl5)

    tbl3.Knob = if arg1.knob then React.createElement(View, { tag = "size-0-0 auto-xy", testId = `{arg1.testId}--custom-knob` }, arg1.knob) else React.createElement(PresentationContext.Provider, { value = value }, { Knob = knob })
    return createElement(var7, var8, tbl3)
end

return SliderThumb
