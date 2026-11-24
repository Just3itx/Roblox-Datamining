-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:21:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local SendMessageError = require(FriendsChatParent.AppChat.SendMessageError)

local function getConversationMessageSentInfo(arg1, recipientIds: string)
    local tbl1 = {
        messageSentResult = SendMessageError.OtherFailure,
        recipientIds = recipientIds
    }

    if arg1 == nil then
        tbl1.messageSentResult = SendMessageError.NoResponse
        return tbl1
    end

    if (arg1.StatusCode or arg1.responseCode) == 409 then
        tbl1.messageSentResult = SendMessageError.Conflict
        return tbl1
    end

    if arg1.responseBody == nil then
        tbl1.messageSentResult = SendMessageError.NoResponseBody
        return tbl1
    end

    local messages = arg1.responseBody.messages
    if messages == nil or #messages == 0 then
        tbl1.messageSentResult = SendMessageError.NoMessages
        return tbl1
    end

    local var1 = messages[1]
    if var1.status == nil then
        tbl1.messageSentResult = SendMessageError.NoMessageStatus
    else
        tbl1.messageSentResult = var1.status
        tbl1.messageId = var1.id
    end

    return tbl1
end

return getConversationMessageSentInfo
