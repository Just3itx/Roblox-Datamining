-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:40:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")

local getMessageSentDateTime = require(AppChat.Utils.getMessageSentDateTime)
local getUnixTimestampSeconds = require(AppChat.Utils.getUnixTimestampSeconds)

local function getMessageSentUnixSeconds(arg1)
    return getUnixTimestampSeconds(getMessageSentDateTime(arg1))
end

return getMessageSentUnixSeconds
