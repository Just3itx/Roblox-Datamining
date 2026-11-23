-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:11:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatNetworking = script:FindFirstAncestor("AppChatNetworking")
local AppChatNetworkingParent = AppChatNetworking.Parent
local CHAT_PLATFORM_BASE_URL = require(AppChatNetworking.url.CHAT_PLATFORM_BASE_URL)

local RoduxNetworking = require(script.Parent.RoduxNetworking)

local GetFFlagEnableSocialCards = require(AppChatNetworkingParent.SharedFlags).GetFFlagEnableSocialCards
local FFlagAppChatEnableReactions = require(AppChatNetworkingParent.SharedFlags).FFlagAppChatEnableReactions

return RoduxNetworking.GET(script.Name, function(arg1, conversationId, cursor)
    return arg1(CHAT_PLATFORM_BASE_URL):path("v1"):path("get-conversation-messages"):queryArgs({
        conversation_id = conversationId,
        cursor = cursor,
        include_cards = not not GetFFlagEnableSocialCards(),
        include_reactions = if FFlagAppChatEnableReactions then true else nil
    }):setStatusIds(
        { conversationId }
    )
end)
