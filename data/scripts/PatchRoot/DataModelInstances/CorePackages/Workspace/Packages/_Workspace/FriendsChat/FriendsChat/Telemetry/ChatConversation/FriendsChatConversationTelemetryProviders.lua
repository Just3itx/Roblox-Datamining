-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:21:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local React = require(FriendsChatParent.React)

local ChatConversationTelemetryLayer = require(FriendsChatParent.AppChat.ChatConversationTelemetryLayer)

local ExpChatConversationListAdapter = require(script.Parent.Parent.Parent.ConversationList.ExpChatConversationListAdapter)

local function FriendsChatConversationTelemetryProviders(tbl1)
    local conversationId = tbl1.conversationId

    local value = React.useCallback(function()
        local moderationType = nil
        local userPendingStatus = nil
        if conversationId ~= nil and conversationId ~= "" then
            local var1 = ExpChatConversationListAdapter.getConversationStore().getConversation(conversationId, false)
            if var1 ~= nil then
                moderationType = var1.moderationType
                userPendingStatus = var1.userPendingStatus
            end
        end
        return {
            conversationId = conversationId,
            moderationType = moderationType,
            userPendingStatus = userPendingStatus
        }
    end, { conversationId })

    return React.createElement(ChatConversationTelemetryLayer.Provider, { value = value }, tbl1.children)
end

return FriendsChatConversationTelemetryProviders
