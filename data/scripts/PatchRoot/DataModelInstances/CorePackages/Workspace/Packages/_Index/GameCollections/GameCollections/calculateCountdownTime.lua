-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:20:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function calculateCountdownTime(num1: number)
    num1 += 59

    local num2 = 0
    local num3 = 0
    local var1

    if num1 >= 86400 then
        var1 = math.floor(num1 / 86400)
        num1 -= var1 * 86400
    else
        var1 = 0
    end
    if num1 >= 3600 then
        num2 = math.floor(num1 / 3600)
        num1 -= num2 * 3600
    end
    if num1 > 0 then
        num3 = math.floor(num1 / 60)
    end

    return { days = var1, hours = num2, minutes = num3 }
end

return calculateCountdownTime
