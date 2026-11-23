-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:11:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = game:GetService("CorePackages").Packages._Index.Foundation.Foundation
local FoundationParent = Foundation.Parent
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent

local React = require(FoundationParent.React)
local ReactUtils = require(FoundationParent.ReactUtils)
local FFlagComposerFooter = require(AppBloxParent.SharedFlags).FFlagComposerFooter
local bool1 = game:DefineFastFlag("ComposerMultiLineCaretFix", false)
local bool2 = game:DefineFastFlag("ComposerDraftTextBindingSync", false)

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
local composerDebug = require(script.Parent.composerDebug)
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
        [React.Change.AbsoluteSize] = tbl2.onAbsoluteSizeChanged,
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
    local var4 = FFlagComposerFooter and var2.footerElement ~= nil
    local ref = React.useRef(nil)
    local var6 = React.useRef(nil)
    local var5 = React.useRef(nil)
    local var8 = React.useRef(nil)
    local var9 = React.useRef("")
    local var10 = React.useRef(getBindableValue(var2.text))

    local var11 = React.useRef(nil)
    local var12 = React.useRef(Vector2.zero)
    local var13 = React.useRef(false)
    local var14 = React.useRef(0)
    local var15, setHover = React.useState(false)
    local var17, var18 = React.useState(false)

    local var19 = useTextInputVariants(var3, var2.size, var2.variant, var2.radius, var17, var2.hasError)
    local container = var19.container
    local offset = if var2.leadingElement ~= nil then var3.Gap.Small elseif var2.trailingElement == nil then nil else var3.Gap.XSmall
    local tag = if offset == nil and var2.trailingElement and typeof(container.tag) == "string" then string.gsub(container.tag, "gap%-large", "gap-xsmall") else container.tag
    local var21 = if var17 and var2.variant == InputVariant.Standard and not var2.hasError then var3.Color.Stroke.Default else container.strokeStyle
    local var22 = useStyleTags(var19.textBox.tag)

    local isDisabled = var2.isDisabled
    local var23 = React.useRef(isDisabled)
    var23.current = isDisabled
    local isDisabled2 = var2.isDisabled

    if isDisabled2 then
        if var2.trailingElement == nil then
            isDisabled2 = not var4
        else
            isDisabled2 = false
        end
    end
    local var24 = usePreferredInput()
    local var25, var26 = React.useState(false)
    local bool3 = var24 == Enum.PreferredInput.Touch
    React.useEffect(function()
        if isDisabled then
            var26(false)
            var18(false)
        end
        return function() end
    end, { isDisabled })

    local standard = var3.Stroke.Standard
    local num1 = math.ceil(standard) * 2
    local num2 = math.ceil(var3.Stroke.Thick) * 2

    useComposerFocusLock(isDisabled == true, { ref, var6 })

    local textStyle = getDisabledStyle(var3.Color.Content.Emphasis, isDisabled)
    local fontStyle = var19.textBox.fontStyle
    local fontSize = fontStyle.FontSize
    local lineHeight = fontStyle.LineHeight

    local singleLineHeight = getMultiLineTextHeight(fontSize, 1, lineHeight)
    local var27, var28 = React.useState(1)
    local var29, var30 = React.useState(singleLineHeight)
    local bool4 = var2.maxLines ~= nil
    local var31, var32 = React.useState(function()
        return getBindableValue(var2.text)
    end)

    React.useEffect(function()
        composerDebug.setEnabled(var2.composerDebug == true)
        return function() end
    end, { var2.composerDebug })

    local var33 = React.useCallback(function()
        local current = ref.current or var6.current
        return if current and current.AbsoluteSize.X > 0 then current.AbsoluteSize.X else 0
    end, {})

    local var34 = React.useCallback(function(text: string)
        local var34 = measureTextLineCount({
            text = text,
            maxLines = var2.maxLines,
            singleLineHeight = singleLineHeight,
            layoutWidth = var33(),
            font = normalizeFontFace(fontStyle.Font),
            fontSize = fontSize
        })
        if bool1 then
            var30(getMultiLineTextHeight(fontSize, var34.unclampedLineCount, lineHeight))
        else
            local var35 = if var34.boundsY and var34.boundsY > 0 then math.ceil(var34.boundsY) else singleLineHeight
            var30(math.max(var35, var34.lineCount * singleLineHeight))
        end
        return var34.lineCount
    end, {
        fontSize,
        lineHeight,
        fontStyle.Font,
        var2.maxLines,
        var33,
        singleLineHeight
    })

    local text = if bool4 then var2.text else getBindableValue(var2.text)
    local num3 = math.max(1, math.floor(var2.minLines or 1))
    if var2.maxLines then
        num3 = math.min(num3, var2.maxLines)
    end

    local var36 = if var2.maxLines then math.max(num3, var27) else math.max(num3, var2.numLines)
    local isMultiLine = if var2.alwaysMultiLine then true else var36 > 1

    local var37 = isMultiLine and var25

    React.useEffect(function()
        if not bool4 then
            return function() end
        end
        local current = getBindableValue(var2.text)
        if current ~= var10.current then
            composerDebug.log("syncFromParent", `len={utf8.len(current) or #current}`)
            var10.current = current
            var32(current)
            var28(var34(current))
            task.defer(function()
                var28(var34(current))
            end)
        end
        return function() end
    end, { var2.text, var34, bool4 })

    local setSelectionStart = React.useCallback(function(selectionStart)
        if ref.current then
            ref.current.SelectionStart = selectionStart
        end
        if var6.current then
            var6.current.SelectionStart = selectionStart
        end
    end, {})

    local setCursorPosition = React.useCallback(function(cursorPosition)
        if ref.current then
            ref.current.CursorPosition = cursorPosition
        end
        if var6.current then
            var6.current.CursorPosition = cursorPosition
        end
    end, {})

    local var40 = React.useCallback(function()
        local current = ref.current or var6.current
        if current == nil or current.Parent == nil then
            return
        end

        local var40 = utf8.len(current.Text)
        if var40 then
            setSelectionStart(0)
            setCursorPosition(var40 + 1)
        end
    end, { setSelectionStart, setCursorPosition })

    local var41 = React.useCallback(function()
        if isMultiLine and bool3 and not var25 then
            if ref.current and ref.current.Parent then
                var9.current = ref.current.Text
            end
            var26(true)
            return
        end

        local current = ref.current or var6.current
        if current == nil then
            return
        end

        current:CaptureFocus()
        if var2.focusBehavior == InputFocusBehavior.Highlight then
            task.spawn(var40)
        end
    end, {
        var40,
        var2.focusBehavior,
        isMultiLine,
        bool3,
        var25
    })

    local releaseFocus = React.useCallback(function()
        if ref.current then
            ref.current:ReleaseFocus()
        end
        if var6.current then
            var6.current:ReleaseFocus()
        end
        var26(false)
        var18(false)
    end, {})

    local getIsFocused = React.useCallback(function()
        local current = ref.current or var6.current
        if current then
            return (current:IsFocused())
        end
        return nil
    end, {})

    local getSelectionStart = React.useCallback(function()
        local current = ref.current or var6.current
        return if current then current.SelectionStart else nil
    end, {})

    local getCursorPosition = React.useCallback(function()
        local current = ref.current or var6.current
        return if current then current.CursorPosition else nil
    end, {})

    local onActivated = React.useCallback(function()
        local current = ref.current or var6.current
        if current then
            current.Text = ""
        end
    end, {})

    React.useImperativeHandle(arg2, function()
        return {
            getIsFocused = getIsFocused,
            focus = var41,
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
        var41,
        releaseFocus,
        setCursorPosition,
        setSelectionStart
    })

    local onTextChanged = React.useCallback(function(arg3)
        if arg3 == nil or arg3.Parent == nil or var9.current ~= "" then
            return
        end

        if var23.current then
            local text = arg3.Text

            if bool2 and bool4 and text ~= "" and text ~= var10.current then
                var10.current = text
                var32(text)
                var28(var34(text))
            end

            return
        end

        local text = arg3.Text
        if var13.current and text ~= "" or text == var10.current then
            return
        end

        var10.current = text

        if isMultiLine and var5.current then
            var5.current.Text = text
        end

        if bool4 then
            var32(text)
        end

        if var2.maxLines then
            var28(var34(text))
            task.defer(function()
                var28(var34(text))
            end)
        end

        var2.onChanged(text)
    end, {
        var2.onChanged,
        isMultiLine,
        var2.maxLines,
        var34,
        bool4
    })
    local var48 = React.useRef(false)

    local onInputChanged = React.useCallback(function(_, arg3)
        if arg3.UserInputType == Enum.UserInputType.MouseMovement then
            var48.current = false
        end
    end, {})

    local var50 = React.useCallback(function(_, arg3)
        if not var48.current then
            return
        end

        var48.current = false

        if arg3.UserInputType ~= Enum.UserInputType.MouseButton1 then
            return
        end

        var40()
    end, { setSelectionStart, setCursorPosition, var40 })

    local var51 = React.useCallback(function(current: string)
        var10.current = current
        if bool4 then
            var32(current)
        end
        if var2.maxLines then
            var28(var34(current))
        end
        var2.onChanged(current)
    end, {
        var2.maxLines,
        var34,
        var2.onChanged,
        bool4
    })

    local bool6 = not (var2.onReturnPressed == nil) and not bool3

    local var52 = React.useCallback(function(_, str1: string)
        if var2.onReturnPressed == nil then
            return
        end

        local current = os.clock()
        if current - var14.current < 0.15 then
            composerDebug.log("returnSubmit", `source={str1} skipped=debounced`)
            return
        end

        composerDebug.log("returnSubmit", `source={str1}`)
        var14.current = current
        var13.current = true
        var2.onReturnPressed()

        task.delay(0.15, function()
            var13.current = false
        end)
    end, { var2.onReturnPressed })

    local onReturnPressed = React.useCallback(function(_: boolean, bool7: boolean)
        local current = ref.current
        if current == nil or current:IsFocused() ~= true then
            return
        end

        if not bool7 then
            var52(current, "UserInputService.InputBegan")
            return
        end

        local currentText = current.Text
        task.defer(function()
            if current.Parent == nil then
                return
            end

            local currentText2 = current.Text
            if currentText2 ~= currentText then
                composerDebug.log("returnNewline", "source=UserInputService.InputBegan-shift engineInserted=true")
                var51(currentText2)
            end
        end)
    end, { var52, var51 })

    local var54 = useComposerKeyboardConnections({ enabled = bool6 == true, onReturnPressed = onReturnPressed })

    local connect = var54.connect
    local disconnect = var54.disconnect

    local onFocusGained = React.useCallback(function()
        if isDisabled then
            return
        end

        var18(true)
        if var2.onFocus then
            var2.onFocus()
        end

        if bool6 then
            connect()
        end

        local focusBehavior = var2.focusBehavior
        if focusBehavior ~= InputFocusBehavior.Clear then
            if focusBehavior == InputFocusBehavior.Highlight then
                var48.current = true
            end

            return
        end

        if ref.current then
            ref.current.Text = ""
        end
        if var6.current then
            var6.current.Text = ""
        end
    end, {
        var2.onFocus,
        isDisabled,
        var2.focusBehavior,
        bool6,
        connect
    })

    local onInputEnded = React.useCallback(function(arg3, arg4)
        var50(arg3, arg4)
    end, { var50 })

    local var57 = React.useCallback(function(arg3, bool7: boolean, arg4)
        composerDebug.log("textBox.FocusLost", `enterPressed={bool7}`)

        if bool6 then
            disconnect()
        end

        var18(false)
        var48.current = false

        if isMultiLine then
            var26(false)
        end

        if var2.onFocusLost then
            var2.onFocusLost(arg4)
        end

        if bool7 and bool6 then
            var52(arg3, "TextBox.FocusLost")
        end
    end, {
        isMultiLine,
        var2.onFocusLost,
        bool6,
        var52,
        disconnect
    })

    local onStateChanged = React.useCallback(function(hover)
        setHover(hover == ControlState.Hover)
    end, {})

    local var59 = React.useCallback(function(arg3, vector2: Vector2)
        var11.current = vector2
        if var2.onDragStarted then
            var2.onDragStarted(arg3, vector2)
        end
    end, { var2.onDragStarted })

    local var60 = React.useCallback(function(arg3, vector2: Vector2)
        if var2.onDrag then
            var2.onDrag(arg3, vector2)
        end
    end, { var2.onDrag })

    local var61 = React.useCallback(function(arg3, vector2: Vector2)
        if var11.current == vector2 then
            var41()
        else
            releaseFocus()
            var18(false)
        end
        var11.current = nil
        if var2.onDragEnded then
            var2.onDragEnded(arg3, vector2)
        end
    end, { var2.onDragEnded, var41, releaseFocus })

    local multiLineTextHeight2 = if var2.maxLines then getMultiLineTextHeight(fontSize, var2.maxLines, lineHeight) else nil
    local multiLineTextHeight3 = getMultiLineTextHeight(fontSize, num3, lineHeight)
    local yOffset = React.useMemo(function()
        if not var2.maxLines then
            return getMultiLineTextHeight(fontSize, var36, lineHeight)
        end

        return math.clamp(math.max(multiLineTextHeight3, var29), multiLineTextHeight3, multiLineTextHeight2)
    end, {
        var2.maxLines,
        multiLineTextHeight3,
        var29,
        multiLineTextHeight2,
        fontSize,
        var36,
        lineHeight
    })

    local var62 = React.useMemo(function()
        local multiLineTextHeight4 = getMultiLineTextHeight(fontSize, 1, lineHeight)
        local var62 = multiLineTextHeight4 + math.round(math.round((container.minHeight - num1 - multiLineTextHeight4) * 2) / 2) + num1
        return UDim.new(0, math.ceil(var62 / 2))
    end, {
        container.minHeight,
        num1,
        fontSize,
        lineHeight
    })
    local radius = React.useMemo(function()
        if var2.maxLines then
            return var62
        end
        if var2.radius ~= Radius.Circle then
            return nil
        end

        return UDim.new(0, math.ceil(container.minHeight / 2))
    end, {
        var2.maxLines,
        var62,
        container.minHeight,
        var2.radius
    })
    local cursor = React.useMemo(function()
        return {
            radius = radius or UDim.new(0, container.radius),
            offset = var3.Stroke.Thick,
            borderWidth = var3.Stroke.Thick
        }
    end, { var3, container.radius, radius })

    local useMemo = React.useMemo
    local function func1()
        local num4 = math.round((container.minHeight - num1 - getMultiLineTextHeight(fontSize, 1, lineHeight)) * 2) / 2

        local var65 = UDim.new(0, math.floor(num4 / 2))
        local var66 = UDim.new(0, math.ceil(num4 / 2))
        if FFlagComposerFooter and var4 then
            local offset2 = math.min(var3.Size.Size_100, var66.Offset)
            var65 += UDim.new(0, offset2)
            var66 -= UDim.new(0, offset2)
        end
        local var67 = yOffset + math.round(num4)
        local var68 = var67 + num1

        return {
            top = var65,
            bottom = var66,
            left = UDim.new(0, 0),
            right = UDim.new(0, 0)
        }, var68, var67
    end

    local minHeight = container.minHeight
    local var65 = if FFlagComposerFooter then var4 else nil
    local var66 = if FFlagComposerFooter then var3 else nil
    local var67, yOffset2, yOffset3 = useMemo(func1, { minHeight, num1, num2, fontSize, yOffset, lineHeight, var65, var66 })

    local yOffset4 = var67.bottom.Offset + var67.top.Offset
    local bool7 = isMultiLine and not (var2.maxLines == nil) and not var25
    local bool8 = var2.textPaddingOnParent == true
    local bool9 = bool8 and bool7
    local bool10 = bool8 and not bool9
    local padding = if bool8 then nil else var67
    local yOffset5 = if bool8 then yOffset else yOffset + yOffset4
    local var69 = if bool8 then var29 else var29 + yOffset4
    local yOffset6 = if bool7 then math.max(yOffset5, var69) else yOffset5
    local yOffset7 = if bool10 then yOffset6 + yOffset4 else yOffset6
    local uDim2 = UDim2.new(1, 0, 0, yOffset6)
    local uDim2_2 = UDim2.new(1, 0, 0, yOffset5)

    React.useEffect(function()
        if var2.maxLines then
            composerDebug.log("layout", `lineCount={var36} borderFrameHeight={yOffset2}`)
        end
        return function() end
    end, { var36, yOffset2, var2.maxLines })

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

    local var72 = React.useCallback(function(arg3)
        local current = var8.current
        local current2 = var5.current
        if current == nil or current2 == nil then
            return
        end

        local var72 = arg3.TextSize * arg3.LineHeight
        local canvasPositionY = current.CanvasPosition.Y

        current2.Text = truncateTextToCursor(arg3)
        local textBoundsY = current2.TextBounds.Y

        local var73 = canvasPositionY - var67.top.Offset + var67.bottom.Offset

        local var74 = canvasPositionY + current.AbsoluteSize.Y - var67.top.Offset - var67.bottom.Offset

        if textBoundsY - var72 < var73 then
            current.CanvasPosition += Vector2.new(0, textBoundsY - var72 - var73)
        end

        if var74 < textBoundsY then
            current.CanvasPosition += Vector2.new(0, textBoundsY - var74)
        end
    end, { var67 })

    local var73 = if bool1 then React.useCallback(function(arg3)
        if not arg3:IsFocused() then
            return
        end

        arg3.CursorPosition = arg3.CursorPosition
        var72(arg3)
    end, { var72 }) else nil

    local var74 = React.useCallback(function(current)
        if current == nil then
            return
        end

        var8.current = current
        current.ClipsDescendants = true
        current.CanvasPosition = var12.current
    end, {})

    local var75 = React.useCallback(function(arg3)
        if not arg3 then
            return
        end

        arg3.Text = var9.current
        var9.current = ""
        task.delay(0, function()
            if arg3.Parent ~= nil then
                arg3:CaptureFocus()
            end
        end)
    end, {})

    local var76 = React.useCallback(function(arg3)
        var12.current = arg3.CanvasPosition
    end, {})

    local dragDetector = React.useMemo(function()
        if not (var2.onDragStarted or var2.onDrag or var2.onDragEnded) then
            return nil
        end

        return React.createElement("UIDragDetector", {
            DragStyle = Enum.UIDragDetectorDragStyle.Scriptable,
            [React.Event.DragStart] = var59,
            [React.Event.DragContinue] = var60,
            [React.Event.DragEnd] = var61,
            Enabled = not (var17 or isDisabled)
        })
    end, {
        var59,
        var60,
        var61,
        var17,
        isDisabled,
        var2.onDragStarted,
        var2.onDrag,
        var2.onDragEnded
    })

    local left = useBindable(if var2.horizontalPadding then var2.horizontalPadding.left or UDim.new(0, 0) else UDim.new(0, 0))

    local var79 = useBindable(if var2.horizontalPadding then var2.horizontalPadding.right or UDim.new(0, 0) else UDim.new(0, 0))

    local var80 = React.useMemo(function()
        if var2.hasClearButton then
            return UDim2.fromOffset(0, (container.minHeight - var3.Stroke.Standard) / 2)
        end

        return nil
    end, { var2.hasClearButton, container.minHeight, var3.Stroke.Standard })

    local var7 = ReactUtils.useComposedRef(var6, var75)

    local var16 = offset ~= nil
        and {
            FillDirection = Enum.FillDirection.Horizontal,
            Padding = UDim.new(0, offset),
            SortOrder = Enum.SortOrder.LayoutOrder
        }
        or nil

    local createElement = React.createElement
    local var83 = View
    local var84 = withCommonProps
    local tbl2 = {
        Size = UDim2.new(1, 0, 0, yOffset2),
        AutomaticSize = if FFlagComposerFooter then Enum.AutomaticSize.Y else nil,
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

    if var21 and container.strokeThickness then
        tbl3 = {
            Color = var21.Color3,
            Transparency = if isDisabled then blendTransparencies(var21.Transparency, Constants.DISABLED_TRANSPARENCY) else var21.Transparency,
            Thickness = container.strokeThickness,
            BorderStrokePosition = if var17 or var15 then Enum.BorderStrokePosition.Center else Enum.BorderStrokePosition.Inner
        }
    else
        tbl3 = nil
    end

    tbl2.stroke = tbl3
    local var85 = if FFlagComposerFooter and not radius then UDim.new(0, if var2.radius then var3.Radius[var2.radius] else container.radius) else radius
    tbl2.cornerRadius = var85
    local tbl4

    if FFlagComposerFooter then
        tbl4 = {
            left = UDim.new(0, standard),
            right = UDim.new(0, standard),
            top = UDim.new(0, standard),
            bottom = UDim.new(0, standard)
        }
    else
        tbl4 = {
            left = left:map(function(arg3)
                return UDim.new(0, standard) + arg3
            end),
            right = if var2.trailingElement == nil and var2.hasClearButton then UDim.new(0, standard) else var79:map(function(arg3)
                return UDim.new(0, standard) + arg3
            end),
            top = UDim.new(0, standard),
            bottom = UDim.new(0, standard)
        }
    end

    tbl2.padding = tbl4

    tbl2.onActivated = if isDisabled then nil else var41
    tbl2.onStateChanged = onStateChanged
    tbl2.isDisabled = isDisabled2
    tbl2.backgroundStyle = if container.bgStyle then getDisabledStyle({
        Color3 = container.bgStyle.Color3,
        Transparency = if var2.backgroundGradient then 0 else container.bgStyle.Transparency
    }, isDisabled2) else nil

    tbl2.stateLayer = {
        affordance = StateLayerAffordance.None
    }
    tbl2.layout = FFlagComposerFooter and {
        FillDirection = Enum.FillDirection.Vertical,
        SortOrder = Enum.SortOrder.LayoutOrder
    }
        or var16

    tbl2.tag = if FFlagComposerFooter then "col" else tag
    tbl2.testId = `{var2.testId}--outer-container`
    local var86 = var84(var2, tbl2)

    local tbl5 = {
        DragDetector = dragDetector,
        Background = var2.backgroundGradient,
        InputRow = 0,
        Footer = 0
    }
    local createElement2 = React.createElement
    local var87 = if FFlagComposerFooter then View else React.Fragment
    local tbl6

    if FFlagComposerFooter then
        tbl6 = {
            LayoutOrder = 1,
            Size = UDim2.new(1, 0, 0, yOffset3),
            layout = var16,
            padding = 0,
            tag = 0,
            testId = 0
        }
        local tbl7 = { left = left, right = 0 }
        if var2.trailingElement == nil and var2.hasClearButton then
            var79 = UDim.new(0, 0)
        end

        tbl7.right = var79
        tbl6.padding = tbl7

        tbl6.tag = tag
        tbl6.testId = `{var2.testId}--input-row`
    else
        tbl6 = nil
    end

    local tbl7 = {
        Leading = if var2.leadingElement then React.createElement(View, {
            GroupTransparency = if isDisabled2 then Constants.DISABLED_TRANSPARENCY else nil,
            LayoutOrder = 1,
            tag = "col align-y-bottom self-stretch size-0-full auto-x",
            testId = `{var2.testId}--leading`
        }, var2.leadingElement) else nil,
        TextBoxWrapper = 0,
        Clear = 0,
        Trailing = 0
    }

    local createElement3 = React.createElement
    local var88 = if isMultiLine then ScrollView else View
    local tbl8 = {
        LayoutOrder = 2,
        testId = if FFlagComposerFooter then `{var2.testId}--viewport` else nil,
        padding = if bool9 then var67 else nil,
        selection = { Selectable = false },
        scroll = scroll,
        layout = layout,
        onCanvasPositionChanged = 0,
        scrollingFrameRef = 0,
        tag = "fill size-full clip"
    }

    if not isMultiLine then
        var76 = nil
    end

    tbl8.onCanvasPositionChanged = var76
    if not isMultiLine then
        var74 = nil
    end

    tbl8.scrollingFrameRef = var74

    local tbl9 = { TextContent = 0 }
    local createElement4 = React.createElement
    local var89 = View
    local tbl10 = {
        Size = if bool7 then UDim2.new(1, 0, 0, yOffset7) else nil,
        tag = {
            ["fill size-full"] = not bool7
        },
        padding = if bool10 then var67 else nil,
        selection = { Selectable = false },
        onActivated = if isDisabled then nil else var41,
        stateLayer = {
            affordance = StateLayerAffordance.None
        }
    }
    local tbl11 = { TextBox = 0, MobileFocusTarget = 0, MobileTextBox = 0 }
    local var90

    if var25 then
        var90 = nil
    else
        local createElement5 = React.createElement
        local var91 = var1
        local tbl12 = {
            text = text,
            placeholder = var2.placeholder,
            textInputType = var2.textInputType,
            fontStyle = fontStyle,
            textStyle = textStyle,
            isMultiLine = isMultiLine,
            isDisabled = isDisabled,
            ref = ref,
            tag = `{var22 or ""} data-testid={var2.testId}--textbox`,
            Size = 0,
            automaticSize = 0,
            padding = 0,
            onFocusGained = 0,
            onFocusLost = 0,
            onTextChanged = 0,
            onCursorPositionChanged = 0,
            onAbsoluteSizeChanged = 0,
            onInputChanged = 0,
            onInputEnded = 0,
            manualFocusRelease = 0,
            shouldEmitReturnEvents = 0,
            overlayNativeInput = nil
        }

        if not isMultiLine then
            uDim2 = nil
        end

        tbl12.Size = uDim2
        tbl12.automaticSize = if var2.maxLines then nil elseif bool4 then if isMultiLine and not var25 and var31 ~= "" then Enum.AutomaticSize.Y else nil else mapBindable(var2.text, function(arg3): Enum.AutomaticSize?
            return if isMultiLine and not var25 and arg3 ~= "" then Enum.AutomaticSize.Y else nil
        end)
        tbl12.padding = padding
        tbl12.onFocusGained = onFocusGained
        tbl12.onFocusLost = if isMultiLine then if bool3 then nil else var57 else var57
        tbl12.onTextChanged = onTextChanged
        tbl12.onCursorPositionChanged = if isMultiLine then var72 else nil
        if not (bool1 and isMultiLine) then
            var73 = nil
        end

        tbl12.onAbsoluteSizeChanged = var73

        tbl12.onInputChanged = onInputChanged
        tbl12.onInputEnded = onInputEnded
        tbl12.manualFocusRelease = if bool3 then var2.manualFocusRelease else nil

        tbl12.shouldEmitReturnEvents = if bool3 and var2.manualFocusRelease == true then var2.alwaysMultiLine == true or nil else nil

        local tbl13 = {
            DragDetector = dragDetector,
            BoundsChecker = if isMultiLine then React.createElement(var1, {
                isBoundsChecker = true,
                fontStyle = fontStyle,
                textStyle = textStyle,
                Size = if bool8 then UDim2.fromScale(1, 1) else UDim2.new(1, 0, 1, yOffset4),
                ref = var5
            }) else nil
        }
        var90 = createElement5(var91, tbl12, tbl13)
    end

    tbl11.TextBox = var90

    tbl11.MobileFocusTarget = if isMultiLine and bool3 and not (var25 or isDisabled) then React.createElement(View, {
        onActivated = var41,
        selection = { Selectable = false },
        stateLayer = {
            affordance = StateLayerAffordance.None
        },
        tag = "size-full",
        testId = `{var2.testId}--mobile-focus-target`,
        ZIndex = 2
    }) else nil
    local var91

    if var37 then
        local createElement5 = React.createElement
        local var92 = var1
        local tbl12 = {
            text = text,
            placeholder = var2.placeholder,
            textInputType = var2.textInputType,
            fontStyle = fontStyle,
            textStyle = textStyle,
            isMultiLine = isMultiLine,
            isDisabled = isDisabled,
            padding = padding,
            ref = var7,
            tag = `{var22 or ""} data-testid={var2.testId}--mobile-textbox`,
            Size = uDim2_2,
            onFocusGained = onFocusGained,
            onFocusLost = 0,
            onTextChanged = 0,
            onCursorPositionChanged = 0,
            onInputEnded = 0,
            manualFocusRelease = 0,
            shouldEmitReturnEvents = 0,
            overlayNativeInput = nil
        }

        if not (isMultiLine and bool3) then
            var57 = nil
        end

        tbl12.onFocusLost = var57
        tbl12.onTextChanged = onTextChanged
        tbl12.onCursorPositionChanged = if isMultiLine then var72 else nil
        tbl12.onInputEnded = onInputEnded
        tbl12.manualFocusRelease = if bool3 then var2.manualFocusRelease else nil

        tbl12.shouldEmitReturnEvents = if bool3 and var2.manualFocusRelease == true then var2.alwaysMultiLine == true or nil else nil
        var91 = createElement5(var92, tbl12)
    else
        var91 = nil
    end

    tbl11.MobileTextBox = var91
    tbl9.TextContent = createElement4(var89, tbl10, tbl11)
    tbl7.TextBoxWrapper = createElement3(var88, tbl8, tbl9)
    local var92

    if var2.hasClearButton then
        local createElement5 = React.createElement
        local var93 = View

        local tbl12 = {
            isDisabled = isDisabled,
            GroupTransparency = if isDisabled then Constants.DISABLED_TRANSPARENCY else nil,
            LayoutOrder = 3,
            Visible = mapBindable(var2.text, function(arg3): boolean
                return arg3 ~= ""
            end),
            tag = var19.clearButton.tag
        }

        var92 = createElement5(var93, tbl12, {
            ClearButton = React.createElement(View, {
                onActivated = onActivated,
                padding = UDim.new(0, var19.clearButton.padding),
                Position = var80,
                stateLayer = {
                    affordance = StateLayerAffordance.None
                },
                tag = "anchor-center-left auto-xy",
                testId = `{var2.testId}--clear-button`
            }, {
                Icon = React.createElement(Icon, { name = var19.clearButton.icon })
            })
        })
    else
        var92 = nil
    end

    tbl7.Clear = var92
    local element2

    if var2.trailingElement then
        element2 = React.createElement(View, {
            GroupTransparency = if isDisabled2 then Constants.DISABLED_TRANSPARENCY else nil,
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

    tbl7.Trailing = element2
    tbl5.InputRow = createElement2(var87, tbl6, tbl7)

    tbl5.Footer = if var4 then React.createElement(
        View,
        {
            LayoutOrder = 2,
            tag = "size-full-0 auto-y",
            testId = `{var2.testId}--footer`
        },
        var2.footerElement
    ) else nil
    return createElement(var83, var86, tbl5)
end))
