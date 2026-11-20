-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:41:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local getStepGridPosition = require(script.Parent.getStepGridPosition)

local function calculateInputSliderValue(num1: number, num2: number, num3: number, num4: number?, numberRange: NumberRange): number
    local num5 = num2 * num3
    local num6 = math.sign(num5) * math.floor(math.abs(num5))
    if num6 == 0 then
        return math.clamp(num1, numberRange.Min, numberRange.Max)
    end

    local num7 = num1 + num6
    if num4 ~= nil then
        local stepGridPosition = getStepGridPosition(num1, num4, numberRange)
        local num8 = if num6 > 0 then math.floor(stepGridPosition) else math.ceil(stepGridPosition)
        num7 = numberRange.Min + (num8 + num6) * num4
    end

    return math.clamp(num7, numberRange.Min, numberRange.Max)
end

return calculateInputSliderValue
