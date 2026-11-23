-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:21:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local Promise = require(AppChatParent.Promise)

local GetConversationMessageListStore = require(AppChat.Stores.GetConversationMessageListStore)
local ingestOlderMessages = require(AppChat.Stores.Ingestion.ingestOlderMessages)

local function fetchOlderMessages(str1: string)
    local conversationMessageListStore = GetConversationMessageListStore(false)
    local metadata = conversationMessageListStore.getMetadata(str1, false)
    if metadata and (metadata.isLoading or metadata.fetchedOldest) then
        return Promise.resolve({ response = nil, ingestedIds = {} })
    end

    local nextPageCursor = metadata and metadata.nextPageCursor or nil
    conversationMessageListStore.setLoading(str1, true)

    return AppChatNetworking.http.GetConversationMessages(nil, str1, nextPageCursor):andThen(function(response)
        local responseBody = response and response.responseBody
        local var1 = not responseBody and {} or responseBody.messages or {}
        local nextCursor = if responseBody then responseBody.next_cursor else nil
        return {
            response = response,
            ingestedIds = ingestOlderMessages(str1, var1, nextCursor)
        }
    end):catch(function(arg1)
        conversationMessageListStore.setLoading(str1, false)
        return Promise.reject(arg1)
    end)
end

return fetchOlderMessages
