-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function formatInputSliderValue(num1: number): string
    local num2 = math.floor(num1 * 1000 + 0.5) / 1000

    return tostring(if num2 == 0 then 0 else num2)
end

return formatInputSliderValue
