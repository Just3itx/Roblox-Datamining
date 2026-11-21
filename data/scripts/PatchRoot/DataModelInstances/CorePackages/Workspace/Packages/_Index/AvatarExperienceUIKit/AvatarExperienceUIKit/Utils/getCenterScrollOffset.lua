-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:11:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getCenterScrollOffset(num1: number, num2: number, num3: number, num4: number)
    if num4 <= 0 then
        return nil
    end

    local num5 = math.max(0, num1 + num2 * 0.5 - num4 * 0.5)
    return if math.abs(num5 - num3) < 1 then nil else num5
end

return getCenterScrollOffset
