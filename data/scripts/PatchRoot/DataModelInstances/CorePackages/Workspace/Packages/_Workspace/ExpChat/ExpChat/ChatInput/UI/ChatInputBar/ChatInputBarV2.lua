-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:50:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local React = require(ExpChatParent.React)
local Foundation = require(ExpChatParent.Foundation)
local ExpChatShared = require(ExpChatParent.ExpChatShared)

local Config = require(ExpChat.Config)
local ChannelChip = require(script.Parent.ChannelChip)

local FFlagEnableConsoleExpControls = require(ExpChatParent.SharedFlags).FFlagEnableConsoleExpControls
local FFlagExpChatInputBarV2CustomSendButton = require(ExpChat.Flags.FFlagExpChatInputBarV2CustomSendButton)

local FFlagExpChatInputBarV2CornerAndTruncationFix = require(ExpChat.Flags.FFlagExpChatInputBarV2CornerAndTruncationFix)
local FFlagExpChatComposerInputBarFigmaParity = require(ExpChat.Flags.FFlagExpChatComposerInputBarFigmaParity)

local FFlagExpChatPresetChatEnabled = ExpChatShared.Flags.FFlagExpChatPresetChatEnabled
local FFlagExpChatFixBackspaceNilTargetChannel = ExpChatShared.Flags.FFlagExpChatFixBackspaceNilTargetChannel
local FFlagExpChatPresetChatGamepadEnabled = require(ExpChat.Flags.FFlagExpChatPresetChatGamepadEnabled)

local function renderCustomSendButton(tbl1, arg1, hasEmptyInputText: boolean?, func1: (...any) -> (...any))
    local var1 = if hasEmptyInputText then arg1.Color.ActionStandard else arg1.Color.ActionEmphasis
    local size800 = arg1.Size.Size_800

    local createElement = React.createElement
    local str1 = "CanvasGroup"
    local tbl2 = {
        AnchorPoint = Vector2.new(1, 0),
        BackgroundTransparency = 1,
        GroupTransparency = if hasEmptyInputText then tbl1.setTransparency(0.5, tbl1.transparencyValue) else tbl1.transparencyValue,
        Position = UDim2.fromScale(1, 0),
        Size = UDim2.new(0, tbl1.sendButtonContainerWidth + 6, 1, 0)
    }
    local tbl3 = {
        Layout = React.createElement(
            "UIListLayout",
            {
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center
            }
        ),
        SendButton = 0
    }

    local createElement2 = React.createElement
    local str2 = "TextButton"
    local tbl4 = {
        AutoButtonColor = false,
        BackgroundColor3 = var1.Background.Color3,
        BackgroundTransparency = var1.Background.Transparency,
        BorderSizePixel = 0,
        Selectable = not hasEmptyInputText and (if FFlagExpChatPresetChatGamepadEnabled then nil else false),
        Size = UDim2.fromOffset(size800, size800),
        Text = ""
    }
    local activated = React.Event.Activated

    if hasEmptyInputText then
        func1 = nil
    end

    tbl4[activated] = func1
    tbl3.SendButton = createElement2(str2, tbl4, {
        UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(1, 0) }),
        IconLayout = React.createElement(
            "UIListLayout",
            {
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center
            }
        ),
        Icon = React.createElement(
            Foundation.Icon,
            {
                name = Foundation.Enums.IconName.ArrowMediumUp,
                size = Foundation.Enums.IconSize.Small,
                style = var1.Foreground
            }
        )
    })
    return createElement(str1, tbl2, tbl3)
end

return React.memo(function(tbl1) -- name: ChatInputBarV2
    local var1 = Foundation.Hooks.useTokens()
    local setTransparency = tbl1.setTransparency
    local chatInputBarSettings = tbl1.chatInputBarSettings
    local chatInputBarBackgroundTransparency = tbl1.chatInputBarBackgroundTransparency
    local isSpatialUiEnabled = tbl1.isSpatialUIEnabled
    local canLocalUserChatDerived = tbl1.canLocalUserChatDerived
    local targetChannelWidth = tbl1.targetChannelWidth
    local showPlaceholderText = tbl1.showPlaceholderText
    local hasEmptyInputText = tbl1.hasEmptyInputText
    local cursor = tbl1.cursor
    local placeholderRef = tbl1.placeholderRef
    local textBoxRef = tbl1.textBoxRef
    local customTextBoxRef = tbl1.customTextBoxRef
    local onAbsoluteSizeChanged = tbl1.onAbsoluteSizeChanged
    local onFocused = tbl1.onFocused
    local onFocusLost = tbl1.onFocusLost
    local onTextChanged = tbl1.onTextChanged
    local onReturnPressedFromOnScreenKeyboard = tbl1.onReturnPressedFromOnScreenKeyboard
    local onSendActivated = tbl1.onSendActivated

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
    local str3 = "Frame"
    local tbl6 = {
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = chatInputBarSettings.BackgroundColor3,
        BackgroundTransparency = setTransparency(chatInputBarBackgroundTransparency, tbl1.transparencyValue),
        LayoutOrder = 1,
        Position = UDim2.fromScale(0, 0),
        Size = UDim2.fromScale(1, 0)
    }
    local tbl7 = {
        UICorner = React.createElement(
            "UICorner",
            {
                CornerRadius = if FFlagExpChatInputBarV2CornerAndTruncationFix then UDim.new(0, 20) else UDim.new(1, 0)
            }
        ),
        UIStroke = React.createElement("UIStroke", {
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            Color = var1.Color.Stroke.Default.Color3,
            Transparency = setTransparency(var1.Color.Stroke.Default.Transparency, tbl1.transparencyValue)
        }),
        UIPadding = React.createElement("UIPadding", { PaddingRight = UDim.new(0, 2) }),
        TextContainer = 0,
        SendButtonContainer = 0
    }
    local createElement4 = React.createElement
    local str4 = "Frame"
    local tbl8 = {
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        Position = UDim2.fromScale(0, 0),
        Size = UDim2.new(1, -(tbl1.sendButtonContainerWidth + 6), 0, 0)
    }

    local tbl9 = {
        TargetChannelChip = React.createElement(ChannelChip, {
            transparency = setTransparency(0, tbl1.transparencyValue),
            onAbsoluteSizeChanged = onAbsoluteSizeChanged,
            onChannelChipActivated = FFlagExpChatFixBackspaceNilTargetChannel and function()
                tbl1.resetTargetChannel(tbl1.isGlobalChatTabActive)
            end or tbl1.resetTargetChannel,
            targetTextChannelDisplayName = tbl1.targetTextChannelDisplayName or "",
            isChannelBarVisible = tbl1.isChannelBarVisible,
            developerChannelTabsEnabled = tbl1.developerChannelTabsEnabled
        }),
        DisabledPlaceholderLabel = 0,
        TextBoxContainer = 0,
        UIPadding = 0
    }
    local bool1 = not canLocalUserChatDerived

    if bool1 then
        local createElement5 = React.createElement
        local str5 = "TextLabel"

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
            ref = placeholderRef
        }

        bool1 = createElement5(str5, tbl10)
    end

    tbl9.DisabledPlaceholderLabel = bool1

    if canLocalUserChatDerived then
        local createElement5 = React.createElement
        local str5 = "Frame"

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
            local createElement6 = React.createElement
            local str6 = "TextBox"
            local tbl12 = {
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
                    and chatInputBarSettings.PlaceholderColor3 == Config.ChatInputBarPlaceholderColor then var1.DarkMode.Content.Default.Color3 else chatInputBarSettings.PlaceholderColor3,
                TextColor3 = chatInputBarSettings.TextColor3,
                TextSize = if isSpatialUiEnabled then chatInputBarSettings.SpatialPanelTextSize else chatInputBarSettings.TextSize,
                TextTransparency = setTransparency(
                    if showPlaceholderText and not FFlagExpChatComposerInputBarFigmaParity then 0.5 else 0,
                    tbl1.transparencyValue
                ),
                TextStrokeTransparency = setTransparency(chatInputBarSettings.TextStrokeTransparency, tbl1.transparencyValue),
                TextStrokeColor3 = chatInputBarSettings.TextStrokeColor3,
                TextWrapped = if FFlagExpChatInputBarV2CornerAndTruncationFix then not showPlaceholderText else not (FFlagExpChatPresetChatEnabled and showPlaceholderText and tbl1.shouldTruncatePlaceholder),
                TextTruncate = if FFlagExpChatInputBarV2CornerAndTruncationFix and showPlaceholderText then Enum.TextTruncate.AtEnd elseif FFlagExpChatPresetChatEnabled and showPlaceholderText then Enum.TextTruncate.AtEnd else nil,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
                ZIndex = 2,
                [React.Event.Focused] = onFocused,
                [React.Event.FocusLost] = onFocusLost,
                [React.Change.Text] = onTextChanged,
                [React.Event.ReturnPressedFromOnScreenKeyboard] = onReturnPressedFromOnScreenKeyboard
            }

            if chatInputBarSettings.TextBox then
                textBoxRef = customTextBoxRef
            end

            tbl12.ref = textBoxRef
            canLocalUserChatDerived = createElement6(str6, tbl12)
        end

        tbl11.TextBox = canLocalUserChatDerived
        canLocalUserChatDerived = createElement5(str5, tbl10, tbl11)
    end

    tbl9.TextBoxContainer = canLocalUserChatDerived

    tbl9.UIPadding = React.createElement("UIPadding", {
        PaddingBottom = UDim.new(0, 10),
        PaddingLeft = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10),
        PaddingTop = UDim.new(0, 10)
    })
    tbl7.TextContainer = createElement4(str4, tbl8, tbl9)
    local var2

    if FFlagExpChatInputBarV2CustomSendButton then
        var2 = renderCustomSendButton(tbl1, var1, hasEmptyInputText, onSendActivated)
    else
        local createElement5 = React.createElement
        local str5 = "CanvasGroup"
        local tbl10 = {
            AnchorPoint = Vector2.new(1, 0),
            BackgroundTransparency = 1,
            GroupTransparency = tbl1.transparencyValue,
            Position = UDim2.fromScale(1, 0),
            Size = UDim2.new(0, tbl1.sendButtonContainerWidth + 6, 1, 0)
        }
        local tbl11 = {
            Layout = React.createElement(
                "UIListLayout",
                {
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    VerticalAlignment = Enum.VerticalAlignment.Center
                }
            ),
            SendButton = React.createElement(Foundation.IconButton, {
                icon = Foundation.Enums.IconName.ArrowMediumUp,
                variant = if hasEmptyInputText then Foundation.Enums.ButtonVariant.Standard else Foundation.Enums.ButtonVariant.Emphasis,
                size = Foundation.Enums.InputSize.Small,
                isCircular = true,
                isDisabled = hasEmptyInputText,
                Selectable = if FFlagExpChatPresetChatGamepadEnabled then nil else false,
                onActivated = onSendActivated
            })
        }
        var2 = createElement5(str5, tbl10, tbl11)
    end

    tbl7.SendButtonContainer = var2
    tbl5.InputGroup = createElement3(str3, tbl6, tbl7)
    tbl3.Container = createElement2(str2, tbl4, tbl5)
    return createElement(str1, tbl2, tbl3)
end)
