-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function calculateSliderValueFraction(num1: number, numberRange: NumberRange): number
    return math.clamp((num1 - numberRange.Min) / (numberRange.Max - numberRange.Min), 0, 1)
end

return calculateSliderValueFraction
