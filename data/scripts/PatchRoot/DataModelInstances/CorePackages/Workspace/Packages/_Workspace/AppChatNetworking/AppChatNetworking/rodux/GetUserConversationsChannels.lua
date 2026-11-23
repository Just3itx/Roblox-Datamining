-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:11:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatNetworking = script:FindFirstAncestor("AppChatNetworking")
local CHAT_PLATFORM_BASE_URL = require(AppChatNetworking.url.CHAT_PLATFORM_BASE_URL)

local RoduxNetworking = require(script.Parent.RoduxNetworking)
local AppChatNetworkingParent = AppChatNetworking.Parent
local GetFFlagIsSquadEnabled = require(AppChatNetworkingParent.SharedFlags).GetFFlagIsSquadEnabled
local GetFFlagEnableSocialCards = require(AppChatNetworkingParent.SharedFlags).GetFFlagEnableSocialCards

return RoduxNetworking.GET(script.Name, function(arg1, cursor: string?)
    return arg1(CHAT_PLATFORM_BASE_URL):path("v1"):path("get-user-conversations"):queryArgs({
        cursor = cursor,
        include_cards = not not GetFFlagEnableSocialCards(),
        include_user_data = true,
        include_messages = true,
        check_for_group_up = not not GetFFlagIsSquadEnabled()
    })
end)
