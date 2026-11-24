-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:10:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local MessageEffect = require(script.Parent.MessageEffect)

local FIntExpChatMessageEffectChatWindowEnlargeTextSize = require(ExpChat.Flags.FIntExpChatMessageEffectChatWindowEnlargeTextSize)

local function getChatWindowMessageLineHeight(tbl1, num1: number, num2: number): number
    if not (tbl1 and table.find(tbl1, MessageEffect.ChatWindowEnlarge)) then
        return 1
    end

    return math.clamp(FIntExpChatMessageEffectChatWindowEnlargeTextSize / math.min(num1, num2), 1, 3)
end

return getChatWindowMessageLineHeight
