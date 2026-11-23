-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:21:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local _AppChatNetworking = require(AppChatParent.AppChatNetworking)
local GetFFlagEnableSocialCards = require(AppChatParent.SharedFlags).GetFFlagEnableSocialCards

local _Types = require(AppChat.MessageData.Types)

local function buildConversationMessageFromApi(arg1, conversationId: string)
    return {
        id = arg1.id,
        type = arg1.type,
        content = arg1.content,
        created_at = arg1.created_at,
        sender_user_id = arg1.sender_user_id,
        moderation_type = arg1.moderation_type,
        visibility = arg1.visibility,
        preview_content = arg1.preview_content,
        content_to_display = arg1.content_to_display or arg1.content,
        replies_to = arg1.replies_to,
        cards = if GetFFlagEnableSocialCards() then arg1.cards else nil,
        filtered_for_receivers = arg1.filtered_for_receivers,
        is_previewable = arg1.is_previewable,
        conversationId = conversationId,
        stableKey = arg1.id
    }
end

return buildConversationMessageFromApi
