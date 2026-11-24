-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:50:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local React = require(ExpChatParent.React)
local ReactFocusNavigation = require(ExpChatParent.ReactFocusNavigation)
local ExpChatShared = require(ExpChatParent.ExpChatShared)
local FocusUtils = require(ExpChatParent.Chrome).FocusUtils
local useFocusInputBar = require(ExpChatParent.ChatUIPrimitives).Hooks.useFocusInputBar
local useInputBarTabNavigation = require(ExpChatParent.ChatUIPrimitives).Hooks.useInputBarTabNavigation

local GetMessagesStore = require(ExpChat.Stores.GetMessagesStore)
local IXPServiceWrapper = require(ExpChatParent.IxpServiceWrapper).IXPServiceWrapper
local GetChatTooltipStore = require(ExpChat.Stores.GetChatTooltipStore)

local UIBlox = require(ExpChatParent.UIBlox)
local Promise = require(ExpChatParent.Promise)
local Signals = require(ExpChatParent.Signals)
local SignalsReact = require(ExpChatParent.SignalsReact)
local List = require(ExpChatParent.llama).List
local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local useCursor = UIBlox.App.SelectionCursor.useCursor

local useInterpolatedClientSettings = require(ExpChat.ClientSettings.useInterpolatedClientSettings)
local Config = require(ExpChat.Config)
local GetFocusNavigationStore = require(ExpChat.Stores.GetFocusNavigationStore)
local GetPresetChatStore = require(ExpChat.Stores.GetPresetChatStore)
local var1 = ExpChatShared.Logger:new("ExpChat/" .. script.Name)
local autoCastCommand = ExpChatShared.Commands.autoCastCommand
local RBXWhisperCommand = ExpChatShared.Commands.Whisper.RBXWhisperCommand
local RBXTeamCommand = ExpChatShared.Commands.RBXTeamCommand

local Localization = require(ExpChat.Localization)
local getOtherDisplayNameInWhisperChannel = require(ExpChat.getOtherDisplayNameInWhisperChannel)

local ChannelChip = require(script.Parent.ChannelChip)

local AutocompleteText = require(ExpChat.Autocomplete.AutocompleteText)
local PresetEntryText = require(ExpChat.Autocomplete.PresetEntryText)
local PresetSearch = require(ExpChat.Autocomplete.PresetSearch)
local Constants = require(ExpChat.PresetChat.Constants)
local sendPreset = require(ExpChat.PresetChat.sendPreset)
local initializeEmojis = require(ExpChat.Autocomplete.Initializations.initializeEmojis)
local initializeCommands = require(ExpChat.Autocomplete.Initializations.initializeCommands)
local initializeGlobalCommands = require(ExpChat.Autocomplete.Initializations.initializeGlobalCommands)
local initialCommands = require(ExpChat.Autocomplete.Initializations.initialCommands)
local sortEmojiResultsCallback = require(ExpChat.Autocomplete.SortingCallbacks.sortEmojiResultsCallback)
local sortCommandResultsCallback = require(ExpChat.Autocomplete.SortingCallbacks.sortCommandResultsCallback)

local ChatInput = script:FindFirstAncestor("ChatInput")
local AutocompleteDropdown = require(ChatInput.UI.AutocompleteDropdown)

local ChatInputBarV2 = require(script.Parent.ChatInputBarV2)
local ChatInputBarV2Dictation = require(script.Parent.ChatInputBarV2Dictation)
local FFlagExpChatPresetChatEnabled = ExpChatShared.Flags.FFlagExpChatPresetChatEnabled

local FFlagExpChatPresetChatAutocompleteEnabled = require(ExpChat.Flags.FFlagExpChatPresetChatAutocompleteEnabled)

local FFlagExpChatPresetChatAutocompleteAnalyticsEnabled = require(ExpChat.Flags.FFlagExpChatPresetChatAutocompleteAnalyticsEnabled)
local FFlagExpChatEmojiDropdownShowAnalytics = require(ExpChat.Flags.FFlagExpChatEmojiDropdownShowAnalytics)

local FFlagExpChatEmojiDropdownDismissAnalytics = require(ExpChat.Flags.FFlagExpChatEmojiDropdownDismissAnalytics)
local FFlagExpChatUniverseChatPresetEnabled = require(ExpChat.Flags.FFlagExpChatUniverseChatPresetEnabled)
local FFlagExpChatUseUnifiedTooltipStore = ExpChatShared.Flags.FFlagExpChatUseUnifiedTooltipStore
local FFlagExpChatNewInputBar = require(ExpChat.Flags.FFlagExpChatNewInputBar)
local FFlagExpChatAutocompleteDropdownRedesign = require(ExpChat.Flags.FFlagExpChatAutocompleteDropdownRedesign)
local FFlagExpChatNewInputBarDictation = require(ExpChat.Flags.FFlagExpChatNewInputBarDictation)
local FFlagExpChatPresetChatGamepadEnabled = require(ExpChat.Flags.FFlagExpChatPresetChatGamepadEnabled)

local bool1 = game:DefineFastFlag("ExpChatPresetChatIXPExposure", false)
local str1 = game:DefineFastString("ExpChatPresetChatIXPLayerName", "UniverseChat.PresetChat")

local bool2 = game:DefineFastFlag("ExpChatDictationIXPExposure", false)
local str2 = game:DefineFastString("ExpChatDictationIXPLayerName", "UniverseChat.Dictation")

local bool3 = game:DefineFastFlag("ExpChatPresetAutocompleteIxpEnabled", false)
local str3 = game:DefineFastString("ExpChatPresetAutocompleteIxpLayer", "")

local bool4 = game:DefineFastFlag("ExpChatPresetAutocompleteSearchVariants", false)

local FFlagExpChatPresetChatSendEnabled = require(ExpChat.Flags.FFlagExpChatPresetAutocompleteIxpGated) and ExpChatShared.Flags.FFlagExpChatPresetChatSendEnabled

local bool5 = game:DefineFastFlag("ExpChatMainInputBarClickAnalytics", false)

local getEnableChatInputBarConfigurationAutocompleteEnabled = require(ExpChat.Flags.getEnableChatInputBarConfigurationAutocompleteEnabled)

local SharedFlags = require(ExpChatParent.SharedFlags)
local FFlagEnableConsoleExpControls = SharedFlags.FFlagEnableConsoleExpControls
local FFlagChromeChatGamepadSupportFix = SharedFlags.FFlagChromeChatGamepadSupportFix
local FFlagConsoleChatUseChromeFocusUtils = SharedFlags.FFlagConsoleChatUseChromeFocusUtils
local bool6 = game:DefineFastFlag("ChatOptimizeCommandProcessing", false)
local bool7 = game:DefineFastFlag("ExpChatDoNotSetCursorPosition", false)

local FFlagExpChatBackspaceExitsTargetChannelInGlobalTabs = require(ExpChat.Flags.FFlagExpChatBackspaceExitsTargetChannelInGlobalTabs)
local FFlagExpChatFixBackspaceNilTargetChannel = ExpChatShared.Flags.FFlagExpChatFixBackspaceNilTargetChannel
local GetFFlagTextChatEnableUniverseChatTabs = ExpChatShared.Flags.GetFFlagTextChatEnableUniverseChatTabs

local FFlagExpChatDictation = SharedFlags.FFlagExpChatDictation
local FFlagExpChatContinuousDictation = SharedFlags.FFlagExpChatContinuousDictation
local FFlagExpChatTabShortcutNav = SharedFlags.FFlagExpChatTabShortcutNav
local enabled = FFlagExpChatDictation or FFlagExpChatContinuousDictation

local DictationInputBar = require(script.Parent.Dictation.DictationInputBar)
local useSendTelemetry = require(script.Parent.Dictation.useSendTelemetry)
local usePresetAutocompleteAnalytics = require(script.Parent.usePresetAutocompleteAnalytics)

local ExpChatPresetChatAutocompleteExperimentation = require(ExpChatParent.SocialExperiments).ExpChatPresetChatAutocompleteExperimentation

local ActionBindableEvent = ExpChatShared.ActionBindableEvent
local focusNavigationStore = GetFocusNavigationStore(false)
local var3 = ExpChatShared.Flags.FIntPresetChatCooldownLuaMs / 1000

local function setTransparency(arg1, arg2) -- Luacid: Inlined by compiler; 8 call sites recovered
    return arg2:map(function(num1: number): number
        return arg1 + num1 * (1 - arg1)
    end)
end

local var4 = nil
local var5 = nil
local var6 = nil
local var7 = nil
local var8 = nil

local function onChatInputBarFocusLost(callback: ((...any) -> (...any))?, keybinds, callback2): RBXScriptConnection
    local tbl1 = { Enum.KeyCode.ButtonB }
    local var9 = keybinds or tbl1
    local connection = nil
    connection = UserInputService.InputBegan:Connect(function(input: InputObject)
        local keyCode = if input then input.KeyCode else nil

        for _, value in var9 do
            if keyCode ~= value then
                continue
            end

            GuiService:SetMenuIsOpen(false, "ExperienceChat")
            callback2()
            if callback then
                callback()
            else
                GuiService.SelectedCoreObject = nil
            end

            if connection then
                connection:Disconnect()
                connection = nil

                return
            end

            break
        end
    end)

    return connection
end

local function useEffectChatInputBarFocus(arg1, arg2, arg3, callback, callback2)
    if not FFlagConsoleChatUseChromeFocusUtils then
        if FFlagChromeChatGamepadSupportFix then
            React.useEffect(function()
                local var9 = nil
                local var10 = nil

                local connection = ActionBindableEvent.Event:Connect(function(arg4)
                    local current = if arg2.current then arg2.current else arg1.current

                    if not FFlagEnableConsoleExpControls or arg4.type ~= "ChatTopBarFocusSelect" or not current then
                        return
                    end
                    GuiService:SetMenuIsOpen(true, "ExperienceChat")
                    callback()
                    GuiService.SelectedCoreObject = current

                    var10 = task.delay(0, function()
                        var10 = nil
                        if var9 then
                            var9:Disconnect()
                        end
                        var9 = onChatInputBarFocusLost(arg4.onSelectionLost, arg4.keybinds, callback2)
                    end)
                end)

                return function()
                    connection:disconnect()

                    if var10 then
                        task.cancel(var10)
                        var10 = nil
                    end
                    if var9 then
                        var9:Disconnect()
                        var9 = nil
                    end
                end
            end, { arg1.current, arg2.current })
        end
        return
    end

    React.useEffect(function()
        local tbl1 = {}
        local connection = nil

        local effect = Signals.createEffect(function(arg4)
            local chatInputBarFocused = focusNavigationStore.getChatInputBarFocused(arg4)

            local current = (if arg2.current then arg2.current else arg1.current) or arg3.current

            if not current then
                return
            end

            if not chatInputBarFocused then
                if GuiService.MenuIsOpen then
                    GuiService:SetMenuIsOpen(false, "ExperienceChat")
                    callback2()
                    if connection then
                        connection:Disconnect()
                        connection = nil
                    end
                end

                return
            end

            GuiService:SetMenuIsOpen(true, "ExperienceChat")
            callback()
            GuiService.SelectedCoreObject = current

            if connection then
                return
            end

            connection = UserInputService.InputBegan:Connect(function(input: InputObject)
                if input and tbl1[input.KeyCode] then
                    FocusUtils.FocusOnChrome(function()
                        focusNavigationStore.unfocusChatInputBar()
                    end, "chat")
                end
            end)
        end)

        return function()
            effect()

            if connection then
                connection:Disconnect()
                connection = nil
            end
        end
    end, {})
end

local function ChatInputBar(arg1)
    local var9 = React.useRef("")

    if FFlagExpChatUseUnifiedTooltipStore then
        local setIsChatInputBarVisible = GetChatTooltipStore(false).setIsChatInputBarVisible

        React.useEffect(function()
            if arg1.visible ~= nil then
                setIsChatInputBarVisible(arg1.visible)
            else
                setIsChatInputBarVisible(true)
            end
            return function()
                setIsChatInputBarVisible(false)
            end
        end, { arg1.visible, setIsChatInputBarVisible })
    end

    local var10, setInputText = React.useState("")
    local var12, var13 = React.useState(0)
    local var14 = var12
    local var15 = var13
    local var16, var17 = React.useState(0)
    local var18 = var16
    local var19 = var17
    local var20 = if bool5 then React.useRef(false) else nil
    local isFocused, var22 = React.useState(false)
    local var23, _ = React.useState(true)
    local targetChannelWidth, var25 = React.useBinding(0)
    local var26 = React.useRef(false)
    local textBoxRef = React.useRef(nil)
    local customTextBoxRef = React.useRef(nil)
    local var29 = if enabled then useSendTelemetry({ enabled = enabled, textBoxRef = textBoxRef, customTextBoxRef = customTextBoxRef }) else nil
    local var30 = React.useRef(nil)
    local autocompleteDropdownRef = React.useRef(nil)
    local var32 = if FFlagExpChatEmojiDropdownDismissAnalytics then React.useRef(nil) else nil

    local var33 = React.useRef(nil)
    local var34 = React.useRef(nil)
    local var35 = React.useRef(false)
    local var36 = ReactFocusNavigation.useFocusGuiObject()

    local var37 = SignalsReact.useSignalState(focusNavigationStore.getChatInputBarFocused)

    local messagesStore = GetMessagesStore(false)
    local canLocalUserChatDerived = SignalsReact.useSignalState(messagesStore.getCanLocalUserChat)
    local var39 = if FFlagExpChatPresetChatEnabled then SignalsReact.useSignalState(GetPresetChatStore(false).getIsTrayOpen) else nil
    local var40 = if FFlagExpChatPresetChatEnabled then SignalsReact.useSignalState(GetPresetChatStore(false).getIsEnabled) else nil
    local var41 = React.useRef(false)

    React.useEffect(function()
        customTextBoxRef.current = arg1.chatInputBarSettings.TextBox
    end, { if arg1.chatInputBarSettings.TextBox == nil then "nil" else arg1.chatInputBarSettings.TextBox })

    local focus = nil
    if FFlagExpChatTabShortcutNav then
        local var42 = if arg1.chatInputBarSettings.TextBox == nil then textBoxRef else customTextBoxRef
        focus = useFocusInputBar(var42).focus
        useInputBarTabNavigation(var42, arg1.userInputService)
    end

    React.useEffect(function()
        if not FFlagExpChatTabShortcutNav then
            return
        end

        return Signals.createEffect(function(arg2)
            local chatInputBarFocusRequestTime = focusNavigationStore.getChatInputBarFocusRequestTime(arg2)
            if chatInputBarFocusRequestTime == nil then
                return
            end
            if os.clock() - chatInputBarFocusRequestTime <= 5 then
                focus()
            end
            focusNavigationStore.clearChatInputBarFocusRequest()
        end)
    end, { focus })

    React.useEffect(function()
        if not arg1.autocompleteEnabled then
            return
        end

        local tbl1 = {}
        local connection = TextChatService.DescendantAdded:Connect(function(descendant: Instance)
            if descendant:IsA("TextChatCommand") and string.sub(descendant.PrimaryAlias, 1, 1) == "/" then
                var5 = AutocompleteText.new(initializeCommands)

                table.insert(tbl1, (descendant:GetPropertyChangedSignal("AutocompleteVisible"):Connect(function()
                    var5 = AutocompleteText.new(initializeCommands)
                end)))
            end
        end)
        local connection2 = TextChatService.DescendantRemoving:Connect(function(descendant: Instance)
            if descendant:IsA("TextChatCommand") and string.sub(descendant.PrimaryAlias, 1, 1) == "/" then
                var5 = AutocompleteText.new(initializeCommands)
            end
        end)

        if getEnableChatInputBarConfigurationAutocompleteEnabled() then
            var5 = AutocompleteText.new(initializeCommands)
            var4 = AutocompleteText.new(initializeEmojis)
            if GetFFlagTextChatEnableUniverseChatTabs() then
                var6 = AutocompleteText.new(initializeGlobalCommands)
            end
            local var42 = initialCommands()
            if var42 then
                for _, value in var42 do
                    table.insert(tbl1, (value:GetPropertyChangedSignal("AutocompleteVisible"):Connect(function()
                        var5 = AutocompleteText.new(initializeCommands)
                    end)))
                end
            end
        end
        return function()
            if connection2 then
                connection2:Disconnect()
            end
            connection:Disconnect()
            for _, value in ipairs(tbl1) do
                value:Disconnect()
            end
            table.clear(tbl1)
        end
    end, {})

    local useCallback = React.useCallback
    local function func1()
        var1:trace("onSendActivated with input text: '{}'", var10)

        local var42 = canLocalUserChatDerived
        if not (var26.current and var42) then
            var1:debug("onSendActivated could not send message. isMounted: {} canLocalUserChat: {}", tostring(var26.current), var42)

            return
        end

        if not textBoxRef.current and not customTextBoxRef.current then
            var1:debug("onSendActivated could not send message because textBoxRef.current was nil")
            return
        end

        local currentText = if customTextBoxRef.current then customTextBoxRef.current.Text else textBoxRef.current.Text
        local var43 = if var29 then var29.consumeOnSend(currentText) else nil
        local var44 = if GetFFlagTextChatEnableUniverseChatTabs() and arg1.isGlobalChatTabActive and arg1.onSendGlobalChat then arg1.onSendGlobalChat else arg1.onSendChat

        if var44 and string.find(currentText, "%S") ~= nil then
            if FFlagExpChatDictation then
                var44(currentText, var43, var43 ~= nil)
            else
                var44(currentText)
            end
        else
            var1:debug("onSendActivated could not send message. text: '{}' canLocalUserChat: {}", currentText, var42)
        end

        if customTextBoxRef.current then
            customTextBoxRef.current.Text = ""
            customTextBoxRef.current:ReleaseFocus()
        end
        if textBoxRef.current then
            textBoxRef.current.Text = ""
            textBoxRef.current:ReleaseFocus()
        end
        setInputText("")

        if FFlagExpChatPresetChatGamepadEnabled then
            local current = customTextBoxRef.current or textBoxRef.current
            if current then
                GuiService.SelectedCoreObject = current
            end
        end

        if arg1.targetTextChannel and arg1.targetTextChannelDisplayName ~= "" then
            var35.current = true
        end
    end

    local current = customTextBoxRef.current

    local canLocalUserChat = arg1.canLocalUserChat
    local isGlobalChatTabActive = arg1.isGlobalChatTabActive
    local onSendChat = arg1.onSendChat or false
    local onSendGlobalChat = arg1.onSendGlobalChat or false
    local targetTextChannel = arg1.targetTextChannel or false
    local targetTextChannelDisplayName = arg1.targetTextChannelDisplayName
    local consumeOnSend = if var29 then var29.consumeOnSend else false
    local onSendActivated = useCallback(func1, {
        var10,
        current,
        canLocalUserChatDerived,
        canLocalUserChat,
        isGlobalChatTabActive,
        onSendChat,
        onSendGlobalChat,
        targetTextChannel,
        targetTextChannelDisplayName,
        consumeOnSend
    })

    local onSendRecordingTap = if enabled then React.useCallback(function(tbl1)
        if not (var26.current and canLocalUserChatDerived) then
            return
        end
        local textSent = tbl1 and tbl1.textSent or ""
        local var43 = if GetFFlagTextChatEnableUniverseChatTabs() and arg1.isGlobalChatTabActive and arg1.onSendGlobalChat then arg1.onSendGlobalChat else arg1.onSendChat

        if var43 and string.find(textSent, "%S") ~= nil then
            var43(textSent, tbl1, true)
        end
        if customTextBoxRef.current then
            customTextBoxRef.current.Text = ""
            customTextBoxRef.current:ReleaseFocus()
        end
        if textBoxRef.current then
            textBoxRef.current.Text = ""
            textBoxRef.current:ReleaseFocus()
        end
        setInputText("")
        if FFlagExpChatPresetChatGamepadEnabled then
            local current2 = customTextBoxRef.current or textBoxRef.current
            if current2 then
                GuiService.SelectedCoreObject = current2
            end
        end
        if arg1.targetTextChannel and arg1.targetTextChannelDisplayName ~= "" then
            var35.current = true
        end
    end, {
        customTextBoxRef.current,
        canLocalUserChatDerived,
        arg1.canLocalUserChat,
        arg1.isGlobalChatTabActive,
        arg1.onSendChat or false,
        arg1.onSendGlobalChat or false,
        arg1.targetTextChannel or false,
        arg1.targetTextChannelDisplayName
    }) else nil

    local recordPresetChosen = if FFlagExpChatPresetChatAutocompleteAnalyticsEnabled then usePresetAutocompleteAnalytics({
        isFocused = isFocused,
        autocompleteEnabled = arg1.autocompleteEnabled,
        autocompleteDropdownReducer = arg1.autocompleteDropdownReducer
    }).recordPresetChosen else nil

    local function sendSelectedPreset(str4: string)
        local presetChatStore = GetPresetChatStore(false)
        local presetId = PresetSearch.getPresetIdForValue(presetChatStore, str4)
        if presetId == nil then
            var1:warning("Could not resolve a preset id for autocomplete entry '{}'; skipping send.", str4)
            return
        end

        presetChatStore.setPresetCooldownEndsAt(os.clock() + var3)

        local var44 = sendPreset(presetId, arg1.targetTextChannel)
        if var44 ~= "Sent" then
            presetChatStore.setPresetCooldownEndsAt(nil)
            var1:warning("Could not send preset {} from autocomplete: {}", presetId, var44)
            return
        end

        ExpChatShared.Analytics:TelemetryLogEvent(
            ExpChatShared.Analytics.ExpChatPresetActionConfig,
            {
                event_type = Constants.Analytics.EventTypes.Click,
                component = if FFlagExpChatPresetChatAutocompleteAnalyticsEnabled then Constants.Analytics.Components.AutocompleteDropdown else Constants.Analytics.Components.PresetAutocomplete,
                preset_id = presetId
            },
            if FFlagExpChatPresetChatAutocompleteAnalyticsEnabled then Constants.Analytics.ExtendedStandardizedFields else ExpChatShared.Analytics.DefaultStandardizedFields
        )
    end

    local useCallback2 = React.useCallback

    local function func2(arg2)
        local result = if FFlagExpChatAutocompleteDropdownRedesign then arg1.autocompleteDropdownReducer.results[arg2.Parent.LayoutOrder] else nil
        local var44 = if FFlagExpChatPresetChatAutocompleteEnabled and arg1.autocompleteDropdownReducer.autocompleteType == "presets" then if FFlagExpChatAutocompleteDropdownRedesign then result else PresetEntryText.undecorate(arg2.TextLabel.Text, arg1.chatInputBarSettings.TextSize) else nil

        if FFlagExpChatPresetChatAutocompleteAnalyticsEnabled and recordPresetChosen ~= nil and var44 ~= nil then
            recordPresetChosen(var44)
        end

        if FFlagExpChatEmojiDropdownDismissAnalytics and var32 and arg1.autocompleteDropdownReducer.autocompleteType == "emojis" then
            local var45 = var32
            var45.current = if FFlagExpChatAutocompleteDropdownRedesign then result else arg2.TextLabel.Text
        end

        arg1.autocompleteDropdownActivated(false)
        arg1.autocompleteDropdownResultsChanged({})
        local current2 = if customTextBoxRef.current then customTextBoxRef.current else textBoxRef.current

        if not current2 then
            var1:error("Could not find textBox")
            return
        end

        local current2Text = current2.Text

        local str4 = string.sub(current2Text, 1, var14 - 1)
        local str5 = string.sub(current2Text, var14, #current2Text)

        local str6 = if FFlagExpChatPresetChatAutocompleteEnabled and var44 ~= nil then "" else str5

        local str7 = ""
        if arg1.autocompleteDropdownReducer.autocompleteType == "emojis" then
            local emojiLabelText = arg2.EmojiLabel.Text

            str7 = string.gsub(str4, ":[^:]*$", emojiLabelText)
        elseif arg1.autocompleteDropdownReducer.autocompleteType == "commands" then
            if not FFlagExpChatAutocompleteDropdownRedesign then
                result = arg2.TextLabel.Text
            end
            str7 = string.gsub(str4, "(/.*)", result)
        end

        if str6 ~= "" then
            str7 ..= str6
        end
        current2.Text = str7
        setInputText(str7)

        if var26.current then
            if bool5 and var20 and not current2:IsFocused() then
                var20.current = true
            end
            current2:CaptureFocus()
            if var37 then
                var36(current2)
            end

            if str6 ~= "" and not bool7 then
                current2.CursorPosition = #str7 - #str6 + 1
            end
        end

        arg1.autocompleteDropdownDeactivated()

        if FFlagExpChatPresetChatAutocompleteEnabled and var44 ~= nil then
            sendSelectedPreset(var44)
        end
    end

    local var44 = var14
    local autocompleteDropdownActivated = arg1.autocompleteDropdownActivated
    local autocompleteDropdownDeactivated = arg1.autocompleteDropdownDeactivated
    local autocompleteType = arg1.autocompleteDropdownReducer and arg1.autocompleteDropdownReducer.autocompleteType
    local autocompleteDropdownResultsChanged = arg1.autocompleteDropdownResultsChanged
    local targetTextChannel2 = if FFlagExpChatPresetChatAutocompleteEnabled then arg1.targetTextChannel or false else nil
    local textSize = if FFlagExpChatPresetChatAutocompleteEnabled then arg1.chatInputBarSettings.TextSize else nil
    local var45 = if FFlagExpChatPresetChatAutocompleteAnalyticsEnabled then recordPresetChosen else nil
    local var46 = if FFlagExpChatEmojiDropdownDismissAnalytics then var32 else nil
    local results = if FFlagExpChatAutocompleteDropdownRedesign then arg1.autocompleteDropdownReducer and arg1.autocompleteDropdownReducer.results else nil
    local onAutocompleteSelected = useCallback2(func2, {
        var37,
        var36,
        var23,
        var44,
        autocompleteDropdownActivated,
        autocompleteDropdownDeactivated,
        autocompleteType,
        autocompleteDropdownResultsChanged,
        targetTextChannel2,
        textSize,
        var45,
        var46,
        results
    })

    React.useEffect(function()
        if not var26.current then
            return
        end

        local current2 = if customTextBoxRef.current then customTextBoxRef.current else textBoxRef.current

        if current2 then
            current2:CaptureFocus()
            return
        end
        var1:error("Could not focus chat input bar because textBox not found")
    end, { arg1.shouldFocusChatInputBar, customTextBoxRef.current })

    if FFlagExpChatPresetChatEnabled then
        React.useEffect(function()
            if not var39 then
                return
            end

            local current2 = if customTextBoxRef.current then customTextBoxRef.current else textBoxRef.current

            if current2 and current2:IsFocused() then
                current2:ReleaseFocus()
            end
        end, { var39 })
    end

    React.useEffect(function()
        var1:trace("Mounted")
        var26.current = true

        if bool1 then
            IXPServiceWrapper:LogUserLayerExposure(str1)
        end

        return function()
            var1:trace("Unmounting")
            var26.current = false
        end
    end, {})

    React.useEffect(function()
        local connection = nil
        if arg1.autocompleteEnabled then
            local current2 = if customTextBoxRef.current then customTextBoxRef.current else textBoxRef.current

            if current2 then
                connection = current2:GetPropertyChangedSignal("CursorPosition"):Connect(function()
                    local cursorPosition = current2.CursorPosition
                    if cursorPosition and cursorPosition ~= -1 then
                        var15(cursorPosition)
                    end
                end)
            end
        end

        return function()
            if connection then
                connection:Disconnect()
            end
        end
    end, { customTextBoxRef.current })

    React.useEffect(function()
        if not arg1.autocompleteEnabled then
            return function() end
        end

        var34.current = arg1.userInputService.InputBegan:connect(function(input: InputObject, _)
            if not arg1.autocompleteDropdownReducer.activated or not Enum.KeyCode.Up and not Enum.KeyCode.Down then
                return
            end

            if input and input.KeyCode == Enum.KeyCode.Up and arg1.autocompleteDropdownReducer.selectedIndex > 1 then
                arg1.autocompleteDropdownSelectionChanged(arg1.autocompleteDropdownReducer.selectedIndex - 1)
            end
            if input
                and input.KeyCode == Enum.KeyCode.Down
                and arg1.autocompleteDropdownReducer.selectedIndex < #arg1.autocompleteDropdownReducer.results
            then
                arg1.autocompleteDropdownSelectionChanged(arg1.autocompleteDropdownReducer.selectedIndex + 1)
            end
        end)

        return function()
            local current2 = var34.current
            if current2 and current2.Connected then
                current2:Disconnect()
            end
            var34.current = nil
        end
    end, { arg1.userInputService, arg1.autocompleteDropdownReducer })

    React.useEffect(function()
        local var48 = GetFFlagTextChatEnableUniverseChatTabs() and not arg1.developerChannelTabsEnabled
        local bool8 = if FFlagExpChatBackspaceExitsTargetChannelInGlobalTabs then not arg1.isChannelBarVisible or var48 else not arg1.isChannelBarVisible

        var33.current = arg1.userInputService.InputEnded:connect(function(input: InputObject, _)
            if not (if customTextBoxRef.current then customTextBoxRef.current and customTextBoxRef.current:IsFocused() and input and input.KeyCode == Enum.KeyCode.Backspace else textBoxRef.current and textBoxRef.current:IsFocused() and input and input.KeyCode == Enum.KeyCode.Backspace) then
                return
            end

            local bool9 = (arg1.targetTextChannelDisplayName or "") ~= ""

            if var35.current and bool8 and (not FFlagExpChatFixBackspaceNilTargetChannel or bool9) then
                arg1.resetTargetChannel(if FFlagExpChatFixBackspaceNilTargetChannel then arg1.isGlobalChatTabActive else nil)

                var1:debug("ChatInputBar ChatInputBarResetTargetChannel()")
                var35.current = false
                return
            end

            if var10 ~= "" then
                return
            end
            if not FFlagExpChatFixBackspaceNilTargetChannel then
                bool9 = arg1.targetTextChannelDisplayName ~= ""
            end

            if bool9 then
                var35.current = true
            end
        end)

        return function()
            local current2 = var33.current
            if current2 and current2.Connected then
                current2:Disconnect()
            end
            var33.current = nil
        end
    end, {
        arg1.userInputService,
        customTextBoxRef.current,
        arg1.isChannelBarVisible,
        arg1.targetTextChannelDisplayName,
        arg1.resetTargetChannel,
        if FFlagExpChatBackspaceExitsTargetChannelInGlobalTabs then arg1.developerChannelTabsEnabled else nil,
        if FFlagExpChatFixBackspaceNilTargetChannel then arg1.isGlobalChatTabActive else nil
    })

    React.useEffect(function()
        arg1.contextActionService:BindCoreAction("FocusChat", function(_: string, userInputState, arg2) -- name: handleAction
            if arg1.isChatHotkeyEnabled
                and arg2
                and (arg2.KeyCode == Config.ChatInputBarDefaultFocusKeyCode or arg2.KeyCode == arg1.devDefinedFocusKeyCode)
            then
                local current2 = if customTextBoxRef.current then customTextBoxRef.current else textBoxRef.current

                if current2 and userInputState == Enum.UserInputState.Begin and current2 and not current2:IsFocused() then
                    task.delay(0, function()
                        current2:CaptureFocus()
                    end)

                    arg1.focusChatHotKeyActivated()

                    var41.current = true

                    return Enum.ContextActionResult.Sink
                end
            end

            return Enum.ContextActionResult.Pass
        end, false, Enum.UserInputType.Keyboard)

        return function()
            arg1.contextActionService:UnbindCoreAction("FocusChat")
        end
    end, {
        arg1.isChatHotkeyEnabled,
        arg1.devDefinedFocusKeyCode,
        var41.current,
        customTextBoxRef.current
    })

    local function func3(isFocusedWrite: boolean) -- Luacid: Inlined by compiler; 2 call sites recovered
        local chatInputBarConfiguration = TextChatService:FindFirstChildOfClass("ChatInputBarConfiguration")
        if chatInputBarConfiguration then
            chatInputBarConfiguration.IsFocusedWrite = isFocusedWrite
        end
    end

    local onFocused = React.useCallback(function()
        var22(true)
        arg1.onFocus()
        func3(true)

        if not bool5 or not var20 then
            return
        end

        if var20.current then
            var20.current = false
            return
        end
        ExpChatShared.Analytics:TelemetryLogEvent(
            ExpChatShared.Analytics.ExpChatPresetActionConfig,
            {
                event_type = Constants.Analytics.EventTypes.Click,
                component = Constants.Analytics.Components.MainInputBar
            },
            Constants.Analytics.ExtendedStandardizedFields
        )
    end, { arg1.onFocus })

    local onFocusLost = React.useCallback(function(_, bool8: boolean, arg2)
        var1:debug("Focus lost with enter: {}", tostring(bool8))

        local current2 = autocompleteDropdownRef.current

        if bool8 or arg2 and (arg2.KeyCode == Enum.KeyCode.Return or arg2.KeyCode == Enum.KeyCode.KeypadEnter) then
            if arg1.autocompleteEnabled
                and current2
                and arg1.autocompleteDropdownReducer.activated
                and #arg1.autocompleteDropdownReducer.results > 0
                and (not FFlagExpChatPresetChatAutocompleteEnabled or arg1.autocompleteDropdownReducer.selectedIndex > 0)
            then
                local offsetFrame = current2.ScrollBarFrame.ScrollViewFrame.ScrollView.OffsetFrame

                for _, child in ipairs(offsetFrame:GetChildren()) do
                    if child.ClassName == "Frame" and child.LayoutOrder == arg1.autocompleteDropdownReducer.selectedIndex then
                        onAutocompleteSelected(child.TextLabelButton)
                        return
                    end
                end
            else
                onSendActivated()

                if FFlagExpChatPresetChatAutocompleteEnabled
                    and arg1.autocompleteEnabled
                    and arg1.autocompleteDropdownReducer.autocompleteType == "presets"
                then
                    arg1.autocompleteDropdownDeactivated()
                end
            end
        end

        if var26.current then
            if arg1.autocompleteEnabled and current2 and arg1.autocompleteDropdownReducer.activated then
                if arg2 then
                    if arg2.KeyCode == Enum.KeyCode.Escape then
                        arg1.autocompleteDropdownActivated(false)
                        local current3 = if customTextBoxRef.current then customTextBoxRef.current else textBoxRef.current

                        if current3 then
                            local cursorPosition = var14

                            if bool5 and var20 and not current3:IsFocused() then
                                var20.current = true
                            end
                            current3:CaptureFocus()
                            if not bool7 then
                                current3.CursorPosition = cursorPosition
                            end
                            return
                        end
                        var1:error("Could not focus chat input bar because textBox not found")
                    else
                        local x = arg2.Position.X
                        local y = arg2.Position.Y
                        local absolutePositionX = current2.AbsolutePosition.X

                        local var49 = absolutePositionX + current2.AbsoluteSize.X
                        local absolutePositionY = current2.AbsolutePosition.Y

                        local var50 = absolutePositionY + current2.AbsoluteSize.Y
                        if x < absolutePositionX or var49 < x or y < absolutePositionY or var50 < y then
                            arg1.autocompleteDropdownActivated(false)
                        end
                    end
                end
            else
                var22(false)
            end
        end

        arg1.onUnfocus()
        func3(false)

        if not var41.current then
            return
        end

        local localPlayer = Players.LocalPlayer
        if localPlayer then
            local textBox = Instance.new("TextBox")
            textBox.Visible = false
            textBox.Parent = localPlayer:FindFirstChildOfClass("PlayerGui")
            textBox:CaptureFocus()
            textBox:ReleaseFocus()
            textBox:Destroy()
        end

        var41.current = false
    end)

    React.useEffect(function()
        local var50 = nil
        local var51 = nil

        local connection = ActionBindableEvent.Event:Connect(function(arg2)
            local current2 = if FFlagEnableConsoleExpControls then if customTextBoxRef.current then customTextBoxRef.current else textBoxRef.current else nil

            if arg2.type == "ChatTopBarFocusActivated" then
                if not FFlagEnableConsoleExpControls then
                    if customTextBoxRef.current then
                        current2 = customTextBoxRef.current
                    else
                        current2 = textBoxRef.current
                    end
                end

                if current2 then
                    task.delay(0, function()
                        current2:CaptureFocus()
                    end)
                end
            elseif not FFlagChromeChatGamepadSupportFix
                and FFlagEnableConsoleExpControls
                and arg2.type == "ChatTopBarFocusSelect"
                and current2
            then
                GuiService:SetMenuIsOpen(true, "ExperienceChat")
                onFocused()
                GuiService.SelectedCoreObject = current2

                var51 = task.delay(0, function()
                    var51 = nil
                    if var50 then
                        var50:Disconnect()
                    end
                    var50 = onChatInputBarFocusLost(arg2.onSelectionLost, arg2.keybinds, onFocusLost)
                end)
            end
        end)

        return function()
            connection:disconnect()

            if var51 then
                task.cancel(var51)
                var51 = nil
            end
            if var50 then
                var50:Disconnect()
                var50 = nil
            end
        end
    end, { textBoxRef.current, customTextBoxRef.current })

    useEffectChatInputBarFocus(textBoxRef, customTextBoxRef, var30, onFocused, onFocusLost)

    local function handlePresetAutocomplete(text: string, cursorPosition: number)
        if cursorPosition < 1 then
            return
        end

        local str4 = string.sub(text, 1, cursorPosition - 1)
        local matchingPresets = if arg1.targetTextChannel == nil and not FFlagExpChatUniverseChatPresetEnabled then {} else PresetSearch.findMatchingPresets(
            GetPresetChatStore(false),
            str4,
            if bool4 then ExpChatPresetChatAutocompleteExperimentation.getSearchVariant() else nil
        )

        if #matchingPresets == 0 then
            if arg1.autocompleteDropdownReducer.autocompleteType == "presets" then
                arg1.autocompleteDropdownDeactivated()
            end
            return
        end

        arg1.autocompleteDropdownTypeChanged("presets")
        arg1.autocompleteDropdownActivated(true)
        local autocompleteDropdownResultsChanged2 = arg1.autocompleteDropdownResultsChanged

        if not FFlagExpChatAutocompleteDropdownRedesign then
            str4 = nil
        end

        autocompleteDropdownResultsChanged2(matchingPresets, str4)

        arg1.autocompleteDropdownSelectionChanged(0)
    end

    local function handleAutocomplete(arg2, text, arg3)
        if arg3 == "/" and arg2.CursorPosition == 2
            or arg1.autocompleteDropdownReducer.autocompleteType == "commands" and arg3 ~= ":"
        then
            arg1.autocompleteDropdownTypeChanged("commands")
            arg1.autocompleteDropdownActivated(true)
            if arg3 ~= "" and arg3 ~= " " then
                local str4 = string.sub(text, 1, arg2.CursorPosition - 1):lower()

                local results2 = (if arg1.isGlobalChatTabActive and var6 then var6 else var5):getResults(str4, sortCommandResultsCallback)
                arg1.autocompleteDropdownResultsChanged(results2, if FFlagExpChatAutocompleteDropdownRedesign then str4 else nil)

                if str4 == results2[1] then
                    arg1.autocompleteDropdownActivated(false)
                    arg1.autocompleteDropdownResultsChanged({})
                end
            else
                arg1.autocompleteDropdownDeactivated()
            end

            return
        end

        if not arg1.autocompleteDropdownReducer.activated and not (#arg1.autocompleteDropdownReducer.results > 0)
            or arg1.autocompleteDropdownReducer.autocompleteType ~= "emojis"
        then
            local var50 = string.find(text, ":[^:]*$")

            if arg3 == ":" then
                arg1.autocompleteDropdownTypeChanged("emojis")
                arg1.autocompleteDropdownActivated(true)
                arg1.autocompleteDropdownResultsChanged({})
                var19(var50)
                return
            end

            if FFlagExpChatPresetChatAutocompleteEnabled then
                handlePresetAutocomplete(text, arg2.CursorPosition)
            end

            return
        end

        arg1.autocompleteDropdownActivated(true)
        local str4 = string.sub(text, 1, arg2.CursorPosition - 1)
        local var50 = string.find(str4, ":[^:]*$")

        if arg3 ~= "" and arg3 ~= ":" and arg3 ~= " " and var50 then
            local str5 = string.sub(text, var50 + 1, arg2.CursorPosition - 1):lower()

            local var51 = not (str5 and string.len(str5) > 1) and {} or var4:getResults(str5, sortEmojiResultsCallback)

            local autocompleteDropdownResultsChanged2 = arg1.autocompleteDropdownResultsChanged

            if not FFlagExpChatAutocompleteDropdownRedesign then
                str5 = nil
            end

            autocompleteDropdownResultsChanged2(var51, str5)
            return
        end

        if arg3 ~= ":" then
            if arg3 == " " then
                arg1.autocompleteDropdownActivated(false)
                arg1.autocompleteDropdownResultsChanged({})
            else
                arg1.autocompleteDropdownDeactivated()
                var19(0)
            end

            return
        end

        if var50 == var18 then
            arg1.autocompleteDropdownResultsChanged({})
            return
        end

        local str5 = string.sub(text, var18 + 1, arg2.CursorPosition - 2):lower()
        if List.includes(arg1.autocompleteDropdownReducer.results, str5) then
            local str6 = string.sub(text, arg2.CursorPosition, #text)
            local str7 = string.sub(text, 1, arg2.CursorPosition - 2) .. str6
            arg2.Text = str7
            setInputText(str7)

            if not bool7 then
                arg2.CursorPosition -= 1
            end

            local current2 = autocompleteDropdownRef.current
            if current2 then
                local offsetFrame = current2.ScrollBarFrame.ScrollViewFrame.ScrollView.OffsetFrame

                for _, child in ipairs(offsetFrame:GetChildren()) do
                    if FFlagExpChatAutocompleteDropdownRedesign then
                        if child.ClassName == "Frame" and arg1.autocompleteDropdownReducer.results[child.LayoutOrder] == str5 then
                            local textLabelButton = child:FindFirstChild("TextLabelButton")
                            if textLabelButton then
                                onAutocompleteSelected(textLabelButton)
                                return
                            end
                        end
                    elseif child.ClassName == "Frame" then
                        local textLabelButton = child:FindFirstChild("TextLabelButton")
                        if textLabelButton then
                            local textLabel = textLabelButton:FindFirstChild("TextLabel")
                            if textLabel and textLabel.Text and textLabel.Text == str5 then
                                onAutocompleteSelected(textLabelButton)
                                return
                            end
                        end
                    end
                end

                return
            end
        else
            arg1.autocompleteDropdownActivated(false)
            arg1.autocompleteDropdownResultsChanged({})
        end
    end

    React.useEffect(function()
        if TextChatService.CreateDefaultCommands then
            var7 = TextChatService:FindFirstChild(RBXTeamCommand.name, true)
            var8 = TextChatService:FindFirstChild(RBXWhisperCommand.name, true)
        end
    end, {})

    local onTextChanged = React.useCallback(function(arg2)
        local text = arg2.Text

        if arg1.autocompleteEnabled then
            local var50 = string.find(text, "\r")
            local bool8 = arg2.CursorPosition < #text + 1
            if var50 then
                local var51 = string.gsub(text, "\r", "")
                arg2.Text = var51
                setInputText(var51)
                if bool8 then
                    arg2.CursorPosition -= 1
                end
                return
            end
        end

        local str4 = string.sub(text, arg2.CursorPosition - 1, arg2.CursorPosition - 1)
        var1:trace("Input: {}", text)
        local var50 = if utf8.len(text) then utf8.len(utf8.nfcnormalize(text)) else string.len(text)

        if var50 and arg1.messageCharacterLimit < var50 then
            var1:debug("Message is over the character limit of {}", tostring(arg1.messageCharacterLimit))
            arg2.Text = var10
            return
        end
        setInputText(text)

        if getEnableChatInputBarConfigurationAutocompleteEnabled() and arg1.autocompleteEnabled then
            handleAutocomplete(arg2, text, str4)
        end

        local var51 = var35
        var51.current = #text == 0 and var35.current

        if not bool6 then
            if arg1.localPlayer then
                local userId = arg1.localPlayer.UserId

                local tbl1 = {}
                if var7 and var7.Enabled then
                    table.insert(tbl1, autoCastCommand(RBXTeamCommand, userId, text))
                end
                if var8 and var8.Enabled then
                    table.insert(tbl1, autoCastCommand(RBXWhisperCommand, userId, text))
                end
                local var52 = #tbl1 == 0 and { Promise.reject() } or tbl1

                Promise.any(var52):andThen(function()
                    arg2.Text = ""
                    setInputText("")

                    var35.current = true
                end):catch(function(arg3)
                    var1:trace("Could not send autoCastCommand. Error: {}", arg3)
                end)
            end

            return
        end

        if string.sub(text, 1, 1) ~= "/" or not arg1.localPlayer or text == var9.current then
            if string.sub(text, 1, 1) ~= "/" then
                var9.current = ""
            end

            return
        end

        var9.current = text

        local userId = arg1.localPlayer.UserId
        local tbl1 = {}
        if var7 and var7.Enabled then
            table.insert(tbl1, autoCastCommand(RBXTeamCommand, userId, text))
        end
        if var8 and var8.Enabled then
            table.insert(tbl1, autoCastCommand(RBXWhisperCommand, userId, text))
        end
        local var52 = #tbl1 == 0 and { Promise.reject() } or tbl1

        Promise.any(var52):andThen(function()
            arg2.Text = ""
            setInputText("")

            var35.current = true
        end):catch(function(arg3)
            var1:trace("Could not send autoCastCommand. Error: {}", arg3)
        end)
    end)

    local onReturnPressedFromOnScreenKeyboard = React.useCallback(function()
        local current2 = if customTextBoxRef.current then customTextBoxRef.current else textBoxRef.current

        if current2 then
            current2:ReleaseFocus(true)
        end
    end, { textBoxRef.current, customTextBoxRef.current })

    local var52 = React.useCallback(function(arg2)
        var25(arg2.Visible and arg2.AbsoluteSize.X or 0)
    end)

    local var53 = useCursor()

    local onAutocompleteDropdownHover = React.useCallback(function(arg2)
        arg1.autocompleteDropdownSelectionChanged(arg2.LayoutOrder)
    end)

    local hasEmptyInputText = var10 == ""
    local showPlaceholderText = hasEmptyInputText and not isFocused
    local chatInputBarSettings = arg1.chatInputBarSettings
    local chatWindowSettings = arg1.chatWindowSettings
    local var2 = if canLocalUserChatDerived == nil then arg1.canLocalUserChat else canLocalUserChatDerived

    React.useEffect(function()
        if bool2 and var2 then
            IXPServiceWrapper:LogUserLayerExposure(str2)
        end
    end, { var2 })

    React.useEffect(function()
        if not bool3
            or not isFocused
            or not getEnableChatInputBarConfigurationAutocompleteEnabled()
            or not arg1.autocompleteEnabled
        then
            return
        end

        local presetChatStore = GetPresetChatStore(false)

        if not presetChatStore.getIsEnabled(false) or presetChatStore.getAccessLevel(false) ~= Constants.AccessLevel.Enabled then
            return
        end

        IXPServiceWrapper:LogFlagLinkedUserLayerExposure(str3)
    end, { isFocused, arg1.autocompleteEnabled, var40 })

    React.useEffect(function()
        if not FFlagExpChatPresetChatSendEnabled
            or not isFocused
            or not getEnableChatInputBarConfigurationAutocompleteEnabled()
            or not arg1.autocompleteEnabled
        then
            return
        end

        local presetChatStore = GetPresetChatStore(false)

        if not presetChatStore.getIsEnabled(false) or presetChatStore.getAccessLevel(false) ~= Constants.AccessLevel.Enabled then
            return
        end

        ExpChatPresetChatAutocompleteExperimentation.logExposure()
    end, { isFocused, arg1.autocompleteEnabled, var40 })

    local backgroundTransparency = useInterpolatedClientSettings(chatInputBarSettings).BackgroundTransparency
    local backgroundTransparency2 = useInterpolatedClientSettings(chatWindowSettings).BackgroundTransparency
    local backgroundColor3 = useInterpolatedClientSettings(chatWindowSettings).BackgroundColor3

    local isSpatialUiEnabled = arg1.isSpatialUIEnabled

    local createElement = React.createElement
    local str4 = "Frame"

    local tbl1 = {
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = backgroundColor3,
        BackgroundTransparency = if FFlagExpChatNewInputBar then 1 else setTransparency(backgroundTransparency2, arg1.transparencyValue),
        BorderSizePixel = 0,
        LayoutOrder = arg1.LayoutOrder,
        Size = arg1.size,
        Visible = arg1.visible,
        ZIndex = 2,
        [React.Event.MouseEnter] = arg1.onHovered,
        [React.Event.MouseLeave] = arg1.onUnhovered,
        [React.Change.AbsoluteSize] = React.useCallback(function(arg2)
            local chatInputBarConfiguration = TextChatService:FindFirstChildOfClass("ChatInputBarConfiguration")
            if chatInputBarConfiguration and arg1.onAbsoluteSizeChanged then
                arg1.onAbsoluteSizeChanged(arg2, chatInputBarConfiguration)
            end
        end),
        [React.Change.AbsolutePosition] = React.useCallback(function(arg2)
            local chatInputBarConfiguration = TextChatService:FindFirstChildOfClass("ChatInputBarConfiguration")
            if chatInputBarConfiguration and arg1.onAbsolutePositionChanged then
                arg1.onAbsolutePositionChanged(arg2, chatInputBarConfiguration)
            end
        end)
    }

    local tbl2 = {
        AutocompleteDropdown = 0,
        UISizeConstraint = 0,
        UIPadding = 0,
        ChatInputBarV2 = 0,
        Background = 0
    }
    local element

    if getEnableChatInputBarConfigurationAutocompleteEnabled() and arg1.autocompleteEnabled then
        element = React.createElement(AutocompleteDropdown, {
            chatInputBarSettings = chatInputBarSettings,
            chatWindowSettings = chatWindowSettings,
            setTransparency = setTransparency,
            transparencyValue = arg1.transparencyValue,
            activated = arg1.autocompleteDropdownReducer.activated and isFocused,
            isChatInputBarVisible = if FFlagExpChatEmojiDropdownShowAnalytics then arg1.visible else nil,
            chosenEmojiForAnalyticsRef = if FFlagExpChatEmojiDropdownDismissAnalytics then var32 else nil,
            results = arg1.autocompleteDropdownReducer.results,
            query = if FFlagExpChatAutocompleteDropdownRedesign then arg1.autocompleteDropdownReducer.query else nil,
            selectedIndex = arg1.autocompleteDropdownReducer.selectedIndex,
            autocompleteType = arg1.autocompleteDropdownReducer.autocompleteType,
            onAutocompleteDropdownHover = onAutocompleteDropdownHover,
            onAutocompleteSelected = onAutocompleteSelected,
            autocompleteDropdownRef = autocompleteDropdownRef,
            textBoxRef = if chatInputBarSettings.TextBox then customTextBoxRef else textBoxRef
        })
            or nil
    else
        element = nil
    end

    tbl2.AutocompleteDropdown = element

    tbl2.UISizeConstraint = React.createElement("UISizeConstraint", { MaxSize = Vector2.new(Config.ChatWindowMaxWidth, math.huge) })

    tbl2.UIPadding = React.createElement("UIPadding", {
        PaddingLeft = if FFlagExpChatNewInputBar then nil else UDim.new(0, 8),
        PaddingRight = if FFlagExpChatNewInputBar then nil else UDim.new(0, 8),
        PaddingTop = arg1.addTopPadding and UDim.new(0, 8) or UDim.new(0, 0),
        PaddingBottom = UDim.new(0, 1)
    })
    local var56

    if FFlagExpChatNewInputBar then
        if FFlagExpChatNewInputBarDictation and enabled and var2 then
            local createElement2 = React.createElement
            local var57 = ChatInputBarV2Dictation
            local tbl3 = {
                transparencyValue = arg1.transparencyValue,
                sendButtonContainerWidth = arg1.sendButtonContainerWidth,
                resetTargetChannel = arg1.resetTargetChannel,
                targetTextChannel = arg1.targetTextChannel,
                targetTextChannelDisplayName = arg1.targetTextChannelDisplayName,
                isChannelBarVisible = arg1.isChannelBarVisible,
                developerChannelTabsEnabled = arg1.developerChannelTabsEnabled,
                canLocalUserChat = arg1.canLocalUserChat,
                disabledChatPlaceholderText = arg1.disabledChatPlaceholderText,
                placeholderText = arg1.placeholderText,
                setTransparency = setTransparency,
                chatInputBarSettings = chatInputBarSettings,
                chatInputBarBackgroundTransparency = backgroundTransparency,
                isSpatialUIEnabled = isSpatialUiEnabled,
                canLocalUserChatDerived = canLocalUserChatDerived,
                targetChannelWidth = targetChannelWidth,
                showPlaceholderText = showPlaceholderText,
                hasEmptyInputText = hasEmptyInputText
            }

            if not FFlagExpChatPresetChatEnabled then
                var40 = nil
            end

            tbl3.shouldTruncatePlaceholder = var40
            tbl3.cursor = var53
            tbl3.placeholderRef = var30
            tbl3.textBoxRef = textBoxRef
            tbl3.customTextBoxRef = customTextBoxRef
            tbl3.onAbsoluteSizeChanged = var52
            tbl3.onFocused = onFocused
            tbl3.onFocusLost = onFocusLost
            tbl3.onTextChanged = onTextChanged
            tbl3.onReturnPressedFromOnScreenKeyboard = onReturnPressedFromOnScreenKeyboard
            tbl3.onSendActivated = onSendActivated
            tbl3.onSendRecordingTap = onSendRecordingTap
            tbl3.onTranscriptionStaged = if var29 then var29.stageTranscription else nil
            tbl3.inputText = var10
            tbl3.setInputText = setInputText
            tbl3.isGlobalChatTabActive = arg1.isGlobalChatTabActive
            tbl3.onDictationActivityChanged = arg1.onDictationActivityChanged
            tbl3.onDictationStateChanged = arg1.onDictationStateChanged
            var56 = createElement2(var57, tbl3)
        else
            local createElement2 = React.createElement
            local var57 = ChatInputBarV2
            local tbl3 = {
                transparencyValue = arg1.transparencyValue,
                sendButtonContainerWidth = arg1.sendButtonContainerWidth,
                resetTargetChannel = arg1.resetTargetChannel,
                targetTextChannel = arg1.targetTextChannel,
                targetTextChannelDisplayName = arg1.targetTextChannelDisplayName,
                isChannelBarVisible = arg1.isChannelBarVisible,
                developerChannelTabsEnabled = arg1.developerChannelTabsEnabled,
                canLocalUserChat = arg1.canLocalUserChat,
                disabledChatPlaceholderText = arg1.disabledChatPlaceholderText,
                placeholderText = arg1.placeholderText,
                setTransparency = setTransparency,
                chatInputBarSettings = chatInputBarSettings,
                chatInputBarBackgroundTransparency = backgroundTransparency,
                isSpatialUIEnabled = isSpatialUiEnabled,
                canLocalUserChatDerived = canLocalUserChatDerived,
                targetChannelWidth = targetChannelWidth,
                showPlaceholderText = showPlaceholderText,
                hasEmptyInputText = hasEmptyInputText,
                shouldTruncatePlaceholder = 0,
                cursor = 0,
                placeholderRef = 0,
                textBoxRef = 0,
                customTextBoxRef = 0,
                onAbsoluteSizeChanged = 0,
                onFocused = 0,
                onFocusLost = 0,
                onTextChanged = 0,
                onReturnPressedFromOnScreenKeyboard = 0,
                onSendActivated = 0,
                isGlobalChatTabActive = 0
            }

            if not FFlagExpChatPresetChatEnabled then
                var40 = nil
            end

            tbl3.shouldTruncatePlaceholder = var40
            tbl3.cursor = var53
            tbl3.placeholderRef = var30
            tbl3.textBoxRef = textBoxRef
            tbl3.customTextBoxRef = customTextBoxRef
            tbl3.onAbsoluteSizeChanged = var52
            tbl3.onFocused = onFocused
            tbl3.onFocusLost = onFocusLost
            tbl3.onTextChanged = onTextChanged
            tbl3.onReturnPressedFromOnScreenKeyboard = onReturnPressedFromOnScreenKeyboard
            tbl3.onSendActivated = onSendActivated
            tbl3.isGlobalChatTabActive = if FFlagExpChatFixBackspaceNilTargetChannel then arg1.isGlobalChatTabActive else nil
            var56 = createElement2(var57, tbl3)
        end
    else
        var56 = nil
    end

    tbl2.ChatInputBarV2 = var56
    local var57

    if FFlagExpChatNewInputBar then
        var57 = nil
    elseif enabled and var2 then
        local createElement2 = React.createElement
        local var58 = DictationInputBar

        local tbl3 = {
            chatInputBarSettings = chatInputBarSettings,
            transparencyValue = arg1.transparencyValue,
            chatInputBarBackgroundTransparency = backgroundTransparency,
            inputText = var10,
            setInputText = setInputText,
            canLocalUserChat = var2,
            disabledChatPlaceholderText = arg1.disabledChatPlaceholderText,
            targetChannelWidth = targetChannelWidth,
            showPlaceholderText = showPlaceholderText,
            placeholderText = arg1.placeholderText,
            cursor = var53,
            placeholderRef = var30,
            textBoxRef = textBoxRef,
            customTextBoxRef = customTextBoxRef,
            onFocused = onFocused,
            onFocusLost = onFocusLost,
            onTextChanged = onTextChanged,
            onReturnPressedFromOnScreenKeyboard = onReturnPressedFromOnScreenKeyboard,
            onChannelChipAbsoluteSizeChanged = var52,
            onChannelChipActivated = FFlagExpChatFixBackspaceNilTargetChannel and function()
                arg1.resetTargetChannel(arg1.isGlobalChatTabActive)
            end or arg1.resetTargetChannel,
            targetTextChannel = arg1.targetTextChannel,
            targetTextChannelDisplayName = arg1.targetTextChannelDisplayName or "",
            isChannelBarVisible = arg1.isChannelBarVisible,
            isGlobalChatTabActive = arg1.isGlobalChatTabActive,
            developerChannelTabsEnabled = arg1.developerChannelTabsEnabled,
            onDictationActivityChanged = arg1.onDictationActivityChanged,
            onDictationStateChanged = arg1.onDictationStateChanged,
            onSendActivated = onSendActivated,
            onSendRecordingTap = onSendRecordingTap,
            onTranscriptionStaged = if var29 then var29.stageTranscription else nil,
            isSpatialUIEnabled = isSpatialUiEnabled,
            isTextBoxSelectable = if FFlagEnableConsoleExpControls then true else nil,
            isPlaceholderSelectable = true,
            placeholderSelectionImageObject = var53
        }

        var57 = createElement2(var58, tbl3)
    else
        local createElement2 = React.createElement
        local str5 = "Frame"
        local tbl3 = {
            AutomaticSize = Enum.AutomaticSize.XY,
            BackgroundColor3 = chatInputBarSettings.BackgroundColor3,
            BackgroundTransparency = if FFlagExpChatNewInputBar then 1 else setTransparency(backgroundTransparency, arg1.transparencyValue),
            Size = UDim2.new(1, 0, 0, 0)
        }
        local tbl4 = {
            Border = React.createElement("UIStroke", {
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                Color = Config.ChatInputBarBorderColor3,
                Transparency = setTransparency(Config.ChatInputBarBorderTransparency, arg1.transparencyValue)
            }),
            Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0, 3) }),
            Container = 0
        }
        local createElement3 = React.createElement
        local str6 = "Frame"
        local tbl5 = {
            AutomaticSize = Enum.AutomaticSize.Y,
            Size = UDim2.fromScale(1, 0),
            BackgroundTransparency = 1
        }
        local tbl6 = { TextContainer = 0, SendButton = 0 }
        local createElement4 = React.createElement
        local str7 = "Frame"
        local tbl7 = {
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, -arg1.sendButtonContainerWidth, 0, 0)
        }

        local tbl8 = {
            TargetChannelChip = React.createElement(ChannelChip, {
                transparency = setTransparency(0, arg1.transparencyValue),
                onAbsoluteSizeChanged = var52,
                onChannelChipActivated = FFlagExpChatFixBackspaceNilTargetChannel and function()
                    arg1.resetTargetChannel(arg1.isGlobalChatTabActive)
                end or arg1.resetTargetChannel,
                targetTextChannelDisplayName = arg1.targetTextChannelDisplayName or "",
                isChannelBarVisible = arg1.isChannelBarVisible,
                developerChannelTabsEnabled = arg1.developerChannelTabsEnabled
            }),
            DisabledPlaceholderLabel = 0,
            TextBoxContainer = 0,
            UIPadding = 0
        }
        local bool10 = not canLocalUserChatDerived

        if bool10 then
            local createElement5 = React.createElement
            local str8 = "TextLabel"

            local tbl9 = {
                AnchorPoint = Vector2.new(1, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                Font = Config.ChatInputBarFont,
                Text = arg1.disabledChatPlaceholderText,
                Position = UDim2.fromScale(1, 0),
                Size = targetChannelWidth:map(function(num1: number): UDim2
                    return UDim2.new(1, -(num1 + 8), 0, 0)
                end),
                TextColor3 = showPlaceholderText and chatInputBarSettings.PlaceholderColor3 or chatInputBarSettings.TextColor3,
                TextSize = if isSpatialUiEnabled then chatInputBarSettings.SpatialPanelTextSize else chatInputBarSettings.TextSize,
                TextTransparency = setTransparency(if showPlaceholderText then 0.5 else 0, arg1.transparencyValue),
                Selectable = true,
                SelectionImageObject = var53,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
                ref = var30
            }

            bool10 = createElement5(str8, tbl9)
        end

        tbl8.DisabledPlaceholderLabel = bool10
        local var58

        if canLocalUserChatDerived then
            local createElement5 = React.createElement
            local str8 = "Frame"

            local tbl9 = {
                AnchorPoint = Vector2.new(1, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                Position = UDim2.fromScale(1, 0),
                Size = targetChannelWidth:map(function(num1: number): UDim2
                    return UDim2.new(1, -(num1 + 8), 0, 0)
                end)
            }

            local tbl10 = { TextBox = 0 }
            local element2

            if canLocalUserChatDerived then
                element2 = React.createElement("TextBox", {
                    AnchorPoint = Vector2.new(0, 0),
                    AutomaticSize = Enum.AutomaticSize.XY,
                    BackgroundTransparency = 1,
                    ClearTextOnFocus = false,
                    FontFace = chatInputBarSettings.FontFace,
                    PlaceholderText = showPlaceholderText and arg1.placeholderText or "",
                    Selectable = if FFlagEnableConsoleExpControls then true else nil,
                    SelectionImageObject = var53,
                    Size = UDim2.fromScale(1, 0),
                    Text = "",
                    PlaceholderColor3 = chatInputBarSettings.PlaceholderColor3,
                    TextColor3 = chatInputBarSettings.TextColor3,
                    TextSize = if isSpatialUiEnabled then chatInputBarSettings.SpatialPanelTextSize else chatInputBarSettings.TextSize,
                    TextTransparency = setTransparency(if showPlaceholderText then 0.5 else 0, arg1.transparencyValue),
                    TextStrokeTransparency = setTransparency(chatInputBarSettings.TextStrokeTransparency, arg1.transparencyValue),
                    TextStrokeColor3 = chatInputBarSettings.TextStrokeColor3,
                    TextWrapped = true,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Top,
                    ZIndex = 2,
                    [React.Event.Focused] = onFocused,
                    [React.Event.FocusLost] = onFocusLost,
                    [React.Change.Text] = onTextChanged,
                    [React.Event.ReturnPressedFromOnScreenKeyboard] = onReturnPressedFromOnScreenKeyboard,
                    ref = if chatInputBarSettings.TextBox then customTextBoxRef else textBoxRef
                })
            else
                element2 = canLocalUserChatDerived
            end

            tbl10.TextBox = element2
            var58 = createElement5(str8, tbl9, tbl10)
        else
            var58 = canLocalUserChatDerived
        end

        tbl8.TextBoxContainer = var58

        tbl8.UIPadding = React.createElement("UIPadding", {
            PaddingBottom = UDim.new(0, 10),
            PaddingLeft = UDim.new(0, 10),
            PaddingRight = UDim.new(0, 10),
            PaddingTop = UDim.new(0, 10)
        })
        tbl6.TextContainer = createElement4(str7, tbl7, tbl8)
        tbl6.SendButton = React.createElement("TextButton", {
            AnchorPoint = Vector2.new(1, 0),
            BackgroundTransparency = 1,
            LayoutOrder = 2,
            Position = UDim2.fromScale(1, 0),
            Selectable = false,
            Size = UDim2.new(0, arg1.sendButtonContainerWidth, 1, 0),
            Text = "",
            [React.Event.Activated] = onSendActivated
        }, {
            Layout = React.createElement(
                "UIListLayout",
                {
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    VerticalAlignment = Enum.VerticalAlignment.Center
                }
            ),
            SendIcon = React.createElement(ImageSetLabel, {
                BackgroundTransparency = 1,
                ImageColor3 = hasEmptyInputText and chatInputBarSettings.PlaceholderColor3 or chatInputBarSettings.TextColor3,
                ImageTransparency = setTransparency(if hasEmptyInputText then 0.5 else 0, arg1.transparencyValue),
                Image = Images["icons/actions/send"],
                Size = UDim2.new(0, 30, 0, 30),
                ZIndex = 2
            })
        })
        tbl4.Container = createElement3(str6, tbl5, tbl6)
        var57 = createElement2(str5, tbl3, tbl4)
    end

    tbl2.Background = var57
    return createElement(str4, tbl1, tbl2)
end

local var9 = Localization.connect(function(arg1)
    local var9 = nil
    if arg1.targetTextChannel then
        for k, value in pairs({
            RBXTeam = "CoreScripts.TextChat.TeamChat.PrefixText",
            RBXWhisper = "CoreScripts.TextChat.WhisperChat.PrefixText.Outgoing"
        }) do
            if not string.match(arg1.targetTextChannel.Name, k) then
                continue
            end

            if k == "RBXWhisper" then
                local rbxName = getOtherDisplayNameInWhisperChannel(arg1.targetTextChannel, arg1.localPlayer)
                if rbxName then
                    var9 = {
                        value,
                        { RBX_NAME = rbxName }
                    }
                end
            else
                var9 = value
            end
        end
    end

    return { targetTextChannelDisplayName = var9 }
end)(ChatInputBar)

return React.memo(var9)
