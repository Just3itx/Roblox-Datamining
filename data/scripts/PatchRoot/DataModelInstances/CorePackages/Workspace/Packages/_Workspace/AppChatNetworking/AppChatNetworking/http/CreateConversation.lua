-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:01:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local AppChatNetworking = script:FindFirstAncestor("AppChatNetworking")
local AppChatNetworkingParent = AppChatNetworking.Parent
local LuauPolyfill = require(AppChatNetworkingParent.LuauPolyfill)

local default = require(AppChatNetworking.url.HttpRequest).default
local CHAT_PLATFORM_BASE_URL = require(AppChatNetworking.url.CHAT_PLATFORM_BASE_URL)

return function(arg1, type: string, tbl1, name: string?)
    arg1 = arg1 or default
    local participantUserIds = LuauPolyfill.Array.map(tbl1, function(arg2): number?
        return tonumber(arg2)
    end)

    local postBody = HttpService:JSONEncode({ conversations = {{ type = type, name = name, participant_user_ids = participantUserIds }} })

    return arg1(`{CHAT_PLATFORM_BASE_URL}/v1/create-conversations`, "POST", { postBody = postBody })
end
