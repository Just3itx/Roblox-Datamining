-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:10:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")

local MessageEffect = require(script.Parent.MessageEffect)

local FIntExpChatMessageEffectChatWindowEnlargeTextSize = require(ExpChat.Flags.FIntExpChatMessageEffectChatWindowEnlargeTextSize)

local function applyChatWindowMessageEffects(str1: string, tbl1): string
    if tbl1 and table.find(tbl1, MessageEffect.ChatWindowEnlarge) then
        return `<font size='{FIntExpChatMessageEffectChatWindowEnlargeTextSize}'>{str1}</font>`
    end
    return str1
end

return applyChatWindowMessageEffects
