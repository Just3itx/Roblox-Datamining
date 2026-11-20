-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:21:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local DateTimePickerRangeBandRole = require(Foundation.Enums.DateTimePickerRangeBandRole)
local DateTimeUtilities = require(script.Parent.Parent.DateTimeUtilities)
local LocalizationService = require(Foundation.Utility.Wrappers).Services.LocalizationService

local function roundUpToNearestHalfHour(dateTime)
    local var1 = DateTimeUtilities.toLocalTime(dateTime)
    if var1.Second == 0 and (var1.Minute == 0 or var1.Minute == 30) then
        return DateTimeUtilities.roundDownToNearestMinute(dateTime)
    end

    local var2 = DateTimeUtilities.roundToStartOfDay(dateTime)
    local num1 = math.min(math.ceil((dateTime.UnixTimestamp - var2) / 1800) * 1800, 84600)

    return DateTime.fromUnixTimestamp(var2 + num1)
end

local function getDayOfWeek(dateTime): number -- Luacid: Inlined by compiler; 1 call site recovered
    return tonumber((dateTime:FormatLocalTime("d", "en-us"))) or 0
end

local function getRangeDayBounds(arg1): (number, number) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = DateTimeUtilities.roundToStartOfDay(arg1.startDate)
    local var2 = DateTimeUtilities.roundToStartOfDay(arg1.endDate)
    return math.min(var1, var2), math.max(var1, var2)
end

return {
    getDayOfWeek = getDayOfWeek,
    getRangeBandRadiusTag = function(arg1, arg2, arg3): string
        local num1, num2 = getRangeDayBounds(arg2)
        local var1 = DateTimeUtilities.roundToStartOfDay(arg1)
        local bool1 = num1 < var1
        local bool2 = var1 < num2
        local dayOfWeek = getDayOfWeek(arg1)
        local bool3 = not (arg3 == DateTimePickerRangeBandRole.Start) and (dayOfWeek == 0 or not bool1)
        local bool4 = not (arg3 == DateTimePickerRangeBandRole.End) and (dayOfWeek == 6 or not bool2)
        return if bool3 and bool4 then "radius-circle" elseif bool3 then "radius-left-circle" elseif bool4 then "radius-right-circle" else ""
    end,
    getRangeDayBounds = getRangeDayBounds,
    getTimeSlotIndex = function(tbl1, id: number?)
        if id == nil then
            return nil
        end
        for value, value2 in tbl1 do
            if value2.id == id then
                return value
            end
        end
        return nil
    end,
    getTimeSlotsForDay = function(dateTime)
        local var1 = roundUpToNearestHalfHour(dateTime)
        local var2 = DateTimeUtilities.toLocalTime(var1)
        local unixTimestamp = DateTime.fromLocalTime(var2.Year, var2.Month, var2.Day, var2.Hour, var2.Minute, 0).UnixTimestamp

        local tbl1 = {}

        for i = 0, 47 do
            local hour = math.floor(i / 2)
            local minute = i % 2 * 30

            local dateTime2 = DateTime.fromLocalTime(var2.Year, var2.Month, var2.Day, hour, minute, 0)

            table.insert(
                tbl1,
                {
                    id = dateTime2.UnixTimestamp,
                    text = dateTime2:FormatLocalTime("LT", LocalizationService.RobloxLocaleId)
                }
            )
        end
        return tbl1, unixTimestamp
    end,
    resolveAnchorDate = function(tbl1, arg1)
        if tbl1 and tbl1[1] then
            return tbl1[1]
        elseif arg1 then
            return arg1
        end
        return DateTime.now()
    end,
    roundUpToNearestHalfHour = roundUpToNearestHalfHour,
    toViewDate = function(arg1)
        local var1 = DateTimeUtilities.toLocalTime(arg1)
        return {
            month = var1.Month,
            year = var1.Year
        }
    end
}
