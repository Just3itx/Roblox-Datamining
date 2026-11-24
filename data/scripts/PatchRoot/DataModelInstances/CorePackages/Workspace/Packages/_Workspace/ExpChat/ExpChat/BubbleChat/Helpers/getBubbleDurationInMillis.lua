-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local isBorderlessBubbleChatMessage = require(script.Parent.isBorderlessBubbleChatMessage)
local _getBubbleChatDisplayText = require(script.Parent.getBubbleChatDisplayText)

local function getBubbleDurationInMillis(arg1, num1: number): number
    return if isBorderlessBubbleChatMessage(arg1) then 3400 else num1
end

return getBubbleDurationInMillis
