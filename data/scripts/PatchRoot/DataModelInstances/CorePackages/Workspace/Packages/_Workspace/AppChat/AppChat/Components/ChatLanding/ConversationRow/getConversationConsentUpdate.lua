-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:11:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")

local Constants = require(AppChat.Constants)
local ConversationChannels = require(AppChat.Models.ConversationChannels)

local tbl1 = {
    [Constants.OptInVariant.OsaContextCard] = {
        field = "osaAcknowledgementStatus",
        value = ConversationChannels.OsaAcknowledgementStatus.Acknowledged
    },
    [Constants.OptInVariant.ChatOptInInfoCard] = {
        field = "userOptedIntoChatMessages",
        value = ConversationChannels.UserOptedIntoChatMessagesStatus.OptedIn
    }
}

return function(str1: string?)
    return if str1 == nil then nil else tbl1[str1]
end
