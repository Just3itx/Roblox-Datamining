-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:40:56Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent

local React = require(FoundationParent.React)

local DateTimeCalendarDayAppearanceUtilities = require(script.Parent.Parent.Utilities.DateTimeCalendarDayAppearanceUtilities)
local DateTimeCalendarViewUtilities = require(script.Parent.Parent.Utilities.DateTimeCalendarViewUtilities)
local DateTimeParsingUtilities = require(script.Parent.Parent.Utilities.DateTimeParsingUtilities)
local DateTimeRangeSelectionUtilities = require(script.Parent.Parent.Utilities.DateTimeRangeSelectionUtilities)
local DateTimeUtilities = require(script.Parent.Parent.DateTimeUtilities)

local function useSingleMonthCalendarState(tbl1)
    local bool1 = tbl1.isDateRange == true

    local var1 = React.useMemo(function()
        if tbl1.selectedDates then
            return DateTimeRangeSelectionUtilities.normalizeDates({ acceptsDateRange = bool1, dates = tbl1.selectedDates })
        end

        return {}
    end, { tbl1.selectedDates, bool1 })

    local selectedDateTimes, var3 = React.useState(var1)

    React.useEffect(function()
        var3(var1)
    end, { var1 })

    React.useEffect(function()
        if tbl1.selectedDates then
            return
        end
        tbl1.onSelectedDateChanged(var1)
    end, { tbl1.selectedDates, var1, tbl1.onSelectedDateChanged })

    local localSelectedDateTimes = React.useMemo(function()
        local result = {}
        for _, value in selectedDateTimes do
            table.insert(result, DateTimeUtilities.toLocalTime(value))
        end
        return result
    end, { selectedDateTimes })

    local currViewDate, var6 = React.useState(
        DateTimeCalendarViewUtilities.toViewDate(
            DateTimeCalendarViewUtilities.resolveAnchorDate(tbl1.selectedDates, tbl1.referenceDate)
        )
    )

    React.useEffect(function()
        if not tbl1.viewAnchorDate then
            return
        end
        var6(DateTimeCalendarViewUtilities.toViewDate(tbl1.viewAnchorDate))
    end, { tbl1.viewAnchorDate })

    local navigateToNextMonth = React.useCallback(function()
        local month, year = DateTimeUtilities.getNextMonthInfo(currViewDate.month, currViewDate.year)
        var6({ month = month, year = year })
    end, { currViewDate })

    local navigateToPreviousMonth = React.useCallback(function()
        local month, year = DateTimeUtilities.getPrevMonthInfo(currViewDate.month, currViewDate.year)
        var6({ month = month, year = year })
    end, { currViewDate })

    local onViewDateChanged = React.useCallback(function(arg1)
        var6(arg1)
    end, {})

    local var10, var11 = React.useState(function()
        return nil
    end)

    local highlightDates = React.useMemo(function()
        if not bool1 then
            return selectedDateTimes
        end
        return DateTimeCalendarDayAppearanceUtilities.resolveHighlightDates(selectedDateTimes, var10)
    end, { bool1, selectedDateTimes, var10 })

    local onHoverEnter = React.useCallback(function(arg1)
        if not bool1 then
            return
        end
        var11(arg1)
    end, { bool1 })

    local onHoverLeave = React.useCallback(function()
        var11(nil)
    end, {})

    React.useEffect(function()
        if not bool1 then
            return
        end
        if not selectedDateTimes[1] or selectedDateTimes[2] then
            var11(nil)
        end
    end, { bool1, selectedDateTimes })

    return {
        currViewDate = currViewDate,
        handleDateActivated = React.useCallback(function(day: number, month: number, year: number)
            local var15 = selectedDateTimes[1]
            local hour, minute

            if var15 then
                local var16 = DateTimeUtilities.toLocalTime(var15)
                hour = var16.Hour
                minute = var16.Minute
            else
                hour = 0
                minute = 0
            end
            local dateTime = DateTime.fromLocalTime(year, month, day, hour, minute)
            if tbl1.showTimeList then
                dateTime = DateTimeCalendarViewUtilities.roundUpToNearestHalfHour(dateTime)
            end

            var6({ month = month, year = year })
            var11(nil)
            local var16 = not bool1 and { dateTime } or DateTimeRangeSelectionUtilities.selectRangeEndpoint(selectedDateTimes, dateTime)

            var3(var16)
            tbl1.onSelectedDateChanged(var16)
        end, {
            bool1,
            tbl1.showTimeList,
            tbl1.onSelectedDateChanged,
            selectedDateTimes
        }),
        highlightDates = highlightDates,
        isDateRange = bool1,
        localSelectedDateTimes = localSelectedDateTimes,
        navigateToNextMonth = navigateToNextMonth,
        navigateToPreviousMonth = navigateToPreviousMonth,
        onHoverEnter = onHoverEnter,
        onHoverLeave = onHoverLeave,
        onTimeListItemChanged = React.useCallback(function(unixTimestamp: number)
            local var15 = DateTimeParsingUtilities.adjustForDaylightSaving(DateTime.fromUnixTimestamp(unixTimestamp))
            var3({ var15 })
            tbl1.onSelectedDateChanged({ var15 })
        end, { tbl1.onSelectedDateChanged }),
        onViewDateChanged = onViewDateChanged,
        selectedDateTimes = selectedDateTimes
    }
end

return useSingleMonthCalendarState
