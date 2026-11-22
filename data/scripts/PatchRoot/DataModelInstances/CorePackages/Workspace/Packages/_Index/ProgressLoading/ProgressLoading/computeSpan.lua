-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:30:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function computeSpan(num1: number, num2: number, num3: number, num4: number?, num5: number?): number
    local num6 = num5 or 0
    local num7 = num1 - num3 * num2 * 2

    if num4 then
        num7 = math.min(num7, num4 * num2)
    end

    return math.max(num7, num6)
end

return computeSpan
