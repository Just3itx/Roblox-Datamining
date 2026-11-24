-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:50:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local React = require(ExpChatParent.React)
local RoactUtils = require(ExpChatParent.RoactUtils)
local SharedFlags = require(ExpChatParent.SharedFlags)
local SignalsReact = require(ExpChatParent.SignalsReact)

local FriendsChatEventReceiver = require(ExpChatParent.FriendsChat.FriendsChatEventReceiver)
local FriendsChatTabName = require(ExpChatParent.FriendsChat.FriendsChatTabName)
local GetTransparencyStore = require(ExpChat.Stores.GetTransparencyStore)
local GetChannelTabsStore = require(ExpChat.Stores.GetChannelTabsStore)
local selectSelectedTabName = require(ExpChat.selectSelectedTabName)
local useChannelTabUnreadWriter = require(ExpChat.useChannelTabUnreadWriter)

local useSelector = RoactUtils.Hooks.RoactRodux.useSelector

local function selectIsChatWindowVisible(arg1)
    return arg1.ChatVisibility.isChatWindowEnabled.value
end

local function onActiveConversationMessageReceived()
    GetTransparencyStore(false).resetAllTransparency()
end

local func1 = SharedFlags.FFlagExpChatUseChannelTabsStore and function() -- name: useSelectedTabNameFromSignals
    return SignalsReact.useSignalState(GetChannelTabsStore(false).getSelectedTabName)
end or function() -- name: useSelectedTabNameFromRodux
    return useSelector(selectSelectedTabName)
end

local function FriendsChatEventReceiverConnector()
    local selectedTabName = func1()
    local isChatWindowVisible = useSelector(selectIsChatWindowVisible)
    local setTabUnread = useChannelTabUnreadWriter(FriendsChatTabName)

    return React.createElement(FriendsChatEventReceiver, {
        setTabUnread = setTabUnread,
        selectedTabName = selectedTabName,
        isChatWindowVisible = isChatWindowVisible,
        onActiveConversationMessageReceived = onActiveConversationMessageReceived
    })
end

return FriendsChatEventReceiverConnector
