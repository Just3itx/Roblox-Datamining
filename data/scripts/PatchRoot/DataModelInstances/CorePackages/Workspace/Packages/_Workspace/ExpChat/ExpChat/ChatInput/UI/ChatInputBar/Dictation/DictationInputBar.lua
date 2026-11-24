-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:51:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local React = require(ExpChatParent.React)
local Foundation = require(ExpChatParent.Foundation)

local FFlagExpChatDictationFTUX = require(ExpChat.Flags.FFlagExpChatDictationFTUX)
local FFlagExpChatDictationFadeOverride = require(ExpChat.Flags.FFlagExpChatDictationFadeOverride)
local FFlagExpChatContinuousDictationIdleFade = require(ExpChat.Flags.FFlagExpChatContinuousDictationIdleFade)
local var1 = FFlagExpChatDictationFadeOverride and FFlagExpChatContinuousDictationIdleFade

local Config = require(ExpChat.Config)

local ChannelChip = require(script.Parent.Parent.ChannelChip)
local DictationFTUX = require(script.Parent.DictationFTUX)
local StopCountdown = require(script.Parent.Parent.StopCountdown)
local DictationWaveform = require(script.Parent.DictationWaveform)
local useDictationInputBar = require(script.Parent.useDictationInputBar)
local useDictationTextArea = require(script.Parent.useDictationTextArea)
local DictationAffordances = require(script.Parent.DictationAffordances)

local function lerp(num1: number, num2: number, num3: number): number -- Luacid: Inlined by compiler; 5 call sites recovered
    return num1 + (num2 - num1) * num3
end

local function setTransparency(arg1, arg2) -- Luacid: unused: defined but never referenced
    return arg2:map(function(num1: number): number
        return lerp(arg1, 1, num1)
    end)
end

return React.memo(function(arg1) -- name: DictationInputBar
    local var2 = Foundation.Hooks.useTokens()

    local var3 = useDictationInputBar({
        inputText = arg1.inputText,
        setInputText = arg1.setInputText,
        chatInputBarSettings = arg1.chatInputBarSettings,
        customTextBoxRef = arg1.customTextBoxRef,
        textBoxRef = arg1.textBoxRef,
        targetTextChannel = arg1.targetTextChannel,
        isGlobalChatTabActive = arg1.isGlobalChatTabActive,
        onDictationActivityChanged = arg1.onDictationActivityChanged,
        onDictationStateChanged = arg1.onDictationStateChanged,
        onSendRecordingTap = arg1.onSendRecordingTap,
        onTranscriptionStaged = arg1.onTranscriptionStaged
    })

    local var4 = DictationAffordances.deriveMicSendButton(var3, {
        hasEmptyInputText = arg1.inputText == "",
        idleSendIcon = Foundation.Enums.IconName.PaperAirplane,
        idleSendVariant = Foundation.Enums.ButtonVariant.Emphasis,
        idleSendActivated = arg1.onSendActivated,
        idleSendDisabled = false
    })

    local var5 = DictationAffordances.deriveBackgroundColors(var3, {
        defaultColor3 = arg1.chatInputBarSettings.BackgroundColor3,
        defaultTransparency = arg1.chatInputBarBackgroundTransparency,
        listeningColor3 = var2.Color.Shift.Shift_200.Color3,
        listeningTransparency = var2.Color.Shift.Shift_200.Transparency
    })
    local backgroundStyle = React.useMemo(function()
        return arg1.transparencyValue:map(function(num1: number)
            return {
                Color3 = var5.color3,
                Transparency = lerp(var5.baseTransparency, 1, num1)
            }
        end)
    end, { arg1.transparencyValue, var5.color3, var5.baseTransparency })

    local var7 = DictationAffordances.shouldPreventFade(var3, var1)
    local groupTransparency = React.useMemo(function()
        if var7 then
            return arg1.transparencyValue:map(function(_: number): number
                return 0
            end)
        end
        return arg1.transparencyValue
    end, { var7, arg1.transparencyValue })

    local var9 = useDictationTextArea(
        var3,
        {
            transparencyValue = arg1.transparencyValue,
            showPlaceholderText = arg1.showPlaceholderText
        }
    )
    local useLongPressOverlay = var4.useLongPressOverlay
    local micGestureHandlers = var3.micGestureHandlers

    local createElement = React.createElement
    local view = Foundation.View
    local tbl1 = {
        Name = "Background",
        tag = "row align-y-center gap-small size-full-0 auto-y padding-x-xsmall radius-medium",
        backgroundStyle = backgroundStyle,
        stroke = 0
    }
    local stroke = {
        Color = Config.ChatInputBarBorderColor3,
        Transparency = 0
    }
    local chatInputBarBorderTransparency = Config.ChatInputBarBorderTransparency

    stroke.Transparency = arg1.transparencyValue:map(function(num1: number): number
        return lerp(chatInputBarBorderTransparency, 1, num1)
    end)

    tbl1.stroke = stroke

    local tbl3 = {
        StopCountdown = React.createElement(StopCountdown, {
            LayoutOrder = 1,
            countdownProgress = var3.dictation.bindings.countdownProgress,
            onActivated = var3.dictation.stopDictation,
            Visible = var3.dictation.bindings.isRecording
        }),
        TextArea = 0,
        MicButton = 0,
        FTUX = 0,
        SendIcon = 0
    }
    local createElement2 = React.createElement
    local str1 = "Frame"
    local tbl4 = {
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder = 2,
        Size = UDim2.fromScale(0, 0),
        SelectionBehaviorDown = arg1.selectionBehavior,
        SelectionBehaviorLeft = arg1.selectionBehavior,
        SelectionBehaviorRight = arg1.selectionBehavior,
        SelectionBehaviorUp = arg1.selectionBehavior,
        SelectionGroup = arg1.selectionGroup
    }
    local tbl5 = {
        TargetChannelChip = 0,
        DisabledPlaceholderLabel = 0,
        TextBoxContainer = 0,
        WaveformOverlay = 0,
        UIFlexItem = 0
    }
    local createElement3 = React.createElement
    local var10 = ChannelChip
    local tbl6 = {
        transparency = 0,
        onAbsoluteSizeChanged = 0,
        onChannelChipActivated = 0,
        targetTextChannelDisplayName = 0,
        isChannelBarVisible = 0,
        developerChannelTabsEnabled = 0
    }
    local num1 = 0

    tbl6.transparency = arg1.transparencyValue:map(function(num2: number): number
        return lerp(num1, 1, num2)
    end)

    tbl6.onAbsoluteSizeChanged = arg1.onChannelChipAbsoluteSizeChanged
    tbl6.onChannelChipActivated = arg1.onChannelChipActivated
    tbl6.targetTextChannelDisplayName = arg1.targetTextChannelDisplayName or ""
    tbl6.isChannelBarVisible = arg1.isChannelBarVisible
    tbl6.developerChannelTabsEnabled = arg1.developerChannelTabsEnabled
    tbl5.TargetChannelChip = createElement3(var10, tbl6)

    local bool1 = not arg1.canLocalUserChat

    if bool1 then
        local createElement4 = React.createElement
        local str2 = "TextLabel"

        local tbl7 = {
            AnchorPoint = Vector2.new(1, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Font = Config.ChatInputBarFont,
            Text = arg1.disabledChatPlaceholderText,
            Position = UDim2.fromScale(1, 0),
            Size = arg1.targetChannelWidth:map(function(num2: number): UDim2
                return UDim2.new(1, -(num2 + 8), 0, 0)
            end),
            TextColor3 = arg1.showPlaceholderText and arg1.chatInputBarSettings.PlaceholderColor3 or arg1.chatInputBarSettings.TextColor3,
            TextSize = if arg1.isSpatialUIEnabled then arg1.chatInputBarSettings.SpatialPanelTextSize else arg1.chatInputBarSettings.TextSize,
            TextTransparency = 0,
            Selectable = 0,
            SelectionImageObject = 0,
            TextWrapped = true,
            TextXAlignment = 0,
            TextYAlignment = 0,
            ref = 0
        }

        local num2 = if arg1.showPlaceholderText then 0.5 else 0

        tbl7.TextTransparency = arg1.transparencyValue:map(function(num3: number): number
            return lerp(num2, 1, num3)
        end)
        tbl7.Selectable = arg1.isPlaceholderSelectable
        tbl7.SelectionImageObject = arg1.placeholderSelectionImageObject

        tbl7.TextXAlignment = Enum.TextXAlignment.Left
        tbl7.TextYAlignment = Enum.TextYAlignment.Top
        tbl7.ref = arg1.placeholderRef
        bool1 = createElement4(str2, tbl7)
    end

    tbl5.DisabledPlaceholderLabel = bool1
    local var11

    if arg1.canLocalUserChat then
        local createElement4 = React.createElement
        local str2 = "Frame"

        local tbl7 = {
            AnchorPoint = Vector2.new(1, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Position = UDim2.fromScale(1, 0),
            Size = arg1.targetChannelWidth:map(function(num2: number): UDim2
                return UDim2.new(1, -(num2 + 8), 0, 0)
            end)
        }

        local tbl8 = {
            TextBox = React.createElement("TextBox", {
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.XY,
                BackgroundTransparency = 1,
                ClearTextOnFocus = false,
                FontFace = arg1.chatInputBarSettings.FontFace,
                PlaceholderText = arg1.showPlaceholderText and arg1.placeholderText or "",
                Selectable = arg1.isTextBoxSelectable,
                SelectionImageObject = arg1.cursor,
                Size = UDim2.fromScale(1, 0),
                Text = "",
                PlaceholderColor3 = arg1.chatInputBarSettings.PlaceholderColor3,
                TextColor3 = arg1.chatInputBarSettings.TextColor3,
                TextSize = if arg1.isSpatialUIEnabled then arg1.chatInputBarSettings.SpatialPanelTextSize else arg1.chatInputBarSettings.TextSize,
                TextTransparency = var9.textTransparency,
                TextStrokeTransparency = var9.textStrokeTransparency,
                TextStrokeColor3 = arg1.chatInputBarSettings.TextStrokeColor3,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
                ZIndex = 2,
                [React.Event.Focused] = arg1.onFocused,
                [React.Event.FocusLost] = arg1.onFocusLost,
                [React.Change.Text] = arg1.onTextChanged,
                [React.Event.ReturnPressedFromOnScreenKeyboard] = arg1.onReturnPressedFromOnScreenKeyboard,
                ref = if arg1.chatInputBarSettings.TextBox then arg1.customTextBoxRef else arg1.textBoxRef
            })
        }
        var11 = createElement4(str2, tbl7, tbl8) or nil
    else
        var11 = nil
    end

    tbl5.TextBoxContainer = var11

    local createElement4 = React.createElement
    local str2 = "Frame"
    local tbl7 = {
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.fromScale(0, 0.5),
        Size = UDim2.new(
            1,
            0,
            0,
            if arg1.isSpatialUIEnabled then arg1.chatInputBarSettings.SpatialPanelTextSize else arg1.chatInputBarSettings.TextSize
        ),
        Visible = var3.dictation.bindings.isAudioActive,
        ZIndex = 3
    }
    local tbl8 = {
        List = React.createElement(DictationWaveform, {
            isActive = var3.isRecording or var3.isListening,
            audioDeviceInput = var3.dictation.audioDeviceInput,
            transcribedSamplesBinding = var3.transcribedSamplesBinding,
            transparencyValue = if var3.isListening and not var7 then arg1.transparencyValue else nil,
            onSample = var3.onWaveformSample
        })
    }
    tbl5.WaveformOverlay = createElement4(str2, tbl7, tbl8)

    tbl5.UIFlexItem = React.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.Fill })
    tbl3.TextArea = createElement2(str1, tbl4, tbl5)

    local createElement5 = React.createElement
    local view2 = Foundation.View
    local tbl9 = {
        ref = var3.micButtonSlotRef,
        tag = "auto-xy padding-xsmall",
        GroupTransparency = groupTransparency,
        LayoutOrder = 3
    }
    local tbl10 = {
        IconButton = React.createElement(Foundation.IconButton, {
            icon = var4.icon,
            size = Foundation.Enums.InputSize.Small,
            variant = var4.variant,
            isCircular = true,
            isDisabled = var4.isDisabled,
            onActivated = useLongPressOverlay and function() end or var4.onActivated,
            Selectable = not useLongPressOverlay and nil
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

    tbl10.InputTarget = element
    tbl3.MicButton = createElement5(view2, tbl9, tbl10)
    local element2 = if FFlagExpChatDictationFTUX and var3.ftux and var3.ftux.shouldShow then React.createElement(
        DictationFTUX,
        {
            anchorRef = var3.micButtonSlotRef,
            onDismiss = if FFlagExpChatDictationFTUX then var3.ftux.dismiss else nil
        }
    ) else nil
    tbl3.FTUX = element2

    tbl3.SendIcon = React.createElement(Foundation.Icon, {
        name = Foundation.Enums.IconName.PaperAirplane,
        style = {
            Color3 = arg1.chatInputBarSettings.PlaceholderColor3,
            Transparency = 0
        },
        size = Foundation.Enums.IconSize.Small,
        Visible = false
    })
    return createElement(view, tbl1, tbl3)
end)
