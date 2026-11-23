-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:51:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local var1 = require(AppChat.Logger):new(script.Name)
local createConversation = require(script.Parent.createConversation)
local getOtherParticipants = require(AppChat.Conversations.getOtherParticipants)
local _ConversationChannels = require(AppChat.Models.ConversationChannels)
local FriendConversationCreated = require(AppChat.Conversations.Actions.FriendConversationCreated)

local function createFriendConversation(oldFriendConversationId: string, arg1)
    return function(arg2)
        local state = arg2:getState()

        local conversation = state.ChatAppReducer.Conversations[oldFriendConversationId]
        if not conversation then
            var1:error(
                "Could not find friendConversationId {} in store state. Unable to create converstation.",
                oldFriendConversationId
            )
            return
        end

        local otherParticipants = getOtherParticipants(conversation, state.LocalUserId)
        if #otherParticipants > 1 then
            var1:error(
                "friendConversationId {} has more than 2 participants. Unable to create one-to-one conversation.",
                oldFriendConversationId
            )
            return
        end

        local str1 = tostring(otherParticipants[1])

        return arg2:dispatch(createConversation("one_to_one", { str1 }, arg1, "userSentMessageToFriendPlaceholder")):tap(function(arg3)
            arg2:dispatch(
                FriendConversationCreated({ newConversationId = arg3.id, oldFriendConversationId = oldFriendConversationId })
            )
        end)
    end
end

return createFriendConversation
