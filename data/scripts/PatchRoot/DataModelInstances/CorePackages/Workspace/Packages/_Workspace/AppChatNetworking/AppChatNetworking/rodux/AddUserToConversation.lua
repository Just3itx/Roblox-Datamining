-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:10:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatNetworking = script:FindFirstAncestor("AppChatNetworking")
local AppChatNetworkingParent = AppChatNetworking.Parent
local LuauPolyfill = require(AppChatNetworkingParent.LuauPolyfill)

local CHAT_PLATFORM_BASE_URL = require(AppChatNetworking.url.CHAT_PLATFORM_BASE_URL)

return require(script.Parent.RoduxNetworking).POST(script.Name, function(arg1, conversationId: string, tbl1)
    local userIds = LuauPolyfill.Array.map(tbl1, function(arg2): number?
        return tonumber(arg2)
    end)

    return arg1(CHAT_PLATFORM_BASE_URL):path("v1"):path("add-users"):body({ conversation_id = conversationId, user_ids = userIds })
end)
