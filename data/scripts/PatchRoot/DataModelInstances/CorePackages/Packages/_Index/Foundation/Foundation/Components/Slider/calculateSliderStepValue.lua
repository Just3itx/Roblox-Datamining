-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:51:08Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function calculateSliderStepValue(num1: number, num2: number, numberRange: NumberRange): number
    if not (num2 > 0) then
        return num1
    end

    local num3 = math.floor((num1 - numberRange.Min) / num2 + 0.5)
    return math.clamp(numberRange.Min + num3 * num2, numberRange.Min, numberRange.Max)
end

return calculateSliderStepValue
