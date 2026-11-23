-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local Conversation = require(AppChat.Models.Conversation)

return function(arg1): boolean
    if not arg1 then
        return false
    end

    return arg1.conversationType == Conversation.Type.MULTI_USER_CONVERSATION
        and arg1.osaAcknowledgementStatus == Conversation.OsaAcknowledgementStatus.Unacknowledged
end
