-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:11:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function isFeedContentScrollable(num1: number, num2: number, num3: number): boolean
    local num4 = num2 - num3 * 2
    return num1 > 0 and num4 > 0 and num4 < num1
end

return isFeedContentScrollable
