-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:10:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TextChatService = game:GetService("TextChatService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local ExpChat = script:FindFirstAncestor("ExpChat")
local isTenFootInterface = require(ExpChat.Parent.AppCommonLib).isTenFootInterface
local ExpChatShared = require(ExpChat.Parent.ExpChatShared)

local Analytics = ExpChatShared.Analytics
local Config = require(ExpChat.Config)

local Actions = ExpChat.Actions
local ConfigurationObjectsLoaded = require(Actions.ConfigurationObjectsLoaded)
local ChatInputBarConfigurationEnabled = require(Actions.ChatInputBarConfigurationEnabled)
local ChatWindowConfigurationEnabled = require(Actions.ChatWindowConfigurationEnabled)
local ChannelTabsConfigurationEnabled = require(Actions.ChannelTabsConfigurationEnabled)
local LocalTextChannelParticipantAdded = require(Actions.LocalTextChannelParticipantAdded)
local TargetTextChannelPropertyChanged = ExpChatShared.Actions.TargetTextChannelPropertyChanged
local BubbleChatSettingsChanged = require(Actions.BubbleChatSettingsChanged)
local ChatLayoutVerticalAlignmentChanged = require(Actions.ChatLayoutVerticalAlignmentChanged)
local ChatLayoutHorizontalAlignmentChanged = require(Actions.ChatLayoutHorizontalAlignmentChanged)
local ChatWindowSettingsChanged = require(Actions.ChatWindowSettingsChanged)
local ChatInputBarSettingsChanged = require(Actions.ChatInputBarSettingsChanged)
local ChannelTabsSettingsChanged = require(Actions.ChannelTabsSettingsChanged)
local DevTextBoxEnabledChanged = require(Actions.DevTextBoxEnabledChanged)

local setUpBubbleChatConfigurationChildren = require(script.Parent.setUpBubbleChatConfigurationChildren)
local syncFriendsTabVisibility = require(script.Parent.syncFriendsTabVisibility)

local getEnableChatInputBarConfigurationAutocompleteEnabled = require(ExpChat.Flags.getEnableChatInputBarConfigurationAutocompleteEnabled)
local FFlagExpChatGlobalTabDefault = require(ExpChat.Flags.FFlagExpChatGlobalTabDefault)
local isGlobalTabFirst = require(ExpChat.isGlobalTabFirst)

local getFFlagExpChatFixChannelTabsMidExperienceToggle = require(ExpChat.Flags.getFFlagExpChatFixChannelTabsMidExperienceToggle)

local GetTransparencyStore = require(ExpChat.Stores.GetTransparencyStore)
local GetChannelTabsStore = require(ExpChat.Stores.GetChannelTabsStore)
local GetChatConfigurationStore = require(ExpChat.Stores.GetChatConfigurationStore)

local GetMessagesStore = require(ExpChat.Stores.GetMessagesStore)

local ExpChatParent = ExpChat.Parent
local GetFFlagTextChatEnableUniverseChatTabs = require(ExpChatParent.ExpChatShared).Flags.GetFFlagTextChatEnableUniverseChatTabs
local SharedFlags = require(ExpChatParent.SharedFlags)
local FFlagExpChatStickyTabs = SharedFlags.FFlagExpChatStickyTabs
local FFlagExpChatUseChannelTabsStore = SharedFlags.FFlagExpChatUseChannelTabsStore
local FFlagExpChatUseChatConfigStore = SharedFlags.FFlagExpChatUseChatConfigStore
local FFlagExpChatTabShortcutNav = SharedFlags.FFlagExpChatTabShortcutNav

local var1 = nil

local function isKeyboardKeyCodeSanitized(keyCode: Enum.KeyCode): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    local stringForKeyCode = UserInputService:GetStringForKeyCode(keyCode)
    if stringForKeyCode ~= nil and stringForKeyCode ~= "" and keyCode ~= Enum.KeyCode.None then
        return true
    end

    warn("ChatInputBarConfiguration.KeyboardKeyCode has an unsupported keycode for rendering UI:" .. tostring(keyCode))

    return false
end

local function shouldReorderTabs(allChannelTabs, textChannel: TextChannel): boolean
    local allChannelTab = if textChannel then allChannelTabs[textChannel.Name] else nil

    if allChannelTab == nil then
        return false
    end

    local num1 = 0
    for _ in pairs(allChannelTabs) do
        num1 += 1
    end

    local channelTabsConfiguration = TextChatService:FindFirstChildOfClass("ChannelTabsConfiguration")
    if not channelTabsConfiguration then
        return false
    end

    local absoluteSizeX = channelTabsConfiguration.AbsoluteSize.X
    if absoluteSizeX < num1 * Config.ChannelTabsSettings.MinTabWidth or not num1 then
        num1 = math.floor(
            (absoluteSizeX - Config.ChannelTabsSettings.DropdownIconContainerWidth) / Config.ChannelTabsSettings.MinTabWidth
        )
    end

    return num1 < (if FFlagExpChatUseChannelTabsStore then allChannelTab.tabIndex else allChannelTab.TabIndex)
end

return function(arg1, arg2)
    if arg2.analytics then
        Analytics.with(arg2.analytics)
    end

    local function func1(str1: string, str2: string, arg3)
        local var2

        if type(arg3) == "number" or type(arg3) == "boolean" or typeof(arg3) == "EnumItem" then
            var2 = tostring(arg3)
        elseif typeof(arg3) == "Color3" then
            var2 = arg3:ToHex()
        else
            if typeof(arg3) ~= "Font" then
                return
            end

            var2 = tostring((string.gsub(arg3.Family, "rbxasset://fonts/families/", ""))) .. " " .. tostring(arg3.Weight) .. " " .. tostring(arg3.Style)
        end

        assert(var2, "should exist")
        Analytics.FireClientAnalyticsWithEventName(str1, { [str2] = var2 })
    end

    local bool1 = false

    local function func2()
        local chatInputBarConfiguration = TextChatService:FindFirstChildOfClass("ChatInputBarConfiguration")
        local result = ({})
        if not chatInputBarConfiguration then
            return {}
        end

        local transparencyStore = GetTransparencyStore(false)
        arg1:dispatch(ChatInputBarConfigurationEnabled(chatInputBarConfiguration.Enabled))
        if chatInputBarConfiguration.Enabled then
            transparencyStore.resetAllTransparency()
        end
        chatInputBarConfiguration:GetPropertyChangedSignal("Enabled"):Connect(function()
            arg1:dispatch(ChatInputBarConfigurationEnabled(chatInputBarConfiguration.Enabled))
            if chatInputBarConfiguration.Enabled then
                transparencyStore.resetAllTransparency()
            end
        end)

        chatInputBarConfiguration:GetPropertyChangedSignal("TargetTextChannel"):Connect(function()
            local targetTextChannel = chatInputBarConfiguration.TargetTextChannel
            local allChannelTabs = if FFlagExpChatUseChannelTabsStore then GetChannelTabsStore(false).getChannelTabsState(false).allChannelTabs else arg1:getState().ChannelTabs.allChannelTabs
            local bool2 = shouldReorderTabs(allChannelTabs, targetTextChannel)
            if FFlagExpChatTabShortcutNav
                and bool2
                and targetTextChannel ~= nil
                and (if FFlagExpChatUseChannelTabsStore then GetChannelTabsStore(false).getChannelTabsState(false).selectedTabName else arg1:getState().ChannelTabs.selectedTabName) == targetTextChannel.Name
            then
                bool2 = false
            end

            if if FFlagExpChatStickyTabs then bool1 else FFlagExpChatGlobalTabDefault and bool1 and isGlobalTabFirst() then
                bool1 = false
                local hasUserSelectedTab, selectedTabName

                if FFlagExpChatUseChannelTabsStore then
                    local var2 = GetChannelTabsStore(false).getChannelTabsState(false)
                    hasUserSelectedTab = var2.hasUserSelectedTab
                    selectedTabName = var2.selectedTabName
                else
                    local channelTabs = arg1:getState().ChannelTabs
                    if channelTabs == nil then
                        hasUserSelectedTab = false
                    else
                        hasUserSelectedTab = channelTabs.hasUserSelectedTab
                    end

                    if channelTabs == nil then
                        selectedTabName = nil
                    else
                        selectedTabName = channelTabs.selectedTabName
                    end
                end

                if if FFlagExpChatStickyTabs then hasUserSelectedTab or FFlagExpChatGlobalTabDefault and isGlobalTabFirst() and selectedTabName == "RBXGlobal" else not hasUserSelectedTab and selectedTabName == "RBXGlobal" then
                    if FFlagExpChatStickyTabs then
                        chatInputBarConfiguration.TargetTextChannel = if selectedTabName then arg1:getState().TextChannels.allTextChannels[selectedTabName] else nil
                    end
                    return
                end
            end

            arg1:dispatch(TargetTextChannelPropertyChanged(targetTextChannel, bool2))
            if FFlagExpChatUseChannelTabsStore then
                GetChannelTabsStore(false).setTargetChannel(targetTextChannel and targetTextChannel.Name, bool2)
            end
        end)

        if arg2.defaultTargetTextChannel then
            chatInputBarConfiguration.TargetTextChannel = arg2.defaultTargetTextChannel
        elseif TextChatService.ChatVersion == Enum.ChatVersion.LegacyChatService then
            game:GetService("Chat"):GetPropertyChangedSignal("IsAutoMigrated"):Once(function()
                local rbxGeneral = TextChatService:FindFirstChild("RBXGeneral", true)
                if not rbxGeneral or not rbxGeneral:IsA("TextChannel") then
                    return
                end

                if FFlagExpChatStickyTabs then
                    bool1 = chatInputBarConfiguration.TargetTextChannel ~= rbxGeneral
                elseif FFlagExpChatGlobalTabDefault then
                    bool1 = true
                end
                chatInputBarConfiguration.TargetTextChannel = rbxGeneral
            end)
        end

        arg1:dispatch(DevTextBoxEnabledChanged(chatInputBarConfiguration.TextBox ~= nil))
        chatInputBarConfiguration:GetPropertyChangedSignal("TextBox"):Connect(function()
            arg1:dispatch(DevTextBoxEnabledChanged(chatInputBarConfiguration.TextBox ~= nil))
        end)

        arg1.changed:connect(function(arg3, arg4)
            if arg3.TextChannels ~= arg4.TextChannels and arg3.TextChannels.targetTextChannel ~= arg4.TextChannels.targetTextChannel then
                chatInputBarConfiguration.TargetTextChannel = arg3.TextChannels.targetTextChannel
            end
        end)

        local tbl1 = {
            "BackgroundTransparency",
            "BackgroundColor3",
            "TextSize",
            "TextColor3",
            "TextStrokeColor3",
            "TextStrokeTransparency",
            "FontFace",
            "PlaceholderColor3",
            "KeyboardKeyCode"
        }

        if getEnableChatInputBarConfigurationAutocompleteEnabled() and chatInputBarConfiguration.AutocompleteEnabled ~= nil then
            table.insert(tbl1, "AutocompleteEnabled")
        end

        for _, value in ipairs(tbl1) do
            if not chatInputBarConfiguration[value] then
                continue
            end

            local keyCode = chatInputBarConfiguration[value]

            if value == "KeyboardKeyCode" and not isKeyboardKeyCodeSanitized(keyCode) then
                chatInputBarConfiguration.KeyboardKeyCode = Enum.KeyCode.Slash
                result[value] = Enum.KeyCode.Slash
            else
                result[value] = keyCode
                func1("ChatInputBarConfigurationLoaded", value, keyCode)
            end
        end

        if isTenFootInterface() then
            result.TextSize = math.floor(0.5 + result.TextSize * 1.5)
        end

        chatInputBarConfiguration.Changed:Connect(function(property: string)
            local keyCode = chatInputBarConfiguration[property]

            if property == "KeyboardKeyCode" and not isKeyboardKeyCodeSanitized(keyCode) then
                chatInputBarConfiguration.KeyboardKeyCode = arg1:getState().ChatLayout.ChatInputBarSettings.KeyboardKeyCode
                return
            end

            if FFlagExpChatUseChatConfigStore then
                GetChatConfigurationStore(false).setChatInputBarProperty(property, keyCode)
            else
                arg1:dispatch(ChatInputBarSettingsChanged(property, keyCode))
            end

            func1("ChatInputBarConfigurationChanged", property, keyCode)
        end)

        return result
    end

    local function func3()
        local bubbleChatConfiguration = TextChatService:FindFirstChildOfClass("BubbleChatConfiguration")
        local result = ({})
        if not bubbleChatConfiguration then
            return {}
        end

        for _, value in ipairs({
            "Enabled",
            "AdorneeName",
            "BubbleDuration",
            "BubblesSpacing",
            "VerticalStudsOffset",
            "LocalPlayerStudsOffset",
            "MinimizeDistance",
            "MaxDistance",
            "BackgroundColor3",
            "TextColor3",
            "TextSize",
            "FontFace",
            "MaxBubbles",
            "TailVisible",
            "BackgroundTransparency"
        }) do
            if bubbleChatConfiguration[value] ~= nil then
                local var2 = bubbleChatConfiguration[value]
                result[value] = var2

                func1("BubbleChatConfigurationLoaded", value, var2)
            end
        end

        if isTenFootInterface() then
            result.TextSize = math.floor(0.5 + result.TextSize * 1.5)
        end

        bubbleChatConfiguration.Changed:Connect(function(property: string)
            local var2 = bubbleChatConfiguration[property]
            if FFlagExpChatUseChatConfigStore then
                GetChatConfigurationStore(false).setBubbleChatProperty(property, var2)
            else
                arg1:dispatch(BubbleChatSettingsChanged(property, var2))
            end

            func1("BubbleChatConfigurationChanged", property, var2)
        end)

        local var2 = setUpBubbleChatConfigurationChildren(arg1)
        for k, value in pairs(var2) do
            if value then
                result[k] = var2[k]
            end
        end

        return result
    end

    local function func4()
        local localPlayer = Players.LocalPlayer
        if not localPlayer then
            return
        end

        for _, descendant in TextChatService:GetDescendants() do
            if not descendant:IsA("TextSource") or descendant.UserId ~= localPlayer.UserId then
                continue
            end

            local descendantParent = descendant.Parent
            if not (descendantParent and descendantParent:IsA("TextChannel")) then
                continue
            end

            if FFlagExpChatUseChannelTabsStore then
                GetChannelTabsStore(false).handleLocalTextChannelParticipantAdded(descendantParent)
            else
                arg1:dispatch(LocalTextChannelParticipantAdded(descendantParent))
            end
        end
    end

    local function func5()
        local channelTabsConfiguration = TextChatService:FindFirstChildOfClass("ChannelTabsConfiguration")
        local result = ({})
        if var1 then
            var1()
        end
        var1 = syncFriendsTabVisibility(arg1)

        if not channelTabsConfiguration then
            return {}
        end

        arg1:dispatch(ChannelTabsConfigurationEnabled(channelTabsConfiguration.Enabled))
        if GetFFlagTextChatEnableUniverseChatTabs() then
            local messagesStore = GetMessagesStore(false)
            if messagesStore then
                messagesStore.setChannelTabsConfigurationEnabled(channelTabsConfiguration.Enabled)
            end
        end
        if FFlagExpChatUseChannelTabsStore then
            GetChannelTabsStore(false).setChannelTabsConfigurationEnabled(channelTabsConfiguration.Enabled)
        end
        channelTabsConfiguration:GetPropertyChangedSignal("Enabled"):Connect(function()
            arg1:dispatch(ChannelTabsConfigurationEnabled(channelTabsConfiguration.Enabled))
            if GetFFlagTextChatEnableUniverseChatTabs() then
                local messagesStore = GetMessagesStore(false)
                if messagesStore then
                    messagesStore.setChannelTabsConfigurationEnabled(channelTabsConfiguration.Enabled)
                end
            end
            if FFlagExpChatUseChannelTabsStore then
                GetChannelTabsStore(false).setChannelTabsConfigurationEnabled(channelTabsConfiguration.Enabled)
            end

            if getFFlagExpChatFixChannelTabsMidExperienceToggle()
                and GetFFlagTextChatEnableUniverseChatTabs()
                and channelTabsConfiguration.Enabled
            then
                func4()
            end
        end)

        for _, value in ipairs({
            "BackgroundTransparency",
            "BackgroundColor3",
            "HoverBackgroundColor3",
            "FontFace",
            "TextSize",
            "TextColor3",
            "SelectedTabTextColor3",
            "TextStrokeColor3",
            "TextStrokeTransparency"
        }) do
            if channelTabsConfiguration[value] then
                local var2 = channelTabsConfiguration[value]
                result[value] = var2

                func1("ChannelTabsConfigurationLoaded", value, var2)
            end
        end

        if isTenFootInterface() then
            result.TextSize = math.floor(0.5 + result.TextSize * 1.5)
        end

        channelTabsConfiguration.Changed:Connect(function(property: string)
            local var2 = channelTabsConfiguration[property]
            if FFlagExpChatUseChatConfigStore then
                GetChatConfigurationStore(false).setChannelTabsProperty(property, var2)
            else
                arg1:dispatch(ChannelTabsSettingsChanged(property, var2))
            end

            func1("ChannelTabsConfigurationChanged", property, var2)
        end)

        return result
    end

    local chatWindowSettings = (function()
        local chatWindowConfiguration = TextChatService:FindFirstChildOfClass("ChatWindowConfiguration")
        local result = ({})

        if not chatWindowConfiguration then
            return {}
        end

        arg1:dispatch(ChatWindowConfigurationEnabled(chatWindowConfiguration.Enabled))
        chatWindowConfiguration:GetPropertyChangedSignal("Enabled"):Connect(function()
            arg1:dispatch(ChatWindowConfigurationEnabled(chatWindowConfiguration.Enabled))
        end)

        arg1:dispatch(ChatLayoutHorizontalAlignmentChanged(chatWindowConfiguration.HorizontalAlignment))
        chatWindowConfiguration:GetPropertyChangedSignal("HorizontalAlignment"):Connect(function()
            arg1:dispatch(ChatLayoutHorizontalAlignmentChanged(chatWindowConfiguration.HorizontalAlignment))
        end)

        arg1:dispatch(ChatLayoutVerticalAlignmentChanged(chatWindowConfiguration.VerticalAlignment))
        chatWindowConfiguration:GetPropertyChangedSignal("VerticalAlignment"):Connect(function()
            arg1:dispatch(ChatLayoutVerticalAlignmentChanged(chatWindowConfiguration.VerticalAlignment))
        end)

        for _, value in ipairs({
            "BackgroundColor3",
            "BackgroundTransparency",
            "FontFace",
            "TextColor3",
            "TextSize",
            "TextStrokeColor3",
            "TextStrokeTransparency",
            "HeightScale",
            "WidthScale",
            "HorizontalAlignment",
            "VerticalAlignment"
        }) do
            if chatWindowConfiguration[value] then
                local var2 = chatWindowConfiguration[value]
                result[value] = var2

                func1("ChatWindowConfigurationLoaded", value, var2)
            end
        end

        if isTenFootInterface() then
            result.TextSize = math.floor(0.5 + result.TextSize * 1.5)
        end

        chatWindowConfiguration.Changed:Connect(function(property: string)
            local var2 = chatWindowConfiguration[property]
            if FFlagExpChatUseChatConfigStore then
                GetChatConfigurationStore(false).setChatWindowProperty(property, var2)
            else
                arg1:dispatch(ChatWindowSettingsChanged(property, var2))
            end

            func1("ChatWindowConfigurationChanged", property, var2)
        end)

        return result
    end)()
    local bubbleChatSettings = func3()
    local chatInputBarSettings = func2()
    local channelTabsSettings = func5()

    if FFlagExpChatUseChatConfigStore then
        local chatConfigurationStore = GetChatConfigurationStore(false)

        chatConfigurationStore.mergeBubbleChatSettings(bubbleChatSettings)
        chatConfigurationStore.mergeChatWindowSettings(chatWindowSettings)
        chatConfigurationStore.mergeChatInputBarSettings(chatInputBarSettings)
        chatConfigurationStore.mergeChannelTabsSettings(channelTabsSettings)
    else
        arg1:dispatch(
            ConfigurationObjectsLoaded({
                bubbleChatSettings = bubbleChatSettings,
                chatWindowSettings = chatWindowSettings,
                chatInputBarSettings = chatInputBarSettings,
                channelTabsSettings = channelTabsSettings
            })
        )
    end
end
