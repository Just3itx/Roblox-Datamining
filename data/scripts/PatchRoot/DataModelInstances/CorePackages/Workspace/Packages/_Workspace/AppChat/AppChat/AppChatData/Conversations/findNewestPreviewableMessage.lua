-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")

local _Types = require(AppChat.AppChatData.Types)
local getMessageSentDateTime = require(AppChat.Utils.getMessageSentDateTime)
local getUnixTimestampSeconds = require(AppChat.Utils.getUnixTimestampSeconds)
local isMessagePreviewable = require(AppChat.Utils.isMessagePreviewable)

local function findNewestPreviewableMessage(tbl1, num1: number)
    local var1 = nil

    for _, value in tbl1 do
        if value == nil or not isMessagePreviewable(value) then
            continue
        end

        local sentDateTime = getMessageSentDateTime(value)
        local sentUnixSeconds = getUnixTimestampSeconds(sentDateTime)
        if sentUnixSeconds == nil or not (num1 < sentUnixSeconds) then
            continue
        end
        var1 = {
            messageId = value.id,
            sentDateTime = sentDateTime,
            sentUnixSeconds = sentUnixSeconds
        }
        num1 = sentUnixSeconds
    end

    return var1
end

return findNewestPreviewableMessage
