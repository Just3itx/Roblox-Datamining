-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:50:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local Dash = require(FoundationParent.Dash)
local React = require(FoundationParent.React)

local Components = Foundation.Components
local InputLabel = require(Components.InputLabel)
local Text = require(Components.Text)
local _Types = require(Components.Types)
local View = require(Components.View)

local getStateLayerStyle = require(Components.Interactable.getStateLayerStyle)
local useSliderDirectionalInput = require(Components.InternalSlider.useSliderDirectionalInput)

local devAssert = require(Foundation.Utility.devAssert)
local getBindableValue = require(Foundation.Utility.getBindableValue)
local getDisabledStyle = require(Foundation.Utility.getDisabledStyle)
local mapBindable = require(Foundation.Utility.mapBindable)
local useLastInputMode = require(Foundation.Utility.Input.useLastInputMode)
local usePlugin = require(Foundation.Providers.Plugin.usePlugin)
local useStyleTags = require(Foundation.Providers.Style.useStyleTags)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local ControlState = require(Foundation.Enums.ControlState)

local InputLabelSize = require(Foundation.Enums.InputLabelSize)

local InputMode = require(Foundation.Utility.Input.InputMode)

local OnChangeCallbackReason = require(Foundation.Enums.OnChangeCallbackReason)

local StateLayerAffordance = require(Foundation.Enums.StateLayerAffordance)

local _Tokens = require(Foundation.Providers.Style.Tokens)
local calculateInputSliderValue = require(script.Parent.calculateInputSliderValue)
local formatInputSliderValue = require(script.Parent.formatInputSliderValue)
local snapInputSliderValue = require(script.Parent.snapInputSliderValue)
local useInputSliderFill = require(script.Parent.useInputSliderFill)

local tbl1 = {
    SelectionBehaviorLeft = Enum.SelectionBehavior.Stop,
    SelectionBehaviorRight = Enum.SelectionBehavior.Stop,
    SelectionBehaviorUp = Enum.SelectionBehavior.Stop,
    SelectionBehaviorDown = Enum.SelectionBehavior.Stop
}

local tbl2 = { sensitivity = 1, isDisabled = false, testId = "--foundation-input-slider" }

local function ScrubDragDetector(tbl3)
    if not tbl3.isPresent then
        return nil
    end

    return React.createElement("UIDragDetector", {
        DragStyle = Enum.UIDragDetectorDragStyle.Scriptable,
        SelectionModeDragSpeed = UDim2.new(),
        Enabled = tbl3.isEnabled,
        [React.Tag] = `data-testid={tbl3.testId}`,
        [React.Event.DragStart] = tbl3.onDragStart,
        [React.Event.DragContinue] = tbl3.onDragContinue,
        [React.Event.DragEnd] = tbl3.onDragEnd
    })
end

local function isSelectedState(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1 == ControlState.Selected or arg1 == ControlState.SelectedPressed
end

local function isHoveredState(arg1): boolean -- Luacid: Inlined by compiler; 6 call sites recovered
    return arg1 == ControlState.Hover or arg1 == ControlState.Pressed
end

local function isPointerOver(arg1, arg2): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return isHoveredState(arg1) or isHoveredState(arg2)
end

local function getFieldStateLayerStyle(arg1, arg2, bool1: boolean) -- Luacid: Inlined by compiler; 2 call sites recovered
    if bool1 then
        return getStateLayerStyle(arg1, nil, ControlState.Pressed)
    elseif isHoveredState(arg2) then
        return getStateLayerStyle(arg1, nil, arg2)
    end
    return nil
end

local function getContentStyles(arg1, bool1: boolean, isDisabled: boolean) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = if bool1 then arg1.Color.Content.Emphasis else arg1.Color.Content.Default
    local var2 = if bool1 then arg1.Color.Content.Default else arg1.Color.Content.Muted
    return getDisabledStyle(var1, isDisabled), getDisabledStyle(var2, isDisabled)
end

local function resolveSensitivity(sensitivity: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    local bool1 = sensitivity > 0
    devAssert(bool1, `InputSlider: sensitivity must be positive, got {sensitivity}.`)
    return if bool1 then sensitivity else 1
end

local function resolveStep(step: number?) -- Luacid: Inlined by compiler; 1 call site recovered
    if step == nil then
        return nil
    end
    local bool1 = step > 0
    devAssert(bool1, `InputSlider: step must be positive, got {step}.`)
    return if bool1 then step else nil
end

return React.memo(React.forwardRef(function(arg1, ref) -- name: InputSlider
    local var1 = withDefaults(arg1, tbl2)
    local var2 = useTokens()
    local var3 = usePlugin()
    local var4 = useLastInputMode()

    local range = var1.range
    local var5 = resolveStep(var1.step)
    local num1 = resolveSensitivity(var1.sensitivity)
    local isDisabled = var1.isDisabled

    local var6 = React.useRef(nil)
    local var7 = React.useRef(nil)
    local var8 = React.useRef(false)
    local var9 = React.useRef(0)
    local var10 = React.useRef(false)

    local interactable, var12 = React.useState(false)
    local isPresent, var14 = React.useState(false)
    local var15, var16 = React.useState(false)
    local var17, var18 = React.useState(false)
    local var19, onStateChanged = React.useState(ControlState.Initialize)
    local var21, var11 = React.useState(ControlState.Initialize)
    local var23, var24 = React.useBinding("")
    local bool1 = isSelectedState(var19)
    local var25 = interactable or isPresent or var17

    local getValue = React.useCallback(function(): number
        return math.clamp(getBindableValue(var1.value), range.Min, range.Max)
    end, { var1.value, range })

    local var27 = React.useCallback(function(num2: number, arg2)
        if num2 ~= getValue() then
            var1.onValueChanged(num2, arg2)
        end
    end, { var1.onValueChanged, getValue })

    local var28 = React.useCallback(function()
        local current = var6.current
        if current == nil or isDisabled then
            return
        end

        current:CaptureFocus()

        task.defer(function()
            if current.Parent ~= nil and current:IsFocused() then
                current.SelectionStart = 1
                current.CursorPosition = utf8.len(current.Text) + 1
            end
        end)
    end, { isDisabled })

    local onDragStart = React.useCallback(function(_, vector2: Vector2)
        if isDisabled then
            return
        end
        var16(true)
        var7.current = {
            pressX = vector2.X,
            originX = vector2.X,
            startValue = getValue(),
            hasStarted = false
        }
    end, { isDisabled, getValue })

    local onDragContinue = React.useCallback(function(_, vector2: Vector2)
        local current = var7.current
        if current == nil then
            return
        end

        if not current.hasStarted then
            if math.abs(vector2.X - current.pressX) < 3 then
                return
            end
            current.hasStarted = true
            current.originX = vector2.X

            var10.current = false
            var14(true)
            if var1.onDragStarted then
                var1.onDragStarted()
            end
        end

        var27(
            calculateInputSliderValue(current.startValue, vector2.X - current.originX, num1 * 0.25, var5, range),
            OnChangeCallbackReason.Drag
        )
    end, {
        var1.onDragStarted,
        var27,
        num1,
        var5,
        range
    })
    local onDragEnd = React.useCallback(function()
        var16(false)
        local current = var7.current
        var7.current = nil
        if current == nil then
            return
        end

        if current.hasStarted then
            var14(false)
            if var1.onDragEnded then
                var1.onDragEnded()
            end
        else
            var28()
        end
    end, { var1.onDragEnded, var28 })

    local var32 = React.useRef(var1.onDragEnded)
    var32.current = var1.onDragEnded

    local var33 = React.useCallback(function()
        local current = var7.current
        var7.current = nil
        if current == nil or not current.hasStarted then
            return
        end

        var14(false)
        if var32.current then
            var32.current()
        end
    end, {})

    React.useEffect(function()
        return function()
            local current = var7.current

            var7.current = nil
            if current ~= nil and current.hasStarted and var32.current then
                var32.current()
            end
        end
    end, {})

    local var34 = React.useCallback(function(arg2)
        local var34 = formatInputSliderValue(getValue())
        var8.current = false
        var24(var34)
        arg2.Text = var34
        var12(true)
    end, { getValue })

    local var35 = React.useCallback(function(arg2, bool2: boolean, arg3)
        var12(false)
        local bool3 = not (arg3 == nil) and arg3.KeyCode == Enum.KeyCode.Escape

        if var8.current or bool3 then
            var8.current = false
            return
        end

        local var35 = tonumber(arg2.Text)

        local bool4 = var35 ~= var35
        if var35 == nil or bool4 or arg2.Text == formatInputSliderValue(getValue()) then
            return
        end

        local var36 = snapInputSliderValue(var35, var5, range)

        if var36 ~= getValue() then
            var10.current = true
        end
        var27(var36, if bool2 then OnChangeCallbackReason.Keyboard else OnChangeCallbackReason.FocusLost)
    end, {
        getValue,
        var27,
        range,
        var5
    })

    local var36 = React.useCallback(function(arg2)
        var24(arg2.Text)
    end, {})

    local var37 = React.useCallback(function()
        local current = var6.current
        if current and current:IsFocused() then
            var8.current = true
            current:ReleaseFocus()
        end
    end, {})

    local var38 = React.useCallback(function()
        var9.current = getValue()
        var18(true)
    end, { getValue })

    local var39 = React.useCallback(function()
        var18(false)
    end, {})

    local onExit = React.useCallback(function()
        var27(var9.current, OnChangeCallbackReason.Keyboard)
        var18(false)
    end, { var27 })

    local var41 = React.useMemo(function()
        return {
            getValue = getValue,
            onStep = function(num2: number)
                if var5 == nil then
                    local var41 = getValue()
                    num2 = math.clamp(var41 + math.sign(num2 - var41) * 1, range.Min, range.Max)
                end
                var27(num2, OnChangeCallbackReason.Keyboard)
            end,
            onExit = onExit
        }
    end, {
        getValue,
        var27,
        onExit,
        var5,
        range
    })
    useSliderDirectionalInput(var17 and not isDisabled, var5 or 1, range, false, var41)

    React.useEffect(function()
        local bool2 = not (var4 == nil) and var4 ~= InputMode.Directional

        if var17 and (not bool1 or interactable or bool2) then
            var18(false)
        end
    end, {
        var17,
        bool1,
        interactable,
        var4
    })

    local onActivated = React.useCallback(function(_, arg2)
        local bool2 = arg2.KeyCode == Enum.KeyCode.Return or arg2.KeyCode == Enum.KeyCode.KeypadEnter
        if not bool2 and arg2.KeyCode ~= Enum.KeyCode.ButtonA then
            return
        end

        if var17 then
            var39()
        elseif bool2 then
            var28()
        else
            var38()
        end
    end, {
        var17,
        var39,
        var28,
        var38
    })
    React.useEffect(function()
        if isDisabled then
            var18(false)
            var37()
            var33()
        end
    end, { isDisabled, var33 })

    local var43 = not isDisabled and not interactable and (isPresent or isPointerOver(var19, var21))

    React.useEffect(function()
        if var3 == nil or not var43 then
            return
        end

        local mouse = var3:GetMouse()
        local icon = mouse.Icon
        mouse.Icon = "rbxasset://SystemCursors/SizeEW"
        return function()
            mouse.Icon = icon
        end
    end, { var3, var43 })

    local var44 = useInputSliderFill(var1.value, range, isDisabled, var10)

    local var45 = React.useMemo(function()
        if interactable then
            return var23
        end
        return mapBindable(var1.value, function(num2: number)
            return formatInputSliderValue(math.clamp(num2, range.Min, range.Max))
        end)
    end, {
        interactable,
        var23,
        var1.value,
        range
    })

    local var46, textStyle = getContentStyles(var2, var25, isDisabled)
    local backgroundStyle = if isDisabled or interactable or var17 then nil elseif isPresent then getFieldStateLayerStyle(var2, nil, true) else getFieldStateLayerStyle(var2, var19, false)
    local var48 = useStyleTags("text-body-small text-align-x-left text-align-y-center gui-object-defaults")

    local tbl3 = {
        isPresent = isPresent or var15 or var4 ~= InputMode.Directional,
        isEnabled = not interactable and (not isDisabled or var15),
        onDragStart = onDragStart,
        onDragContinue = onDragContinue,
        onDragEnd = onDragEnd
    }

    local createElement = React.createElement
    local var49 = View
    local var50 = withCommonProps
    local tbl4 = {
        Size = UDim2.new(var1.width or UDim.new(1, 0), UDim.new()),
        tag = "col gap-small auto-y",
        selectionGroup = if var17 then tbl1 else nil,
        ref = ref
    }
    local var51 = var50(var1, tbl4)

    local tbl5 = { Label = 0, Field = 0 }
    local element

    if var1.label and var1.label ~= "" then
        element = React.createElement(View, {
            tag = "auto-xy",
            onStateChanged = var11,
            stateLayer = {
                affordance = StateLayerAffordance.None
            },
            selection = { Selectable = false },
            isDisabled = isDisabled,
            LayoutOrder = 1,
            testId = `{var1.testId}--label`
        }, {
            Text = React.createElement(InputLabel, {
                Text = var1.label,
                size = InputLabelSize.XSmall,
                isDisabled = isDisabled,
                testId = `{var1.testId}--label-text`
            }),
            DragDetector = React.createElement(ScrubDragDetector, Dash.join(tbl3, { testId = `{var1.testId}--label--drag-detector` }))
        })
    else
        element = nil
    end

    tbl5.Label = element

    local createElement2 = React.createElement
    local var52 = View
    local tbl6 = {
        tag = {
            ["size-full-600 radius-small"] = true,
            ["stroke-standard stroke-position-inner stroke-system-emphasis"] = var25
        },
        stateLayer = {
            affordance = StateLayerAffordance.None
        },
        backgroundStyle = {
            Color3 = Color3.new(1, 1, 1),
            Transparency = 0.001
        },
        cursor = {
            radius = UDim.new(0, var2.Radius.Small),
            offset = var2.Stroke.Thick,
            borderWidth = var2.Stroke.Thick
        },
        onStateChanged = onStateChanged,
        onActivated = onActivated,
        isDisabled = isDisabled,
        LayoutOrder = 2,
        testId = `{var1.testId}--field`
    }
    local tbl7 = {
        Fill = React.createElement("UIGradient", {
            Color = var44.color,
            Transparency = var44.transparency,
            Offset = var44.offset,
            [React.Tag] = `data-testid={var1.testId}--fill`
        }),
        DragDetector = React.createElement(ScrubDragDetector, Dash.join(tbl3, { testId = `{var1.testId}--field--drag-detector` })),
        StateLayer = if backgroundStyle then React.createElement(View, {
            tag = "size-full radius-small",
            backgroundStyle = backgroundStyle,
            ZIndex = 2,
            testId = `{var1.testId}--state-layer`
        }) else nil,
        Content = 0
    }

    local createElement3 = React.createElement
    local var53 = View
    local tbl8 = { tag = "row align-y-center gap-xxsmall size-full padding-x-small", ZIndex = 3 }

    local tbl9 = {
        Value = React.createElement("TextBox", {
            Text = var45,
            ClearTextOnFocus = false,
            TextEditable = not isDisabled,
            Interactable = interactable,
            Selectable = false,
            AutomaticSize = Enum.AutomaticSize.X,
            Size = UDim2.fromScale(0, 1),
            TextColor3 = var46.Color3,
            TextTransparency = var46.Transparency,
            LayoutOrder = 1,
            ref = var6,
            [React.Tag] = `{var48} data-testid={var1.testId}--textbox`,
            [React.Event.Focused] = var34,
            [React.Event.FocusLost] = var35,
            [React.Change.Text] = var36
        }),
        Suffix = if var1.suffix then React.createElement(Text, {
            Text = var1.suffix,
            tag = "auto-xy text-body-small",
            textStyle = textStyle,
            LayoutOrder = 2,
            testId = `{var1.testId}--suffix`
        }) else nil
    }
    tbl7.Content = createElement3(var53, tbl8, tbl9)
    tbl5.Field = createElement2(var52, tbl6, tbl7)
    return createElement(var49, var51, tbl5)
end))
