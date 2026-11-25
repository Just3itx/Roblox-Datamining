-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local sendEmojiExpression = require(script.Parent.sendEmojiExpression)
local sendPresetExpression = require(script.Parent.sendPresetExpression)

local function sendExpression(arg1, arg2, bool1: boolean)
    if arg1.kind == "preset" then
        return sendPresetExpression(arg1.presetId, arg2)
    elseif arg1.kind == "emoji" then
        return sendEmojiExpression(arg1.unicode, arg2, bool1)
    end
    return false
end

return sendExpression
