-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:31:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GetTextSize = require(script.Parent.GetTextSize)

local function getTextHeight(str1: string, arg1, num1: number, x: number, num2: number?)
    local vector2 = Vector2.new(x, math.min(10000, num2 or 10000))
    return GetTextSize(str1, num1, arg1, vector2).Y
end

return getTextHeight
