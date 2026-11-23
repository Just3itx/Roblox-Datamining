-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Cryo = require(AppChatParent.Cryo)
local Promise = require(AppChatParent.Promise)
local _ConversationChannels = require(AppChat.Models.ConversationChannels)
local ReloadedMessagesForConversations = require(AppChat.Conversations.Actions.ReloadedMessagesForConversations)
local multiGetConversationDetails = require(AppChat.Conversations.Thunks.multiGetConversationDetails)

local function reloadMessagesForConversations(tbl1)
    return function(arg1)
        local conversations = arg1:getState().ChatAppReducer.Conversations
        local var1 = Cryo.List.filter(tbl1, function(arg2): boolean
            local conversation = conversations[arg2]
            return not not (conversation and conversation.source == "channels")
        end)
        if #var1 == 0 then
            return Promise.resolve()
        end

        arg1:dispatch(ReloadedMessagesForConversations(var1))
        return arg1:dispatch(multiGetConversationDetails(var1))
    end
end
return reloadMessagesForConversations
