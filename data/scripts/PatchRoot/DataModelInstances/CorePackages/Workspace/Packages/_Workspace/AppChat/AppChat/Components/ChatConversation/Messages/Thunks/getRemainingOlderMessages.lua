-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:31:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local AppChatNetworking = require(AppChatParent.AppChatNetworking)

local RoduxNetworking = require(AppChat.Http.RoduxNetworking)
local Promise = require(AppChatParent.Promise)
local var1 = require(AppChat.Logger):new(script.Name)

local getNewestWithNilPreviousMessageId = require(AppChat.Components.ChatConversation.Utils.getNewestWithNilPreviousMessageId)

return function(func1: (...any) -> (...any), str1: string)
    var1:info("Maybe getting older messages for {}", str1)
    return function(arg1)
        local chatAppReducer = arg1:getState().ChatAppReducer
        if not (chatAppReducer and chatAppReducer.Conversations) then
            return Promise.resolve()
        end

        local conversation = chatAppReducer.Conversations[str1]

        local bool1 = AppChatNetworking.rodux.GetOlderMessages.getStatus(arg1:getState(), str1) == RoduxNetworking.Enum.NetworkStatus.Fetching
        if not conversation then
            var1:info("Canceling since conversation id {} is not in local state", str1)
            return Promise.resolve()
        elseif bool1 then
            var1:info("Canceling since we are already fetching older messages for conversation id {}", str1)
            return Promise.resolve()
        elseif conversation.fetchedOldestMessage then
            var1:info("Canceling since we have already fetched the oldest message for conversation id {}", str1)

            return Promise.resolve()
        else
            local newestWithNilPreviousMessageId = getNewestWithNilPreviousMessageId(conversation.messages)
            return func1(str1, newestWithNilPreviousMessageId, conversation.nextCursor)
        end
    end
end
