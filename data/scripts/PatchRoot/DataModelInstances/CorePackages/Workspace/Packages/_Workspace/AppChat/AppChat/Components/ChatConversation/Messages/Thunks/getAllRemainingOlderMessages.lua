-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:31:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local AppChatNetworking = require(AppChatParent.AppChatNetworking)

local RoduxNetworking = require(AppChat.Http.RoduxNetworking)
local Promise = require(AppChatParent.Promise)
local var1 = require(AppChat.Logger):new(script.Name)

local getNewestWithNilPreviousMessageId = require(AppChat.Components.ChatConversation.Utils.getNewestWithNilPreviousMessageId)

local num1 = game:DefineFastInt("AppChatMessageFetchRetryDelayMs", 500)

local function fetchNextBatch(arg1, func1: (...any) -> (...any), str1: string, num2: number, num3: number)
    if num2 <= num3 then
        var1:info("Max depth reached ({}), stopping recursive message fetching", num3)
        return Promise.resolve()
    end

    local chatAppReducer = arg1:getState().ChatAppReducer
    if not (chatAppReducer and chatAppReducer.Conversations) then
        var1:info("No conversations in state, stopping recursive message fetching")
        return Promise.resolve()
    end

    local conversation = chatAppReducer.Conversations[str1]
    if not conversation then
        var1:info("Conversation not found, stopping recursive message fetching")
        return Promise.resolve()
    end

    if conversation.fetchedOldestMessage then
        var1:info("Already fetched oldest message, stopping recursive message fetching")
        return Promise.resolve()
    end

    if AppChatNetworking.rodux.GetOlderMessages.getStatus(arg1:getState(), str1) == RoduxNetworking.Enum.NetworkStatus.Fetching then
        var1:info("Messages are currently being fetched, waiting before trying again")

        return Promise.delay(num1 / 1000):andThen(function()
            return fetchNextBatch(arg1, func1, str1, num2, num3)
        end)
    end

    local newestWithNilPreviousMessageId = getNewestWithNilPreviousMessageId(conversation.messages)
    var1:info("Fetching batch {} of older messages for conversation {}", num3, str1)

    return arg1:dispatch(func1(str1, newestWithNilPreviousMessageId, conversation.nextCursor)):andThen(function()
        var1:info("Fetched batch {}, continuing to fetch next batch", num3)
        return fetchNextBatch(arg1, func1, str1, num2, num3 + 1)
    end)
end

return function(func1: (...any) -> (...any), str1: string, num2: number)
    var1:info("Starting to fetch all remaining older messages for conversation {}", str1)
    return function(arg1)
        return fetchNextBatch(arg1, func1, str1, num2, 0):catch(function(arg2)
            var1:warning("Error fetching all remaining older messages: {}", arg2)
            return Promise.reject(arg2)
        end)
    end
end
