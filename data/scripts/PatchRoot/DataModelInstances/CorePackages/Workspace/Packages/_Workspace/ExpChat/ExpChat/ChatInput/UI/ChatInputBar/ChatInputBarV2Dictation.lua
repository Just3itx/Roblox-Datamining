-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:50:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local React = require(ExpChatParent.React)
local Foundation = require(ExpChatParent.Foundation)
local ExpChatShared = require(ExpChatParent.ExpChatShared)

local Config = require(ExpChat.Config)
local FFlagExpChatPresetChatEnabled = ExpChatShared.Flags.FFlagExpChatPresetChatEnabled
local FFlagExpChatFixBackspaceNilTargetChannel = ExpChatShared.Flags.FFlagExpChatFixBackspaceNilTargetChannel
local FFlagExpChatDictationFTUX = require(ExpChat.Flags.FFlagExpChatDictationFTUX)

local FFlagExpChatInputBarV2CornerAndTruncationFix = require(ExpChat.Flags.FFlagExpChatInputBarV2CornerAndTruncationFix)
local FFlagExpChatComposerInputBarFigmaParity = require(ExpChat.Flags.FFlagExpChatComposerInputBarFigmaParity)
local FFlagExpChatDictationStopReplacesSend = require(ExpChat.Flags.FFlagExpChatDictationStopReplacesSend)
local FFlagExpChatDictationFadeOverride = require(ExpChat.Flags.FFlagExpChatDictationFadeOverride)
local FFlagExpChatContinuousDictationIdleFade = require(ExpChat.Flags.FFlagExpChatContinuousDictationIdleFade)
local var1 = FFlagExpChatDictationFadeOverride and FFlagExpChatContinuousDictationIdleFade

local FFlagEnableConsoleExpControls = require(ExpChatParent.SharedFlags).FFlagEnableConsoleExpControls

local ChannelChip = require(script.Parent.ChannelChip)
local StopCountdown = require(script.Parent.StopCountdown)
local _Dictation = require(script.Parent.Dictation)
local DictationFTUX = require(script.Parent.Dictation.DictationFTUX)
local DictationWaveform = require(script.Parent.Dictation.DictationWaveform)
local useDictationInputBar = require(script.Parent.Dictation.useDictationInputBar)
local useDictationTextArea = require(script.Parent.Dictation.useDictationTextArea)
local DictationAffordances = require(script.Parent.Dictation.DictationAffordances)

local function lerp(baseTransparency: number, num1: number, num2: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    return baseTransparency + (num1 - baseTransparency) * num2
end

return React.memo(function(tbl1) -- name: ChatInputBarV2Dictation
    local var2 = Foundation.Hooks.useTokens()
    local setTransparency = tbl1.setTransparency
    local chatInputBarSettings = tbl1.chatInputBarSettings
    local isSpatialUiEnabled = tbl1.isSpatialUIEnabled
    local canLocalUserChatDerived = tbl1.canLocalUserChatDerived
    local targetChannelWidth = tbl1.targetChannelWidth
    local showPlaceholderText = tbl1.showPlaceholderText
    local bool1 = tbl1.hasEmptyInputText == true
    local cursor = tbl1.cursor

    local var3 = useDictationInputBar({
        inputText = tbl1.inputText,
        setInputText = tbl1.setInputText,
        chatInputBarSettings = chatInputBarSettings,
        customTextBoxRef = tbl1.customTextBoxRef,
        textBoxRef = tbl1.textBoxRef,
        targetTextChannel = tbl1.targetTextChannel,
        isGlobalChatTabActive = tbl1.isGlobalChatTabActive,
        onDictationActivityChanged = tbl1.onDictationActivityChanged,
        onDictationStateChanged = tbl1.onDictationStateChanged,
        onSendActivated = tbl1.onSendActivated,
        onSendRecordingTap = tbl1.onSendRecordingTap,
        onTranscriptionStaged = tbl1.onTranscriptionStaged
    })

    local var4 = DictationAffordances.deriveMicSendButton(var3, {
        hasEmptyInputText = bool1,
        idleSendIcon = Foundation.Enums.IconName.ArrowMediumUp,
        idleSendVariant = if bool1 then Foundation.Enums.ButtonVariant.Standard else Foundation.Enums.ButtonVariant.Emphasis,
        idleSendActivated = tbl1.onSendActivated,
        idleSendDisabled = bool1
    })

    local var5 = DictationAffordances.deriveBackgroundColors(var3, {
        defaultColor3 = chatInputBarSettings.BackgroundColor3,
        defaultTransparency = tbl1.chatInputBarBackgroundTransparency,
        listeningColor3 = var2.Color.Shift.Shift_200.Color3,
        listeningTransparency = var2.Color.Shift.Shift_200.Transparency
    })
    local backgroundStyle = React.useMemo(function()
        return tbl1.transparencyValue:map(function(num1: number)
            return {
                Color3 = var5.color3,
                Transparency = lerp(var5.baseTransparency, 1, num1)
            }
        end)
    end, { tbl1.transparencyValue, var5.color3, var5.baseTransparency })

    local var7 = DictationAffordances.shouldPreventFade(var3, var1)
    local groupTransparency = React.useMemo(function()
        if var7 then
            return tbl1.transparencyValue:map(function(_: number): number
                return 0
            end)
        end
        return tbl1.transparencyValue
    end, { var7, tbl1.transparencyValue })

    local var9 = useDictationTextArea(var3, { transparencyValue = tbl1.transparencyValue, showPlaceholderText = showPlaceholderText })

    local useLongPressOverlay = var4.useLongPressOverlay
    local micGestureHandlers = var3.micGestureHandlers
    local isRecording = FFlagExpChatDictationStopReplacesSend and var3.isRecording

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 0)
    }
    local tbl3 = { Container = 0 }
    local createElement2 = React.createElement
    local str2 = "Frame"
    local tbl4 = {
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.fromScale(1, 0),
        BackgroundTransparency = 1
    }
    local tbl5 = { InputGroup = 0 }
    local createElement3 = React.createElement
    local view = Foundation.View
    local tbl6 = {
        tag = {
            ["row align-y-center auto-y padding-x-xxsmall"] = true,
            ["radius-circle"] = not FFlagExpChatInputBarV2CornerAndTruncationFix
        },
        cornerRadius = if FFlagExpChatInputBarV2CornerAndTruncationFix then UDim.new(0, 20) else nil,
        backgroundStyle = backgroundStyle,
        stroke = {
            Color = var2.Color.Stroke.Default.Color3,
            Transparency = setTransparency(var2.Color.Stroke.Default.Transparency, tbl1.transparencyValue)
        },
        LayoutOrder = 1,
        Position = UDim2.fromScale(0, 0),
        Size = UDim2.fromScale(1, 0)
    }
    local tbl7 = {
        StopCountdown = if FFlagExpChatDictationStopReplacesSend then nil else React.createElement(StopCountdown, {
            LayoutOrder = 1,
            countdownProgress = var3.dictation.bindings.countdownProgress,
            onActivated = var3.dictation.stopDictation,
            Visible = var3.dictation.bindings.isRecording
        }),
        TextContainer = 0,
        SendButtonContainer = 0,
        FTUX = 0
    }

    local createElement4 = React.createElement
    local str3 = "Frame"
    local tbl8 = {
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder = 2,
        Size = UDim2.fromScale(0, 0)
    }

    local tbl9 = {
        TargetChannelChip = React.createElement(ChannelChip, {
            transparency = setTransparency(0, tbl1.transparencyValue),
            onAbsoluteSizeChanged = tbl1.onAbsoluteSizeChanged,
            onChannelChipActivated = FFlagExpChatFixBackspaceNilTargetChannel and function()
                tbl1.resetTargetChannel(tbl1.isGlobalChatTabActive)
            end or tbl1.resetTargetChannel,
            targetTextChannelDisplayName = tbl1.targetTextChannelDisplayName or "",
            isChannelBarVisible = tbl1.isChannelBarVisible,
            developerChannelTabsEnabled = tbl1.developerChannelTabsEnabled
        }),
        DisabledPlaceholderLabel = 0,
        TextBoxContainer = 0,
        WaveformOverlay = 0,
        UIFlexItem = 0,
        UIPadding = 0
    }
    local bool2 = not canLocalUserChatDerived

    if bool2 then
        local createElement5 = React.createElement
        local str4 = "TextLabel"

        local tbl10 = {
            AnchorPoint = Vector2.new(1, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Font = Config.ChatInputBarFont,
            Text = tbl1.disabledChatPlaceholderText,
            Position = UDim2.fromScale(1, 0),
            Size = targetChannelWidth:map(function(num1: number): UDim2
                return UDim2.new(1, -(num1 + 8), 0, 0)
            end),
            TextColor3 = showPlaceholderText and chatInputBarSettings.PlaceholderColor3 or chatInputBarSettings.TextColor3,
            TextSize = if isSpatialUiEnabled then chatInputBarSettings.SpatialPanelTextSize else chatInputBarSettings.TextSize,
            TextTransparency = setTransparency(if showPlaceholderText then 0.5 else 0, tbl1.transparencyValue),
            Selectable = true,
            SelectionImageObject = cursor,
            TextWrapped = if FFlagExpChatInputBarV2CornerAndTruncationFix then not showPlaceholderText else not (FFlagExpChatPresetChatEnabled and showPlaceholderText and tbl1.shouldTruncatePlaceholder),
            TextTruncate = if FFlagExpChatInputBarV2CornerAndTruncationFix and showPlaceholderText then Enum.TextTruncate.AtEnd elseif FFlagExpChatPresetChatEnabled and showPlaceholderText then Enum.TextTruncate.AtEnd else nil,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            ref = tbl1.placeholderRef
        }

        bool2 = createElement5(str4, tbl10)
    end

    tbl9.DisabledPlaceholderLabel = bool2

    if canLocalUserChatDerived then
        local createElement5 = React.createElement
        local str4 = "Frame"

        local tbl10 = {
            AnchorPoint = Vector2.new(1, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Position = UDim2.fromScale(1, 0),
            Size = targetChannelWidth:map(function(num1: number): UDim2
                return UDim2.new(1, -(num1 + 8), 0, 0)
            end)
        }

        local tbl11 = { TextBox = 0 }
        if canLocalUserChatDerived then
            canLocalUserChatDerived = React.createElement("TextBox", {
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.XY,
                BackgroundTransparency = 1,
                ClearTextOnFocus = false,
                FontFace = chatInputBarSettings.FontFace,
                PlaceholderText = showPlaceholderText and tbl1.placeholderText or "",
                Selectable = if FFlagEnableConsoleExpControls then true else nil,
                SelectionImageObject = cursor,
                Size = UDim2.fromScale(1, 0),
                Text = "",
                PlaceholderColor3 = if FFlagExpChatComposerInputBarFigmaParity
                    and chatInputBarSettings.PlaceholderColor3 == Config.ChatInputBarPlaceholderColor then var2.DarkMode.Content.Default.Color3 else chatInputBarSettings.PlaceholderColor3,
                TextColor3 = chatInputBarSettings.TextColor3,
                TextSize = if isSpatialUiEnabled then chatInputBarSettings.SpatialPanelTextSize else chatInputBarSettings.TextSize,
                TextTransparency = var9.textTransparency,
                TextStrokeTransparency = var9.textStrokeTransparency,
                TextStrokeColor3 = chatInputBarSettings.TextStrokeColor3,
                TextWrapped = not (FFlagExpChatInputBarV2CornerAndTruncationFix and showPlaceholderText),
                TextTruncate = if FFlagExpChatInputBarV2CornerAndTruncationFix and showPlaceholderText then Enum.TextTruncate.AtEnd else nil,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
                ZIndex = 2,
                [React.Event.Focused] = tbl1.onFocused,
                [React.Event.FocusLost] = tbl1.onFocusLost,
                [React.Change.Text] = tbl1.onTextChanged,
                [React.Event.ReturnPressedFromOnScreenKeyboard] = tbl1.onReturnPressedFromOnScreenKeyboard,
                ref = if chatInputBarSettings.TextBox then tbl1.customTextBoxRef else tbl1.textBoxRef
            })
        end

        tbl11.TextBox = canLocalUserChatDerived
        canLocalUserChatDerived = createElement5(str4, tbl10, tbl11)
    end

    tbl9.TextBoxContainer = canLocalUserChatDerived

    local createElement5 = React.createElement
    local str4 = "Frame"
    local tbl10 = {
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.fromScale(0, 0.5),
        Size = UDim2.new(
            1,
            0,
            0,
            if isSpatialUiEnabled then chatInputBarSettings.SpatialPanelTextSize else chatInputBarSettings.TextSize
        ),
        Visible = var3.dictation.bindings.isAudioActive,
        ZIndex = 3
    }
    local tbl11 = {
        List = React.createElement(DictationWaveform, {
            isActive = var3.isRecording or var3.isListening,
            audioDeviceInput = var3.dictation.audioDeviceInput,
            transcribedSamplesBinding = var3.transcribedSamplesBinding,
            transparencyValue = if var3.isListening and not var7 then tbl1.transparencyValue else nil,
            onSample = var3.onWaveformSample
        })
    }
    tbl9.WaveformOverlay = createElement5(str4, tbl10, tbl11)

    tbl9.UIFlexItem = React.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.Fill })

    tbl9.UIPadding = React.createElement("UIPadding", {
        PaddingBottom = UDim.new(0, 10),
        PaddingLeft = UDim.new(0, var2.Padding.Medium),
        PaddingRight = UDim.new(0, var2.Padding.Medium),
        PaddingTop = UDim.new(0, 10)
    })
    tbl7.TextContainer = createElement4(str3, tbl8, tbl9)

    local createElement6 = React.createElement
    local view2 = Foundation.View
    local tbl12 = {
        ref = var3.micButtonSlotRef,
        tag = "auto-xy padding-xxsmall",
        GroupTransparency = groupTransparency,
        LayoutOrder = 3
    }
    local tbl13 = {
        TrailingStopCountdown = if isRecording then React.createElement(
            StopCountdown,
            {
                countdownProgress = var3.dictation.bindings.countdownProgress,
                onActivated = var3.dictation.stopDictation
            }
        ) else nil,
        SendButton = React.createElement(Foundation.IconButton, {
            icon = var4.icon,
            variant = var4.variant,
            size = Foundation.Enums.InputSize.Small,
            isCircular = true,
            isDisabled = var4.isDisabled,
            Selectable = not useLongPressOverlay and nil,
            onActivated = useLongPressOverlay and function() end or var4.onActivated,
            Visible = not isRecording and nil
        }),
        InputTarget = 0
    }
    local element

    if useLongPressOverlay and micGestureHandlers ~= nil then
        element = React.createElement("TextButton", {
            Active = true,
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1),
            Text = "",
            ZIndex = 2,
            Selectable = true,
            SelectionImageObject = var3.micCursor,
            [React.Event.Activated] = micGestureHandlers[React.Event.Activated],
            [React.Event.InputBegan] = micGestureHandlers[React.Event.InputBegan],
            [React.Event.InputEnded] = micGestureHandlers[React.Event.InputEnded]
        })
    else
        element = nil
    end

    tbl13.InputTarget = element
    tbl7.SendButtonContainer = createElement6(view2, tbl12, tbl13)
    local element2 = if FFlagExpChatDictationFTUX and var3.ftux and var3.ftux.shouldShow then React.createElement(
        DictationFTUX,
        {
            anchorRef = var3.micButtonSlotRef,
            onDismiss = if FFlagExpChatDictationFTUX then var3.ftux.dismiss else nil
        }
    ) else nil
    tbl7.FTUX = element2
    tbl5.InputGroup = createElement3(view, tbl6, tbl7)
    tbl3.Container = createElement2(str2, tbl4, tbl5)
    return createElement(str1, tbl2, tbl3)
end)
