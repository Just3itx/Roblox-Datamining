-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:51:04Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local SliderStepDirection = require(script.Parent.SliderStepDirection)

local SliderStepSize = require(script.Parent.SliderStepSize)

local function calculateAdjacentStepValue(num1: number, increment, numberRange: NumberRange, num2: number?, page): number
    local var1 = numberRange.Max - numberRange.Min
    local bool1 = increment == SliderStepDirection.Increment

    if not (num2 and num2 > 0) then
        local var2 = if page == SliderStepSize.Page then 0.1 * var1 else 0.01 * var1

        if not bool1 then
            var2 = -var2
        end
        return math.clamp(num1 + var2, numberRange.Min, numberRange.Max)
    end

    local var2 = if page == SliderStepSize.Page then math.max(1, math.round(0.1 * var1 / num2)) else 1
    local var3 = (num1 - numberRange.Min) / num2
    local num3 = math.max(1, math.abs(var3)) * 1e-6
    local var4 = if bool1 then math.floor(var3 + num3) + var2 else math.ceil(var3 - num3) - var2
    return math.clamp(numberRange.Min + var4 * num2, numberRange.Min, numberRange.Max)
end

return calculateAdjacentStepValue
