-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T18:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function roundToDecimals(num1: number, num2: number): number
    local num3 = 10 ^ num2
    return math.floor(num1 * num3 + 0.5) / num3
end

return roundToDecimals
