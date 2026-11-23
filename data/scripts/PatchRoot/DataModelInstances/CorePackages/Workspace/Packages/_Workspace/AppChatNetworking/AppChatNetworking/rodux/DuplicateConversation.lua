-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatNetworking = script:FindFirstAncestor("AppChatNetworking")
local CHAT_PLATFORM_BASE_URL = require(AppChatNetworking.url.CHAT_PLATFORM_BASE_URL)

local RoduxNetworking = require(script.Parent.RoduxNetworking)

local _SharedTypes = require(AppChatNetworking.responses.SharedTypes)

return RoduxNetworking.POST(script.Name, function(arg1, conversationToDuplicate: string, moderationType)
    return arg1(CHAT_PLATFORM_BASE_URL):path("v1"):path("create-conversations"):body({
        conversations = {{
            conversation_to_duplicate = conversationToDuplicate,
            moderation_type = moderationType,
            type = "group",
            participant_user_ids = {}
        }}
    }):setStatusIds(
        { conversationToDuplicate }
    )
end)
