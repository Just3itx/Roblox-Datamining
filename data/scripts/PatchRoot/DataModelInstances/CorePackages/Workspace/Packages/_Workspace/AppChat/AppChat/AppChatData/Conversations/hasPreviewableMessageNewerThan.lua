-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:01:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")

local _Types = require(AppChat.AppChatData.Types)
local getMessageSentDateTime = require(AppChat.Utils.getMessageSentDateTime)
local getUnixTimestampMillis = require(AppChat.Utils.getUnixTimestampMillis)
local isMessagePreviewable = require(AppChat.Utils.isMessagePreviewable)

local function hasPreviewableMessageNewerThan(tbl1, num1: number)
    for _, value in tbl1 do
        if value ~= nil and isMessagePreviewable(value) and num1 < (getUnixTimestampMillis(getMessageSentDateTime(value)) or 0) then
            return true
        end
    end
    return false
end

return hasPreviewableMessageNewerThan
