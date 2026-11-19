-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:11:12Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local getThumbTravel = require(script.Parent.getThumbTravel)

local function getThumbOffset(num1: number, num2: number, num3: number, num4: number, bool1: boolean?): number
    if getThumbTravel(num3, num4, bool1) == nil then
        return 0
    end

    if bool1 then
        return (num2 - 0.5 - num1 * num3) * num4
    end

    return (num2 - 1 - num1 * (num3 - 1)) * num4
end

return getThumbOffset
