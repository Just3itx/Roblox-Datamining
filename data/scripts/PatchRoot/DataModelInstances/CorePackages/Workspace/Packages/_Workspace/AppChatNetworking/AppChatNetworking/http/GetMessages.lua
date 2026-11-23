-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:01:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local AppChatNetworking = script:FindFirstAncestor("AppChatNetworking")
local AppChatNetworkingParent = AppChatNetworking.Parent

local CHAT_PLATFORM_BASE_URL = require(AppChatNetworking.url.CHAT_PLATFORM_BASE_URL)
local default = require(AppChatNetworking.url.HttpRequest).default
local GetFFlagEnableSocialCards = require(AppChatNetworkingParent.SharedFlags).GetFFlagEnableSocialCards

return function(arg1, conversationId: string, tbl1, tbl2)
    arg1 = arg1 or default

    local messages = {}
    for _, messageId in tbl1 do
        table.insert(messages, { conversation_id = conversationId, message_id = messageId })
    end

    local postBody = HttpService:JSONEncode({
        messages = messages,
        include_reactions = not not (tbl2 and tbl2.include_reactions),
        include_cards = not not GetFFlagEnableSocialCards()
    })
    return arg1(`{CHAT_PLATFORM_BASE_URL}/v1/get-messages`, "POST", { postBody = postBody })
end
