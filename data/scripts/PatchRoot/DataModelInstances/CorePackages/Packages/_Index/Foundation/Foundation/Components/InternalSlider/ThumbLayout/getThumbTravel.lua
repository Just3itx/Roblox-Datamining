-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:11:13Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function getThumbTravel(num1: number, num2: number, bool1: boolean?): number?
    if not bool1 then
        num1 -= 1
    end

    local num3 = 1 - num1 * num2
    return if num3 > 0 then num3 else nil
end

return getThumbTravel
