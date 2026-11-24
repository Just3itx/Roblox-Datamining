-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:10:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")

local MessageEffect = require(script.Parent.MessageEffect)

local FIntExpChatMessageEffectChatWindowEnlargeTextSize = require(ExpChat.Flags.FIntExpChatMessageEffectChatWindowEnlargeTextSize)

local function getChatWindowPrefixOffset(tbl1, num1: number): number
    if not (tbl1 and table.find(tbl1, MessageEffect.ChatWindowEnlarge)) then
        return 0
    end

    return math.max(0, math.round(FIntExpChatMessageEffectChatWindowEnlargeTextSize * 0.44 - num1 / 2))
end

return getChatWindowPrefixOffset
