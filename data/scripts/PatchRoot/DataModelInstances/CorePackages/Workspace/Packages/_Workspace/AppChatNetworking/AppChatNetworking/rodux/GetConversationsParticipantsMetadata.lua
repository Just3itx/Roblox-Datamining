-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:11:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatNetworking = script:FindFirstAncestor("AppChatNetworking")
local CHAT_PLATFORM_BASE_URL = require(AppChatNetworking.url.CHAT_PLATFORM_BASE_URL)

return require(script.Parent.RoduxNetworking).POST(script.Name, function(arg1, conversationIds)
    return arg1(CHAT_PLATFORM_BASE_URL):path("v1"):path("get-conversations-participants-metadata"):body(
        { conversation_ids = conversationIds }
    ):setStatusIds(
        conversationIds
    )
end)
