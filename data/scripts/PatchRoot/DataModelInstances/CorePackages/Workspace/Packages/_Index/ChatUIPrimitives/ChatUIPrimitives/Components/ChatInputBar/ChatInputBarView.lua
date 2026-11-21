-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:01:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
local ChatUIPrimitivesParent = ChatUIPrimitives.Parent
local React = require(ChatUIPrimitivesParent.React)
local ReactIs = require(ChatUIPrimitivesParent.ReactIs)
local Foundation = require(ChatUIPrimitivesParent.Foundation)
local normalizeFontFace = Foundation.Utility.normalizeFontFace
local FFlagChatInputBarGuardInvalidUtf8 = require(ChatUIPrimitivesParent.SharedFlags).FFlagChatInputBarGuardInvalidUtf8
local FFlagExpChatHidePlaceholderUnderOverlay = require(ChatUIPrimitives.Flags.FFlagExpChatHidePlaceholderUnderOverlay)
local FFlagExpChatComposerKeepTrayEntryMounted = require(ChatUIPrimitives.Flags.FFlagExpChatComposerKeepTrayEntryMounted)

local FFlagExpChatComposerKeepTrayEntryOnDisabledOverlay = require(ChatUIPrimitives.Flags.FFlagExpChatComposerKeepTrayEntryOnDisabledOverlay)

local getTextLengthIfValidUtf8 = require(script.Parent.getTextLengthIfValidUtf8)
local ChannelChip = require(script.Parent.ChannelChip)
local _AutocompleteTypes = require(ChatUIPrimitives.universal.Autocomplete.AutocompleteTypes)
local ChatAutocompleteDropdown = require(script.Parent.Autocomplete.ChatAutocompleteDropdown)
local useChatAutocompleteEngine = require(script.Parent.Autocomplete.useChatAutocompleteEngine)
local useAutocompleteSources = require(ChatUIPrimitives.universal.Autocomplete.useAutocompleteSources)
local ExpressionTrayView = require(ChatUIPrimitives.Components.ExpressionTray.ExpressionTrayView)
local useExpressionTray = require(ChatUIPrimitives.Hooks.useExpressionTray)

local function getPlaceholderText(props) -- Luacid: Inlined by compiler; 2 call sites recovered
    return if FFlagExpChatHidePlaceholderUnderOverlay and props.centerOverlay ~= nil and props.centerOverlayTextHidden then "" else props.placeholderText or ""
end

local function fade(num1: number, num2: number): number -- Luacid: Inlined by compiler; 14 call sites recovered
    return num1 + num2 * (1 - num1)
end

local function deriveTransparency(num1: number, arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    if ReactIs.isBinding(arg1) then
        return arg1:map(function(num2: number): number
            return fade(num1, num2)
        end)
    end

    return fade(num1, arg1)
end

local function deriveBackgroundStyle(color3: Color3, num1: number, arg1)
    if ReactIs.isBinding(arg1) then
        return arg1:map(function(num2: number)
            return {
                Color3 = color3,
                Transparency = fade(num1, num2)
            }
        end)
    end

    return {
        Color3 = color3,
        Transparency = fade(num1, arg1)
    }
end

local function withVariant(arg1, variant: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    local var1 = table.clone(arg1)
    var1.variant = variant
    return var1
end

local function renderDropdown(tbl1)
    if tbl1.props.autocomplete == nil and tbl1.props.autocompleteOptions == nil then
        return nil
    end
    local autocomplete = tbl1.autocomplete
    return React.createElement(ChatAutocompleteDropdown, {
        isOpen = autocomplete.isOpen,
        results = autocomplete.results,
        selectedIndex = autocomplete.selectedIndex,
        keyboardIndex = autocomplete.keyboardIndex,
        renderEntry = autocomplete.renderEntry,
        anchorRef = tbl1.barContainerRef,
        onHover = autocomplete.setSelectedIndex,
        onSelect = tbl1.onCommitSelection,
        onDismiss = autocomplete.dismiss
    })
end

local function renderSideChip(tbl1)
    return React.createElement(ChannelChip, {
        transparency = tbl1.transparencyValue,
        sideChipText = tbl1.props.sideChipText,
        showSideChip = tbl1.props.showSideChip,
        onSideChipActivated = tbl1.props.onSideChipActivated,
        onAbsoluteSizeChanged = tbl1.onChannelChipAbsoluteSizeChanged
    })
end

local function renderSendButton(tbl1)
    return React.createElement(Foundation.IconButton, {
        icon = Foundation.Enums.IconName.ArrowMediumUp,
        variant = if tbl1.isSendDisabled then Foundation.Enums.ButtonVariant.Standard else Foundation.Enums.ButtonVariant.Emphasis,
        size = Foundation.Enums.InputSize.Small,
        isCircular = true,
        isDisabled = tbl1.isSendDisabled,
        onActivated = tbl1.onSendActivated
    })
end

local function renderLegacy(tbl1)
    local tokens = tbl1.tokens
    local props = tbl1.props
    local textSize = props.textSize or tokens.Typography.CaptionMedium.FontSize

    local bool1 = props.primary ~= nil
    local bool2 = not tbl1.shouldReplaceDisabledContent

    if bool2 then
        if tbl1.hasLeadingAction then
            bool2 = not tbl1.isEmpty and tbl1.canChat and not bool1
        else
            bool2 = not bool1
        end
    end

    local xOffset = if tbl1.showLeadingAction then 36 else 0
    local var2 = if bool2 or bool1 then tbl1.sendButtonContainerWidth + 6 else 0

    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        tag = "auto-y",
        Size = UDim2.new(1, 0, 0, 0),
        ref = tbl1.barContainerRef
    }
    local tbl3 = {
        Dropdown = renderDropdown(tbl1),
        TrayOverlay = tbl1.trayOverlay,
        Container = 0
    }
    local createElement2 = React.createElement
    local view2 = Foundation.View
    local tbl4 = {
        tag = "auto-y",
        Size = UDim2.fromScale(1, 0)
    }
    local tbl5 = { InputGroup = 0 }
    local createElement3 = React.createElement
    local view3 = Foundation.View
    local tbl6 = {
        LayoutOrder = 2,
        cornerRadius = UDim.new(0, 20),
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.fromScale(1, 0),
        backgroundStyle = deriveBackgroundStyle(tbl1.surfaceColor, 0.2, tbl1.transparencyValue),
        stroke = {
            Color = tokens.Color.Stroke.Default.Color3,
            Transparency = deriveTransparency(tokens.Color.Stroke.Default.Transparency, tbl1.transparencyValue)
        },
        padding = {
            right = UDim.new(0, 2)
        }
    }
    local tbl7 = {
        CustomDisabledContent = if tbl1.shouldReplaceDisabledContent then props.disabledOverlay else nil,
        LeadingActionContainer = 0,
        TextContainer = 0,
        SendButtonContainer = 0
    }
    local element

    if tbl1.showLeadingAction then
        element = React.createElement(Foundation.View, {
            tag = "position-top-left",
            Size = UDim2.new(0, xOffset, 1, 0)
        }, {
            Layout = React.createElement(
                "UIListLayout",
                {
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    VerticalAlignment = Enum.VerticalAlignment.Center
                }
            ),
            Action = tbl1.leadingAddon
        })
    else
        element = nil
    end

    tbl7.LeadingActionContainer = element
    local var3

    if tbl1.shouldReplaceDisabledContent then
        var3 = nil
    else
        local createElement4 = React.createElement
        local view4 = Foundation.View
        local tbl8 = {
            tag = "auto-y",
            Position = UDim2.fromOffset(xOffset, 0),
            Size = UDim2.new(1, -(xOffset + var2), 0, 0),
            padding = {
                top = UDim.new(0, 10),
                bottom = UDim.new(0, 10),
                left = UDim.new(0, 10),
                right = UDim.new(0, 10)
            }
        }
        local tbl9 = {
            SideChip = renderSideChip(tbl1),
            CenterOverlay = props.centerOverlay,
            DisabledLabel = 0,
            TextBoxContainer = 0
        }
        local var4

        if tbl1.canChat then
            var4 = nil
        else
            local createElement5 = React.createElement
            local foundationText = Foundation.Text
            local tbl10 = {
                tag = "position-top-right anchor-top-right auto-y text-caption-medium text-wrap text-align-x-left text-align-y-top content-muted",
                Text = props.disabledChatPlaceholderText or "",
                Size = tbl1.reserveSize,
                TextTransparency = 0
            }
            local transparencyValue = tbl1.transparencyValue
            local var5

            if ReactIs.isBinding(transparencyValue) then
                local num1 = 0.5

                var5 = transparencyValue:map(function(num2: number): number
                    return fade(num1, num2)
                end)
            else
                var5 = transparencyValue * 0.5 + 0.5
            end

            tbl10.TextTransparency = var5
            var4 = createElement5(foundationText, tbl10)
        end

        tbl9.DisabledLabel = var4
        local var5

        if tbl1.canChat then
            local createElement5 = React.createElement
            local view5 = Foundation.View
            local tbl10 = {
                tag = "position-top-right anchor-top-right auto-y",
                Size = tbl1.reserveSize
            }
            local tbl11 = { TextBox = 0 }
            local createElement6 = React.createElement
            local str1 = "TextBox"
            local tbl12 = {
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.XY,
                BackgroundTransparency = 1,
                ClearTextOnFocus = false,
                MaxVisibleGraphemes = props.maximumCharacterLimit or -1,
                FontFace = props.fontFace or normalizeFontFace(tokens.Typography.CaptionMedium.Font),
                PlaceholderText = getPlaceholderText(props),
                PlaceholderColor3 = tbl1.placeholderColor,
                Size = UDim2.fromScale(1, 0),
                Text = props.defaultValue or "",
                TextColor3 = tbl1.textColor,
                TextSize = textSize
            }
            local var6

            if props.centerOverlay == nil or not props.centerOverlayTextHidden then
                local transparencyValue = tbl1.transparencyValue

                if ReactIs.isBinding(transparencyValue) then
                    local num1 = 0

                    var6 = transparencyValue:map(function(num2: number): number
                        return fade(num1, num2)
                    end)
                else
                    var6 = transparencyValue * 1 + 0
                end
            else
                var6 = 1
            end

            tbl12.TextTransparency = var6

            tbl12.TextWrapped = true
            tbl12.TextXAlignment = Enum.TextXAlignment.Left
            tbl12.TextYAlignment = Enum.TextYAlignment.Top
            tbl12.TextEditable = props.enableFocusedWrite ~= false
            tbl12.ZIndex = 2

            tbl12[React.Change.Text] = tbl1.onTextChanged
            tbl12[React.Event.ReturnPressedFromOnScreenKeyboard] = tbl1.onReturnPressedFromOnScreenKeyboard
            tbl12[React.Event.Focused] = tbl1.onFocused
            tbl12[React.Event.FocusLost] = tbl1.onFocusLost
            tbl12.ref = tbl1.textBoxRef
            tbl12.SelectionImageObject = props.selectionImageObject
            tbl12.Selectable = props.selectionImageObject ~= nil or nil
            tbl11.TextBox = createElement6(str1, tbl12)
            var5 = createElement5(view5, tbl10, tbl11)
        else
            var5 = nil
        end

        tbl9.TextBoxContainer = var5
        var3 = createElement4(view4, tbl8, tbl9)
    end

    tbl7.TextContainer = var3
    local element2

    if bool2 or bool1 then
        element2 = React.createElement("CanvasGroup", {
            AnchorPoint = Vector2.new(1, 0),
            BackgroundTransparency = 1,
            GroupTransparency = tbl1.transparencyValue,
            Position = UDim2.fromScale(1, 0),
            Size = UDim2.new(0, tbl1.sendButtonContainerWidth + 6, 1, 0)
        }, {
            Layout = React.createElement(
                "UIListLayout",
                {
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    VerticalAlignment = Enum.VerticalAlignment.Center
                }
            ),
            SendButton = if bool1 then props.primary else renderSendButton(tbl1)
        })
    else
        element2 = nil
    end

    tbl7.SendButtonContainer = element2
    tbl5.InputGroup = createElement3(view3, tbl6, tbl7)
    tbl3.Container = createElement2(view2, tbl4, tbl5)
    return createElement(view, tbl2, tbl3)
end

local function renderComposer(tbl1)
    local tokens = tbl1.tokens
    local props = tbl1.props
    local fontSize = tokens.Typography.BodyMedium.FontSize
    local bool1 = props.primary ~= nil
    local bool2 = not tbl1.shouldReplaceDisabledContent
    local var1 = tbl1.sendButtonContainerWidth + 6

    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        tag = "size-full-0 auto-y",
        ref = tbl1.barContainerRef
    }
    local tbl3 = {
        Dropdown = renderDropdown(tbl1),
        TrayOverlay = tbl1.trayOverlay,
        Container = 0
    }
    local createElement2 = React.createElement
    local view2 = Foundation.View
    local tbl4 = { tag = "row align-y-center gap-small size-full-0 auto-y" }

    local tbl5 = { LeadingButton = 0, InputGroup = 0 }
    local element

    if FFlagExpChatComposerKeepTrayEntryMounted then
        if tbl1.hasLeadingAction then
            element = React.createElement(
                Foundation.View,
                {
                    LayoutOrder = 1,
                    tag = "auto-xy",
                    Visible = tbl1.showLeadingAction
                },
                {
                    Action = tbl1.leadingAddon
                }
            )
        else
            element = nil
        end
    elseif tbl1.showLeadingAction then
        element = React.createElement(Foundation.View, { LayoutOrder = 1, tag = "auto-xy" }, { Action = tbl1.leadingAddon })
    else
        element = nil
    end

    tbl5.LeadingButton = element

    local createElement3 = React.createElement
    local view3 = Foundation.View
    local tbl6 = {
        LayoutOrder = 2,
        cornerRadius = UDim.new(0, tokens.Radius.Circle),
        tag = "grow size-0 auto-y",
        backgroundStyle = tbl1.pillBackgroundStyle,
        stroke = tbl1.pillStroke,
        sizeConstraint = {
            MinSize = Vector2.new(0, 40)
        },
        padding = {
            right = UDim.new(0, 4)
        }
    }
    local tbl7 = {
        CustomDisabledContent = if tbl1.shouldReplaceDisabledContent then props.disabledOverlay else nil,
        TextContainer = 0,
        SendButtonContainer = 0
    }
    local var2

    if tbl1.shouldReplaceDisabledContent then
        var2 = nil
    else
        local createElement4 = React.createElement
        local view4 = Foundation.View
        local tbl8 = {
            tag = "auto-y",
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.fromScale(0, 0.5),
            ClipsDescendants = true,
            Size = UDim2.new(1, -var1, 0, 0),
            padding = {
                left = UDim.new(0, 16),
                right = UDim.new(0, 4),
                top = UDim.new(0, 10),
                bottom = UDim.new(0, 10)
            }
        }
        local tbl9 = {
            SideChip = renderSideChip(tbl1),
            CenterOverlay = props.centerOverlay,
            DisabledLabel = 0,
            TextBoxContainer = 0
        }
        local var3

        if tbl1.canChat then
            var3 = nil
        else
            local createElement5 = React.createElement
            local foundationText = Foundation.Text
            local tbl10 = {
                tag = "position-top-right anchor-top-right auto-y text-body-medium text-align-x-left text-truncate-end content-muted",
                Text = props.disabledChatPlaceholderText or "",
                Size = tbl1.reserveSize,
                TextTransparency = 0
            }
            local transparencyValue = tbl1.transparencyValue
            local var4

            if ReactIs.isBinding(transparencyValue) then
                local num1 = 0.5

                var4 = transparencyValue:map(function(num2: number): number
                    return fade(num1, num2)
                end)
            else
                var4 = transparencyValue * 0.5 + 0.5
            end

            tbl10.TextTransparency = var4
            var3 = createElement5(foundationText, tbl10)
        end

        tbl9.DisabledLabel = var3
        local var4

        if tbl1.canChat then
            local createElement5 = React.createElement
            local view5 = Foundation.View
            local tbl10 = {
                tag = "position-top-right anchor-top-right auto-y clip",
                Size = tbl1.reserveSize
            }
            local tbl11 = {
                TextBox = React.createElement("TextBox", {
                    AnchorPoint = Vector2.new(0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundTransparency = 1,
                    ClearTextOnFocus = false,
                    MaxVisibleGraphemes = props.maximumCharacterLimit or -1,
                    FontFace = props.fontFace or normalizeFontFace(tokens.Typography.BodyMedium.Font),
                    PlaceholderText = getPlaceholderText(props),
                    PlaceholderColor3 = tbl1.composerPlaceholderColor,
                    Size = UDim2.fromScale(1, 0),
                    Text = props.defaultValue or "",
                    TextColor3 = tbl1.textColor,
                    TextSize = fontSize,
                    TextTransparency = if props.centerOverlay ~= nil and props.centerOverlayTextHidden then 1 else tbl1.textTransparency,
                    TextWrapped = false,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Center,
                    TextEditable = props.enableFocusedWrite ~= false,
                    ZIndex = 2,
                    [React.Change.Text] = tbl1.onTextChanged,
                    [React.Event.ReturnPressedFromOnScreenKeyboard] = tbl1.onReturnPressedFromOnScreenKeyboard,
                    [React.Event.Focused] = tbl1.onFocused,
                    [React.Event.FocusLost] = tbl1.onFocusLost,
                    ref = tbl1.textBoxRef,
                    SelectionImageObject = props.selectionImageObject,
                    Selectable = props.selectionImageObject ~= nil or nil
                })
            }
            var4 = createElement5(view5, tbl10, tbl11)
        else
            var4 = nil
        end

        tbl9.TextBoxContainer = var4
        var2 = createElement4(view4, tbl8, tbl9)
    end

    tbl7.TextContainer = var2
    local element2

    if bool2 then
        element2 = React.createElement("CanvasGroup", {
            AnchorPoint = Vector2.new(1, 0),
            AutomaticSize = Enum.AutomaticSize.X,
            BackgroundTransparency = 1,
            GroupTransparency = tbl1.pillTransparency,
            Position = UDim2.fromScale(1, 0),
            Size = UDim2.new(0, 0, 1, 0)
        }, {
            Layout = React.createElement(
                "UIListLayout",
                {
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    VerticalAlignment = Enum.VerticalAlignment.Center
                }
            ),
            SendButton = if bool1 then props.primary else renderSendButton(tbl1)
        })
    else
        element2 = nil
    end

    tbl7.SendButtonContainer = element2
    tbl5.InputGroup = createElement3(view3, tbl6, tbl7)
    tbl3.Container = createElement2(view2, tbl4, tbl5)
    return createElement(view, tbl2, tbl3)
end

return React.memo(function(props) -- name: ChatInputBarView
    local tokens = Foundation.Hooks.useTokens()

    local themedColors = props.themedColors
    local color3 = if themedColors then tokens.Color.Surface.Surface_100.Color3 else tokens.DarkMode.Surface.Surface_100.Color3
    local color3_2 = if themedColors then tokens.Color.Content.Muted.Color3 else tokens.DarkMode.Content.Muted.Color3
    local color3_3 = if themedColors then tokens.Color.Content.Emphasis.Color3 else tokens.DarkMode.Content.Emphasis.Color3
    local color3_4 = if themedColors then tokens.Color.Content.Default.Color3 else tokens.DarkMode.Content.Default.Color3
    local onChange = props.onChange
    local onSend = props.onSend
    local canLocalUserChat = props.canLocalUserChat
    local transparencyValue = props.transparencyValue or 0
    local maximumCharacterLimit = props.maximumCharacterLimit
    local shouldReplaceDisabledContent = not canLocalUserChat and props.disabledOverlay ~= nil

    local pillStrokeStyle = props.pillStrokeStyle
    local pillTransparency = React.useMemo(function()
        if canLocalUserChat or pillStrokeStyle ~= nil then
            return transparencyValue
        end

        local var2 = transparencyValue

        if not ReactIs.isBinding(var2) then
            return var2 * 0.5 + 0.5
        end

        local num1 = 0.5

        return (var2:map(function(num2: number): number
            return fade(num1, num2)
        end))
    end, { canLocalUserChat, transparencyValue, pillStrokeStyle })
    local pillBackgroundStyle = React.useMemo(function()
        return deriveBackgroundStyle(color3, 0.2, pillTransparency)
    end, { color3, pillTransparency })
    local pillStroke = React.useMemo(function()
        if pillStrokeStyle then
            return {
                Color = pillStrokeStyle.Color3,
                Transparency = deriveTransparency(pillStrokeStyle.Transparency or 0, transparencyValue)
            }
        end

        return {
            Color = tokens.Color.Stroke.Default.Color3,
            Transparency = deriveTransparency(tokens.Color.Stroke.Default.Transparency, pillTransparency)
        }
    end, {
        tokens,
        pillTransparency,
        pillStrokeStyle,
        transparencyValue
    })

    local textTransparency = React.useMemo(function()
        return deriveTransparency(0, transparencyValue)
    end, { transparencyValue })

    local var6 = React.useRef(nil)
    local textBoxRef = props.textBoxRef or var6
    local barContainerRef = React.useRef(nil)
    local var9 = useChatAutocompleteEngine(textBoxRef, props.autocomplete)
    local var10 = useAutocompleteSources(textBoxRef, props.autocompleteOptions)
    if props.autocompleteOptions == nil then
        var10 = var9
    end

    local var11 = React.useRef(props.defaultValue or "")
    local var12, var13 = React.useState(function(): boolean
        return (props.defaultValue or "") == ""
    end)

    local var14, var15 = React.useBinding(0)

    local onChannelChipAbsoluteSizeChanged = React.useCallback(function(arg1)
        var15(arg1.AbsoluteSize.X)
    end, {})

    local size200 = tokens.Size.Size_200
    local bool2 = props.composerLayout == true
    local reserveSize = React.useMemo(function()
        if bool2 then
            return var14:map(function(num1: number): UDim2
                local var17 = if num1 > 0 then num1 + size200 else 0
                return UDim2.new(1, -var17, 0, 0)
            end)
        end
        return var14:map(function(num1: number): UDim2
            return UDim2.new(1, -(num1 + size200), 0, 0)
        end)
    end, { var14, size200, bool2 })

    local onSendActivated = React.useCallback(function()
        local current = textBoxRef.current
        local var18 = if current then current.Text else ""
        if var18 == "" then
            return
        end
        onSend(var18)
        if current then
            current.Text = ""
        end
        var13(true)
    end, { onSend, textBoxRef })

    local onReturnPressedFromOnScreenKeyboard = React.useCallback(function()
        local current = textBoxRef.current
        if current then
            current:ReleaseFocus(true)
        end
    end, { textBoxRef })

    local onTextChanged = React.useCallback(function(arg1)
        local text = arg1.Text
        if maximumCharacterLimit ~= nil then
            if FFlagChatInputBarGuardInvalidUtf8 then
                local textLengthIfValidUtf8 = getTextLengthIfValidUtf8(text)
                if textLengthIfValidUtf8 ~= nil then
                    if maximumCharacterLimit < textLengthIfValidUtf8 then
                        arg1.Text = var11.current
                        return
                    end
                    var11.current = text
                end
            else
                local var20 = utf8.nfcnormalize(text)
                if (utf8.len(var20) or #var20) > maximumCharacterLimit then
                    arg1.Text = var11.current
                    return
                end
                var11.current = text
            end
        end
        var13(text == "")
        if onChange then
            onChange(text)
        end
        var10.onTextChanged(text)
    end, { onChange, maximumCharacterLimit, var10.onTextChanged })

    local onFocused = React.useCallback(function()
        if props.onFocusGained then
            props.onFocusGained()
        end
    end, { props.onFocusGained })

    local var22 = React.useCallback(function(arg1)
        if props.autocompleteOptions ~= nil then
            var13(arg1.Text == "")
        end
    end, { props.autocompleteOptions })

    local onCommitSelection = React.useCallback(function(num1: number)
        var10.commitSelection(num1)
        local current = textBoxRef.current
        if current ~= nil then
            var22(current)
        end
    end, { var10.commitSelection, textBoxRef, var22 })

    local onFocusLost = React.useCallback(function(_, bool3: boolean)
        local current = textBoxRef.current
        if current and var10.interceptSend(current, bool3) then
            var22(current)
        elseif bool3 then
            onSendActivated()
        end
        if props.onFocusLost then
            props.onFocusLost()
        end
    end, {
        onSendActivated,
        props.onFocusLost,
        textBoxRef,
        var10.interceptSend,
        var22
    })

    React.useEffect(function()
        if not canLocalUserChat then
            var13(true)
        end
    end, { canLocalUserChat })

    local var25 = useExpressionTray(props.expressionTray)
    local element, element2

    if var25 == nil or not var25.isVisible then
        element = nil
        element2 = nil
    else
        element = React.createElement(ExpressionTrayView, (withVariant(var25, "entry")))
        element2 = React.createElement(ExpressionTrayView, (withVariant(var25, "overlay")))
    end

    local leadingAddon = if element == nil then props.leftAddon else element
    local hasLeadingAction = leadingAddon ~= nil
    local showLeadingAction = if FFlagExpChatComposerKeepTrayEntryOnDisabledOverlay then hasLeadingAction and var12 and (element ~= nil or not shouldReplaceDisabledContent) else hasLeadingAction and var12 and not shouldReplaceDisabledContent

    if FFlagExpChatComposerKeepTrayEntryMounted then
        local var28 = props.composerLayout == true and var25 ~= nil and var25.isOpen and not showLeadingAction
        local onPressedOutside = if var25 == nil then nil else var25.onPressedOutside

        React.useEffect(function()
            if var28 and onPressedOutside ~= nil then
                onPressedOutside()
            end
        end, { var28, onPressedOutside })
    end

    assert(
        props.autocomplete == nil or props.autocompleteOptions == nil,
        "Pass autocomplete or autocompleteOptions, not both"
    )

    local tbl1 = {
        tokens = tokens,
        props = props,
        leadingAddon = leadingAddon,
        trayOverlay = element2,
        canChat = canLocalUserChat,
        isEmpty = var12,
        isSendDisabled = var12 or not canLocalUserChat,
        hasLeadingAction = hasLeadingAction,
        showLeadingAction = showLeadingAction,
        shouldReplaceDisabledContent = shouldReplaceDisabledContent,
        transparencyValue = transparencyValue,
        textColor = color3_3,
        surfaceColor = color3,
        placeholderColor = color3_2,
        composerPlaceholderColor = color3_4,
        pillTransparency = pillTransparency,
        pillBackgroundStyle = pillBackgroundStyle,
        pillStroke = pillStroke,
        textTransparency = textTransparency,
        textBoxRef = textBoxRef,
        barContainerRef = barContainerRef,
        reserveSize = reserveSize,
        autocomplete = var10,
        sendButtonContainerWidth = 30,
        onChannelChipAbsoluteSizeChanged = onChannelChipAbsoluteSizeChanged,
        onSendActivated = onSendActivated,
        onCommitSelection = onCommitSelection,
        onReturnPressedFromOnScreenKeyboard = onReturnPressedFromOnScreenKeyboard,
        onTextChanged = onTextChanged,
        onFocused = onFocused,
        onFocusLost = onFocusLost
    }

    if props.composerLayout == true then
        return renderComposer(tbl1)
    end
    return renderLegacy(tbl1)
end)
