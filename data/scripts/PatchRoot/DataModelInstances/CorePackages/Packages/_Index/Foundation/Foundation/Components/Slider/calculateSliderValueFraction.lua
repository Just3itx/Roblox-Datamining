-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:51:09Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function calculateSliderValueFraction(num1: number, numberRange: NumberRange): number
    return math.clamp((num1 - numberRange.Min) / (numberRange.Max - numberRange.Min), 0, 1)
end

return calculateSliderValueFraction
