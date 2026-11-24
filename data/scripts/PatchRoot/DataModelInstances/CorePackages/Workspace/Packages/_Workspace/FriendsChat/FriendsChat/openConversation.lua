-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:21:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChat = script:FindFirstAncestor("FriendsChat")
local FriendsChatParent = FriendsChat.Parent

local _Promise = require(FriendsChatParent.Promise)
local fetchConversationDetailsToSignals = require(FriendsChatParent.AppChat.fetchConversationDetailsToSignals)
local GetConversationStore = require(FriendsChatParent.AppChat.GetConversationStore)
local GetFriendsChatNavigationStore = require(FriendsChat.Stores.GetFriendsChatNavigationStore)

local function openConversation(str1: string)
    return fetchConversationDetailsToSignals(str1):andThen(function(): boolean
        if GetConversationStore(false).getConversation(str1, false) == nil then
            return false
        end

        GetFriendsChatNavigationStore(false).setSelectedConversationId(str1)
        return true
    end, function(): boolean
        return false
    end)
end

return openConversation
