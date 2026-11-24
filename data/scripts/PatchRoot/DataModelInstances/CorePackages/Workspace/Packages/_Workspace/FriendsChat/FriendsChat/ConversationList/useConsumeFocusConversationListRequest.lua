-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:01:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChat = script:FindFirstAncestor("FriendsChat")
local FriendsChatParent = FriendsChat.Parent
local React = require(FriendsChatParent.React)
local Signals = require(FriendsChatParent.Signals)

local GetFriendsChatNavigationStore = require(FriendsChat.Stores.GetFriendsChatNavigationStore)
local isFocusRequestFresh = require(FriendsChat.Focus.isFocusRequestFresh)

local function useConsumeFocusConversationListRequest<T>(arg1: T, callback: (...any) -> (...any))
    React.useEffect(function()
        local friendsChatNavigationStore = GetFriendsChatNavigationStore(false)
        return Signals.createEffect(function(arg2)
            local conversationListFocusRequestTime = friendsChatNavigationStore.getConversationListFocusRequestTime(arg2)
            if conversationListFocusRequestTime == nil then
                return
            end

            if not isFocusRequestFresh(conversationListFocusRequestTime, os.clock(), 5) then
                friendsChatNavigationStore.clearConversationListFocusRequest()
                return
            end

            local var1 = arg1(arg2)
            if var1 == nil then
                return
            end
            callback(var1)
            friendsChatNavigationStore.clearConversationListFocusRequest()
        end)
    end, { arg1, callback })
end

return useConsumeFocusConversationListRequest
