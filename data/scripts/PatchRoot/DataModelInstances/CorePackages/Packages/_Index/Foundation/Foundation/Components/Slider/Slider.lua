-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:40:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)
local ReactUtils = require(FoundationParent.ReactUtils)

local Constants = require(Foundation.Constants)

local GuiService = require(Foundation.Utility.Wrappers.Services).GuiService
local InputMode = require(Foundation.Utility.Input.InputMode)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local useBindable = require(Foundation.Utility.useBindable)
local useLastInputMode = require(Foundation.Utility.Input.useLastInputMode)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local calculateSliderFraction = require(script.Parent.calculateSliderFraction)
local calculateSliderStepValue = require(script.Parent.calculateSliderStepValue)
local calculateSliderValueFraction = require(script.Parent.calculateSliderValueFraction)
local getGuiInputPosition = require(script.Parent.getGuiInputPosition)
local getSelectionEntryDirection = require(script.Parent.getSelectionEntryDirection)
local useSliderCaptureKeys = require(script.Parent.useSliderCaptureKeys)
local useSliderDirectionalInput = require(script.Parent.useSliderDirectionalInput)

local InputSize = require(Foundation.Enums.InputSize)

local Visibility = require(Foundation.Enums.Visibility)

local Orientation = require(Foundation.Enums.Orientation)

local SliderVariant = require(Foundation.Enums.SliderVariant)

local SliderType = require(Foundation.Enums.SliderType)

local ColorNamespace = require(Foundation.Enums.ColorNamespace)
local ControlState = require(Foundation.Enums.ControlState)
local CursorType = require(Foundation.Enums.CursorType)
local InternalSlider = require(Foundation.Components.InternalSlider)
local SliderThumb = require(script.Parent.SliderThumb)
local StateLayerAffordance = require(Foundation.Enums.StateLayerAffordance)

local CursorComponent = require(Foundation.Providers.Cursor.CursorComponent)
local Flags = require(Foundation.Utility.Flags)
local Knob = require(Foundation.Components.Knob)
local PresentationContext = require(Foundation.Providers.Style.PresentationContext)
local blendTransparencies = require(Foundation.Utility.blendTransparencies)
local getKnobSize = require(Foundation.Components.Knob.getKnobSize)
local usePresentationContext = PresentationContext.usePresentationContext
local useSliderVariants = require(Foundation.Components.Slider.useSliderVariants)
local useTokens = require(Foundation.Providers.Style.useTokens)

local tbl1 = {
    range = NumberRange.new(0, 1),
    size = InputSize.Medium,
    width = UDim.new(1, 0),
    orientation = Orientation.Horizontal,
    variant = SliderVariant.Standard,
    isDisabled = false,
    isContained = false,
    knobVisibility = Visibility.Auto,
    testId = "--foundation-slider"
}

local value = {
    colorNamespace = ColorNamespace.Inverse
}
local tbl3 = {
    SelectionBehaviorLeft = Enum.SelectionBehavior.Stop,
    SelectionBehaviorRight = Enum.SelectionBehavior.Stop,
    SelectionBehaviorUp = Enum.SelectionBehavior.Stop,
    SelectionBehaviorDown = Enum.SelectionBehavior.Stop
}

local tbl4 = {
    SelectionBehaviorLeft = Enum.SelectionBehavior.Escape,
    SelectionBehaviorRight = Enum.SelectionBehavior.Escape,
    SelectionBehaviorUp = Enum.SelectionBehavior.Escape,
    SelectionBehaviorDown = Enum.SelectionBehavior.Escape
}

local selectionGroup = {
    SelectionBehaviorLeft = Enum.SelectionBehavior.Stop,
    SelectionBehaviorRight = Enum.SelectionBehavior.Stop,
    SelectionBehaviorUp = Enum.SelectionBehavior.Stop,
    SelectionBehaviorDown = Enum.SelectionBehavior.Stop
}

return React.forwardRef(function(arg1, ref) -- name: Slider
    if Flags.FoundationSliderRebuild then
        local var1 = withDefaults(arg1, tbl1)
        local bool1 = var1.orientation == Orientation.Vertical
        local bool2 = arg1.type == SliderType.Range
        local var2 = useTokens()
        local var3 = useSliderVariants(var2, var1.size, var1.variant, bool1)

        local var4 = useBindable(if arg1.type == SliderType.Range then 0 else arg1.value)

        local var5 = useBindable(if arg1.type == SliderType.Range then arg1.value else NumberRange.new(0))

        local thumbs = React.useMemo(function()
            if not bool2 then
                return {{
                    value = var4:map(function(num1: number): number
                        return math.clamp(num1, var1.range.Min, var1.range.Max)
                    end),
                    testId = `{var1.testId}--thumb`
                }}
            end

            return {
                {
                    value = var5:map(function(numberRange: NumberRange)
                        return numberRange.Min
                    end),
                    testId = `{var1.testId}--min`
                },
                {
                    value = var5:map(function(numberRange: NumberRange)
                        return numberRange.Max
                    end),
                    testId = `{var1.testId}--max`
                }
            }
        end, {
            bool2,
            var5,
            var4,
            var1.range.Min,
            var1.range.Max,
            var1.testId
        })
        local onValueChanged = React.useCallback(function(num1: number, num2: number)
            if arg1.type == SliderType.Range then
                if arg1.onValueChanged then
                    local value = var5:getValue()
                    arg1.onValueChanged(if num1 == 1 then NumberRange.new(num2, value.Max) else NumberRange.new(value.Min, num2))
                end
            elseif arg1.onValueChanged then
                arg1.onValueChanged(num2)
            end
        end, { arg1.type, arg1.onValueChanged, var5 })

        local renderThumb = React.useCallback(function(num1: number, arg2)
            if var1.knob then
                if bool2 then
                    return var1.knob
                end
                return React.createElement(
                    View,
                    {
                        tag = "size-0-0 auto-xy",
                        Visible = arg2.isVisible,
                        testId = `{var1.testId}--custom-knob`
                    },
                    var1.knob
                )
            end
            local createElement = React.createElement
            local provider = PresentationContext.Provider
            local tbl6 = { value = value }
            local tbl7 = { Knob = 0 }
            local createElement2 = React.createElement
            local var8 = Knob
            local tbl8 = {
                size = var1.size,
                style = if arg2.isVisible then if arg2.isDragging then var3.knob.dragStyle else var3.knob.style else {
                    Color3 = var3.knob.style.Color3,
                    Transparency = 1
                },
                stroke = 0,
                hasShadow = 0,
                testId = 0
            }
            local tbl9

            if var3.knob.stroke then
                tbl9 = {
                    Color = var3.knob.stroke.Color,
                    Thickness = var3.knob.stroke.Thickness,
                    Transparency = 0
                }
                local var9 = blendTransparencies
                local strokeTransparency = if typeof(var3.knob.stroke.Transparency) == "number" then var3.knob.stroke.Transparency else nil
                tbl9.Transparency = var9(strokeTransparency, if arg2.isVisible then 0 else 1)
            else
                tbl9 = nil
            end

            tbl8.stroke = tbl9

            tbl8.hasShadow = var3.knob.hasShadow
            tbl8.testId = if bool2 then `{thumbs[num1].testId}--knob` else `{var1.testId}--knob`
            tbl7.Knob = createElement2(var8, tbl8)
            return createElement(provider, tbl6, tbl7)
        end, {
            var1.knob,
            var1.size,
            var1.testId,
            bool2,
            var3,
            thumbs
        })

        local renderTrack = React.useCallback(function(arg2)
            local element

            if bool2 then
                element = React.createElement(View, {
                    tag = var3.fill.tag,
                    Position = arg2:map(function(arg3)
                        return arg3.Position
                    end),
                    Size = arg2:map(function(arg3)
                        return arg3.Size
                    end),
                    testId = `{var1.testId}--fill`
                })
            else
                local createElement = React.createElement
                local var9 = View

                local tbl6 = {
                    tag = var3.fill.tag,
                    AnchorPoint = if bool1 then Vector2.new(0, 1) else nil,
                    Position = if bool1 then UDim2.fromScale(0, 1) else nil,
                    Size = var4:map(function(num1: number): UDim2
                        local sliderValueFraction = calculateSliderValueFraction(num1, var1.range)
                        if bool1 then
                            return UDim2.fromScale(1, sliderValueFraction)
                        end

                        return UDim2.fromScale(sliderValueFraction, 1)
                    end),
                    testId = `{var1.testId}--fill`
                }

                element = createElement(var9, tbl6)
            end

            return React.createElement(View, {
                tag = var3.bar.tag,
                Size = if bool1 then UDim2.new(0, var3.bar.height, 1, 0) else UDim2.new(1, 0, 0, var3.bar.height),
                testId = `{var1.testId}--bar`
            }, { Fill = element })
        end, {
            var1.range,
            var1.testId,
            bool2,
            bool1,
            var4,
            var3
        })

        return React.createElement(
            InternalSlider,
            withCommonProps(var1, {
                thumbs = thumbs,
                onValueChanged = onValueChanged,
                renderThumb = renderThumb,
                renderTrack = renderTrack,
                range = var1.range,
                step = var1.step,
                size = var1.size,
                width = var1.width,
                orientation = var1.orientation,
                isDisabled = var1.isDisabled,
                isContained = var1.isContained,
                knobVisibility = var1.knobVisibility,
                onDragStarted = var1.onDragStarted,
                onDragEnded = var1.onDragEnded,
                ref = ref
            })
        )
    end
    local var1 = withDefaults(arg1, tbl1)
    local isVertical = var1.orientation == Orientation.Vertical
    local bool2 = arg1.type == SliderType.Range
    local var2 = if arg1.type == SliderType.Range then 0 else arg1.value
    local onValueChanged = if arg1.type == SliderType.Range then nil else arg1.onValueChanged
    local onValueChanged2 = if arg1.type == SliderType.Range then arg1.onValueChanged else nil
    local var3 = useTokens()
    local var4, var5 = React.useState(ControlState.Initialize)
    local var6, var7 = React.useState(false)
    local var8, var9 = React.useState(false)
    local var10 = nil
    local var11 = nil
    if Flags.FoundationSliderCapture then
        var10, var11 = React.useState(false)
    end
    local var12 = nil
    local var13 = nil
    if Flags.FoundationSliderCapture then
        var12, var13 = React.useState(false)
    end

    local var14 = if Flags.FoundationSliderCapture then React.useRef(nil) else nil
    local var15 = if Flags.FoundationSliderCapture then React.useRef(nil) else nil
    local var16 = if Flags.FoundationSliderCapture then React.useRef(false) else nil
    local var17 = React.useRef(false)
    local var18, var19 = React.useState(false)
    local var20 = useBindable(var2):map(function(arg2): number
        return math.clamp(arg2, var1.range.Min, var1.range.Max)
    end)

    local var21 = useBindable(if arg1.type == SliderType.Range then arg1.value else NumberRange.new(0))

    local var22 = React.useRef(nil)

    local var23 = React.useRef(0)
    local minDragTranslation, var25 = React.useBinding(UDim2.new())
    local maxDragTranslation, var27 = React.useBinding(UDim2.new())
    local var28 = React.useCallback(function(yScale: number)
        if isVertical then
            var25(UDim2.fromScale(0, yScale - 1))
            var27(UDim2.fromScale(0, yScale))
            return
        end
        var25(UDim2.fromScale(-yScale, 0))
        var27(UDim2.fromScale(1 - yScale, 0))
    end, { isVertical })

    local var29 = React.useRef(0)
    local var30 = useLastInputMode()
    local trackRef = React.useRef(nil)
    React.useImperativeHandle(ref, function()
        return trackRef.current
    end, {})

    local referenceUiInstance, var33 = React.useBinding(nil)
    local var34 = ReactUtils.useComposedRef(trackRef, var33)

    local var35 = useSliderVariants(var3, var1.size, var1.variant, isVertical)

    local style = React.useMemo(function()
        if var8 then
            if var6 and not bool2 then
                return var35.knob.dragStyle
            end

            return var35.knob.style
        end

        return {
            Color3 = var35.knob.style.Color3,
            Transparency = 1
        }
    end, {
        var35,
        var8,
        var6,
        bool2
    })
    local var37 = var4 == ControlState.Selected or var4 == ControlState.SelectedPressed or Flags.FoundationSliderCapture and var10

    local var38 = if Flags.FoundationSliderCapture then React.useCallback(function()
        if var10 then
            if bool2 then
                var13(not var12)
            end
        else
            var11(true)
        end
    end, { var10, bool2, var12 }) else nil

    if Flags.FoundationSliderCapture then
        useSliderCaptureKeys(var37 and not var1.isDisabled, var38)
    end

    if Flags.FoundationSliderCapture then
        React.useEffect(function()
            if var1.isDisabled then
                var11(false)
            end
        end, { var1.isDisabled })

        React.useEffect(function()
            local function redirectDragSelection() -- Luacid: Inlined by compiler; 1 call site recovered
                local selectedObject = GuiService.SelectedObject
                local isDescendantOf

                if selectedObject == trackRef.current then
                    isDescendantOf = true
                elseif selectedObject == nil or trackRef.current == nil then
                    isDescendantOf = false
                else
                    isDescendantOf = selectedObject:IsDescendantOf(trackRef.current)

                    if isDescendantOf then
                        if selectedObject == var14.current then
                            isDescendantOf = false
                        else
                            isDescendantOf = selectedObject ~= var15.current
                        end
                    end
                end

                if isDescendantOf then
                    GuiService.SelectedObject = var14.current
                end
            end

            redirectDragSelection()
            local connection = GuiService:GetPropertyChangedSignal("SelectedObject"):Connect(redirectDragSelection)
            return function()
                connection:Disconnect()
            end
        end, {})

        React.useEffect(function()
            if not var10 then
                return
            end

            GuiService.SelectedObject = var15.current
            local connection = GuiService:GetPropertyChangedSignal("SelectedObject"):Connect(function()
                if GuiService.SelectedObject ~= var15.current then
                    var11(false)
                end
            end)
            return function()
                connection:Disconnect()
            end
        end, { var10 })
    end

    React.useEffect(function()
        if var1.isDisabled then
            var9(false)
        elseif var1.knobVisibility == Visibility.None then
            var9(var37)
        elseif var1.knobVisibility == Visibility.Always then
            var9(true)
        else
            var9(var6 or var4 == ControlState.Hover or var4 == ControlState.Selected or var4 == ControlState.Pressed)
        end
    end, {
        var1.knobVisibility,
        var4,
        var6,
        var1.isDisabled,
        var37
    })

    local var39 = React.useCallback(function(num1: number)
        if num1 ~= var20:getValue() and onValueChanged then
            onValueChanged(num1)
        end
    end, { var20, onValueChanged })

    local var40 = React.useCallback(function(numberRange: NumberRange)
        local value = var21:getValue()

        if onValueChanged2 and (typeof(value) ~= "NumberRange" or numberRange.Min ~= value.Min or numberRange.Max ~= value.Max) then
            onValueChanged2(numberRange)
        end
    end, { var21, onValueChanged2 })

    local var41 = React.useCallback(function(bool3: boolean)
        var19(bool3)
        if Flags.FoundationSliderCapture then
            var13(bool3)
        end
        var7(true)
        if var1.onDragStarted then
            var1.onDragStarted()
        end
    end, { var1.onDragStarted })

    local onDragEnded = React.useCallback(function()
        var7(false)
        if var1.onDragEnded then
            var1.onDragEnded()
        end
    end, { var1.onDragEnded })

    local onDragStarted = React.useCallback(function()
        var41(false)
    end, { var41 })
    local var24 = React.useCallback(function()
        var41(true)
    end, { var41 })

    local var45 = React.useCallback(function(num1: number): number
        return math.clamp((num1 - var1.range.Min) / (var1.range.Max - var1.range.Min), 0, 1)
    end, { var1.range.Min, var1.range.Max })
    local var46 = React.useCallback(function(num1: number)
        return var1.range.Min + num1 * (var1.range.Max - var1.range.Min)
    end, { var1.range.Min, var1.range.Max })
    local var47 = React.useCallback(function(num1: number)
        local var47 = var46(num1)
        if var1.step then
            return (calculateSliderStepValue(var47, var1.step, var1.range))
        end

        return var47
    end, { var46, var1.step, var1.range })

    local getBounds = React.useCallback(function()
        local var48 = var45(var21:getValue().Max)
        if var1.step and var1.step > 0 then
            local num1 = math.floor((var46(var48) - var1.range.Min) / var1.step + 0.5)
            var48 = var45(var1.range.Min + num1 * var1.step)
        end
        return 0, var48
    end, {
        var21,
        var45,
        var1.step,
        var46,
        var1.range.Min
    })

    local var26 = React.useCallback(function()
        local var49 = var45(var21:getValue().Min)
        if var1.step and var1.step > 0 then
            local num1 = math.floor((var46(var49) - var1.range.Min) / var1.step + 0.5)
            var49 = var45(var1.range.Min + num1 * var1.step)
        end
        return var49, 1
    end, {
        var21,
        var45,
        var1.step,
        var46,
        var1.range.Min
    })

    local onSeek = React.useCallback(function(num1: number)
        local value = var21:getValue()
        var40(NumberRange.new(math.min(var47(num1), value.Max), value.Max))
    end, { var21, var40, var47 })
    local var31 = React.useCallback(function(num1: number)
        local value = var21:getValue()
        var40(NumberRange.new(value.Min, math.max(var47(num1), value.Min)))
    end, { var21, var40, var47 })

    local var52 = React.useCallback(function(num1: number, bool3: boolean)
        if bool3 then
            local var52, var53 = var26()
            var31(math.clamp(num1, var52, var53))
            return
        end
        local var52, var53 = getBounds()
        onSeek(math.clamp(num1, var52, var53))
    end, {
        var26,
        getBounds,
        var31,
        onSeek
    })
    local var53 = React.useCallback(function(_, vector2: Vector2)
        if not bool2 or var30 == InputMode.Directional or not trackRef.current then
            return
        end

        local sliderFraction = calculateSliderFraction(getGuiInputPosition(vector2, trackRef.current), trackRef.current, isVertical)
        local value = var21:getValue()
        local var53 = var45(value.Min)
        local var54 = var45(value.Max)
        local current = math.abs(var54 - sliderFraction) < math.abs(sliderFraction - var53) or var53 == var54 and var54 < sliderFraction

        var17.current = current
        if Flags.FoundationSliderCapture then
            var13(current)
        end
        var41(current)
        var52(sliderFraction, current)
    end, {
        bool2,
        var30,
        isVertical,
        var21,
        var41,
        var52,
        var45
    })

    local var54 = React.useCallback(function(_, vector2: Vector2)
        if not bool2 or var30 == InputMode.Directional or not trackRef.current then
            return
        end

        local guiInputPosition = getGuiInputPosition(vector2, trackRef.current)
        var52(calculateSliderFraction(guiInputPosition, trackRef.current, isVertical), var17.current)
    end, {
        bool2,
        var30,
        isVertical,
        var52
    })
    local var55 = React.useCallback(function()
        if not bool2 then
            return
        end
        onDragEnded()
    end, { bool2, onDragEnded })

    local var56 = if Flags.FoundationSliderCapture then React.useCallback(function()
        var11(false)
        GuiService.SelectedObject = var14.current
    end, {}) else nil

    local useMemo = React.useMemo
    local function func1()
        return {
            getValue = function()
                if not (Flags.FoundationSliderCapture and bool2) then
                    return var20:getValue()
                end

                local value = var21:getValue()
                return if var12 then value.Max else value.Min
            end,
            onStep = Flags.FoundationSliderCapture and function(num1: number)
                if not bool2 then
                    var39(num1)

                    return
                end

                local value = var21:getValue()
                if var12 then
                    var40(NumberRange.new(value.Min, math.max(num1, value.Min)))
                    return
                end
                var40(NumberRange.new(math.min(num1, value.Max), value.Max))
            end or function(num1: number)
                if var1.step then
                    num1 = calculateSliderStepValue(num1, var1.step, var1.range)
                end
                var39(num1)
            end,
            onExit = if Flags.FoundationSliderCapture then var56 else nil
        }
    end

    local step = var1.step
    local range = var1.range
    local var57 = if Flags.FoundationSliderCapture then bool2 else nil
    local var58 = if Flags.FoundationSliderCapture then var21 else nil
    local var59 = if Flags.FoundationSliderCapture then var12 else nil
    local var60 = if Flags.FoundationSliderCapture then var40 else nil
    local var61 = if Flags.FoundationSliderCapture then var56 else nil
    local var62 = useMemo(func1, { var20, var39, step, range, var57, var58, var59, var60, var61 })

    local var63 = var37 and not var1.isDisabled
    local var64 = if Flags.FoundationSliderCapture then var63 and var10 else var63 and not bool2
    useSliderDirectionalInput(var64, var1.step, var1.range, isVertical, var62)

    local var65 = React.useCallback(function(_, _vector2: Vector2)
        local current = var22.current
        if not current then
            return
        end

        local var65 = var1.range.Max - var1.range.Min
        local var32 = if isVertical then -current.DragUDim2.Y.Scale else current.DragUDim2.X.Scale

        if var30 == InputMode.Directional and math.abs(var32 - var29.current) > 0.01 then
            var23.current = (var20:getValue() - var1.range.Min) / var65 - var32
            var29.current = var32
            var28(var23.current)
            return
        end

        var29.current = var32

        local num1 = math.clamp(var23.current + var32, 0, 1)
        local var67 = var1.range.Min + num1 * var65

        local var68 = var39
        if var1.step then
            var67 = calculateSliderStepValue(var67, var1.step, var1.range)
        end

        var68(var67)
    end, {
        var1.step,
        var1.range,
        var30,
        var20,
        var39,
        isVertical,
        var28
    })

    local var66 = React.useCallback(function(_, vector2: Vector2)
        var7(true)

        if var1.onDragStarted then
            var1.onDragStarted()
        end

        var29.current = 0

        local var66 = var1.range.Max - var1.range.Min

        if var30 == InputMode.Directional then
            var23.current = (var20:getValue() - var1.range.Min) / var66
            var28(var23.current)
            return
        end

        local var67 = if trackRef.current then var1.range.Min + calculateSliderFraction(getGuiInputPosition(vector2, trackRef.current), trackRef.current, isVertical) * var66 else var1.range.Min
        var23.current = (var67 - var1.range.Min) / var66

        local var68 = var39
        if var1.step then
            var67 = calculateSliderStepValue(var67, var1.step, var1.range)
        end

        var68(var67)

        var28(var23.current)
    end, {
        var1.onDragStarted,
        var1.step,
        var1.range,
        var30,
        var20,
        var39,
        isVertical,
        var28
    })

    local var67 = React.useCallback(function(_, _vector2: Vector2)
        var7(false)

        if var1.onDragEnded then
            var1.onDragEnded()
        end
    end, { var1.onDragEnded })

    local onStateChanged = React.useCallback(function(arg2)
        var5(arg2)

        if not Flags.FoundationSliderCapture then
            return
        end

        local current = arg2 == ControlState.Selected or arg2 == ControlState.SelectedPressed
        if bool2 and current and not var16.current then
            var13(getSelectionEntryDirection(isVertical) < 0)
        end
        var16.current = current
    end, { bool2, isVertical })

    local var69 = usePresentationContext()
    React.useEffect(function()
        local current = var22.current
        if not current then
            return
        end
        current.ReferenceUIInstance = trackRef.current
    end, {})

    local uDim2 = if isVertical then UDim2.fromScale(0.5, 0) else UDim2.fromScale(1, 0.5)

    local anchorPoint = if var1.isContained then var20:map(function(num1: number): Vector2
        local x = (num1 - var1.range.Min) / (var1.range.Max - var1.range.Min)
        if isVertical then
            return Vector2.new(0.5, 1 - x)
        end

        return Vector2.new(x, 0.5)
    end) else Vector2.new(0.5, 0.5)

    local uDim = UDim.new(0, getKnobSize(var3, var1.size).X.Offset)
    local uDim2_2 = if isVertical then UDim2.new(uDim, var1.width) else UDim2.new(var1.width, uDim)

    local stroke = React.useMemo(function(): {Color: any, Thickness: any, Transparency: number}?
        local stroke = var35.knob.stroke
        if stroke == nil then
            return nil
        end
        return {
            Color = stroke.Color,
            Thickness = stroke.Thickness,
            Transparency = blendTransparencies(if typeof(stroke.Transparency) == "number" then stroke.Transparency else nil, if var8 then 0 else 1)
        }
    end, { var35, var8 })

    local var72, var73 = React.useBinding(Vector2.zero)
    local var74 = React.useCallback(function(arg2)
        var73(arg2.AbsoluteSize)
    end, {})
    local knobAppearance = React.useMemo(function()
        return {
            size = var1.size,
            style = if var8 and var6 and not var18 then var35.knob.dragStyle else style,
            stroke = stroke,
            hasShadow = var35.knob.hasShadow
        }
    end, {
        var1.size,
        var8,
        var6,
        var18,
        var35.knob.dragStyle,
        style,
        stroke,
        var35.knob.hasShadow
    })

    local var32 = React.useMemo(function()
        return {
            size = var1.size,
            style = if var8 and var6 and var18 then var35.knob.dragStyle else style,
            stroke = stroke,
            hasShadow = var35.knob.hasShadow
        }
    end, {
        var1.size,
        var8,
        var6,
        var18,
        var35.knob.dragStyle,
        style,
        stroke,
        var35.knob.hasShadow
    })

    local fraction = var21:map(function(numberRange: NumberRange)
        return var45(numberRange.Min)
    end)
    local var36 = var21:map(function(numberRange: NumberRange)
        return var45(numberRange.Max)
    end)
    local var79 = var37 and (not Flags.FoundationSliderCapture or var10)
    local var80 = if Flags.FoundationSliderCapture and bool2 then if var12 then var36 else fraction else nil

    local var42 = if Flags.FoundationSliderCapture and bool2 then if var1.isContained then var80:map(function(x: number): Vector2
        if isVertical then
            return Vector2.new(0.5, 1 - x)
        end

        return Vector2.new(x, 0.5)
    end) else Vector2.new(0.5, 0.5) else nil

    local var82 = if Flags.FoundationSliderCapture and bool2 then if var1.knob then var72:map(function(vector2: Vector2): UDim2
        return UDim2.fromOffset(vector2.X, vector2.Y)
    end) else getKnobSize(var3, var1.size) else nil

    local var43 = if Flags.FoundationSliderCapture then React.useCallback(function(_) end, {}) else nil
    local foundationSliderCapture = Flags.FoundationSliderCapture

    if foundationSliderCapture then
        if var30 == InputMode.Directional then
            foundationSliderCapture = var37
        else
            foundationSliderCapture = false
        end
    end

    local element

    if foundationSliderCapture then
        element = nil
    elseif bool2 then
        element = React.createElement("UIDragDetector", {
            DragStyle = Enum.UIDragDetectorDragStyle.Scriptable,
            [React.Event.DragStart] = var53,
            [React.Event.DragContinue] = var54,
            [React.Event.DragEnd] = var55,
            SelectionModeDragSpeed = UDim2.new(),
            Enabled = not var1.isDisabled
        })
    else
        element = React.createElement("UIDragDetector", {
            ref = var22,
            ReferenceUIInstance = referenceUiInstance,
            DragStyle = Enum.UIDragDetectorDragStyle.TranslateLine,
            DragAxis = if isVertical then Vector2.new(0, 1) else Vector2.new(1, 0),
            ResponseStyle = Enum.UIDragDetectorResponseStyle.CustomScale,
            DragRelativity = Enum.UIDragDetectorDragRelativity.Absolute,
            MinDragTranslation = minDragTranslation,
            MaxDragTranslation = maxDragTranslation,
            [React.Event.DragStart] = var66,
            [React.Event.DragContinue] = var65,
            [React.Event.DragEnd] = var67,
            SelectionModeDragSpeed = UDim2.new(),
            Enabled = not var1.isDisabled
        })
    end

    local tbl6

    if bool2 then
        tbl6 = { Fill = 0, MinKnob = 0, MaxKnob = 0, SelectionCursor = 0 }
        local createElement = React.createElement
        local var84 = View

        local tbl7 = {
            tag = var35.fill.tag,
            AnchorPoint = Vector2.new(0, 0),
            Position = if isVertical then var36:map(function(num1: number): UDim2
                return UDim2.fromScale(0, 1 - num1)
            end) else fraction:map(function(xScale: number): UDim2
                return UDim2.fromScale(xScale, 0)
            end),
            Size = var21:map(function(numberRange: NumberRange): UDim2
                local var85 = var45(numberRange.Max) - var45(numberRange.Min)
                if isVertical then
                    return UDim2.fromScale(1, var85)
                end

                return UDim2.fromScale(var85, 1)
            end),
            testId = `{var1.testId}--fill`
        }

        tbl6.Fill = createElement(var84, tbl7)

        local createElement2 = React.createElement
        local var85 = SliderThumb
        local tbl8 = {
            trackRef = trackRef,
            fraction = fraction,
            isVertical = isVertical,
            isDisabled = var1.isDisabled,
            isDragEnabled = not foundationSliderCapture,
            knobAppearance = knobAppearance,
            knob = var1.knob,
            isContained = var1.isContained,
            onSeek = onSeek,
            getBounds = getBounds,
            onDragStarted = onDragStarted,
            onDragEnded = onDragEnded,
            Visible = var8,
            onAbsoluteSizeChanged = if Flags.FoundationSliderCapture then var74 else nil,
            LayoutOrder = 1,
            testId = `{var1.testId}--min`
        }
        tbl6.MinKnob = createElement2(var85, tbl8)

        local createElement3 = React.createElement
        local var86 = SliderThumb
        local tbl9 = {
            trackRef = trackRef,
            fraction = var36,
            isVertical = isVertical,
            isDisabled = var1.isDisabled,
            isDragEnabled = not foundationSliderCapture,
            knobAppearance = var32,
            knob = var1.knob,
            isContained = var1.isContained,
            onSeek = var31,
            getBounds = var26,
            onDragStarted = var24,
            onDragEnded = onDragEnded,
            Visible = var8,
            onAbsoluteSizeChanged = 0,
            LayoutOrder = 2,
            testId = 0
        }

        if not Flags.FoundationSliderCapture then
            var74 = nil
        end

        tbl9.onAbsoluteSizeChanged = var74

        tbl9.testId = `{var1.testId}--max`
        tbl6.MaxKnob = createElement3(var86, tbl9)
        local element2

        if Flags.FoundationSliderCapture and var79 then
            element2 = React.createElement(View, {
                Size = var82,
                AnchorPoint = var42,
                Position = var80:map(function(xScale: number): UDim2
                    if isVertical then
                        return UDim2.fromScale(0.5, 1 - xScale)
                    end

                    return UDim2.fromScale(xScale, 0.5)
                end),
                ZIndex = 3,
                selection = { Selectable = true },
                selectionGroup = selectionGroup,
                cursor = CursorType.Invisible,
                onStateChanged = var43,
                ref = var15,
                testId = `{var1.testId}--selection-cursor`
            }, {
                Cursor = React.createElement(CursorComponent, {
                    isVisible = true,
                    cornerRadius = UDim.new(0.5, 0),
                    offset = var3.Padding.XSmall,
                    borderWidth = var3.Stroke.Thicker,
                    colorNamespace = var69.colorNamespace
                })
            })
        else
            element2 = nil
        end

        tbl6.SelectionCursor = element2
    else
        tbl6 = { Fill = 0 }
        local createElement = React.createElement
        local var84 = View

        local tbl7 = {
            tag = var35.fill.tag,
            AnchorPoint = if isVertical then Vector2.new(0, 1) else nil,
            Position = if isVertical then UDim2.fromScale(0, 1) else nil,
            Size = var20:map(function(num1: number): UDim2
                local var85 = (num1 - var1.range.Min) / (var1.range.Max - var1.range.Min)
                if isVertical then
                    return UDim2.fromScale(1, var85)
                end

                return UDim2.fromScale(var85, 1)
            end),
            testId = `{var1.testId}--fill`
        }

        local tbl8 = { SelectionCursor = 0, Knob = 0 }
        local var85

        if var79 then
            local createElement2 = React.createElement
            local var86 = View
            local tbl9 = {
                Size = if var1.knob then var72:map(function(vector2: Vector2): UDim2
                    return UDim2.fromOffset(vector2.X, vector2.Y)
                end) else getKnobSize(var3, var1.size),
                AnchorPoint = anchorPoint,
                Position = uDim2,
                selection = Flags.FoundationSliderCapture and { Selectable = true } or nil,
                selectionGroup = if Flags.FoundationSliderCapture then selectionGroup else nil,
                cursor = if Flags.FoundationSliderCapture then CursorType.Invisible else nil,
                onStateChanged = var43,
                ref = var15,
                testId = `{var1.testId}--selection-cursor`
            }

            var85 = createElement2(var86, tbl9, {
                Cursor = React.createElement(CursorComponent, {
                    isVisible = true,
                    cornerRadius = UDim.new(0.5, 0),
                    offset = var3.Padding.XSmall,
                    borderWidth = var3.Stroke.Thicker,
                    colorNamespace = var69.colorNamespace
                })
            })
        else
            var85 = nil
        end

        tbl8.SelectionCursor = var85
        local element2

        if var1.knob then
            element2 = React.createElement(View, {
                tag = "size-0-0 auto-xy",
                AnchorPoint = anchorPoint,
                Position = uDim2,
                Visible = var8,
                onAbsoluteSizeChanged = var74,
                testId = `{var1.testId}--custom-knob`
            }, var1.knob)
        else
            element2 = React.createElement(PresentationContext.Provider, { value = value }, {
                Knob = React.createElement(Knob, {
                    AnchorPoint = anchorPoint,
                    Position = uDim2,
                    size = var1.size,
                    style = style,
                    stroke = stroke,
                    hasShadow = var35.knob.hasShadow,
                    testId = `{var1.testId}--knob`
                })
            })
        end

        tbl8.Knob = element2
        tbl6.Fill = createElement(var84, tbl7, tbl8)
    end

    local uDim2_3 = if isVertical then UDim2.new(0, var35.bar.height, 1, 0) else UDim2.new(1, 0, 0, var35.bar.height)
    local bar = React.createElement(View, { tag = var35.bar.tag, Size = uDim2_3, testId = `{var1.testId}--bar` }, tbl6)

    local tbl7 = { DragDetector = element, Bar = bar }

    if not Flags.FoundationSliderCapture then
        local createElement = React.createElement
        local var84 = View
        local var85 = withCommonProps

        local tbl8 = {
            Size = uDim2_2,
            GroupTransparency = if var1.isDisabled then Constants.DISABLED_TRANSPARENCY else nil,
            stateLayer = {
                affordance = StateLayerAffordance.None
            },
            selectionGroup = if bool2 then nil else var35.selectionGroup,
            cursor = CursorType.Invisible,
            onStateChanged = onStateChanged,
            isDisabled = var1.isDisabled,
            ref = 0
        }

        if bool2 then
            var34 = trackRef
        end

        tbl8.ref = var34
        return createElement(var84, var85(var1, tbl8), tbl7)
    end

    local createElement = React.createElement
    local var84 = View
    local var85 = withCommonProps

    local tbl8 = {
        Size = uDim2_2,
        GroupTransparency = if var1.isDisabled then Constants.DISABLED_TRANSPARENCY else nil,
        selectionGroup = if var10 then tbl3 else tbl4,
        ref = 0
    }

    if bool2 then
        var34 = trackRef
    end

    tbl8.ref = var34
    local var86 = var85(var1, tbl8)

    local tbl9 = {
        FocusTarget = React.createElement(View, {
            Size = UDim2.fromScale(1, 1),
            stateLayer = {
                affordance = StateLayerAffordance.None
            },
            cursor = if var10 then CursorType.Invisible else nil,
            onStateChanged = onStateChanged,
            isDisabled = var1.isDisabled,
            ref = var14,
            ZIndex = 0,
            testId = `{var1.testId}--focus-target`
        }, { DragDetector = element }),
        Bar = bar
    }
    return createElement(var84, var86, tbl9)
end)
