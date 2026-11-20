-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:00:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Constants = require(Foundation.Constants)

local InputMode = require(Foundation.Utility.Input.InputMode)

local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local useLastInputMode = require(Foundation.Utility.Input.useLastInputMode)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local CursorType = require(Foundation.Enums.CursorType)

local InputSize = require(Foundation.Enums.InputSize)

local Orientation = require(Foundation.Enums.Orientation)

local StateLayerAffordance = require(Foundation.Enums.StateLayerAffordance)

local Visibility = require(Foundation.Enums.Visibility)

local CursorComponent = require(Foundation.Providers.Cursor.CursorComponent)
local PresentationContext = require(Foundation.Providers.Style.PresentationContext)
local getKnobSize = require(Foundation.Components.Knob.getKnobSize)
local useTokens = require(Foundation.Providers.Style.useTokens)

local SliderThumb = require(Foundation.Components.Slider.SliderThumb)
local getKnobVisibility = require(script.Parent.getKnobVisibility)
local useSliderCapture = require(script.Parent.useSliderCapture)
local useSliderPointerDrag = require(script.Parent.useSliderPointerDrag)
local useSliderThumbs = require(script.Parent.useSliderThumbs)

local tbl1 = {
    range = NumberRange.new(0, 1),
    size = InputSize.Medium,
    width = UDim.new(1, 0),
    orientation = Orientation.Horizontal,
    isDisabled = false,
    isContained = false,
    knobVisibility = Visibility.Auto,
    testId = "--foundation-internal-slider"
}

local selectionGroup = {
    SelectionBehaviorLeft = Enum.SelectionBehavior.Stop,
    SelectionBehaviorRight = Enum.SelectionBehavior.Stop,
    SelectionBehaviorUp = Enum.SelectionBehavior.Stop,
    SelectionBehaviorDown = Enum.SelectionBehavior.Stop
}

local tbl3 = {
    SelectionBehaviorLeft = Enum.SelectionBehavior.Escape,
    SelectionBehaviorRight = Enum.SelectionBehavior.Escape,
    SelectionBehaviorUp = Enum.SelectionBehavior.Escape,
    SelectionBehaviorDown = Enum.SelectionBehavior.Escape
}

local vector2 = Vector2.new(0.5, 0.5)

local function noop() end

local function getFullBounds(): (number, number)
    return 0, 1
end
return React.forwardRef(function(arg1, arg2) -- name: InternalSlider
    local var1 = withDefaults(arg1, tbl1)
    local isVertical = var1.orientation == Orientation.Vertical
    local var2 = useTokens()
    local var3 = PresentationContext.usePresentationContext()
    local lastInputMode = useLastInputMode()

    local var5 = React.useRef(nil)
    React.useImperativeHandle(arg2, function()
        return var5.current
    end, {})

    local knobSize = getKnobSize(var2, var1.size)

    local var6 = React.useRef(Vector2.new(knobSize.X.Offset, knobSize.Y.Offset))
    local getKnobScale = React.useCallback(function()
        local current = var5.current

        if current and current.AbsoluteSize.X > 0 and current.AbsoluteSize.Y > 0 then
            return var6.current / current.AbsoluteSize
        end

        return Vector2.zero
    end, {})
    local knobScale, var9 = React.useBinding(Vector2.zero)
    local var10 = React.useCallback(function()
        var9(getKnobScale())
    end, { getKnobScale })
    local onAbsoluteSizeChanged = React.useCallback(function(arg3)
        var6.current = arg3.AbsoluteSize
        var10()
    end, { var10 })
    local var4 = React.useCallback(function(arg3)
        var10()
        if var1.onAbsoluteSizeChanged then
            var1.onAbsoluteSizeChanged(arg3)
        end
    end, { var10, var1.onAbsoluteSizeChanged })

    local var13 = useSliderThumbs({
        thumbs = var1.thumbs,
        range = var1.range,
        step = var1.step,
        onValueChanged = var1.onValueChanged,
        knobScale = knobScale,
        getKnobScale = getKnobScale,
        isVertical = isVertical,
        isContained = var1.isContained
    })

    local var14 = useSliderCapture({
        thumbs = var1.thumbs,
        rootRef = var5,
        range = var1.range,
        step = var1.step,
        isVertical = isVertical,
        isDisabled = var1.isDisabled,
        lastInputMode = lastInputMode,
        updateThumbValue = var13.updateThumbValue,
        clampToNeighbors = var13.clampToNeighbors,
        onCaptureStarted = var1.onDragStarted,
        onCaptureEnded = var1.onDragEnded
    })

    local var15 = useSliderPointerDrag({
        thumbs = var1.thumbs,
        rootRef = var5,
        isVertical = isVertical,
        getThumbTrackFraction = var13.getThumbTrackFraction,
        seekThumbToTrackFraction = var13.seekThumbToTrackFraction,
        setActiveIndex = var14.setActiveIndex,
        onDragStarted = var1.onDragStarted,
        onDragEnded = var1.onDragEnded
    })
    local isSelected = lastInputMode == InputMode.Directional and var14.isSelected
    local isDragEnabled = lastInputMode ~= InputMode.Directional
    local isVisible = getKnobVisibility({
        knobVisibility = var1.knobVisibility,
        controlState = var14.controlState,
        isDisabled = var1.isDisabled,
        isSelected = var14.isSelected,
        isDragging = var15.draggedIndex ~= nil
    })

    local uDim = UDim.new(0, knobSize.X.Offset)
    local uDim2 = if isVertical then UDim2.new(uDim, var1.width) else UDim2.new(var1.width, uDim)
    local tbl4 = { FocusTarget = 0, Track = 0, SelectionCursor = 0 }
    local createElement = React.createElement
    local var16 = View
    local tbl5 = {
        Size = UDim2.fromScale(1, 1),
        stateLayer = {
            affordance = StateLayerAffordance.None
        },
        cursor = if var14.isCaptured then CursorType.Invisible else nil,
        onStateChanged = var14.onStateChanged,
        isDisabled = var1.isDisabled,
        ref = var14.focusTargetRef,
        ZIndex = 0,
        testId = `{var1.testId}--focus-target`
    }
    local tbl6 = { DragDetector = 0 }
    local element

    if isSelected then
        element = nil
    else
        element = React.createElement("UIDragDetector", {
            DragStyle = Enum.UIDragDetectorDragStyle.Scriptable,
            [React.Event.DragStart] = var15.onTrackDragStarted,
            [React.Event.DragContinue] = var15.onTrackDrag,
            [React.Event.DragEnd] = var15.onTrackDragEnded,
            SelectionModeDragSpeed = UDim2.new(),
            Enabled = not var1.isDisabled
        })
    end

    tbl6.DragDetector = element
    tbl4.FocusTarget = createElement(var16, tbl5, tbl6)

    tbl4.Track = React.createElement(React.Fragment, nil, if var1.renderTrack then var1.renderTrack(var13.span) else var1.children)
    local element2

    if var14.isCaptured then
        element2 = React.createElement(View, {
            Size = knobScale:map(function(vector2_2: Vector2): UDim2
                return UDim2.fromScale(vector2_2.X, vector2_2.Y)
            end),
            AnchorPoint = vector2,
            Position = var13.positions[var14.activeThumbIndex],
            ZIndex = 3,
            selection = { Selectable = true },
            selectionGroup = selectionGroup,
            cursor = CursorType.Invisible,
            onStateChanged = noop,
            ref = var14.captureTargetRef,
            testId = `{var1.testId}--selection-cursor`
        }, {
            Cursor = React.createElement(CursorComponent, {
                isVisible = true,
                cornerRadius = UDim.new(0.5, 0),
                offset = var2.Padding.XSmall,
                borderWidth = var2.Stroke.Thicker,
                colorNamespace = var3.colorNamespace
            })
        })
    else
        element2 = nil
    end

    tbl4.SelectionCursor = element2

    for k, thumb in var1.thumbs do
        local str1 = `Thumb{k}`
        local createElement2 = React.createElement
        local var17 = SliderThumb
        local tbl7 = {
            trackRef = var5,
            fraction = var13.trackFractions[k],
            isVertical = isVertical,
            AnchorPoint = vector2,
            Position = var13.positions[k],
            Visible = isVisible,
            isDisabled = var1.isDisabled,
            isDragEnabled = isDragEnabled,
            knob = 0,
            onSeek = 0,
            getBounds = 0,
            onDragStarted = 0,
            onDragEnded = 0,
            onAbsoluteSizeChanged = 0,
            testId = 0
        }
        local renderThumb = var1.renderThumb
        local tbl8 = {
            isVisible = isVisible,
            isDragging = var15.draggedIndex == k
        }
        tbl7.knob = renderThumb(k, tbl8)

        function tbl7.onSeek(num1: number)
            var13.seekThumbToTrackFraction(k, num1)
        end
        tbl7.getBounds = getFullBounds
        function tbl7.onDragStarted()
            var15.onThumbDragStarted(k)
        end
        tbl7.onDragEnded = var15.onThumbDragEnded
        tbl7.onAbsoluteSizeChanged = onAbsoluteSizeChanged
        tbl7.testId = thumb.testId
        tbl4[str1] = createElement2(var17, tbl7)
    end

    local var17 = withCommonProps
    local tbl7 = {
        Size = uDim2,
        GroupTransparency = if var1.isDisabled then Constants.DISABLED_TRANSPARENCY else nil,
        selectionGroup = if var14.isCaptured then selectionGroup else tbl3,
        ref = var5
    }
    local var18 = var17(var1, tbl7)

    var18.onAbsoluteSizeChanged = var4

    return React.createElement(View, var18, tbl4)
end)
