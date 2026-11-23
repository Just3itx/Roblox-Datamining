-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:10:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatNetworking = script:FindFirstAncestor("AppChatNetworking")
local AppChatNetworkingParent = AppChatNetworking.Parent
local LuauPolyfill = require(AppChatNetworkingParent.LuauPolyfill)
local CHAT_PLATFORM_BASE_URL = require(AppChatNetworking.url.CHAT_PLATFORM_BASE_URL)

local RoduxNetworking = require(script.Parent.RoduxNetworking)

local _SharedTypes = require(AppChatNetworking.responses.SharedTypes)

return RoduxNetworking.POST(script.Name, function(arg1, type, tbl1, name: string?)
    local participantUserIds = LuauPolyfill.Array.map(tbl1, function(arg2): number?
        return tonumber(arg2)
    end)

    return arg1(CHAT_PLATFORM_BASE_URL):path("v1"):path("create-conversations"):body(
        {
            conversations = {{
                type = type,
                name = name,
                participant_user_ids = participantUserIds
            }}
        }
    ):setStatusIds(
        tbl1
    )
end)
