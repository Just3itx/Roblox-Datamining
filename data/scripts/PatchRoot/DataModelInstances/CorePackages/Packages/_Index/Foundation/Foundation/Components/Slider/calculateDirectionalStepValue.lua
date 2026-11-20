-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:40:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SliderStepDirection = require(script.Parent.SliderStepDirection)

local SliderStepSize = require(script.Parent.SliderStepSize)

local function calculateDirectionalStepValue(num1: number, increment, numberRange: NumberRange, num2: number?, page): number
    local var1 = numberRange.Max - numberRange.Min
    local var2 = if page == SliderStepSize.Page then math.max(0.1 * var1, num2 or 0) else num2 and num2 > 0 and num2 or 0.01 * var1

    if increment ~= SliderStepDirection.Increment then
        var2 = -var2
    end

    return math.clamp(num1 + var2, numberRange.Min, numberRange.Max)
end

return calculateDirectionalStepValue
