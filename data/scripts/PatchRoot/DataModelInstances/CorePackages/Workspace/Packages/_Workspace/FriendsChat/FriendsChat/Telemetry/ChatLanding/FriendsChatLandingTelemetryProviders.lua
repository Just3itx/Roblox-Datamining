-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:21:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local React = require(FriendsChatParent.React)

local ChatLandingTelemetryLayer = require(FriendsChatParent.AppChat.ChatLandingTelemetryLayer)
local ChatLandingTelemetryState = require(FriendsChatParent.AppChat.ChatLandingTelemetryState)
local useGetAndSetRef = require(FriendsChatParent.AppChat.useGetAndSetRef)

local function FriendsChatLandingTelemetryProviders(tbl1)
    local get, set = useGetAndSetRef({})
    local value = React.useCallback(function()
        local var3 = get()
        return {
            chatLandingListCount = var3.chatLandingListCount,
            pendingConversationCount = var3.pendingConversationCount,
            unfilteredConversationCount = var3.unfilteredConversationCount,
            searchSessionId = var3.searchSessionId,
            activeFilters = var3.activeFilters
        }
    end, { get })

    return React.createElement(
        ChatLandingTelemetryState.Provider,
        {
            value = { get = get, set = set }
        },
        {
            Layer = React.createElement(ChatLandingTelemetryLayer.Provider, { value = value }, tbl1.children)
        }
    )
end
return FriendsChatLandingTelemetryProviders
