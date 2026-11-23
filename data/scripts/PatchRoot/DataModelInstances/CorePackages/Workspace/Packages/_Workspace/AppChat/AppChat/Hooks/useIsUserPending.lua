-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:41:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")

local Conversation = require(AppChat.Models.Conversation)
local ConversationChannels = require(AppChat.Models.ConversationChannels)

return function(tbl1): boolean
    if tbl1.conversationType == Conversation.Type.MULTI_USER_CONVERSATION then
        if tbl1.userPendingStatus == ConversationChannels.UserPendingStatus.Pending then
            return true
        end

        return tbl1.userPendingStatus == ConversationChannels.UserPendingStatus.Invalid
            and tbl1.moderationType == ConversationChannels.ModerationType.TrustedComms
    end

    return false
end
