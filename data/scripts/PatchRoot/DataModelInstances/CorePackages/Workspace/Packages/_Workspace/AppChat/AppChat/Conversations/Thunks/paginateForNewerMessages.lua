-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:00:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local FFlagAppChatEnableReactions = require(AppChatParent.SharedFlags).FFlagAppChatEnableReactions

local var1 = require(AppChat.Logger):new("AppChat.paginateForNewerMessages")

local _ConversationChannels = require(AppChat.Models.ConversationChannels)
local GetMessageReactionsStore = require(AppChat.Stores.GetMessageReactionsStore)

local num1 = game:DefineFastInt("AppChatNewMessageFetchMaxDepth", 10)

local function isMessageAlreadyInConversation(arg1, str1: string): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return arg1.messages:Get(str1) ~= nil
end

local function fetchOlderMessages(arg1, arg2, num2: number) -- Luacid: Inlined by compiler; 1 call site recovered
    return function(arg3)
        if FFlagAppChatEnableReactions and arg2.responseBody then
            GetMessageReactionsStore(false).ingestMessageReactions(arg2.responseBody.messages)
        end

        if num1 <= num2 then
            var1:warning("Reached max depth {} of fetching new messages", num1)
            return
        end

        local responseBody = arg2.responseBody
        if not responseBody then
            return
        end

        local messages = responseBody.messages
        local id = if messages and #messages > 0 then messages[#messages].id or nil else nil

        if id == nil then
            var1:warning("No messages in response")
            return
        end
        assert(id, "FFlagLuauTinyControlFlowAnalysis")
        local nextCursor = if responseBody.next_cursor and responseBody.next_cursor ~= "" then responseBody.next_cursor or nil else nil

        if nextCursor == nil then
            var1:debug("No more messages to fetch")
            return
        end

        if isMessageAlreadyInConversation(arg1, id) then
            var1:debug("Last message already in conversation, we've caught up")
            return
        end

        var1:trace("Fetching for the next page of messages using cursor: {}", nextCursor)

        return arg3:dispatch(AppChatNetworking.rodux.GetOlderMessages.API(arg1.id, nextCursor)):andThen(function(arg4)
            return arg3:dispatch(fetchOlderMessages(arg1, arg4, num2 + 1))
        end):catch(function(arg4)
            var1:warning("AppChatNetworking failure in fetchOlderMessages of refreshing new messages: {}", arg4)
        end)
    end
end

return function(arg1)
    return function(arg2)
        var1:info("Starting to fetch newest messages for conversation: {}", arg1.id)

        return arg2:dispatch(AppChatNetworking.rodux.GetOlderMessages.API(arg1.id, nil)):andThen(function(arg3)
            local func1 = fetchOlderMessages(arg1, arg3, 0)
            return arg2:dispatch(func1)
        end):catch(function(arg3)
            var1:warning("AppChatNetworking failure in refreshing first batch of new messages: {}", arg3)
        end)
    end
end
