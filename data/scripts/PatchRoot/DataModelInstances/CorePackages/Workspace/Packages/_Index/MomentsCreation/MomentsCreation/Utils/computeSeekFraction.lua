-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:40:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function computeSeekFraction(num1: number, num2: number, num3: number): number
    if num3 <= 0 then
        return 0
    end
    return math.clamp((num1 - num2) / num3, 0, 1)
end

return computeSeekFraction
