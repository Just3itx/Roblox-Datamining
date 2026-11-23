-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:21:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local AppChatNetworking = require(AppChatParent.AppChatNetworking)

local ingestNewerMessages = require(AppChat.Stores.Ingestion.ingestNewerMessages)

local function fetchNewerMessages(str1: string)
    return AppChatNetworking.http.GetConversationMessages(nil, str1, nil):andThen(function(response)
        local responseBody = response and response.responseBody
        local var1 = not responseBody and {} or responseBody.messages or {}
        return {
            response = response,
            ingestedIds = ingestNewerMessages(str1, var1)
        }
    end)
end
return fetchNewerMessages
