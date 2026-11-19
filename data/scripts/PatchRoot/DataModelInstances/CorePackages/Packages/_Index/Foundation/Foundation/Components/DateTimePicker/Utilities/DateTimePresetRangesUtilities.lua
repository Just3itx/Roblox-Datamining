-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:41:18Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local DateTimeCalendarViewUtilities = require(script.Parent.DateTimeCalendarViewUtilities)
local DateTimePickerDateRangePreset = require(Foundation.Enums.DateTimePickerDateRangePreset)
local DateTimeUtilities = require(script.Parent.Parent.DateTimeUtilities)

local function toStartOfDay(arg1): DateTime -- Luacid: Inlined by compiler; 5 call sites recovered
    local var1 = DateTimeUtilities.toLocalTime(arg1)
    return DateTime.fromLocalTime(var1.Year, var1.Month, var1.Day)
end

local function shiftDays(arg1, num1: number): DateTime -- Luacid: unused: defined but never referenced
    local var1 = DateTimeUtilities.toLocalTime(arg1)
    local dateTime = DateTime.fromLocalTime(var1.Year, var1.Month, var1.Day, 12, 0, 0)
    return toStartOfDay(DateTime.fromUnixTimestamp(dateTime.UnixTimestamp + num1 * 86400))
end

return {
    resolvePresetRange = function(arg1, arg2)
        local var1 = arg2 or DateTime.now()
        local var2 = DateTimeUtilities.toLocalTime(var1)
        local dateTime = toStartOfDay(var1)

        if arg1 == DateTimePickerDateRangePreset.Today then
            return { startDate = dateTime, endDate = dateTime }
        end

        if arg1 == DateTimePickerDateRangePreset.ThisWeek then
            local var3 = -DateTimeCalendarViewUtilities.getDayOfWeek(var1)
            local var4 = DateTimeUtilities.toLocalTime(dateTime)
            local dateTime2 = DateTime.fromLocalTime(var4.Year, var4.Month, var4.Day, 12, 0, 0)
            local dateTime3 = toStartOfDay(DateTime.fromUnixTimestamp(dateTime2.UnixTimestamp + var3 * 86400))

            local tbl1 = { startDate = dateTime3, endDate = 0 }
            local var5 = DateTimeUtilities.toLocalTime(dateTime3)
            local dateTime4 = DateTime.fromLocalTime(var5.Year, var5.Month, var5.Day, 12, 0, 0)
            tbl1.endDate = toStartOfDay(DateTime.fromUnixTimestamp(dateTime4.UnixTimestamp + 518400))
            return tbl1
        end

        if arg1 == DateTimePickerDateRangePreset.LastWeek then
            local var3 = -DateTimeCalendarViewUtilities.getDayOfWeek(var1) - 7
            local var4 = DateTimeUtilities.toLocalTime(dateTime)
            local dateTime2 = DateTime.fromLocalTime(var4.Year, var4.Month, var4.Day, 12, 0, 0)
            local dateTime3 = toStartOfDay(DateTime.fromUnixTimestamp(dateTime2.UnixTimestamp + var3 * 86400))

            local tbl1 = { startDate = dateTime3, endDate = 0 }
            local var5 = DateTimeUtilities.toLocalTime(dateTime3)
            local dateTime4 = DateTime.fromLocalTime(var5.Year, var5.Month, var5.Day, 12, 0, 0)
            tbl1.endDate = toStartOfDay(DateTime.fromUnixTimestamp(dateTime4.UnixTimestamp + 518400))
            return tbl1
        end

        if arg1 == DateTimePickerDateRangePreset.ThisMonth then
            return {
                startDate = DateTime.fromLocalTime(var2.Year, var2.Month, 1),
                endDate = DateTime.fromLocalTime(var2.Year, var2.Month, DateTimeUtilities.getDaysInMonth(var2.Month, var2.Year))
            }
        end

        if arg1 == DateTimePickerDateRangePreset.ThisYear then
            return {
                startDate = DateTime.fromLocalTime(var2.Year, 1, 1),
                endDate = DateTime.fromLocalTime(var2.Year, 12, 31)
            }
        end

        return {
            startDate = DateTime.fromLocalTime(var2.Year - 1, 1, 1),
            endDate = DateTime.fromLocalTime(var2.Year - 1, 12, 31)
        }
    end
}
