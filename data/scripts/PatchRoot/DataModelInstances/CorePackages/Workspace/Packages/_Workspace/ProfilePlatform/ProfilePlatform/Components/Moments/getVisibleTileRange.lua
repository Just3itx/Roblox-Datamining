-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:10:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getVisibleTileRange(num1: number, num2: number, num3: number, num4: number, num5: number?, num6: number): (number, number)
    if num6 <= 0 or num2 <= 0 then
        return 1, 0
    end

    local num7 = num2 + num3

    local num8 = num4 + (num5 or 0)

    local num9 = math.floor(num1 / num7)
    if not (num1 - num9 * num7 < num2) then
        num9 += 1
    end

    return math.clamp(num9 + 1, 1, num6), math.clamp(math.ceil(num1 / num7 + num8), 1, num6)
end

return getVisibleTileRange
