-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local ConversationChannels = require(AppChat.Models.ConversationChannels)
local SignalsExperimental = require(AppChatParent.SignalsExperimental)
local getOtherParticipants = require(script.Parent.getOtherParticipants)
local GetConversationStore = require(AppChat.Stores.GetConversationStore)
local GetConversationSearchDataHydration = require(AppChat.Stores.GetConversationSearchDataHydration)
local FFlagAppChatAnyServerSideConversationSearch = require(AppChat.Flags.FFlagAppChatAnyServerSideConversationSearch)

return function(tbl1, num1: number)
    local otherParticipants = getOtherParticipants(tbl1, num1)
    if #otherParticipants ~= 1 then
        return nil
    end
    local otherParticipant = otherParticipants[1]

    local conversationStore = GetConversationStore(false)
    return AppChatNetworking.http.CreateConversation(nil, "one_to_one", { otherParticipant }):andThen(function(arg1)
        local responseBody = arg1 and arg1.responseBody
        local conversation = responseBody and responseBody.conversations and responseBody.conversations[1]
        if conversation == nil or conversation.status == "failed" then
            return nil
        end

        local channelsApi = ConversationChannels.fromChannelsApi(conversation)
        SignalsExperimental.batch(function()
            conversationStore.upsertConversation(channelsApi, false)
            conversationStore.removeConversation(tbl1.id)
        end)

        if FFlagAppChatAnyServerSideConversationSearch then
            GetConversationSearchDataHydration(false).invalidate()
        end
        return channelsApi
    end)
end
