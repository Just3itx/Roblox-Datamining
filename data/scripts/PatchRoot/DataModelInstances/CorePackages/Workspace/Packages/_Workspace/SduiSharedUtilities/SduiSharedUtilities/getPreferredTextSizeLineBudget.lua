-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:50:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getPreferredTextSizeLineBudget(num1: number, num2: number?): number
    return num1 * math.max(num2 or 0, 0)
end

return getPreferredTextSizeLineBudget
