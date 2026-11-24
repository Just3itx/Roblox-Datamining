-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:10:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MessageEffect = require(script.Parent.MessageEffect)
local isSingleSupportedEmoji = require(script.Parent.isSingleSupportedEmoji)

local function getMessageEffects(str1: string)
    local messageEffects = {}
    if isSingleSupportedEmoji(str1) then
        table.insert(messageEffects, MessageEffect.BorderlessBubbleChat)
        table.insert(messageEffects, MessageEffect.ChatWindowEnlarge)
    end
    return messageEffects
end

return getMessageEffects
