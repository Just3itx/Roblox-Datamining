-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:41:20Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local DateTimeUtilities = require(script.Parent.Parent.DateTimeUtilities)

return {
    normalizeDates = function(tbl1)
        local var1 = typeof(tbl1.dates) ~= "table" and { tbl1.dates } or tbl1.dates
        local var2 = var1[2]
        return if tbl1.acceptsDateRange or var2 == nil then var1 else { var1[1] }
    end,
    selectRangeEndpoint = function<T>(tbl1, arg1: T)
        if not tbl1 or not tbl1[1] or tbl1[2] then
            return { arg1 }
        end

        local var1 = tbl1[1]
        return if DateTimeUtilities.roundToStartOfDay(arg1) < DateTimeUtilities.roundToStartOfDay(var1) then { arg1, var1 } else { var1, arg1 }
    end
}
