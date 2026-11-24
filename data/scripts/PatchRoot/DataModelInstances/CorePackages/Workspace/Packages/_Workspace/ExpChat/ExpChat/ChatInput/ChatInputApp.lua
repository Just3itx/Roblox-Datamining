-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:50:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local ExpChat = script:FindFirstAncestor("ExpChat")
local GetTransparencyStore = require(ExpChat.Stores.GetTransparencyStore)
local Localization = require(ExpChat.Localization)
local LocalizationService = game:GetService("LocalizationService")

local ExpChatParent = ExpChat.Parent
local ExpChatShared = require(ExpChatParent.ExpChatShared)
local Roact = require(ExpChatParent.Roact)
local React = require(ExpChatParent.React)
local RoactRodux = require(ExpChatParent.RoactRodux)
local Signals = require(ExpChatParent.Signals)
local SignalsReact = require(ExpChatParent.SignalsReact)
local tutils = require(ExpChatParent.tutils)
local Config = require(ExpChat.Config)
local InputType = require(ExpChatParent.InputType)
local getInputGroup = require(ExpChatParent.InputType).getInputGroup
local SharedFlags = require(ExpChatParent.SharedFlags)

local FocusChatHotKeyActivated = require(ExpChat.Actions.FocusChatHotKeyActivated)
local AutocompleteDropdownActivated = require(ExpChat.Actions.AutocompleteDropdownActivated)
local AutocompleteDropdownResultsChanged = require(ExpChat.Actions.AutocompleteDropdownResultsChanged)
local AutocompleteDropdownSelectionChanged = require(ExpChat.Actions.AutocompleteDropdownSelectionChanged)
local AutocompleteDropdownTypeChanged = require(ExpChat.Actions.AutocompleteDropdownTypeChanged)
local AutocompleteDropdownDeactivated = require(ExpChat.Actions.AutocompleteDropdownDeactivated)
local bool1 = game:DefineFastFlag("MemoizeChatInputApp", false)

local FFlagEnableConsoleExpControls = SharedFlags.FFlagEnableConsoleExpControls
local FFlagLuaSupportMicroGamepadPreferredInput = SharedFlags.FFlagLuaSupportMicroGamepadPreferredInput
local FFlagExpChatUseChannelTabsStore = SharedFlags.FFlagExpChatUseChannelTabsStore
local GetFFlagTextChatEnableUniverseChatTabs = ExpChatShared.Flags.GetFFlagTextChatEnableUniverseChatTabs
local GetChannelTabsStore = if FFlagExpChatUseChannelTabsStore then require(ExpChat.Stores.GetChannelTabsStore) else nil
local Flags = ExpChat.Flags
local getFFlagUnreduxLastInputTypeChanged = require(Flags.getFFlagUnreduxLastInputTypeChanged)
local FFlagExpChatDictationFadeOverride = require(Flags.FFlagExpChatDictationFadeOverride)
local FFlagExpChatContinuousDictationIdleFade = require(Flags.FFlagExpChatContinuousDictationIdleFade)

local selectSelectedTabName = require(ExpChat.selectSelectedTabName)

local UI = script.Parent.UI
local ChatInputBar = require(UI.ChatInputBar)
local DictationState = require(UI.ChatInputBar.Dictation.DictationState)

local Localization2 = require(ExpChatParent.InExperienceLocales).Localization
local Cryo = require(ExpChatParent.Cryo)

local var1 = (if getFFlagUnreduxLastInputTypeChanged() then Roact.PureComponent else Roact.Component):extend("ChatInputBarApp")

var1.defaultProps = {
    addTopPadding = true,
    LayoutOrder = 1,
    onSendChat = nil,
    transparencyValue = Roact.createBinding(0.3)
}

if getFFlagUnreduxLastInputTypeChanged() then
    function var1.init(arg1)
        arg1:setState({
            isUsingTouch = UserInputService.TouchEnabled,
            isUsingGamepad = UserInputService.PreferredInput == Enum.PreferredInput.Gamepad
                or FFlagLuaSupportMicroGamepadPreferredInput and UserInputService.PreferredInput == Enum.PreferredInput.MicroGamepad
        })

        arg1.connection = UserInputService.LastInputTypeChanged:Connect(function(lastInputType: Enum.UserInputType)
            local inputGroup = getInputGroup(lastInputType)

            arg1:setState({
                isUsingTouch = inputGroup == InputType.InputTypeConstants.Touch,
                isUsingGamepad = inputGroup == InputType.InputTypeConstants.Gamepad
            })
        end)
    end

    function var1.getPlaceholderText(arg1)
        if arg1.state.isUsingGamepad then
            return arg1.props.placeholderGamepadText
        end

        if arg1.state.isUsingTouch then
            return arg1.props.placeholderTouchText
        end

        return arg1.props.placeholderKeyboardText
    end

    function var1.willUnmount(arg1)
        if arg1.connection then
            arg1.connection:Disconnect()
        end
    end
else
    function var1.getPlaceholderText(arg1)
        if arg1.props.isUsingGamepad then
            return arg1.props.placeholderGamepadText
        end

        if arg1.props.isUsingTouch then
            return arg1.props.placeholderTouchText
        end

        return arg1.props.placeholderKeyboardText
    end
end

function var1.render(arg1)
    return React.createElement(ChatInputBar, {
        userInputService = UserInputService,
        contextActionService = game:GetService("ContextActionService"),
        messageCharacterLimit = Config.MessageCharacterLimit,
        sendButtonContainerWidth = 30,
        addTopPadding = arg1.props.addTopPadding,
        LayoutOrder = arg1.props.LayoutOrder,
        placeholderText = arg1:getPlaceholderText(),
        disabledChatPlaceholderText = arg1.props.disabledChatPlaceholderText,
        size = UDim2.fromScale(1, 0),
        chatIntervention = arg1.props.chatIntervention,
        onSendChat = arg1.props.onSendChat,
        onSendGlobalChat = arg1.props.onSendGlobalChat,
        transparencyValue = arg1.props.transparencyValue,
        canLocalUserChat = arg1.props.canLocalUserChat,
        targetTextChannel = arg1.props.targetTextChannel,
        localTeam = arg1.props.localTeam,
        localPlayer = arg1.props.localPlayer,
        defaultSystemTextChannel = arg1.props.defaultSystemTextChannel,
        shouldFocusChatInputBar = arg1.props.shouldFocusChatInputBar,
        resetTargetChannel = arg1.props.resetTargetChannel,
        focusChatHotKeyActivated = arg1.props.focusChatHotKeyActivated,
        devDefinedFocusKeyCode = arg1.props.devDefinedFocusKeyCode,
        visible = arg1.props.visible,
        onFocus = arg1.props.onFocus,
        onUnfocus = arg1.props.onUnfocus,
        onHovered = arg1.props.onHovered,
        onUnhovered = arg1.props.onUnhovered,
        onAbsoluteSizeChanged = arg1.props.onAbsoluteSizeChanged,
        onAbsolutePositionChanged = arg1.props.onAbsolutePositionChanged,
        chatWindowSettings = arg1.props.chatWindowSettings,
        chatInputBarSettings = arg1.props.chatInputBarSettings,
        isChatHotkeyEnabled = arg1.props.isChatHotkeyEnabled,
        autocompleteDropdownReducer = arg1.props.autocompleteDropdownReducer,
        autocompleteDropdownActivated = arg1.props.autocompleteDropdownActivated,
        autocompleteDropdownResultsChanged = arg1.props.autocompleteDropdownResultsChanged,
        autocompleteDropdownSelectionChanged = arg1.props.autocompleteDropdownSelectionChanged,
        autocompleteDropdownTypeChanged = arg1.props.autocompleteDropdownTypeChanged,
        autocompleteDropdownDeactivated = arg1.props.autocompleteDropdownDeactivated,
        autocompleteEnabled = arg1.props.autocompleteEnabled,
        isChannelBarVisible = arg1.props.isChannelBarVisible,
        isGlobalChatTabActive = arg1.props.isGlobalChatTabActive,
        developerChannelTabsEnabled = arg1.props.developerChannelTabsEnabled,
        onDictationActivityChanged = arg1.props.onDictationActivityChanged,
        onDictationStateChanged = arg1.props.onDictationStateChanged
    })
end

local var2 = RoactRodux.connect(function(arg1)
    local var2, channelTabsConfigurationEnabled

    if FFlagExpChatUseChannelTabsStore then
        var2 = nil
        channelTabsConfigurationEnabled = nil
    else
        local channelTabs = arg1.ChannelTabs
        var2 = GetFFlagTextChatEnableUniverseChatTabs() and selectSelectedTabName(arg1) == "RBXGlobal"
        if GetFFlagTextChatEnableUniverseChatTabs() and channelTabs then
            channelTabsConfigurationEnabled = channelTabs.channelTabsConfigurationEnabled
        else
            channelTabsConfigurationEnabled = false
        end
    end

    return {
        targetTextChannel = arg1.TextChannels.targetTextChannel,
        localPlayer = Players.LocalPlayer,
        localTeam = arg1.LocalTeam,
        isUsingTouch = if getFFlagUnreduxLastInputTypeChanged() then nil else arg1.isUsingTouch,
        isUsingGamepad = if getFFlagUnreduxLastInputTypeChanged() then nil else arg1.isUsingGamepad,
        devDefinedFocusKeyCode = arg1.ChatLayout.ChatInputBarSettings.KeyboardKeyCode,
        defaultSystemTextChannel = arg1.TextChannels.allTextChannels.RBXSystem,
        shouldFocusChatInputBar = arg1.shouldFocusChatInputBar,
        chatInputBarSettings = arg1.ChatLayout.ChatInputBarSettings,
        chatIntervention = arg1.ChatIntervention,
        isChatHotkeyEnabled = arg1.ChatVisibility.isChatHotkeyEnabled.value,
        autocompleteDropdownReducer = arg1.AutocompleteDropdown,
        autocompleteEnabled = arg1.ChatLayout.ChatInputBarSettings.AutocompleteEnabled,
        isGlobalChatTabActive = var2,
        developerChannelTabsEnabled = channelTabsConfigurationEnabled
    }
end, function(arg1)
    local transparencyStore = GetTransparencyStore(false)
    local var2 = FFlagExpChatDictationFadeOverride and FFlagExpChatContinuousDictationIdleFade

    local function setDictationHold(bool2: boolean) -- Luacid: Inlined by compiler; 1 call site recovered
        if bool2 then
            transparencyStore.setDictationActive()
            return
        end
        transparencyStore.clearDictationActive()
    end

    local module = {
        focusChatHotKeyActivated = function()
            return arg1(FocusChatHotKeyActivated())
        end,
        onFocus = function()
            return transparencyStore.setTextboxFocus()
        end,
        onUnfocus = function()
            return transparencyStore.clearTextboxFocus()
        end,
        onHovered = function()
            return transparencyStore.resetAllTransparency()
        end,
        onUnhovered = function()
            return transparencyStore.resetAllTransparency()
        end,
        onDictationActivityChanged = if FFlagExpChatDictationFadeOverride and not var2 then setDictationHold else nil,
        onDictationStateChanged = var2 and function(arg2)
            setDictationHold(arg2 == DictationState.Recording or arg2 == DictationState.Transcribing)
        end or nil,
        autocompleteDropdownActivated = 0,
        autocompleteDropdownResultsChanged = 0,
        autocompleteDropdownSelectionChanged = 0,
        autocompleteDropdownTypeChanged = 0,
        autocompleteDropdownDeactivated = 0
    }

    function module.autocompleteDropdownActivated(arg2)
        return arg1(AutocompleteDropdownActivated(arg2))
    end

    function module.autocompleteDropdownResultsChanged(arg2, arg3)
        return arg1(AutocompleteDropdownResultsChanged(arg2, arg3))
    end

    function module.autocompleteDropdownSelectionChanged(arg2)
        return arg1(AutocompleteDropdownSelectionChanged(arg2))
    end

    function module.autocompleteDropdownTypeChanged(arg2)
        return arg1(AutocompleteDropdownTypeChanged(arg2))
    end

    function module.autocompleteDropdownDeactivated()
        return arg1(AutocompleteDropdownDeactivated())
    end

    return module
end)(Localization.connect(function(arg1)
    return {
        placeholderKeyboardText = {
            "CoreScripts.TextChat.InputBar.Hint.MouseKeyboard",
            {
                KEY = UserInputService:GetStringForKeyCode(arg1.devDefinedFocusKeyCode)
            }
        },
        placeholderTouchText = "CoreScripts.TextChat.InputBar.Hint.Touch",
        disabledChatPlaceholderText = "CoreScripts.TextChat.InputBar.Hint.PrivacySettingsDisabled"
    }
end)(var1))

local var3 = FFlagExpChatUseChannelTabsStore and function(arg1) -- name: ResultComponentWithSignals
    local var3 = React.useMemo(function()
        return Signals.createComputed(function(arg2)
            local var3 = GetChannelTabsStore(false).getChannelTabsState(arg2)
            return {
                developerChannelTabsEnabled = if GetFFlagTextChatEnableUniverseChatTabs() then var3.channelTabsConfigurationEnabled else false,
                isGlobalChatTabActive = GetFFlagTextChatEnableUniverseChatTabs() and var3.selectedTabName == "RBXGlobal"
            }
        end, tutils.deepEqual)
    end, {})
    local var4 = SignalsReact.useSignalState(var3)
    return React.createElement(var2, Cryo.Dictionary.union(arg1, var4))
end or var2

local function func1(arg1)
    local localization2 = Localization2.new(LocalizationService.RobloxLocaleId)
    local placeholderGamepadText = if FFlagEnableConsoleExpControls then localization2:Format(
        "CoreScripts.TextChat.InputBar.Hint.GamepadConnected",
        {
            CONFIRM_KEY = localization2:Format("CoreScripts.TextChat.InputBar.Hint.GamepadConnectedConfirm")
        }
    ) else localization2:Format(
        "CoreScripts.TextChat.InputBar.Hint.Gamepad",
        {
            CHAT_BUTTON = localization2:Format("CoreScripts.TopBar.Chat")
        }
    )
    local var5 = Cryo.Dictionary.join(arg1, { placeholderGamepadText = placeholderGamepadText })

    return React.createElement(var3, var5)
end

if bool1 then
    return (React.memo(func1))
end

return func1
