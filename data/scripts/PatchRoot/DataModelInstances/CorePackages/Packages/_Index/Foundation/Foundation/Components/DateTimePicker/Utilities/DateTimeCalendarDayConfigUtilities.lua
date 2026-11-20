-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:21:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local DateTimeCalendarConstants = require(script.Parent.DateTimeCalendarConstants)
local _DateTimeCalendarViewUtilities = require(script.Parent.DateTimeCalendarViewUtilities)
local DateTimePickerCalendarDayKeyPrefix = require(Foundation.Enums.DateTimePickerCalendarDayKeyPrefix)
local DateTimeUtilities = require(script.Parent.Parent.DateTimeUtilities)

local DAYS_PER_WEEK = DateTimeCalendarConstants.DAYS_PER_WEEK
local NUM_ELEMENTS_IN_DATES_GRID = DateTimeCalendarConstants.NUM_ELEMENTS_IN_DATES_GRID
local NUM_NON_DAY_ELEMENTS = DateTimeCalendarConstants.NUM_NON_DAY_ELEMENTS
local NUM_WEEKDAY_HEADERS = DateTimeCalendarConstants.NUM_WEEKDAY_HEADERS

local function countLeadingPadDays(month: number, year: number) -- Luacid: Inlined by compiler; 1 call site recovered
    local firstDayOfWeek = DateTimeUtilities.getFirstDayOfWeek(month, year)

    return if firstDayOfWeek == 0 then DAYS_PER_WEEK else firstDayOfWeek
end

local function countTrailingEmptyDays(num1: number, num2: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    return (DAYS_PER_WEEK - (num1 + num2) % DAYS_PER_WEEK) % DAYS_PER_WEEK
end

return {
    buildCalendarDayConfigs = function(arg1)
        local calendarDayConfigs = {}
        local var1 = NUM_WEEKDAY_HEADERS + 1

        local month, year = DateTimeUtilities.getPrevMonthInfo(arg1.month, arg1.year)
        local daysInMonth = DateTimeUtilities.getDaysInMonth(month, year)
        local var4 = countLeadingPadDays(arg1.month, arg1.year)

        for i = 1, var4 do
            table.insert(calendarDayConfigs, {
                day = daysInMonth - var4 + i,
                keyPrefix = DateTimePickerCalendarDayKeyPrefix.PrevMonth,
                LayoutOrder = var1,
                month = month,
                year = year
            })
            var1 += 1
        end

        for day = 1, DateTimeUtilities.getDaysInMonth(arg1.month, arg1.year) do
            table.insert(calendarDayConfigs, {
                applyEmphasis = true,
                day = day,
                keyPrefix = DateTimePickerCalendarDayKeyPrefix.CurrentMonth,
                LayoutOrder = var1,
                month = arg1.month,
                year = arg1.year
            })
            var1 += 1
        end

        local lastDayOfWeek = DateTimeUtilities.getLastDayOfWeek(arg1.month, arg1.year)
        local var2, var3 = DateTimeUtilities.getNextMonthInfo(arg1.month, arg1.year)
        local var7 = DAYS_PER_WEEK - (lastDayOfWeek + 1)

        local var8 = NUM_NON_DAY_ELEMENTS + #calendarDayConfigs
        if var7 + var8 < NUM_ELEMENTS_IN_DATES_GRID then
            var7 += NUM_ELEMENTS_IN_DATES_GRID - var8 - var7
        end

        for day = 1, var7 do
            table.insert(
                calendarDayConfigs,
                {
                    day = day,
                    keyPrefix = DateTimePickerCalendarDayKeyPrefix.NextMonth,
                    LayoutOrder = var1,
                    month = var2,
                    year = var3
                }
            )
            var1 += 1
        end

        return calendarDayConfigs
    end,
    buildTwoMonthPaneCellConfigs = function(month: number, year: number)
        local twoMonthPaneCellConfigs = {}
        local var1 = NUM_WEEKDAY_HEADERS + 1

        local firstDayOfWeek = DateTimeUtilities.getFirstDayOfWeek(month, year)
        for i = 1, firstDayOfWeek do
            table.insert(twoMonthPaneCellConfigs, { key = `lead-{i}`, LayoutOrder = var1 })

            var1 += 1
        end

        local daysInMonth = DateTimeUtilities.getDaysInMonth(month, year)
        for day = 1, daysInMonth do
            table.insert(
                twoMonthPaneCellConfigs,
                {
                    day = day,
                    key = `day-{day}`,
                    LayoutOrder = var1,
                    month = month,
                    year = year
                }
            )
            var1 += 1
        end

        for i = 1, countTrailingEmptyDays(firstDayOfWeek, daysInMonth) do
            table.insert(twoMonthPaneCellConfigs, { key = `trail-{i}`, LayoutOrder = var1 })

            var1 += 1
        end

        return twoMonthPaneCellConfigs
    end
}
