-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:11:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatNetworking = script:FindFirstAncestor("AppChatNetworking")
local AppChatNetworkingParent = AppChatNetworking.Parent
local CHAT_PLATFORM_BASE_URL = require(AppChatNetworking.url.CHAT_PLATFORM_BASE_URL)

local RoduxNetworking = require(script.Parent.RoduxNetworking)

local GetFFlagEnableSocialCards = require(AppChatNetworkingParent.SharedFlags).GetFFlagEnableSocialCards

return RoduxNetworking.POST(script.Name, function(arg1, ids)
    return arg1(CHAT_PLATFORM_BASE_URL):path("v1"):path("get-conversations"):body({
        ids = ids,
        include_cards = not not GetFFlagEnableSocialCards(),
        include_participants = true,
        include_user_data = true,
        include_messages = true,
        check_for_group_up = true
    }):setStatusIds(
        ids
    )
end)
