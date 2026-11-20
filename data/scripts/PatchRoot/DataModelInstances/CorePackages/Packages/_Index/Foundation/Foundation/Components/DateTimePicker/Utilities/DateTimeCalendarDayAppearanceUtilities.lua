-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:21:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local DateTimeCalendarViewUtilities = require(script.Parent.DateTimeCalendarViewUtilities)
local DateTimePickerRangeBandRole = require(Foundation.Enums.DateTimePickerRangeBandRole)
local DateTimeRangeSelectionUtilities = require(script.Parent.DateTimeRangeSelectionUtilities)
local DateTimeUtilities = require(script.Parent.Parent.DateTimeUtilities)

local function isDaySelected(arg1, tbl1, bool1: boolean)
    local var1 = DateTimeUtilities.toLocalTime(arg1)

    if not bool1 then
        tbl1 = tbl1[1] == nil and {} or { tbl1[1] }
    end

    for _, value in tbl1 do
        if value.Day == var1.Day and value.Month == var1.Month and value.Year == var1.Year then
            return true
        end
    end
    return false
end

local function isDayHighlighted(arg1, tbl1, bool1: boolean) -- Luacid: Inlined by compiler; 2 call sites recovered
    if not (bool1 and tbl1[1] and tbl1[2]) then
        return false
    end

    return DateTimeUtilities.isDateWithinRange(arg1, { startDate = tbl1[1], endDate = tbl1[2] })
end

local function getRangeBand(arg1, tbl1, bool1: boolean, bool2: boolean?)
    local startDate = tbl1[1]
    local endDate = tbl1[2]
    if not (bool1 and startDate and endDate) then
        return nil, nil, nil
    end
    local tbl2 = { startDate = startDate, endDate = endDate }
    local var3, var4 = DateTimeCalendarViewUtilities.getRangeDayBounds(tbl2)
    if var3 == var4 then
        return nil, nil, nil
    end
    local var5 = DateTimeUtilities.roundToStartOfDay(arg1)
    local bool3 = bool2 ~= false

    local function fullCellBand()
        return nil, nil, DateTimeCalendarViewUtilities.getRangeBandRadiusTag(arg1, tbl2, DateTimePickerRangeBandRole.Full)
    end

    if var5 == var3 then
        if bool3 then
            return UDim2.fromScale(0.5, 0), UDim2.fromScale(0.5, 1), DateTimeCalendarViewUtilities.getRangeBandRadiusTag(arg1, tbl2, DateTimePickerRangeBandRole.Start)
        end

        return fullCellBand()
    elseif var5 == var4 then
        if bool3 then
            return UDim2.fromScale(0, 0), UDim2.fromScale(0.5, 1), DateTimeCalendarViewUtilities.getRangeBandRadiusTag(arg1, tbl2, DateTimePickerRangeBandRole.End)
        end

        return fullCellBand()
    elseif isDayHighlighted(arg1, tbl1, bool1) then
        return fullCellBand()
    else
        return nil, nil, nil
    end
end

local function isDaySelectable(arg1, arg2): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return not not (not arg2 or DateTimeUtilities.isDateWithinRange(arg1, arg2))
end

return {
    getDayCellAppearance = function(arg1, tbl1, tbl2, bool1: boolean, arg2)
        local isSelected = isDaySelected(arg1, tbl1, bool1)
        local bandPosition, bandSize, bandRadiusTag = getRangeBand(arg1, tbl2, bool1, isSelected)

        return {
            bandPosition = bandPosition,
            bandRadiusTag = bandRadiusTag,
            bandSize = bandSize,
            isHighlighted = isDayHighlighted(arg1, tbl2, bool1),
            isSelectable = isDaySelectable(arg1, arg2),
            isSelected = isSelected
        }
    end,
    getRangeBand = getRangeBand,
    isDayHighlighted = isDayHighlighted,
    isDaySelectable = isDaySelectable,
    isDaySelected = isDaySelected,
    resolveHighlightDates = function(tbl1, arg1)
        if not (tbl1 and tbl1[1]) then
            return tbl1 or {}
        elseif tbl1[2] or not arg1 then
            return tbl1
        end
        return DateTimeRangeSelectionUtilities.selectRangeEndpoint(tbl1, arg1)
    end
}
