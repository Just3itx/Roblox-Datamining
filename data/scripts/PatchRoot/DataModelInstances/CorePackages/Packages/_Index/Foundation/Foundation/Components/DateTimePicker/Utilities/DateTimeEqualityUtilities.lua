-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:21:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DateTimeUtilities = require(script.Parent.Parent.DateTimeUtilities)

local function isSameDay(arg1, arg2): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return DateTimeUtilities.roundToStartOfDay(arg1) == DateTimeUtilities.roundToStartOfDay(arg2)
end

return {
    areDatesEqual = function(tbl1, tbl2): boolean
        if tbl1 == nil and tbl2 == nil then
            return true
        end
        if tbl1 == nil or tbl2 == nil then
            return false
        end

        local var1 = tbl1[1]
        local var2 = tbl2[1]
        if var1 == nil ~= (var2 == nil) then
            return false
        end
        if var1 and var2 and var1.UnixTimestamp ~= var2.UnixTimestamp then
            return false
        end

        local var3 = tbl1[2]
        local var4 = tbl2[2]
        return var3 == nil == (var4 == nil) and (not var3 or not var4 or var3.UnixTimestamp == var4.UnixTimestamp or false)
    end,
    areDatesSameDayAsRange = function(tbl1, arg1): boolean
        return if tbl1 and tbl1[1] and tbl1[2] then not not (isSameDay(tbl1[1], arg1.startDate) and isSameDay(tbl1[2], arg1.endDate)) else false
    end,
    isRangeWithinSelectableRange = function(arg1, arg2)
        return DateTimeUtilities.isDateWithinRange(arg1.startDate, arg2) and DateTimeUtilities.isDateWithinRange(arg1.endDate, arg2)
    end,
    isSameDay = isSameDay
}
