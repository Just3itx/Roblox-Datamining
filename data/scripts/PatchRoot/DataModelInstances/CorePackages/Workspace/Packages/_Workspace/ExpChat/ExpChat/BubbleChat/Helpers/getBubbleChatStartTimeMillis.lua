-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local isBorderlessBubbleChatMessage = require(script.Parent.isBorderlessBubbleChatMessage)
local _getBubbleChatDisplayText = require(script.Parent.getBubbleChatDisplayText)

local function getBubbleChatStartTimeMillis(arg1)
    return if isBorderlessBubbleChatMessage(arg1) and arg1.bubbleChatReceivedAtMillis then arg1.bubbleChatReceivedAtMillis else arg1.timestamp.UnixTimestampMillis
end

return getBubbleChatStartTimeMillis
