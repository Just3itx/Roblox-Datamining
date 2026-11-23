-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:01:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local AppChatNetworking = script:FindFirstAncestor("AppChatNetworking")

local CHAT_PLATFORM_BASE_URL = require(AppChatNetworking.url.CHAT_PLATFORM_BASE_URL)
local default = require(AppChatNetworking.url.HttpRequest).default

return function(arg1, conversationId: string, messageId: string, emoteId: string)
    arg1 = arg1 or default

    local postBody = HttpService:JSONEncode({ conversation_id = conversationId, message_id = messageId, emote_id = emoteId })

    return arg1(`{CHAT_PLATFORM_BASE_URL}/v1/remove-messages-reactions`, "POST", { postBody = postBody })
end
