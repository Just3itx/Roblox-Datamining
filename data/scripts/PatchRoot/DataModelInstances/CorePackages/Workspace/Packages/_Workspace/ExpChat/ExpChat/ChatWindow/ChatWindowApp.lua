-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:00:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local GetTransparencyStore = require(ExpChat.Stores.GetTransparencyStore)
local GetMessagesStore = require(ExpChat.Stores.GetMessagesStore)
local FFlagExpChatGlobalTabDefault = require(ExpChat.Flags.FFlagExpChatGlobalTabDefault)
local Roact = require(ExpChatParent.Roact)
local React = require(ExpChatParent.React)
local RoactRodux = require(ExpChatParent.RoactRodux)
local Cryo = require(ExpChatParent.Cryo)
local SignalsReact = require(ExpChatParent.SignalsReact)
local List = require(ExpChatParent.llama).List
local ExpChatShared = require(ExpChatParent.ExpChatShared)
local memoize = require(ExpChat.memoize)
local Signals = require(ExpChatParent.Signals)
local createEffect = Signals.createEffect

local FFlagExpChatEnableV2ChatWindow = require(ExpChat.Flags.FFlagExpChatEnableV2ChatWindow)
local FFlagEnableVerifiedBadgeStore = require(ExpChatParent.SharedFlags).FFlagEnableVerifiedBadgeStore

local UI = script.Parent.UI
local ChatWindowMessageSource = require(UI.ChatWindow.ChatWindowMessageSource)

local FFlagExpChatUseChannelTabsStore = require(ExpChatParent.SharedFlags).FFlagExpChatUseChannelTabsStore
local GetChannelTabsStore = if FFlagExpChatUseChannelTabsStore then require(ExpChat.Stores.GetChannelTabsStore) else nil
local bool1 = game:DefineFastFlag("ExpChatMoveMessagesStoreToInit", false)
local GetFFlagTextChatEnableUniverseChatTabs = ExpChatShared.Flags.GetFFlagTextChatEnableUniverseChatTabs
local FFlagExpChatMessagesStoreUseProxy = require(ExpChat.Flags.FFlagExpChatMessagesStoreUseProxy)

local function readByMessageIdAsTable(messagesStore, arg1)
    local byMessageId = if arg1 then messagesStore.getByMessageId(arg1) else messagesStore.getByMessageId(false)

    if not FFlagExpChatMessagesStoreUseProxy then
        return byMessageId
    end

    local result = ({})
    for value, value2 in byMessageId do
        result[value] = value2
    end
    return result
end

local var1 = Roact.Component:extend("ChatWindowApp")
var1.defaultProps = {
    LayoutOrder = 1,
    messages = not FFlagExpChatEnableV2ChatWindow and {} or nil,
    size = UDim2.fromScale(1, 1)
}

local var2 = if GetFFlagTextChatEnableUniverseChatTabs() then memoize(function(arg1, arg2, arg3, arg4)
    if not arg2 then
        return List.map(arg1.windowMessagesInOrder, function(arg5)
            return arg1.byMessageId[arg5]
        end)
    end

    if FFlagExpChatGlobalTabDefault then
        if arg3 and arg1.windowMessagesInOrderByTabId[arg3.Name] and arg4 ~= "RBXGlobal" then
            arg4 = arg3.Name
        end
    elseif arg3 and arg1.windowMessagesInOrderByTabId[arg3.Name] then
        arg4 = arg3.Name
    end
    if arg4 then
        return List.map(arg1.windowMessagesInOrderByTabId[arg4] or {}, function(arg5)
            return arg1.byMessageId[arg5]
        end)
    end

    return {}
end) else memoize(function(arg1, arg2, arg3)
    if not arg2 then
        return List.map(arg1.windowMessagesInOrder, function(arg4)
            return arg1.byMessageId[arg4]
        end)
    elseif arg3 then
        return List.map(arg1.windowMessagesInOrderByTabId[arg3.Name] or {}, function(arg4)
            return arg1.byMessageId[arg4]
        end)
    end

    return {}
end)

if not FFlagExpChatEnableV2ChatWindow then
    function var1.init(arg1)
        arg1.MessagesStore = GetMessagesStore(false)
        arg1.disposeEffects = {}

        if not (bool1 and arg1.MessagesStore) then
            arg1.state = { messagesState = nil }

            return
        end

        arg1.state = {
            messagesState = {
                byMessageId = readByMessageIdAsTable(arg1.MessagesStore),
                windowMessagesInOrder = arg1.MessagesStore.getWindowMessagesInOrder(false),
                windowMessagesInOrderByTabId = arg1.MessagesStore.getWindowMessagesInOrderByTabId(false)
            }
        }
    end

    function var1.didMount(arg1)
        if not arg1.MessagesStore then
            return
        end

        if not bool1 then
            local messagesState = {
                byMessageId = readByMessageIdAsTable(arg1.MessagesStore),
                windowMessagesInOrder = arg1.MessagesStore.getWindowMessagesInOrder(false),
                windowMessagesInOrderByTabId = arg1.MessagesStore.getWindowMessagesInOrderByTabId(false)
            }

            if messagesState then
                arg1:setState({ messagesState = messagesState })
            end
        end

        table.insert(arg1.disposeEffects, (createEffect(function(arg2)
            local byMessageId = readByMessageIdAsTable(arg1.MessagesStore, arg2)
            local windowMessagesInOrder = arg1.MessagesStore.getWindowMessagesInOrder(arg2)
            local windowMessagesInOrderByTabId = arg1.MessagesStore.getWindowMessagesInOrderByTabId(arg2)

            if not byMessageId and not windowMessagesInOrder and not windowMessagesInOrderByTabId then
                return
            end

            arg1:setState({
                messagesState = {
                    byMessageId = byMessageId,
                    windowMessagesInOrder = windowMessagesInOrder,
                    windowMessagesInOrderByTabId = windowMessagesInOrderByTabId
                }
            })
        end)))
    end

    function var1.willUnmount(arg1)
        if not arg1.disposeEffects then
            return
        end

        for _, disposeEffect in ipairs(arg1.disposeEffects) do
            disposeEffect()
        end
        arg1.disposeEffects = {}
    end
end

function var1.render(arg1)
    local var3

    if FFlagExpChatEnableV2ChatWindow then
        var3 = nil
    else
        local messagesState = arg1.state.messagesState

        if messagesState then
            if GetFFlagTextChatEnableUniverseChatTabs() then
                var3 = var2(messagesState, arg1.props.isChannelBarVisible, arg1.props.targetTextChannel, arg1.props.selectedChannelName)
            else
                var3 = var2(messagesState, arg1.props.isChannelBarVisible, arg1.props.targetTextChannel)
            end
        else
            var3 = {}
        end
    end

    local tbl1 = {
        LayoutOrder = arg1.props.LayoutOrder,
        messages = 0,
        size = 0,
        transparencyValue = 0,
        textTransparency = 0,
        onHovered = 0,
        onUnhovered = 0,
        verifiedUserIds = 0,
        activateWhisperMode = 0,
        resetTargetChannel = 0,
        visible = 0,
        onAbsoluteSizeChanged = 0,
        onAbsolutePositionChanged = 0,
        chatWindowSettings = 0,
        showTranslationButton = 0,
        targetTextChannel = 0,
        selectedChannelName = 0,
        scrollResetKey = 0,
        isChannelBarVisible = 0,
        onFocus = 0,
        onUnfocus = 0
    }

    if FFlagExpChatEnableV2ChatWindow then
        var3 = nil
    end

    tbl1.messages = var3
    tbl1.size = arg1.props.size
    tbl1.transparencyValue = arg1.props.transparencyValue
    tbl1.textTransparency = arg1.props.textTransparency
    tbl1.onHovered = arg1.props.onHovered
    tbl1.onUnhovered = arg1.props.onUnhovered
    tbl1.verifiedUserIds = arg1.props.verifiedUserIds
    tbl1.activateWhisperMode = arg1.props.activateWhisperMode
    tbl1.resetTargetChannel = arg1.props.resetTargetChannel
    tbl1.visible = arg1.props.visible
    tbl1.onAbsoluteSizeChanged = arg1.props.onAbsoluteSizeChanged
    tbl1.onAbsolutePositionChanged = arg1.props.onAbsolutePositionChanged
    tbl1.chatWindowSettings = arg1.props.chatWindowSettings
    tbl1.showTranslationButton = arg1.props.showTranslationButton
    tbl1.targetTextChannel = arg1.props.targetTextChannel

    tbl1.selectedChannelName = arg1.props.selectedChannelName

    tbl1.scrollResetKey = arg1.props.selectedChannelName
    tbl1.isChannelBarVisible = arg1.props.isChannelBarVisible
    tbl1.onFocus = arg1.props.onFocus
    tbl1.onUnfocus = arg1.props.onUnfocus

    return Roact.createElement(ChatWindowMessageSource, tbl1)
end

local function haveSameTabNames(arg1, arg2) -- Luacid: unused: defined but never referenced
    if arg1 == arg2 then
        return true
    end
    for value in arg1 do
        if arg2[value] == nil then
            return false
        end
    end
    for value in arg2 do
        if arg1[value] == nil then
            return false
        end
    end
    return true
end

local var3 = React.memo(var1)

return RoactRodux.connect(function(arg1)
    local var4

    if FFlagExpChatUseChannelTabsStore then
        var4 = nil
    else
        local channelTabs = arg1.ChannelTabs
        local selectedChannelName = arg1.TextChannels.selectedChannelName
        var4 = selectedChannelName and channelTabs and channelTabs.allChannelTabs[selectedChannelName] and selectedChannelName
            or channelTabs and channelTabs.selectedTabName
            or "RBXGeneral"
    end

    return {
        chatIntervention = arg1.ChatIntervention,
        verifiedUserIds = if FFlagEnableVerifiedBadgeStore then nil else arg1.VerifiedUsers,
        targetTextChannel = arg1.TextChannels.targetTextChannel,
        selectedChannelName = var4,
        roduxSelectedChannelName = if FFlagExpChatUseChannelTabsStore then arg1.TextChannels.selectedChannelName else nil
    }
end, function(_)
    return {
        onFocus = function()
            return GetTransparencyStore(false).setContextMenuOpen()
        end,
        onUnfocus = function()
            return GetTransparencyStore(false).clearContextMenuOpen()
        end
    }
end)(FFlagExpChatUseChannelTabsStore and function(arg1) -- name: ChatWindowAppWithSignals
    local var4 = React.useMemo(function()
        return Signals.createComputed(function(arg2)
            local var4 = GetChannelTabsStore(false).getChannelTabsState(arg2)
            return {
                allChannelTabs = var4.allChannelTabs,
                selectedTabName = var4.selectedTabName
            }
        end, function(arg2, arg3)
            local bool2

            if arg2.selectedTabName == arg3.selectedTabName then
                local allChannelTabs = arg2.allChannelTabs
                local allChannelTabs2 = arg3.allChannelTabs

                if allChannelTabs == allChannelTabs2 then
                    return true
                end
                for k in allChannelTabs do
                    if allChannelTabs2[k] == nil then
                        return false
                    end
                end
                for k in allChannelTabs2 do
                    if allChannelTabs[k] == nil then
                        return false
                    end
                end

                bool2 = true
            else
                bool2 = false
            end

            return bool2
        end)
    end, {})
    local var5 = SignalsReact.useSignalState(var4)

    local roduxSelectedChannelName = arg1.roduxSelectedChannelName
    local selectedChannelName = roduxSelectedChannelName and var5.allChannelTabs[roduxSelectedChannelName] and roduxSelectedChannelName
        or var5.selectedTabName
        or "RBXGeneral"

    return React.createElement(var3, Cryo.Dictionary.union(arg1, { selectedChannelName = selectedChannelName }))
end or var1)
