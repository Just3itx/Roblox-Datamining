-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:21:14Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)
local ReactIs = require(FoundationParent.ReactIs)
local ReactUtils = require(FoundationParent.ReactUtils)

local Components = Foundation.Components
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local InputSize = require(Foundation.Enums.InputSize)

local _InputLabelSize = require(Foundation.Enums.InputLabelSize)

local InputVariant = require(Foundation.Enums.InputVariant)

local NumberInputControlsVariant = require(Foundation.Enums.NumberInputControlsVariant)

local ScrubBehavior = require(Foundation.Enums.ScrubBehavior)

local OnChangeCallbackReason = require(Foundation.Enums.OnChangeCallbackReason)

local Flags = require(Foundation.Utility.Flags)
local Icon = require(Components.Icon)
local InputField = require(Components.InputField)
local InternalTextInput = require(Components.InternalTextInput)
local Text = require(Components.Text)
local _Types = require(Components.Types)
local View = require(Components.View)
local getBindableValue = require(Foundation.Utility.getBindableValue)
local getInputTextSize = require(Foundation.Utility.getInputTextSize)
local getMultiLineTextHeight = require(Foundation.Utility.getMultiLineTextHeight)
local isBuilderIcon = require(Foundation.Utility.isBuilderIcon)
local joinBindables = require(Foundation.Utility.joinBindables)
local mapBindable = require(Foundation.Utility.mapBindable)
local useIconSize = require(Foundation.Utility.useIconSize)
local useTextInputVariants = require(Components.TextInput.useTextInputVariants)
local useTextSize = require(Foundation.Utility.useTextSize)
local useTokens = require(Foundation.Providers.Style.useTokens)

local NumberInputControls = require(script.Parent.NumberInputControls)
local useNumberInputVariants = require(script.Parent.useNumberInputVariants)

local Constants = require(Foundation.Constants)
local calculateNumberInputValueFromPositions = require(script.Parent.calculateNumberInputValueFromPositions)

local _InputFocusBehavior = require(Foundation.Enums.InputFocusBehavior)

local function round(num1: number, precision: number?): number -- Luacid: Inlined by compiler; 7 call sites recovered
    local num2 = 10 ^ (precision or 0)
    return math.floor(num1 * num2 + 0.5) / num2
end

local tbl1 = {
    [ScrubBehavior.On] = 1,
    [ScrubBehavior.Off] = 0
}

local tbl2 = {
    variant = InputVariant.Standard,
    size = InputSize.Large,
    minimum = -math.huge,
    maximum = math.huge,
    step = 1,
    precision = 3,
    value = 0,
    formatAsString = function(num1: number): string -- name: defaultFormatAsString
        return tostring(num1)
    end,
    isScrubbable = false,
    scrubBehavior = ScrubBehavior.Off,
    hasControls = false,
    testId = "--foundation-number-input"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: NumberInput
    local var1 = withDefaults(arg1, tbl2)

    local var2 = useTokens()
    local var3 = useTextInputVariants(var2, var1.size, var1.variant)
    local controls = useNumberInputVariants(var2, var1.size).controls

    local var4 = React.useRef(nil)

    local textBoxRef = ReactUtils.useComposedRef(var4, var1.textBoxRef)

    local var6 = React.useRef(nil)
    local var7 = React.useRef(false)

    local var8 = React.useCallback(function()
        if var4.current then
            return (var4.current.getIsFocused())
        end

        return false
    end, {})

    local var9, var10 = React.useState(false)
    local hasError = var1.hasError or var9
    local controlsVariant = var1.controlsVariant
    local var12 = if var1.isScrubbable then ScrubBehavior.On else var1.scrubBehavior
    local var13 = var12 and var12 ~= ScrubBehavior.Off

    local var14 = tbl1[var12]
    local var15 = React.useCallback(function(num1: number): number
        return math.clamp(num1, var1.minimum, var1.maximum)
    end, { var1.minimum, var1.maximum })

    local var16 = React.useCallback(function(num1: number, func1: (...any) -> (...any))
        return func1(num1 / var1.step) * var1.step
    end, { var1.step })

    local var17 = React.useMemo(function()
        return mapBindable(var1.value, function(arg2)
            local num1 = round(arg2, var1.precision)
            local num2 = round(arg2 + var1.step, var1.precision)
            local num3 = round(var16(arg2, math.ceil), var1.precision)
            if num1 ~= num3 then
                num2 = num3
            end

            return var15(num2)
        end)
    end, {
        var1.value,
        var1.step,
        var1.precision,
        var15,
        var16
    })
    local var18 = React.useMemo(function()
        return mapBindable(var1.value, function(arg2)
            local num1 = round(arg2, var1.precision)
            local num2 = round(arg2 - var1.step, var1.precision)
            local num3 = round(var16(arg2, math.floor), var1.precision)
            if num1 ~= num3 then
                num2 = num3
            end

            return var15(num2)
        end)
    end, {
        var1.value,
        var1.step,
        var1.precision,
        var15,
        var16
    })
    local isDisabled = React.useMemo(function()
        return mapBindable(var1.value, function(maximum)
            return var1.isDisabled or maximum == var1.maximum
        end)
    end, { var1.isDisabled, var1.value, var1.maximum })

    local var5 = React.useMemo(function()
        return mapBindable(var1.value, function(minimum)
            return var1.isDisabled or minimum == var1.minimum
        end)
    end, { var1.isDisabled, var1.value, var1.minimum })

    local var21 = React.useCallback(function(num1: number): number
        local minimum = var1.minimum
        local maximum = var1.maximum
        return round(math.clamp(num1, minimum, maximum), var1.precision)
    end, { var1.minimum, var1.maximum, var1.precision })

    local text, var23 = React.useBinding(var1.formatAsString(var21(getBindableValue(var1.value))))
    local offset = if var1.size == InputSize.XSmall then var2.Gap.Small - var2.Gap.XSmall / 2 else var2.Gap.Small
    local fontStyle = var3.textBox.fontStyle
    local fontSize = fontStyle.FontSize

    local var24 = if var1.prefix and var1.prefix ~= "" then true else var1.suffix and var1.suffix ~= ""
    local var25 = if var1.prefix then var1.prefix .. " " else nil

    local var26 = React.useMemo(function()
        return {
            Font = fontStyle.Font,
            FontSize = math.floor(fontSize),
            LineHeight = fontStyle.LineHeight
        }
    end, { fontStyle, fontSize })
    local var27 = useTextSize(var25, var26)

    local var28 = useIconSize(var3.icon.size, isBuilderIcon(var1.leadingIcon))
    local var29 = useIconSize(var3.icon.size, isBuilderIcon(var1.trailingIcon))
    local var30 = if var1.leadingIcon then var28.X.Offset else 0
    local var31 = if var1.trailingIcon then var29.X.Offset else 0
    local var32 = if var1.size == InputSize.XSmall then var2.Gap.Small elseif var1.size == InputSize.Small then var2.Gap.Medium else var2.Gap.Large
    local var33 = if var1.leadingIcon then var32 else 0
    local var34 = if var1.trailingIcon then var32 else 0

    local var35 = React.useMemo(function()
        return {
            left = UDim.new(0, var3.container.horizontalPadding.Offset + var30 + var33),
            right = UDim.new(0, var3.container.horizontalPadding.Offset + var31 + var34)
        }
    end, {
        var3.container.horizontalPadding,
        var33,
        var34,
        var30,
        var31
    })

    local padding = React.useMemo(function()
        local multiLineTextHeight = getMultiLineTextHeight(fontSize, 1, fontStyle.LineHeight)

        local num1 = math.round((var3.container.minHeight - 2 - multiLineTextHeight) * 2) / 2

        return {
            top = UDim.new(0, math.floor(num1 / 2) + 1),
            bottom = UDim.new(0, math.ceil(num1 / 2) + 1),
            left = UDim.new(),
            right = UDim.new()
        }
    end, { var3.container.minHeight, fontStyle, fontSize })

    local width = if var1.width then var1.width else UDim.new(0, Constants.DEFAULT_NUMBER_INPUT_WIDTH)

    local onFocus = React.useCallback(function()
        var23(tostring(getBindableValue(var1.value)))

        if var1.onFocusGained then
            var1.onFocusGained()
        end
    end, { var1.onFocusGained, var1.value })

    local var39 = React.useCallback(function(num1: number, arg2)
        num1 = var21(num1)
        var23(if var8() then tostring(num1) else var1.formatAsString(num1))
        var1.onChanged(num1, arg2)
    end, {
        var1.onChanged,
        var1.formatAsString,
        var21,
        var8
    })
    local onFocusLost = React.useCallback(function(arg2)
        var10(false)
        var39(getBindableValue(var1.value), OnChangeCallbackReason.FocusLost)

        if var1.onFocusLost then
            var1.onFocusLost(arg2)
        end
    end, {
        var39,
        var1.onFocusLost,
        var1.value,
        var21
    })
    local onChanged = React.useCallback(function(arg2)
        var23(arg2)
        if not var8() then
            return
        end
        local var41 = tonumber(arg2)

        if var1.onTextChanged ~= nil then
            var1.onTextChanged(arg2)
        elseif var41 == nil then
            var10(true)
            return
        end

        if var41 ~= nil then
            var10(false)
            var1.onChanged(var41, OnChangeCallbackReason.Keyboard)
        end
    end, { var8, var1.onChanged, var1.onTextChanged })

    local onClick = React.useCallback(function()
        if getBindableValue(isDisabled) then
            return
        end
        var39(getBindableValue(var17), OnChangeCallbackReason.Activate)
    end, { isDisabled, var17, var39 })

    local var11 = React.useCallback(function()
        if getBindableValue(var5) then
            return
        end
        var39(getBindableValue(var18), OnChangeCallbackReason.Activate)
    end, { var5, var18, var39 })

    local hasControls = var1.hasControls

    if hasControls then
        if controlsVariant == NumberInputControlsVariant.None then
            hasControls = false
        else
            hasControls = controlsVariant ~= NumberInputControlsVariant.Stacked
        end
    end

    local element = if hasControls then React.createElement(NumberInputControls, {
        variant = var1.variant,
        size = var1.size,
        increment = { isDisabled = isDisabled, onClick = onClick },
        decrement = { isDisabled = var5, onClick = var11 },
        testId = var1.testId
    }) else nil

    local var44 = React.useMemo(function(): UDim
        if hasControls then
            return UDim.new(0, controls.width + offset)
        end

        return UDim.new()
    end, {
        var2,
        controlsVariant,
        var2.Gap.XSmall,
        controls,
        offset,
        hasControls
    })

    local var45 = React.useCallback(function(_, vector2: Vector2)
        local value = var1.value
        var7.current = false
        if value then
            var6.current = {
                position = vector2.X,
                value = getBindableValue(value)
            }
        end
    end, { var1.value })

    local useCallback = React.useCallback
    local function func1(_, vector2: Vector2)
        if not var6.current then
            return
        end

        if Flags.FoundationNumberInputScrubEndedAlone then
            if not var7.current then
                var7.current = true
                if Flags.FoundationNumberInputScrubCallbackProps and var1.onScrubStarted then
                    var1.onScrubStarted()
                end
            end
        elseif Flags.FoundationNumberInputScrubCallbackProps and var1.onScrubStarted and not var7.current then
            var1.onScrubStarted()
            var7.current = true
        end

        local numberInputValueFromPositions = calculateNumberInputValueFromPositions(var6.current.value, var6.current.position, vector2.X, var1.step, var14)

        var39(numberInputValueFromPositions, OnChangeCallbackReason.Drag)
    end

    local step = var1.step
    local onScrubStarted = if Flags.FoundationNumberInputScrubCallbackProps then var1.onScrubStarted else nil
    local var46 = useCallback(func1, { var39, step, var21, onScrubStarted, var14 })

    local var47 = React.useCallback(function()
        if var6.current then
            var6.current = nil
            if Flags.FoundationNumberInputScrubCallbackProps and var1.onScrubEnded and var7.current then
                var1.onScrubEnded()
            end
        end
        var7.current = false
    end, { if Flags.FoundationNumberInputScrubCallbackProps then var1.onScrubEnded else nil })

    local color3 = nil
    local var48, var49

    if Flags.FoundationFixColorOnScrubbableNumberInput then
        local fgStyle = var3.container.fgStyle
        local bgStyle = var3.container.bgStyle
        if bgStyle and bgStyle.Color3 then
            color3 = bgStyle.Color3
        else
            color3 = var2.Color.Shift.Shift_100.Color3
        end

        if fgStyle and fgStyle.Transparency then
            var48 = fgStyle.Transparency
        else
            var48 = var2.Color.None.Transparency
        end

        if bgStyle and bgStyle.Transparency then
            var49 = bgStyle.Transparency
        else
            var49 = var2.Color.None.Transparency
        end
    else
        var48 = var2.Color.Shift.Shift_300.Transparency
        var49 = var2.Color.Shift.Shift_100.Transparency
    end

    local maximum = var1.maximum
    local bool1 = math.abs(maximum) < math.huge and math.abs(var1.minimum) < math.huge
    local var50 = nil
    local var51

    if Flags.FoundationNumberInputScrubbingUsesOffset then
        var51 = React.useMemo(function(): NumberSequence
            return NumberSequence.new({
                NumberSequenceKeypoint.new(0, var48),
                NumberSequenceKeypoint.new(0.499, var48),
                NumberSequenceKeypoint.new(0.5, var49),
                NumberSequenceKeypoint.new(1, var49)
            })
        end, { var48, var49 })

        var50 = React.useMemo(function()
            return mapBindable(var1.value, function(arg2): Vector2
                local var52

                if arg2 and bool1 then
                    local var53 = var15(arg2)
                    var52 = if var1.maximum == var1.minimum then 1 else (var53 - var1.minimum) / (var1.maximum - var1.minimum)
                else
                    var52 = 0
                end

                if var52 <= 0 then
                    return Vector2.new(-1, 0)
                elseif var52 >= 1 then
                    return Vector2.new(1, 0)
                end

                return Vector2.new(var52 - 0.5, 0)
            end)
        end, {
            var1.value,
            var15,
            var1.maximum,
            var1.minimum,
            bool1
        })
    else
        var51 = React.useMemo(function()
            return mapBindable(var1.value, function(arg2)
                local var52

                if arg2 and var1.maximum and var1.minimum then
                    local var53 = var15(arg2)
                    var52 = if var1.maximum == var1.minimum then 1 else (var53 - var1.minimum) / (var1.maximum - var1.minimum)
                else
                    var52 = 0
                end

                if var52 == 0 then
                    return NumberSequence.new(var49)
                elseif var52 == 1 then
                    return NumberSequence.new(var48)
                end

                if not (var52 > 0 or var52 < 1) then
                    return NumberSequence.new(var49)
                end

                local keypoints = { NumberSequenceKeypoint.new(0, var48), NumberSequenceKeypoint.new(var52, var48), NumberSequenceKeypoint.new(math.min(var52 + 0.001, 1), var49) }

                if var52 < 0.999 then
                    table.insert(keypoints, NumberSequenceKeypoint.new(1, var49))
                end

                return NumberSequence.new(keypoints)
            end)
        end, {
            var48,
            var49,
            var1.value,
            var15,
            var1.maximum,
            var1.minimum
        })
    end

    React.useEffect(function()
        if not (var8() or ReactIs.isBinding(var1.value)) then
            var23(var1.formatAsString(var21(var1.value)))
        end
    end, {
        var1.value,
        var1.formatAsString,
        var21,
        var8
    })
    return React.createElement(
        InputField,
        withCommonProps(var1, {
            width = width,
            ref = ref,
            hasError = hasError,
            label = var1.label,
            size = getInputTextSize(var1.size),
            isRequired = var1.isRequired,
            isDisabled = var1.isDisabled,
            hint = var1.hint,
            textBoxRef = textBoxRef,
            input = function(ref2)
                local var52 = hasControls and element

                local createElement = React.createElement
                local var53 = InternalTextInput

                local tbl3 = {
                    inputRef = var1.inputRef,
                    text = joinBindables({
                        text = text,
                        value = var1.value
                    }, function(arg2)
                        if var8() then
                            return arg2.text
                        end
                        return var1.formatAsString(var21(arg2.value))
                    end),
                    hasError = hasError,
                    variant = var1.variant,
                    size = var1.size,
                    Selectable = var1.Selectable,
                    NextSelectionUp = var1.NextSelectionUp,
                    NextSelectionDown = var1.NextSelectionDown,
                    NextSelectionLeft = var1.NextSelectionLeft,
                    NextSelectionRight = var1.NextSelectionRight,
                    horizontalPadding = {
                        left = var3.container.horizontalPadding,
                        right = var3.container.horizontalPadding,
                        innerLeft = if var27 and var27.X > 0 then UDim.new(0, var27.X) else nil
                    },
                    focusBehavior = arg1.focusBehavior,
                    onChanged = onChanged,
                    onFocusLost = onFocusLost,
                    onFocus = onFocus,
                    onDragStarted = if var13 then var45 else nil,
                    onDrag = if var13 then var46 else nil,
                    onDragEnded = if var13 then var47 else nil,
                    onReturnPressed = var1.onReturnPressed,
                    ref = ref2,
                    backgroundGradient = 0,
                    trailingElement = 0,
                    leadingElement = 0,
                    isDisabled = 0,
                    LayoutOrder = 0,
                    testId = 0
                }

                local element2

                if Flags.FoundationNumberInputScrubbingUsesOffset then
                    if var13 and bool1 then
                        element2 = React.createElement("UIGradient", { Color = ColorSequence.new(color3), Transparency = var51, Offset = var50 })
                    else
                        element2 = nil
                    end
                elseif var13 and var51 then
                    element2 = React.createElement("UIGradient", {
                        Color = if Flags.FoundationFixColorOnScrubbableNumberInput then ColorSequence.new(color3) else ColorSequence.new(var2.Color.Shift.Shift_300.Color3),
                        Transparency = var51,
                        Rotation = 0
                    })
                else
                    element2 = nil
                end

                tbl3.backgroundGradient = element2

                tbl3.trailingElement = if var1.trailingIcon then React.createElement(
                    View,
                    { tag = "row align-y-center size-0-full auto-x" },
                    React.createElement(Icon, { name = var1.trailingIcon, style = var3.icon.style, size = var3.icon.size })
                ) else nil

                tbl3.leadingElement = if var1.leadingIcon then React.createElement(
                    View,
                    { tag = "row align-y-center size-0-full auto-x" },
                    React.createElement(Icon, { name = var1.leadingIcon, style = var3.icon.style, size = var3.icon.size })
                ) else nil

                tbl3.isDisabled = var1.isDisabled
                tbl3.LayoutOrder = if var52 then 0 else nil
                tbl3.testId = `{var1.testId}--field`
                local element3 = createElement(var53, tbl3)
                local element4

                if var24 then
                    element4 = React.createElement(Text, {
                        tag = "text-align-x-left text-align-y-center content-muted",
                        fontStyle = var3.textBox.fontStyle,
                        Size = UDim2.new(1, -(var35.left.Offset + var35.right.Offset), 1, 0),
                        Position = UDim2.fromOffset(var35.left.Offset, 0),
                        Text = text:map(function(arg2): string
                            return `{if var1.prefix then var1.prefix .. " " else ""}<font transparency="1">{arg2}</font>{if var1.suffix then " " .. var1.suffix else ""}`
                        end),
                        RichText = true,
                        ClipsDescendants = true,
                        padding = padding,
                        testId = `{var1.testId}--units`
                    })
                else
                    element4 = nil
                end

                local inputField = React.createElement(View, { tag = "size-full-0 auto-y" }, { Input = element3, Units = element4 })

                return React.createElement(View, {
                    Size = UDim2.new(width.Scale - var44.Scale, width.Offset - var44.Offset, 0, 0),
                    tag = "row align-y-center auto-y",
                    layout = {
                        FillDirection = Enum.FillDirection.Horizontal,
                        Padding = UDim.new(0, offset),
                        SortOrder = Enum.SortOrder.LayoutOrder
                    }
                }, {
                    InputField = inputField,
                    Controls = if var52 then element else nil
                })
            end
        })
    )
end))
