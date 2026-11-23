-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:01:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local AppChatNetworking = script:FindFirstAncestor("AppChatNetworking")

local CHAT_PLATFORM_BASE_URL = require(AppChatNetworking.url.CHAT_PLATFORM_BASE_URL)
local default = require(AppChatNetworking.url.HttpRequest).default
local _SharedTypes = require(AppChatNetworking.responses.SharedTypes)

return function(arg1, tbl1)
    arg1 = arg1 or default

    local postBody = HttpService:JSONEncode({
        action_type = tbl1.actionType,
        modal_sequence = tbl1.modalSequence,
        modal_id = tbl1.modalId,
        modal_variant = tbl1.modalVariant,
        conversation_id = tbl1.conversationId,
        friend_id = tbl1.friendId
    })
    return arg1(
        `{CHAT_PLATFORM_BASE_URL}/v1/record-modal-sequence-response`,
        "POST",
        { postBody = postBody, maxRetryCount = 0 }
    )
end
