-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local getThumbTravel = require(script.Parent.getThumbTravel)

local function toThumbTrackFraction(num1: number, num2: number, num3: number, num4: number)
    local thumbTravel = getThumbTravel(num3, num4)

    if thumbTravel == nil then
        return num1
    end

    return num1 * thumbTravel + (num2 - 1) * num4
end

return toThumbTrackFraction
