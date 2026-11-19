-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:20:30Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)
local ReactUtils = require(FoundationParent.ReactUtils)

local Components = Foundation.Components
local Icon = require(Components.Icon)
local Padding = require(Components.Padding)
local ScrollView = require(Components.ScrollView)
local _Types = require(Components.Types)
local View = require(Components.View)

local Constants = require(Foundation.Constants)
local Flags = require(Foundation.Utility.Flags)
local blendTransparencies = require(Foundation.Utility.blendTransparencies)
local getBindableValue = require(Foundation.Utility.getBindableValue)
local getDisabledStyle = require(Foundation.Utility.getDisabledStyle)
local getMultiLineTextHeight = require(Foundation.Utility.getMultiLineTextHeight)
local isPluginSecurity = require(Foundation.Utility.isPluginSecurity)
local mapBindable = require(Foundation.Utility.mapBindable)
local normalizeFontFace = require(Foundation.Utility.normalizeFontFace)
local truncateTextToCursor = require(script.Parent.truncateTextToCursor)
local useBindable = require(Foundation.Utility.useBindable)
local usePreferredInput = require(Foundation.Utility.usePreferredInput)
local useStyleTags = require(Foundation.Providers.Style.useStyleTags)
local useTextInputVariants = require(Components.TextInput.useTextInputVariants)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local InputFocusBehavior = require(Foundation.Enums.InputFocusBehavior)

local InputSize = require(Foundation.Enums.InputSize)

local InputVariant = require(Foundation.Enums.InputVariant)

local Radius = require(Foundation.Enums.Radius)

local _ControlState = require(Foundation.Enums.ControlState)
local StateLayerAffordance = require(Foundation.Enums.StateLayerAffordance)

local tbl1 = {
    size = InputSize.Large,
    variant = InputVariant.Standard,
    numLines = 1,
    testId = "--foundation-internal-text-input",
    Selectable = true
}

local var1 = React.memo(React.forwardRef(function(tbl2, ref)
    local isBoundsChecker = tbl2.isBoundsChecker
    local var1 = tbl2.isMultiLine or isBoundsChecker

    return React.createElement(
        "TextBox",
        {
            ClearTextOnFocus = false,
            Selectable = false,
            Active = not isBoundsChecker and nil,
            Visible = not isBoundsChecker and nil,
            Font = if Flags.FoundationFontFaceMigration then nil else tbl2.fontStyle.Font,
            FontFace = if Flags.FoundationFontFaceMigration then normalizeFontFace(tbl2.fontStyle.Font) else nil,
            TextSize = tbl2.fontStyle.FontSize,
            LineHeight = tbl2.fontStyle.LineHeight,
            TextColor3 = if tbl2.textStyle then tbl2.textStyle.Color3 else nil,
            TextTransparency = if tbl2.textStyle then tbl2.textStyle.Transparency else nil,
            MultiLine = var1,
            TextWrapped = var1,
            TextYAlignment = if var1 then Enum.TextYAlignment.Top else Enum.TextYAlignment.Center,
            TextEditable = not isBoundsChecker and not tbl2.isDisabled,
            Interactable = tbl2.Interactable,
            PlaceholderText = tbl2.placeholder,
            TextInputType = if isPluginSecurity() then tbl2.textInputType else nil,
            Size = if tbl2.Size ~= nil then tbl2.Size else UDim2.fromScale(1, 1),
            AutomaticSize = tbl2.automaticSize,
            Text = if isBoundsChecker then nil else tbl2.text,
            ref = ref,
            [React.Tag] = tbl2.tag,
            [React.Change.Text] = tbl2.onTextChanged,
            [React.Change.CursorPosition] = tbl2.onCursorPositionChanged,
            [React.Event.Focused] = tbl2.onFocusGained,
            [React.Event.FocusLost] = tbl2.onFocusLost,
            [React.Event.InputChanged] = tbl2.onInputChanged,
            [React.Event.InputEnded] = tbl2.onInputEnded
        },
        tbl2.padding and {
            Padding = React.createElement(Padding, { value = tbl2.padding })
        } or nil,
        tbl2.children
    )
end))

return React.memo(React.forwardRef(function(arg1, arg2) -- name: InternalTextInput
    if arg1.Selectable == nil then
        arg1.Selectable = true
    end

    local var2 = withDefaults(arg1, tbl1)
    local var3 = useTokens()
    local num1 = math.max(1, var2.numLines)
    local isMultiLine = num1 > 1

    local ref = React.useRef(nil)
    local var5 = React.useRef(nil)
    local var4 = React.useRef(nil)
    local var7 = React.useRef(nil)
    local var8 = React.useRef("")
    local var9 = React.useRef(getBindableValue(var2.text))

    local var10 = React.useRef(nil)
    local var11 = React.useRef(Vector2.zero)

    local var12, var13 = React.useState(false)
    local var14, var15 = React.useBinding(false)
    local var16 = React.useCallback(function(bool2: boolean)
        var15(bool2)
        var13(bool2)
    end, {})

    local var17 = useTextInputVariants(var3, var2.size, var2.variant, var2.radius, var12, var2.hasError)
    local container = var17.container
    local var18 = useStyleTags(var17.textBox.tag)

    local var19 = usePreferredInput()
    local var20, var21 = React.useState(false)
    local bool2 = var19 == Enum.PreferredInput.Touch

    local standard = var3.Stroke.Standard
    local num2 = math.ceil(standard) * 2
    local num3 = math.ceil(var3.Stroke.Thick) * 2

    local textStyle = getDisabledStyle(var3.Color.Content.Emphasis, var2.isDisabled)
    local fontStyle = var17.textBox.fontStyle
    local fontSize = fontStyle.FontSize
    local lineHeight = fontStyle.LineHeight

    local setSelectionStart = React.useCallback(function(selectionStart)
        if ref.current then
            ref.current.SelectionStart = selectionStart
        end
        if var5.current then
            var5.current.SelectionStart = selectionStart
        end
    end, {})

    local setCursorPosition = React.useCallback(function(cursorPosition)
        if ref.current then
            ref.current.CursorPosition = cursorPosition
        end
        if var5.current then
            var5.current.CursorPosition = cursorPosition
        end
    end, {})

    local var24 = React.useCallback(function()
        local current = ref.current or var5.current
        if current == nil or current.Parent == nil then
            return
        end

        local var24 = utf8.len(current.Text)
        if var24 then
            setSelectionStart(0)
            setCursorPosition(var24 + 1)
        end
    end, { setSelectionStart, setCursorPosition })

    local focus = React.useCallback(function()
        if ref.current == nil then
            return
        end

        ref.current:CaptureFocus()
        if var2.focusBehavior == InputFocusBehavior.Highlight then
            task.spawn(var24)
        end
    end, { var24, var2.focusBehavior })

    local releaseFocus = React.useCallback(function()
        if ref.current then
            ref.current:ReleaseFocus()
        end
    end, {})

    local getIsFocused = React.useCallback(function()
        if ref.current then
            return (ref.current:IsFocused())
        end
        return nil
    end, {})

    local getSelectionStart = React.useCallback(function()
        return if ref.current then ref.current.SelectionStart else nil
    end, {})

    local getCursorPosition = React.useCallback(function()
        return if ref.current then ref.current.CursorPosition else nil
    end, {})

    local onActivated = React.useCallback(function()
        if ref.current then
            ref.current.Text = ""
        end
    end, {})

    React.useImperativeHandle(arg2, function()
        return {
            getIsFocused = getIsFocused,
            focus = focus,
            releaseFocus = releaseFocus,
            getSelectionStart = getSelectionStart,
            getCursorPosition = getCursorPosition,
            setCursorPosition = setCursorPosition,
            setSelectionStart = setSelectionStart
        }
    end, {
        getCursorPosition,
        getIsFocused,
        getSelectionStart,
        focus,
        releaseFocus,
        setCursorPosition,
        setSelectionStart
    })

    local onTextChanged = React.useCallback(function(arg3)
        if arg3 == nil or arg3.Parent == nil or var8.current ~= "" then
            return
        end

        local text = arg3.Text
        if text == var9.current then
            return
        end
        var9.current = text

        if isMultiLine and var4.current then
            var4.current.Text = text
        end

        var2.onChanged(text)
    end, { var2.onChanged, isMultiLine, var20 })

    local var32 = React.useRef(false)

    local onFocusGained = React.useCallback(function()
        if var2.isDisabled then
            return
        end

        if isMultiLine and bool2 then
            if ref.current and ref.current.Parent then
                var8.current = ref.current.Text
            end
            var21(true)
        end

        var16(true)
        if var2.onFocus then
            var2.onFocus()
        end
        local focusBehavior = var2.focusBehavior
        if focusBehavior ~= InputFocusBehavior.Clear then
            if focusBehavior == InputFocusBehavior.Highlight then
                var32.current = true
            end

            return
        end

        var8.current = ""
        if ref.current then
            ref.current.Text = ""
        end
        if var5.current then
            var5.current.Text = ""
        end
    end, {
        var2.onFocus,
        var2.isDisabled,
        bool2,
        isMultiLine,
        var2.focusBehavior
    })

    local onInputChanged = React.useCallback(function(_, arg3)
        if arg3.UserInputType == Enum.UserInputType.MouseMovement then
            var32.current = false
        end
    end, {})

    local onInputEnded = React.useCallback(function(_, arg3)
        if not var32.current then
            return
        end

        var32.current = false

        if arg3.UserInputType ~= Enum.UserInputType.MouseButton1 then
            return
        end

        var24()
    end, { setSelectionStart, setCursorPosition, var24 })

    local var36 = React.useCallback(function(_, bool3: boolean, arg3)
        var16(false)
        var32.current = false

        if isMultiLine then
            var21(false)
        end

        if var2.onFocusLost then
            var2.onFocusLost(arg3)
        end

        if bool3 and var2.onReturnPressed then
            var2.onReturnPressed()
        end
    end, { var2.onReturnPressed, isMultiLine, var2.onFocusLost })

    local var37 = React.useCallback(function(arg3, vector2: Vector2)
        var10.current = vector2
        if var2.onDragStarted then
            var2.onDragStarted(arg3, vector2)
        end
    end, { var2.onDragStarted })

    local var38 = React.useCallback(function(arg3, vector2: Vector2)
        if var2.onDrag then
            var2.onDrag(arg3, vector2)
        end
    end, { var2.onDrag })

    local var39 = React.useCallback(function(arg3, vector2: Vector2)
        if var10.current == vector2 then
            focus()
        else
            releaseFocus()
            var16(false)
        end
        var10.current = nil
        if var2.onDragEnded then
            var2.onDragEnded(arg3, vector2)
        end
    end, { var2.onDragEnded })

    local cursor = React.useMemo(function()
        return {
            radius = UDim.new(0, container.radius),
            offset = var3.Stroke.Thick,
            borderWidth = var3.Stroke.Thick
        }
    end, { var3, container.radius })

    local var41 = React.useMemo(function()
        return getMultiLineTextHeight(fontSize, num1, lineHeight)
    end, { fontSize, num1, lineHeight })

    local padding, yOffset = React.useMemo(function()
        local num4 = math.round((container.minHeight - num2 - getMultiLineTextHeight(fontSize, 1, lineHeight)) * 2) / 2

        local top = UDim.new(0, math.floor(num4 / 2))
        local bottom = UDim.new(0, math.ceil(num4 / 2))
        local var44 = var41 + math.round(num4) + num2

        return {
            top = top,
            bottom = bottom,
            left = UDim.new(0, 0),
            right = UDim.new(0, 0)
        }, var44
    end, {
        container.minHeight,
        num2,
        num3,
        fontSize,
        var41,
        lineHeight
    })

    local var6 = React.useMemo(function()
        return {
            left = if var2.horizontalPadding then var2.horizontalPadding.innerLeft else nil,
            right = if var2.horizontalPadding then var2.horizontalPadding.innerRight else nil
        }
    end, { var2.horizontalPadding })

    local yOffset2 = padding.bottom.Offset + padding.top.Offset
    local uDim2 = UDim2.new(1, 0, 0, var41 + yOffset2)

    local layout = React.useMemo(function()
        if isMultiLine then
            return {
                FillDirection = Enum.FillDirection.Vertical,
                ItemLineAlignment = Enum.ItemLineAlignment.Center
            }
        end

        return nil
    end, { isMultiLine })

    local scroll = React.useMemo(function()
        if not isMultiLine then
            return nil
        end

        return {
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            CanvasSize = UDim2.fromOffset(0, 0),
            ScrollingDirection = Enum.ScrollingDirection.Y,
            VerticalScrollBarInset = Enum.ScrollBarInset.Always
        }
    end, { isMultiLine })

    local var46 = React.useCallback(function(arg3)
        local current = var7.current
        local current2 = var4.current
        if current == nil or current2 == nil then
            return
        end

        local var46 = arg3.TextSize * arg3.LineHeight
        local canvasPositionY = current.CanvasPosition.Y

        current2.Text = truncateTextToCursor(arg3)
        local textBoundsY = current2.TextBounds.Y

        local var47 = canvasPositionY - padding.top.Offset + padding.bottom.Offset

        local var48 = canvasPositionY + current.AbsoluteSize.Y - padding.top.Offset - padding.bottom.Offset

        if textBoundsY - var46 < var47 then
            current.CanvasPosition += Vector2.new(0, textBoundsY - var46 - var47)
        end

        if var48 < textBoundsY then
            current.CanvasPosition += Vector2.new(0, textBoundsY - var48)
        end
    end, { padding })

    local var47 = React.useCallback(function(current)
        if current == nil then
            return
        end

        var7.current = current
        current.ClipsDescendants = true
        current.CanvasPosition = var11.current
    end, {})

    local var48 = React.useCallback(function(arg3)
        if not arg3 then
            return
        end

        arg3.Text = var8.current
        var8.current = ""
        task.delay(0, function()
            if arg3.Parent ~= nil then
                arg3:CaptureFocus()
            end
        end)
    end, {})

    local var49 = React.useCallback(function(arg3)
        var11.current = arg3.CanvasPosition
    end, {})

    local dragDetector = React.useMemo(function()
        if not (var2.onDragStarted or var2.onDrag or var2.onDragEnded) then
            return nil
        end

        return React.createElement("UIDragDetector", {
            DragStyle = Enum.UIDragDetectorDragStyle.Scriptable,
            [React.Event.DragStart] = var37,
            [React.Event.DragContinue] = var38,
            [React.Event.DragEnd] = var39,
            Enabled = not (var12 or var2.isDisabled)
        })
    end, {
        var37,
        var38,
        var39,
        var12,
        var2.isDisabled
    })

    local var51 = useBindable(if var2.horizontalPadding then var2.horizontalPadding.left or UDim.new(0, 0) else UDim.new(0, 0))

    local var52 = useBindable(if var2.horizontalPadding then var2.horizontalPadding.right or UDim.new(0, 0) else UDim.new(0, 0))

    local var53 = React.useMemo(function()
        if var2.hasClearButton then
            return UDim2.fromOffset(0, (container.minHeight - var3.Stroke.Standard) / 2)
        end

        return nil
    end, { var2.hasClearButton, container.minHeight, var3.Stroke.Standard })

    local var22 = ReactUtils.useComposedRef(var5, var48)

    local createElement = React.createElement
    local var55 = View
    local var56 = withCommonProps
    local tbl2 = {
        ref = var2.inputRef,
        Size = UDim2.new(1, 0, 0, yOffset),
        selection = {
            Selectable = var2.Selectable and not var2.isDisabled,
            NextSelectionUp = var2.NextSelectionUp,
            NextSelectionDown = var2.NextSelectionDown,
            NextSelectionLeft = var2.NextSelectionLeft,
            NextSelectionRight = var2.NextSelectionRight
        },
        cursor = cursor,
        stroke = 0,
        cornerRadius = 0,
        padding = 0,
        onActivated = 0,
        isDisabled = 0,
        backgroundStyle = 0,
        stateLayer = 0,
        tag = 0,
        testId = 0
    }
    local tbl3

    if container.strokeStyle and container.strokeThickness then
        tbl3 = {
            Color = container.strokeStyle.Color3,
            Transparency = if var2.isDisabled then blendTransparencies(container.strokeStyle.Transparency, Constants.DISABLED_TRANSPARENCY) else container.strokeStyle.Transparency,
            Thickness = container.strokeThickness,
            BorderStrokePosition = if var12 then Enum.BorderStrokePosition.Center else Enum.BorderStrokePosition.Inner
        }
    else
        tbl3 = nil
    end

    tbl2.stroke = tbl3

    tbl2.cornerRadius = if var2.radius == Radius.Circle then UDim.new(0, math.ceil(container.minHeight / 2)) else nil

    tbl2.padding = {
        left = var51:map(function(arg3)
            return UDim.new(0, standard) + arg3
        end),
        right = if var2.trailingElement == nil and var2.hasClearButton then UDim.new(0, standard) else var52:map(function(arg3)
            return UDim.new(0, standard) + arg3
        end),
        top = UDim.new(0, standard),
        bottom = UDim.new(0, standard)
    }
    tbl2.onActivated = if var2.isDisabled then nil else focus
    tbl2.isDisabled = var2.isDisabled
    local disabledStyle2

    if Flags.FoundationFixColorOnScrubbableNumberInput and var2.backgroundGradient then
        disabledStyle2 = getDisabledStyle({ Color3 = Color3.new(1, 1, 1), Transparency = 0.001 }, var2.isDisabled)
    elseif container.bgStyle then
        disabledStyle2 = getDisabledStyle({
            Color3 = container.bgStyle.Color3,
            Transparency = if not Flags.FoundationFixColorOnScrubbableNumberInput and var2.backgroundGradient then 0 else container.bgStyle.Transparency
        }, var2.isDisabled)
    else
        disabledStyle2 = nil
    end

    tbl2.backgroundStyle = disabledStyle2

    tbl2.stateLayer = {
        affordance = StateLayerAffordance.None
    }
    tbl2.tag = container.tag
    tbl2.testId = `{var2.testId}--outer-container`
    local var57 = var56(var2, tbl2)

    local tbl4 = {
        DragDetector = dragDetector,
        Background = var2.backgroundGradient,
        Leading = if var2.leadingElement then React.createElement(View, {
            GroupTransparency = if var2.isDisabled then Constants.DISABLED_TRANSPARENCY else nil,
            LayoutOrder = 1,
            tag = "size-0-full auto-x",
            testId = `{var2.testId}--leading`
        }, var2.leadingElement) else nil,
        TextBoxWrapper = 0,
        Clear = 0,
        Trailing = 0
    }

    local createElement2 = React.createElement
    local var58 = if isMultiLine then ScrollView else View
    local tbl5 = {
        LayoutOrder = 2,
        selection = { Selectable = false },
        scroll = scroll,
        layout = layout,
        onCanvasPositionChanged = 0,
        scrollingFrameRef = 0,
        padding = 0,
        tag = "fill size-full clip",
        testId = 0
    }

    if not isMultiLine then
        var49 = nil
    end

    tbl5.onCanvasPositionChanged = var49
    if not isMultiLine then
        var47 = nil
    end

    tbl5.scrollingFrameRef = var47
    tbl5.padding = var6

    tbl5.testId = `{var2.testId}--textbox-wrapper`
    local tbl6 = { TextBox = 0, MobileTextBox = 0 }
    local var59

    if var20 then
        var59 = nil
    else
        local createElement3 = React.createElement
        local var60 = var1

        local tbl7 = {
            text = var2.text,
            placeholder = var2.placeholder,
            textInputType = var2.textInputType,
            fontStyle = fontStyle,
            textStyle = textStyle,
            isMultiLine = isMultiLine,
            isDisabled = var2.isDisabled,
            ref = ref,
            tag = `{var18 or ""} data-testid={var2.testId}--textbox`,
            Interactable = if dragDetector == nil then nil else var14,
            Size = if isMultiLine then uDim2 else nil,
            automaticSize = mapBindable(var2.text, function(arg3): Enum.AutomaticSize?
                return if isMultiLine and not var20 and arg3 ~= "" then Enum.AutomaticSize.Y else nil
            end),
            padding = padding,
            onFocusGained = onFocusGained,
            onFocusLost = if isMultiLine then if bool2 then nil else var36 else var36,
            onTextChanged = onTextChanged,
            onCursorPositionChanged = if isMultiLine then var46 else nil,
            onInputChanged = onInputChanged,
            onInputEnded = onInputEnded
        }

        var59 = createElement3(var60, tbl7, {
            BoundsChecker = if isMultiLine then React.createElement(var1, {
                isBoundsChecker = true,
                fontStyle = fontStyle,
                textStyle = textStyle,
                Size = UDim2.new(1, 0, 1, yOffset2),
                ref = var4
            }) else nil
        })
    end

    tbl6.TextBox = var59
    local var60

    if isMultiLine and var20 then
        local createElement3 = React.createElement
        local var61 = var1
        local tbl7 = {
            text = var2.text,
            placeholder = var2.placeholder,
            textInputType = var2.textInputType,
            fontStyle = fontStyle,
            textStyle = textStyle,
            isMultiLine = isMultiLine,
            isDisabled = var2.isDisabled,
            padding = padding,
            ref = var22,
            tag = `{var18 or ""} data-testid={var2.testId}--mobile-textbox`,
            Interactable = 0,
            Size = 0,
            onFocusLost = 0,
            onTextChanged = 0,
            onCursorPositionChanged = 0
        }

        if dragDetector == nil then
            var14 = nil
        end

        tbl7.Interactable = var14
        tbl7.Size = uDim2
        if not (isMultiLine and bool2) then
            var36 = nil
        end

        tbl7.onFocusLost = var36
        tbl7.onTextChanged = onTextChanged
        if not isMultiLine then
            var46 = nil
        end

        tbl7.onCursorPositionChanged = var46
        var60 = createElement3(var61, tbl7)
    else
        var60 = nil
    end

    tbl6.MobileTextBox = var60
    tbl4.TextBoxWrapper = createElement2(var58, tbl5, tbl6)
    local var61

    if var2.hasClearButton then
        local createElement3 = React.createElement
        local var62 = View

        local tbl7 = {
            isDisabled = var2.isDisabled,
            GroupTransparency = if var2.isDisabled then Constants.DISABLED_TRANSPARENCY else nil,
            LayoutOrder = 3,
            Visible = mapBindable(var2.text, function(arg3): boolean
                return arg3 ~= ""
            end),
            tag = var17.clearButton.tag
        }

        var61 = createElement3(var62, tbl7, {
            ClearButton = React.createElement(View, {
                onActivated = onActivated,
                padding = UDim.new(0, var17.clearButton.padding),
                Position = var53,
                stateLayer = {
                    affordance = StateLayerAffordance.None
                },
                tag = "anchor-center-left auto-xy",
                testId = `{var2.testId}--clear-button`
            }, {
                Icon = React.createElement(Icon, { name = var17.clearButton.icon })
            })
        })
    else
        var61 = nil
    end

    tbl4.Clear = var61
    local element2 = if var2.trailingElement then React.createElement(View, {
        GroupTransparency = if var2.isDisabled then Constants.DISABLED_TRANSPARENCY else nil,
        LayoutOrder = 4,
        tag = "size-0-full auto-x",
        testId = `{var2.testId}--trailing`
    }, var2.trailingElement) else nil
    tbl4.Trailing = element2
    return createElement(var55, var57, tbl4)
end))
