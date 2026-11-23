-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:10:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")

local _Types = require(AppChat.AppChatData.Types)
local getMessageSentUnixSeconds = require(AppChat.Utils.getMessageSentUnixSeconds)

local function shouldMarkUnread(tbl1, num1: number, str1: string)
    for _, value in tbl1 do
        local messageSentUnixSeconds = getMessageSentUnixSeconds(value)
        local var1 = value.sender_user_id or value.senderTargetId
        if messageSentUnixSeconds ~= nil
            and num1 < messageSentUnixSeconds
            and var1 ~= nil
            and tostring(var1) ~= str1
            and value.is_badgeable == true
        then
            return true
        end
    end
    return false
end

return shouldMarkUnread
