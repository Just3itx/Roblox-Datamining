-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:01:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function computeStickyOffset(num1: number, num2: number, num3: number?): number
    local num4 = math.min(math.floor(num1 - num2), 0)
    if num3 == nil or not (num3 > 0 and num3 < num2) then
        return num4
    end

    return math.max(num4, num3 - num2)
end

return computeStickyOffset
