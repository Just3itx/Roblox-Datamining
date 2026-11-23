-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local AppChatNetworking = script:FindFirstAncestor("AppChatNetworking")
local AppChatNetworkingParent = AppChatNetworking.Parent

local CHAT_PLATFORM_BASE_URL = require(AppChatNetworking.url.CHAT_PLATFORM_BASE_URL)
local default = require(AppChatNetworking.url.HttpRequest).default
local Object = require(AppChatNetworkingParent.LuauPolyfill).Object
local GetFFlagEnableSocialCards = require(AppChatNetworkingParent.SharedFlags).GetFFlagEnableSocialCards

local tbl1 = { include_participants = true, include_user_data = true, include_messages = true }

return function(arg1, str1: string, tbl2)
    arg1 = arg1 or default
    local var1 = Object.assign({}, tbl1, tbl2 or {})

    local postBody = HttpService:JSONEncode({
        ids = { str1 },
        include_participants = var1.include_participants,
        include_user_data = var1.include_user_data,
        include_messages = var1.include_messages,
        include_cards = not not GetFFlagEnableSocialCards()
    })
    return arg1(`{CHAT_PLATFORM_BASE_URL}/v1/get-conversations`, "POST", { postBody = postBody })
end
