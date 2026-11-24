-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:21:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local React = require(FriendsChatParent.React)
local SignalsReact = require(FriendsChatParent.SignalsReact)
local SharedFlags = require(FriendsChatParent.SharedFlags)

local FriendsSurfaceVisibility = require(FriendsChatParent.ExpChatShared).FriendsSurfaceVisibility
local GetFriendsChatNavigationStore = require(script.Parent.Parent.Stores.GetFriendsChatNavigationStore)
local GetFriendsChatRealtimeStore = require(script.Parent.Parent.Stores.GetFriendsChatRealtimeStore)
local FriendsChatRealtimeSubscriber = require(script.Parent.FriendsChatRealtimeSubscriber)
local FriendsCountRefetchBridge = require(script.Parent.FriendsCountRefetchBridge)
local FriendsTabUnreadBridge = require(script.Parent.FriendsTabUnreadBridge)
local FriendsChatTabName = require(script.Parent.Parent.FriendsChatTabName)

local FFlagFriendsChatHasFriendsGate = SharedFlags.FFlagFriendsChatHasFriendsGate
local FFlagExpChatCanShowFriendsTab = SharedFlags.FFlagExpChatCanShowFriendsTab

local function FriendsChatEventReceiver(tbl1)
    local friendsChatRealtimeStore = GetFriendsChatRealtimeStore(false)
    local var1 = SignalsReact.useSignalState(friendsChatRealtimeStore.getHasEnteredFriendsTab)

    local var2 = SignalsReact.useSignalState(GetFriendsChatNavigationStore(false).getSelectedConversationId)

    React.useEffect(function()
        local var3 = if tbl1.isChatWindowVisible and tbl1.selectedTabName == FriendsChatTabName then var2 else nil
        FriendsSurfaceVisibility.setVisibleConversationId(var3)

        return function()
            if FriendsSurfaceVisibility.getVisibleConversationId(false) == var3 then
                FriendsSurfaceVisibility.setVisibleConversationId(nil)
            end
        end
    end, { tbl1.isChatWindowVisible, tbl1.selectedTabName, var2 })

    return React.createElement(React.Fragment, nil, {
        unreadBridge = React.createElement(FriendsTabUnreadBridge, {
            setTabUnread = tbl1.setTabUnread,
            selectedTabName = tbl1.selectedTabName,
            isChatWindowVisible = tbl1.isChatWindowVisible
        }),
        countRefetchBridge = if FFlagFriendsChatHasFriendsGate and FFlagExpChatCanShowFriendsTab then React.createElement(FriendsCountRefetchBridge) else nil,
        subscriber = if var1 then React.createElement(
            FriendsChatRealtimeSubscriber,
            {
                onActiveConversationMessageReceived = tbl1.onActiveConversationMessageReceived
            }
        ) else nil
    })
end

return FriendsChatEventReceiver
