-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:31:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getFriendDuration(tbl1, num1: number)
    if not tbl1 then
        return nil
    end

    local value = math.floor(
        (num1 - os.time({ year = tbl1.year, month = tbl1.month, day = tbl1.day, hour = 0, min = 0, sec = 0 })) / 86400
    )

    if value < 1 then
        return { value = 0, unit = "days" }
    end

    local var1 = os.date("!*t", num1)
    local var2 = (var1.year - tbl1.year) * 12 + (var1.month - tbl1.month)
    if var1.day < tbl1.day then
        var2 -= 1
    end

    if var2 >= 12 then
        return {
            value = math.floor(var2 / 12),
            unit = "years"
        }
    end

    return if var2 >= 1 then { value = var2, unit = "months" } else { value = value, unit = "days" }
end

return getFriendDuration
