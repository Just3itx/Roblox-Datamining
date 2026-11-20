-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:21:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function floatEquals(num1: number, num2: number, num3: number?): boolean
    local num4 = num1 - num2
    return (num3 or 1e-12) >= math.abs(num4)
end

return floatEquals
