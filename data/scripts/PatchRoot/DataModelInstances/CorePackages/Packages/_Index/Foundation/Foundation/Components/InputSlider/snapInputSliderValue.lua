-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:50:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local getStepGridPosition = require(script.Parent.getStepGridPosition)

local function snapInputSliderValue(num1: number, num2: number?, numberRange: NumberRange)
    local num3 = math.clamp(num1, numberRange.Min, numberRange.Max)
    if num2 == nil then
        return num3
    end

    local var1 = numberRange.Min + math.round((getStepGridPosition(num3, num2, numberRange))) * num2
    if math.abs(numberRange.Max - num3) < math.abs(var1 - num3) then
        return numberRange.Max
    end
    return math.clamp(var1, numberRange.Min, numberRange.Max)
end

return snapInputSliderValue
