-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:20:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local Signals = require(FriendsChatParent.Signals)
local Conversation = require(FriendsChatParent.AppChat.Conversation)
local GetConversationStore = require(FriendsChatParent.AppChat.GetConversationStore)

local function createGetIsGroup(str1: string?)
    return Signals.createComputed(function(arg1): boolean
        if str1 == nil then
            return false
        end
        local var1 = GetConversationStore(arg1).getConversation(str1, arg1)
        return not (var1 == nil) and var1.conversationType == Conversation.Type.MULTI_USER_CONVERSATION
    end)
end

return createGetIsGroup
