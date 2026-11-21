-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:11:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getRevealScrollOffset(num1: number, num2: number, num3: number, num4: number, num5: number, num6: number)
    if num4 <= 0 then
        return nil
    end

    local num7 = math.clamp(num6, 0, math.max(0, (num4 - num2) * 0.5))
    local num8 = math.max(0, num5 - num4)

    local num9 = math.clamp(
        if num1 - num7 < num3 then num1 - num7 elseif num1 + num2 + num7 > num3 + num4 then num1 + num2 + num7 - num4 else num3,
        0,
        num8
    )
    return if math.abs(num9 - num3) < 1 then nil else num9
end

return getRevealScrollOffset
