-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:51:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = game:GetService("CorePackages").Packages._Index.Foundation.Foundation
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)
local ReactUtils = require(FoundationParent.ReactUtils)

local Components = Foundation.Components
local Icon = require(Components.Icon)
local Padding = require(Components.Padding)
local normalizeFontFace = require(Foundation.Utility.normalizeFontFace)
local ScrollView = require(Components.ScrollView)
local _Types = require(Components.Types)
local View = require(Components.View)

local Constants = require(Foundation.Constants)
local blendTransparencies = require(Foundation.Utility.blendTransparencies)
local getBindableValue = require(Foundation.Utility.getBindableValue)
local getDisabledStyle = require(Foundation.Utility.getDisabledStyle)
local getMultiLineTextHeight = require(Foundation.Utility.getMultiLineTextHeight)
local isPluginSecurity = require(Foundation.Utility.isPluginSecurity)
local mapBindable = require(Foundation.Utility.mapBindable)
local truncateTextToCursor = require(Foundation.Components.InternalTextInput.truncateTextToCursor)
local chatTextAreaDebug = require(script.Parent.chatTextAreaDebug)
local measureTextLineCount = require(script.Parent.measureTextLineCount)
local useComposerFocusLock = require(script.Parent.useComposerFocusLock)
local useComposerKeyboardConnections = require(script.Parent.useComposerKeyboardConnections)

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

local ControlState = require(Foundation.Enums.ControlState)
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

    local createElement = React.createElement
    local str1 = "TextBox"
    local tbl3 = {
        ClearTextOnFocus = false,
        Selectable = false,
        Active = not isBoundsChecker and nil,
        Visible = not isBoundsChecker and nil,
        FontFace = normalizeFontFace(tbl2.fontStyle.Font),
        TextSize = tbl2.fontStyle.FontSize,
        LineHeight = tbl2.fontStyle.LineHeight,
        TextColor3 = if tbl2.textStyle then tbl2.textStyle.Color3 else nil,
        TextTransparency = if tbl2.textStyle then tbl2.textStyle.Transparency else nil,
        MultiLine = var1,
        TextWrapped = var1,
        TextYAlignment = if var1 then Enum.TextYAlignment.Top else Enum.TextYAlignment.Center,
        TextEditable = not isBoundsChecker and not tbl2.isDisabled,
        PlaceholderText = tbl2.placeholder,
        TextInputType = if isPluginSecurity() then tbl2.textInputType else nil,
        ManualFocusRelease = if tbl2.manualFocusRelease then true else nil,
        ShouldEmitReturnEvents = if tbl2.shouldEmitReturnEvents then true else nil,
        OverlayNativeInput = if tbl2.overlayNativeInput then true else nil,
        Size = if tbl2.Size ~= nil then tbl2.Size else UDim2.fromScale(1, 1),
        AutomaticSize = tbl2.automaticSize,
        Text = if isBoundsChecker then nil elseif typeof(tbl2.text) == "string" then tbl2.text else tbl2.text,
        ref = ref,
        [React.Tag] = tbl2.tag,
        [React.Change.Text] = tbl2.onTextChanged,
        [React.Change.CursorPosition] = tbl2.onCursorPositionChanged,
        [React.Event.Focused] = tbl2.onFocusGained,
        [React.Event.FocusLost] = tbl2.onFocusLost,
        [React.Event.InputChanged] = tbl2.onInputChanged,
        [React.Event.InputEnded] = tbl2.onInputEnded
    }
    return createElement(
        str1,
        tbl3,
        tbl2.padding and {
            Padding = React.createElement(Padding, { value = tbl2.padding })
        } or nil,
        tbl2.children
    )
end))

return React.memo(React.forwardRef(function(arg1, arg2) -- name: InternalTextInput
    if arg1.Selectable == nil then
        arg1 = table.clone(arg1)
        arg1.Selectable = true
    end

    local var2 = withDefaults(arg1, tbl1)
    local var3 = useTokens()
    local ref = React.useRef(nil)
    local var5 = React.useRef(nil)
    local var4 = React.useRef(nil)
    local var7 = React.useRef(nil)
    local var8 = React.useRef("")
    local var9 = React.useRef(getBindableValue(var2.text))

    local var10 = React.useRef(nil)
    local var11 = React.useRef(Vector2.zero)
    local var12 = React.useRef(false)
    local var13 = React.useRef(0)
    local var14, setHover = React.useState(false)
    local var16, var17 = React.useState(false)

    local var18 = useTextInputVariants(var3, var2.size, var2.variant, var2.radius, var16, var2.hasError)
    local container = var18.container
    local offset = if var2.leadingElement ~= nil then var3.Gap.Small elseif var2.trailingElement == nil then nil else var3.Gap.XSmall
    local tag = if offset == nil and var2.trailingElement and typeof(container.tag) == "string" then string.gsub(container.tag, "gap%-large", "gap-xsmall") else container.tag
    local var20 = if var16 and var2.variant == InputVariant.Standard and not var2.hasError then var3.Color.Stroke.Default else container.strokeStyle
    local var21 = useStyleTags(var18.textBox.tag)

    local isDisabled = var2.isDisabled
    local var6 = var2.isDisabled and var2.trailingElement == nil

    local var23 = usePreferredInput()
    local var24, var25 = React.useState(false)
    local bool1 = var23 == Enum.PreferredInput.Touch

    local standard = var3.Stroke.Standard
    local num1 = math.ceil(standard) * 2
    local num2 = math.ceil(var3.Stroke.Thick) * 2

    useComposerFocusLock(isDisabled == true, { ref, var5 })

    local textStyle = getDisabledStyle(var3.Color.Content.Emphasis, isDisabled)
    local fontStyle = var18.textBox.fontStyle
    local fontSize = fontStyle.FontSize
    local lineHeight = fontStyle.LineHeight

    local singleLineHeight = getMultiLineTextHeight(fontSize, 1, lineHeight)
    local var26, var27 = React.useState(1)
    local var28, var29 = React.useState(singleLineHeight)
    local bool2 = var2.maxLines ~= nil
    local var30, var31 = React.useState(function()
        return getBindableValue(var2.text)
    end)

    React.useEffect(function()
        chatTextAreaDebug.setEnabled(var2.composerDebug == true)
        return function() end
    end, { var2.composerDebug })

    local var32 = React.useCallback(function()
        local current = ref.current or var5.current
        if current and current.AbsoluteSize.X > 0 then
            return current.AbsoluteSize.X
        end
        local current2 = var7.current
        return if current2 and current2.AbsoluteWindowSize.X > 0 then current2.AbsoluteWindowSize.X else 0
    end, {})

    local var33 = React.useCallback(function(text: string)
        local var33 = measureTextLineCount({
            text = text,
            maxLines = var2.maxLines,
            singleLineHeight = singleLineHeight,
            layoutWidth = var32(),
            font = normalizeFontFace(fontStyle.Font),
            fontSize = fontSize
        })
        local var34 = if var33.boundsY and var33.boundsY > 0 then math.ceil(var33.boundsY) else singleLineHeight
        var29(math.max(var34, var33.lineCount * singleLineHeight))
        return var33.lineCount
    end, {
        fontSize,
        lineHeight,
        fontStyle.Font,
        var2.maxLines,
        var32,
        singleLineHeight
    })

    local text = if bool2 then var2.text else getBindableValue(var2.text)

    if not var2.maxLines then
        var26 = math.max(1, var2.numLines)
    end

    local isMultiLine = if var2.alwaysMultiLine then true else var26 > 1

    React.useEffect(function()
        if not bool2 then
            return function() end
        end
        local bindableValue = getBindableValue(var2.text)
        var31(bindableValue)
        var27(var33(bindableValue))
        task.defer(function()
            var27(var33(bindableValue))
        end)

        if typeof(var2.text) ~= "table" or var2.text.getValue == nil then
            return function() end
        end

        return React.__subscribeToBinding(var2.text, function(current: string)
            if current == var9.current then
                return
            end

            chatTextAreaDebug.log("syncFromParent", `len={utf8.len(current) or #current}`)
            var9.current = current
            var31(current)
            var27(var33(current))
            task.defer(function()
                var27(var33(current))
            end)
        end)
    end, { var2.text, var33, bool2 })

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

    local var37 = React.useCallback(function()
        local current = ref.current or var5.current
        if current == nil or current.Parent == nil then
            return
        end

        local var37 = utf8.len(current.Text)
        if var37 then
            setSelectionStart(0)
            setCursorPosition(var37 + 1)
        end
    end, { setSelectionStart, setCursorPosition })

    local focus = React.useCallback(function()
        if ref.current == nil then
            return
        end

        ref.current:CaptureFocus()
        if var2.focusBehavior == InputFocusBehavior.Highlight then
            task.spawn(var37)
        end
    end, { var37, var2.focusBehavior })

    local releaseFocus = React.useCallback(function()
        if ref.current then
            ref.current:ReleaseFocus()
        end
        if var5.current then
            var5.current:ReleaseFocus()
        end
        var25(false)
        var17(false)
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
            setHover = setHover,
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
        if var12.current and text ~= "" or text == var9.current then
            return
        end

        var9.current = text

        if isMultiLine and var4.current then
            var4.current.Text = text
        end

        if bool2 then
            var31(text)
        end

        if var2.maxLines then
            var27(var33(text))
            task.defer(function()
                var27(var33(text))
            end)
        end

        var2.onChanged(text)
    end, {
        var2.onChanged,
        isMultiLine,
        var24,
        var2.maxLines,
        var33,
        bool2
    })

    local var45 = React.useRef(false)

    local onInputChanged = React.useCallback(function(_, arg3)
        if arg3.UserInputType == Enum.UserInputType.MouseMovement then
            var45.current = false
        end
    end, {})

    local var47 = React.useCallback(function(_, arg3)
        if not var45.current then
            return
        end

        var45.current = false

        if arg3.UserInputType ~= Enum.UserInputType.MouseButton1 then
            return
        end

        var37()
    end, { setSelectionStart, setCursorPosition, var37 })

    local var48 = React.useCallback(function(current: string)
        var9.current = current
        if bool2 then
            var31(current)
        end
        if var2.maxLines then
            var27(var33(current))
        end
        var2.onChanged(current)
    end, {
        var2.maxLines,
        var33,
        var2.onChanged,
        bool2
    })

    local bool4 = not (var2.onReturnPressed == nil) and not bool1

    local var49 = React.useCallback(function(_, str1: string)
        if var2.onReturnPressed == nil then
            return
        end

        local current = os.clock()
        if current - var13.current < 0.15 then
            chatTextAreaDebug.log("returnSubmit", `source={str1} skipped=debounced`)
            return
        end

        chatTextAreaDebug.log("returnSubmit", `source={str1}`)
        var13.current = current
        var12.current = true
        var2.onReturnPressed()

        task.delay(0.15, function()
            var12.current = false
        end)
    end, { var2.onReturnPressed })

    local onReturnPressed = React.useCallback(function(_: boolean, bool5: boolean)
        local current = ref.current
        if current == nil or current:IsFocused() ~= true then
            return
        end

        if not bool5 then
            var49(current, "UserInputService.InputBegan")
            return
        end

        local currentText = current.Text
        task.defer(function()
            if current.Parent == nil then
                return
            end

            local currentText2 = current.Text
            if currentText2 ~= currentText then
                chatTextAreaDebug.log("returnNewline", "source=UserInputService.InputBegan-shift engineInserted=true")

                var48(currentText2)
            end
        end)
    end, { var49, var48 })

    local var51 = useComposerKeyboardConnections({ enabled = bool4 == true, onReturnPressed = onReturnPressed })

    local connect = var51.connect
    local disconnect = var51.disconnect

    local onFocusGained = React.useCallback(function()
        if isDisabled then
            return
        end

        if isMultiLine and bool1 then
            if ref.current and ref.current.Parent then
                var8.current = ref.current.Text
            end
            var25(true)
        end

        var17(true)
        if var2.onFocus then
            var2.onFocus()
        end

        if bool4 then
            connect()
        end

        local focusBehavior = var2.focusBehavior
        if focusBehavior ~= InputFocusBehavior.Clear then
            if focusBehavior == InputFocusBehavior.Highlight then
                var45.current = true
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
        isDisabled,
        bool1,
        isMultiLine,
        var2.focusBehavior,
        bool4,
        connect
    })

    local onInputEnded = React.useCallback(function(arg3, arg4)
        var47(arg3, arg4)
    end, { var47 })

    local var54 = React.useCallback(function(arg3, bool5: boolean, arg4)
        chatTextAreaDebug.log("textBox.FocusLost", `enterPressed={bool5}`)

        if bool4 then
            disconnect()
        end

        var17(false)
        var45.current = false

        if isMultiLine then
            var25(false)
        end

        if var2.onFocusLost then
            var2.onFocusLost(arg4)
        end

        if bool5 and bool4 then
            var49(arg3, "TextBox.FocusLost")
        end
    end, {
        isMultiLine,
        var2.onFocusLost,
        bool4,
        var49,
        disconnect
    })

    local onStateChanged = React.useCallback(function(hover)
        setHover(hover == ControlState.Hover)
    end, {})

    local var56 = React.useCallback(function(arg3, vector2: Vector2)
        var10.current = vector2
        if var2.onDragStarted then
            var2.onDragStarted(arg3, vector2)
        end
    end, { var2.onDragStarted })

    local var57 = React.useCallback(function(arg3, vector2: Vector2)
        if var2.onDrag then
            var2.onDrag(arg3, vector2)
        end
    end, { var2.onDrag })

    local var58 = React.useCallback(function(arg3, vector2: Vector2)
        if var10.current == vector2 then
            focus()
        else
            releaseFocus()
            var17(false)
        end
        var10.current = nil
        if var2.onDragEnded then
            var2.onDragEnded(arg3, vector2)
        end
    end, { var2.onDragEnded, focus, releaseFocus })

    local multiLineTextHeight2 = if var2.maxLines then getMultiLineTextHeight(fontSize, var2.maxLines, lineHeight) else nil

    local yOffset = React.useMemo(function()
        if not var2.maxLines then
            return getMultiLineTextHeight(fontSize, var26, lineHeight)
        end

        return math.clamp(math.max(singleLineHeight, var28), singleLineHeight, multiLineTextHeight2)
    end, {
        var2.maxLines,
        singleLineHeight,
        var28,
        multiLineTextHeight2,
        fontSize,
        var26,
        lineHeight
    })

    local var59 = React.useMemo(function()
        local multiLineTextHeight3 = getMultiLineTextHeight(fontSize, 1, lineHeight)
        local var59 = multiLineTextHeight3 + math.round(math.round((container.minHeight - num1 - multiLineTextHeight3) * 2) / 2) + num1
        return UDim.new(0, math.ceil(var59 / 2))
    end, {
        container.minHeight,
        num1,
        fontSize,
        lineHeight
    })
    local var60 = React.useMemo(function()
        if var2.maxLines then
            return var59
        end
        if var2.radius ~= Radius.Circle then
            return nil
        end

        return UDim.new(0, math.ceil(container.minHeight / 2))
    end, {
        var2.maxLines,
        var59,
        container.minHeight,
        var2.radius
    })
    local cursor = React.useMemo(function()
        return {
            radius = var60 or UDim.new(0, container.radius),
            offset = var3.Stroke.Thick,
            borderWidth = var3.Stroke.Thick
        }
    end, { var3, container.radius, var60 })

    local var62, yOffset2 = React.useMemo(function()
        local num3 = math.round((container.minHeight - num1 - getMultiLineTextHeight(fontSize, 1, lineHeight)) * 2) / 2

        local top = UDim.new(0, math.floor(num3 / 2))
        local bottom = UDim.new(0, math.ceil(num3 / 2))
        local var64 = yOffset + math.round(num3) + num1

        return {
            top = top,
            bottom = bottom,
            left = UDim.new(0, 0),
            right = UDim.new(0, 0)
        }, var64
    end, {
        container.minHeight,
        num1,
        num2,
        fontSize,
        yOffset,
        lineHeight
    })

    local yOffset3 = var62.bottom.Offset + var62.top.Offset
    local bool5 = var2.textPaddingOnParent == true
    local padding = if bool5 then nil else var62
    local yOffset4 = if bool5 then yOffset else yOffset + yOffset3
    local bool6 = isMultiLine and not (var2.maxLines == nil) and not var24
    local var64 = if bool5 then var28 else var28 + yOffset3
    local yOffset5 = if bool6 then math.max(yOffset4, var64) else yOffset4
    local yOffset6 = if bool5 then yOffset5 + yOffset3 else yOffset5
    local uDim2 = UDim2.new(1, 0, 0, yOffset5)
    local uDim2_2 = UDim2.new(1, 0, 0, yOffset4)

    React.useEffect(function()
        if var2.maxLines then
            chatTextAreaDebug.log("layout", `lineCount={var26} borderFrameHeight={yOffset2}`)
        end
        return function() end
    end, { var26, yOffset2, var2.maxLines })

    local layout = React.useMemo(function(): {FillDirection: Enum.FillDirection, ItemLineAlignment: number}?
        if not isMultiLine then
            return nil
        end

        return {
            FillDirection = Enum.FillDirection.Vertical,
            ItemLineAlignment = if var2.maxLines ~= nil then Enum.ItemLineAlignment.Start else Enum.ItemLineAlignment.Center
        }
    end, { isMultiLine, var2.maxLines })

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

    local var67 = React.useCallback(function(arg3)
        local current = var7.current
        local current2 = var4.current
        if current == nil or current2 == nil then
            return
        end

        local var67 = arg3.TextSize * arg3.LineHeight
        local canvasPositionY = current.CanvasPosition.Y

        current2.Text = truncateTextToCursor(arg3)
        local textBoundsY = current2.TextBounds.Y

        local var68 = canvasPositionY - var62.top.Offset + var62.bottom.Offset

        local var69 = canvasPositionY + current.AbsoluteSize.Y - var62.top.Offset - var62.bottom.Offset

        if textBoundsY - var67 < var68 then
            current.CanvasPosition += Vector2.new(0, textBoundsY - var67 - var68)
        end

        if var69 < textBoundsY then
            current.CanvasPosition += Vector2.new(0, textBoundsY - var69)
        end
    end, { var62 })

    local var68 = React.useCallback(function(current)
        if current == nil then
            return
        end

        var7.current = current
        current.ClipsDescendants = true
        current.CanvasPosition = var11.current
    end, {})

    local var69 = React.useCallback(function(arg3)
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

    local var70 = React.useCallback(function(arg3)
        var11.current = arg3.CanvasPosition
    end, {})

    local dragDetector = React.useMemo(function()
        if not (var2.onDragStarted or var2.onDrag or var2.onDragEnded) then
            return nil
        end

        return React.createElement("UIDragDetector", {
            DragStyle = Enum.UIDragDetectorDragStyle.Scriptable,
            [React.Event.DragStart] = var56,
            [React.Event.DragContinue] = var57,
            [React.Event.DragEnd] = var58,
            Enabled = not (var16 or isDisabled)
        })
    end, {
        var56,
        var57,
        var58,
        var16,
        isDisabled,
        var2.onDragStarted,
        var2.onDrag,
        var2.onDragEnded
    })

    local var72 = useBindable(if var2.horizontalPadding then var2.horizontalPadding.left or UDim.new(0, 0) else UDim.new(0, 0))

    local var73 = useBindable(if var2.horizontalPadding then var2.horizontalPadding.right or UDim.new(0, 0) else UDim.new(0, 0))

    local var74 = React.useMemo(function()
        if var2.hasClearButton then
            return UDim2.fromOffset(0, (container.minHeight - var3.Stroke.Standard) / 2)
        end

        return nil
    end, { var2.hasClearButton, container.minHeight, var3.Stroke.Standard })

    local var15 = ReactUtils.useComposedRef(var5, var69)

    local createElement = React.createElement
    local var76 = View
    local var77 = withCommonProps
    local tbl2 = {
        Size = UDim2.new(1, 0, 0, yOffset2),
        selection = {
            Selectable = var2.Selectable and not isDisabled,
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
        onStateChanged = 0,
        isDisabled = 0,
        backgroundStyle = 0,
        stateLayer = 0,
        layout = 0,
        tag = 0,
        testId = 0
    }
    local tbl3

    if var20 and container.strokeThickness then
        tbl3 = {
            Color = var20.Color3,
            Transparency = if isDisabled then blendTransparencies(var20.Transparency, Constants.DISABLED_TRANSPARENCY) else var20.Transparency,
            Thickness = container.strokeThickness,
            BorderStrokePosition = if var16 or var14 then Enum.BorderStrokePosition.Center else Enum.BorderStrokePosition.Inner
        }
    else
        tbl3 = nil
    end

    tbl2.stroke = tbl3

    tbl2.cornerRadius = var60
    tbl2.padding = {
        left = var72:map(function(arg3)
            return UDim.new(0, standard) + arg3
        end),
        right = if var2.trailingElement == nil and var2.hasClearButton then UDim.new(0, standard) else var73:map(function(arg3)
            return UDim.new(0, standard) + arg3
        end),
        top = UDim.new(0, standard),
        bottom = UDim.new(0, standard)
    }
    tbl2.onActivated = if isDisabled then nil else focus
    tbl2.onStateChanged = onStateChanged
    tbl2.isDisabled = var6
    tbl2.backgroundStyle = if container.bgStyle then getDisabledStyle({
        Color3 = container.bgStyle.Color3,
        Transparency = if var2.backgroundGradient then 0 else container.bgStyle.Transparency
    }, var6) else nil

    tbl2.stateLayer = {
        affordance = StateLayerAffordance.None
    }
    tbl2.layout = offset ~= nil
        and {
            FillDirection = Enum.FillDirection.Horizontal,
            Padding = UDim.new(0, offset),
            SortOrder = Enum.SortOrder.LayoutOrder
        }
        or nil

    tbl2.tag = tag
    tbl2.testId = `{var2.testId}--outer-container`
    local var78 = var77(var2, tbl2)

    local tbl4 = {
        DragDetector = dragDetector,
        Background = var2.backgroundGradient,
        Leading = if var2.leadingElement then React.createElement(View, {
            GroupTransparency = if var6 then Constants.DISABLED_TRANSPARENCY else nil,
            LayoutOrder = 1,
            tag = "col align-y-bottom self-stretch size-0-full auto-x",
            testId = `{var2.testId}--leading`
        }, var2.leadingElement) else nil,
        TextBoxWrapper = 0,
        Clear = 0,
        Trailing = 0
    }

    local createElement2 = React.createElement
    local var79 = if isMultiLine then ScrollView else View
    local tbl5 = {
        LayoutOrder = 2,
        selection = { Selectable = false },
        scroll = scroll,
        layout = layout,
        onCanvasPositionChanged = 0,
        scrollingFrameRef = 0,
        tag = "fill size-full clip"
    }

    if not isMultiLine then
        var70 = nil
    end

    tbl5.onCanvasPositionChanged = var70
    if not isMultiLine then
        var68 = nil
    end

    tbl5.scrollingFrameRef = var68

    local tbl6 = { TextContent = 0 }
    local createElement3 = React.createElement
    local var80 = View
    local tbl7 = {
        Size = if bool6 then UDim2.new(1, 0, 0, yOffset6) else nil,
        tag = {
            ["fill size-full"] = not bool6
        },
        padding = if bool5 then var62 else nil,
        selection = { Selectable = false },
        onActivated = if isDisabled then nil else focus,
        stateLayer = {
            affordance = StateLayerAffordance.None
        }
    }
    local tbl8 = { TextBox = 0, MobileTextBox = 0 }
    local var81

    if var24 then
        var81 = nil
    else
        local createElement4 = React.createElement
        local var82 = var1
        local tbl9 = {
            text = text,
            placeholder = var2.placeholder,
            textInputType = var2.textInputType,
            fontStyle = fontStyle,
            textStyle = textStyle,
            isMultiLine = isMultiLine,
            isDisabled = isDisabled,
            ref = ref,
            tag = `{var21 or ""} data-testid={var2.testId}--textbox`,
            Size = 0,
            automaticSize = 0,
            padding = 0,
            onFocusGained = 0,
            onFocusLost = 0,
            onTextChanged = 0,
            onCursorPositionChanged = 0,
            onInputChanged = 0,
            onInputEnded = 0,
            manualFocusRelease = 0,
            shouldEmitReturnEvents = 0,
            overlayNativeInput = nil
        }

        if not isMultiLine then
            uDim2 = nil
        end

        tbl9.Size = uDim2
        tbl9.automaticSize = if var2.maxLines then nil elseif bool2 then if isMultiLine and not var24 and var30 ~= "" then Enum.AutomaticSize.Y else nil else mapBindable(var2.text, function(arg3): Enum.AutomaticSize?
            return if isMultiLine and not var24 and arg3 ~= "" then Enum.AutomaticSize.Y else nil
        end)
        tbl9.padding = padding
        tbl9.onFocusGained = onFocusGained
        tbl9.onFocusLost = if isMultiLine then if bool1 then nil else var54 else var54
        tbl9.onTextChanged = onTextChanged
        tbl9.onCursorPositionChanged = if isMultiLine then var67 else nil
        tbl9.onInputChanged = onInputChanged
        tbl9.onInputEnded = onInputEnded
        tbl9.manualFocusRelease = if bool1 then var2.manualFocusRelease else nil
        tbl9.shouldEmitReturnEvents = if bool1 and var2.manualFocusRelease == true then var2.alwaysMultiLine == true or nil else nil

        local tbl10 = {
            DragDetector = dragDetector,
            BoundsChecker = if isMultiLine then React.createElement(var1, {
                isBoundsChecker = true,
                fontStyle = fontStyle,
                textStyle = textStyle,
                Size = if bool5 then UDim2.fromScale(1, 1) else UDim2.new(1, 0, 1, yOffset3),
                ref = var4
            }) else nil
        }
        var81 = createElement4(var82, tbl9, tbl10)
    end

    tbl8.TextBox = var81
    local var82

    if isMultiLine and var24 then
        local createElement4 = React.createElement
        local var83 = var1
        local tbl9 = {
            text = text,
            placeholder = var2.placeholder,
            textInputType = var2.textInputType,
            fontStyle = fontStyle,
            textStyle = textStyle,
            isMultiLine = isMultiLine,
            isDisabled = isDisabled,
            padding = padding,
            ref = var15,
            tag = `{var21 or ""} data-testid={var2.testId}--mobile-textbox`,
            Size = uDim2_2,
            onFocusLost = 0,
            onTextChanged = 0,
            onCursorPositionChanged = 0,
            onInputEnded = 0,
            manualFocusRelease = 0,
            shouldEmitReturnEvents = 0,
            overlayNativeInput = nil
        }

        if not (isMultiLine and bool1) then
            var54 = nil
        end

        tbl9.onFocusLost = var54
        tbl9.onTextChanged = onTextChanged
        if not isMultiLine then
            var67 = nil
        end

        tbl9.onCursorPositionChanged = var67
        tbl9.onInputEnded = onInputEnded
        tbl9.manualFocusRelease = if bool1 then var2.manualFocusRelease else nil
        tbl9.shouldEmitReturnEvents = if bool1 and var2.manualFocusRelease == true then var2.alwaysMultiLine == true or nil else nil
        var82 = createElement4(var83, tbl9)
    else
        var82 = nil
    end

    tbl8.MobileTextBox = var82
    tbl6.TextContent = createElement3(var80, tbl7, tbl8)
    tbl4.TextBoxWrapper = createElement2(var79, tbl5, tbl6)
    local var83

    if var2.hasClearButton then
        local createElement4 = React.createElement
        local var84 = View

        local tbl9 = {
            isDisabled = isDisabled,
            GroupTransparency = if isDisabled then Constants.DISABLED_TRANSPARENCY else nil,
            LayoutOrder = 3,
            Visible = mapBindable(var2.text, function(arg3): boolean
                return arg3 ~= ""
            end),
            tag = var18.clearButton.tag
        }

        var83 = createElement4(var84, tbl9, {
            ClearButton = React.createElement(View, {
                onActivated = onActivated,
                padding = UDim.new(0, var18.clearButton.padding),
                Position = var74,
                stateLayer = {
                    affordance = StateLayerAffordance.None
                },
                tag = "anchor-center-left auto-xy",
                testId = `{var2.testId}--clear-button`
            }, {
                Icon = React.createElement(Icon, { name = var18.clearButton.icon })
            })
        })
    else
        var83 = nil
    end

    tbl4.Clear = var83
    local element2

    if var2.trailingElement then
        element2 = React.createElement(View, {
            GroupTransparency = if var6 then Constants.DISABLED_TRANSPARENCY else nil,
            LayoutOrder = 4,
            tag = {
                ["col align-y-bottom self-stretch size-0-full auto-x"] = var2.trailingAlignBottom == true,
                ["row align-y-center size-0-full auto-x"] = var2.trailingAlignBottom ~= true
            },
            testId = `{var2.testId}--trailing`
        }, var2.trailingElement)
    else
        element2 = nil
    end

    tbl4.Trailing = element2
    return createElement(var76, var78, tbl4)
end))
