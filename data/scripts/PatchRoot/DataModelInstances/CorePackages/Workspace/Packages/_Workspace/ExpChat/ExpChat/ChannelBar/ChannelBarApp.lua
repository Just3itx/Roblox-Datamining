-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:41:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TextChatService = game:GetService("TextChatService")
local UserInputService = game:GetService("UserInputService")
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local React = require(ExpChatParent.React)
local Roact = require(ExpChatParent.Roact)
local RoactRodux = require(ExpChatParent.RoactRodux)
local Cryo = require(ExpChatParent.Cryo)
local SignalsReact = require(ExpChatParent.SignalsReact)
local Analytics = require(ExpChatParent.ExpChatShared).Analytics
local Config = require(ExpChat.Config)
local SharedFlags = require(ExpChatParent.SharedFlags)
local FFlagExpChatUseChannelTabsStore = SharedFlags.FFlagExpChatUseChannelTabsStore

local FFlagExpChatUseChatConfigStore = SharedFlags.FFlagExpChatUseChatConfigStore
local FFlagExpChatLogGlobalChatTabClicked = require(ExpChat.Flags.FFlagExpChatLogGlobalChatTabClicked)
local FFlagGlobalTextChatAddPlaySessionField = require(ExpChat.Flags.FFlagGlobalTextChatAddPlaySessionField)
local GetChatConfigurationStore = require(ExpChat.Stores.GetChatConfigurationStore)

local selectTabByType = require(ExpChat.TabNavigation.selectTabByType)

local FFlagDebugFriendsChat = require(ExpChatParent.FriendsChat.FFlagDebugFriendsChat)
local LocalTextChannelParticipantAdded = require(ExpChat.Actions.LocalTextChannelParticipantAdded)
local ChannelTabsConfigurationEnabled = require(ExpChat.Actions.ChannelTabsConfigurationEnabled)
local GetChannelTabsStore = require(ExpChat.Stores.GetChannelTabsStore)

local Signals = require(ExpChatParent.Signals)
local createEffect = Signals.createEffect

local ChannelBar = require(script.Parent.UI.ChannelBar)

local var1 = Roact.Component:extend("ChannelBarApp")

if FFlagExpChatUseChatConfigStore then
    function var1.init(arg1)
        arg1.chatConfigStore = GetChatConfigurationStore(false)
        arg1.state = {
            channelTabsSettings = arg1.chatConfigStore.getChannelTabsSettings(false)
        }
    end
end

function var1.didMount(arg1)
    if FFlagExpChatUseChatConfigStore then
        arg1.updateChannelTabsSettingsEffect = createEffect(function(arg2)
            local channelTabsSettings = arg1.chatConfigStore.getChannelTabsSettings(arg2)
            arg1:setState({ channelTabsSettings = channelTabsSettings })
        end)
    end

    if not FFlagDebugFriendsChat then
        return
    end
    arg1.debugAddTabsConnection = UserInputService.InputBegan:Connect(function(input: InputObject, gameProcessedEvent: boolean)
        if gameProcessedEvent then
            return
        end

        if input.KeyCode == Enum.KeyCode.J and input:IsModifierKeyDown(Enum.ModifierKey.Ctrl) and arg1.props.debugAddFakeTabs then
            arg1.props.debugAddFakeTabs(3)
        end
    end)
end

function var1.willUnmount(arg1)
    if arg1.updateChannelTabsSettingsEffect then
        arg1.updateChannelTabsSettingsEffect()
        arg1.updateChannelTabsSettingsEffect = nil
    end
    if arg1.debugAddTabsConnection then
        arg1.debugAddTabsConnection:Disconnect()
        arg1.debugAddTabsConnection = nil
    end
end

function var1.render(arg1)
    local channelTabsSettings = if FFlagExpChatUseChatConfigStore then arg1.state.channelTabsSettings else arg1.props.channelTabsSettings

    return React.createElement(ChannelBar, {
        channelTabsSettings = channelTabsSettings,
        chatWindowSettings = arg1.props.chatWindowSettings,
        allChannelTabs = arg1.props.allChannelTabs,
        allTextChannels = arg1.props.allTextChannels,
        selectedTabName = arg1.props.selectedTabName,
        onTabSelected = function(arg2, arg3, channelName, arg4)
            if arg4 == "UniverseChat" and FFlagExpChatLogGlobalChatTabClicked and channelName ~= arg1.props.selectedTabName then
                local var2 = table.clone(Analytics.DefaultStandardizedFields)
                table.insert(var2, "addPlaceInstanceId")
                if FFlagGlobalTextChatAddPlaySessionField then
                    table.insert(var2, "addPlaySessionId")
                end
                Analytics:TelemetryLogEvent(Analytics.ExpChatGlobalChatTabClickedConfig, { channelName = channelName }, var2)
            end

            arg1.props.onTabSelected(arg2, arg3, channelName, arg4)
        end,
        onHovered = arg1.props.onHovered,
        onUnhovered = arg1.props.onUnhovered,
        visible = arg1.props.visible,
        transparencyValue = arg1.props.transparencyValue,
        topBorderRef = arg1.props.topBorderRef
    })
end

local var2 = RoactRodux.connect(function(arg1)
    local tbl1 = {
        channelTabsSettings = 0,
        allChannelTabs = 0,
        selectedTabName = 0,
        allTextChannels = 0
    }
    local var2

    if FFlagExpChatUseChatConfigStore then
        var2 = nil
    else
        var2 = arg1.ChatLayout.ChannelTabsSettings
            or {
                BackgroundTransparency = Config.ChannelTabsSettings.BackgroundTransparency,
                BackgroundColor3 = Config.ChannelTabsSettings.BackgroundColor3,
                HoverBackgroundColor3 = Config.ChannelTabsSettings.HoverBackgroundColor3,
                FontFace = Config.ChannelTabsSettings.FontFace,
                TextSize = Config.ChannelTabsSettings.TextSize,
                TextColor3 = Config.ChannelTabsSettings.TextColor3,
                SelectedTabTextColor3 = Config.ChannelTabsSettings.SelectedTabTextColor3,
                TextStrokeColor3 = Config.ChannelTabsSettings.TextStrokeColor3,
                TextStrokeTransparency = Config.ChannelTabsSettings.TextStrokeTransparency
            }
    end

    tbl1.channelTabsSettings = var2

    tbl1.allChannelTabs = if FFlagExpChatUseChannelTabsStore then nil else arg1.ChannelTabs.allChannelTabs or {}
    tbl1.selectedTabName = if FFlagExpChatUseChannelTabsStore then nil else arg1.ChannelTabs.selectedTabName or ""
    tbl1.allTextChannels = arg1.TextChannels.allTextChannels
    return tbl1
end, function(callback)
    return {
        onTabSelected = function(textChannel, shouldReorderTabs, channelName, tabType)
            selectTabByType(
                callback,
                {
                    channelName = channelName,
                    tabType = tabType,
                    shouldReorderTabs = shouldReorderTabs,
                    textChannel = textChannel
                }
            )
        end,
        debugAddFakeTabs = FFlagDebugFriendsChat and function(num1: number)
            callback(ChannelTabsConfigurationEnabled(true))
            local channelTabsStore = GetChannelTabsStore(false)
            channelTabsStore.setChannelTabsConfigurationEnabled(true)
            for i = 1, num1 do
                local str1 = "D" .. tostring(i)
                local textChannel = Instance.new("TextChannel")
                textChannel.Name = str1

                textChannel.Parent = TextChatService:FindFirstChild("TextChannels") or TextChatService
                callback(LocalTextChannelParticipantAdded(textChannel))
                channelTabsStore.addChannelTab({ type = "TextChat", name = str1 }, nil)
            end
        end or nil
    }
end)(var1)

local function areChannelTabsEqual(allChannelTabs, allChannelTabs2)
    if allChannelTabs == allChannelTabs2 then
        return true
    end
    for k, allChannelTab in allChannelTabs do
        local allChannelTab2 = allChannelTabs2[k]
        if allChannelTab2 == nil
            or allChannelTab2.tabIndex ~= allChannelTab.tabIndex
            or allChannelTab2.type ~= allChannelTab.type
            or allChannelTab2.HasUnreadMessages ~= allChannelTab.HasUnreadMessages
        then
            return false
        end
    end
    for k in allChannelTabs2 do
        if allChannelTabs[k] == nil then
            return false
        end
    end
    return true
end

local function ChannelBarAppWithSignals(arg1)
    local var3 = React.useMemo(function()
        return Signals.createComputed(function(arg2)
            local var3 = GetChannelTabsStore(false).getChannelTabsState(arg2)

            return {
                allChannelTabs = var3.allChannelTabs,
                selectedTabName = var3.selectedTabName or ""
            }
        end, function(arg2, arg3)
            return arg2.selectedTabName == arg3.selectedTabName and areChannelTabsEqual(arg2.allChannelTabs, arg3.allChannelTabs)
        end)
    end, {})
    local var4 = SignalsReact.useSignalState(var3)

    return React.createElement(var2, Cryo.Dictionary.union(arg1, var4))
end

if FFlagExpChatUseChannelTabsStore then
    return React.memo(ChannelBarAppWithSignals)
end

return var2
