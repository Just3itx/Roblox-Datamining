-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:21:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local AppChatNetworking = require(AppChatParent.AppChatNetworking)

local GetConversationStore = require(AppChat.Stores.GetConversationStore)
local getResponseBody = require(AppChat.Stores.Ingestion.getResponseBody)
local ingestConversationListPage = require(AppChat.Stores.Ingestion.ingestConversationListPage)

local function fetchConversationDetailsToSignals(str1: string)
    return AppChatNetworking.http.GetConversations(nil, str1):andThen(function<T>(arg1: T): T
        local conversationStore = GetConversationStore(false)
        local responseBody = getResponseBody(arg1)
        ingestConversationListPage.ingestConversationResponses(conversationStore, responseBody)
        return arg1
    end)
end

return fetchConversationDetailsToSignals
