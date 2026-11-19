-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:21:12Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function calculateNumberInputValueFromPositions(num1: number, num2: number, num3: number, num4: number, num5: number?): number
    return num1 + math.floor((num3 - num2) * (num5 or 1)) * num4
end

return calculateNumberInputValueFromPositions
