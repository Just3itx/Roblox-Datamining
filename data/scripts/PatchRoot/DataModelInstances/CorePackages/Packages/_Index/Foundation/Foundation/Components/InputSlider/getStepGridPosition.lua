-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:41:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getStepGridPosition(num1: number, num2: number, numberRange: NumberRange): number
    local var1 = (num1 - numberRange.Min) / num2
    local num3 = math.round(var1)
    return if math.abs(var1 - num3) < 1e-9 then num3 else var1
end

return getStepGridPosition
