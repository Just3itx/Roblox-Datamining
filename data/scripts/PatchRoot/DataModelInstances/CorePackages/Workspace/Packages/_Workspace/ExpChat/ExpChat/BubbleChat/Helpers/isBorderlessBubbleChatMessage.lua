-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:41:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local MessageEffect = require(ExpChat.MessageEffects.MessageEffect)
local getMessageEffects = require(ExpChat.MessageEffects.getMessageEffects)

local getBubbleChatDisplayText = require(script.Parent.getBubbleChatDisplayText)

local function isBorderlessBubbleChatMessage(arg1): boolean
    local messageEffects = getMessageEffects(getBubbleChatDisplayText(arg1))
    return table.find(messageEffects, MessageEffect.BorderlessBubbleChat) ~= nil
end

return isBorderlessBubbleChatMessage
