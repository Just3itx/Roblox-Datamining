-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:40:47Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local CalendarGridDayLabel = require(script.Parent.CalendarGridDayLabel)

local DateTimeCalendarDayAppearanceUtilities = require(script.Parent.Parent.Utilities.DateTimeCalendarDayAppearanceUtilities)
local DateTimeUtilities = require(script.Parent.Parent.DateTimeUtilities)

local View = require(Foundation.Components.View)
local useTokens = require(Foundation.Providers.Style.useTokens)

local function RangeCalendarDayCell(tbl1)
    local var1 = useTokens()
    local dateTime = DateTime.fromLocalTime(tbl1.year, tbl1.month, tbl1.day)
    local selectedDates = tbl1.selectedDates or {}

    local tbl2 = {}
    for _, value in selectedDates do
        table.insert(tbl2, DateTimeUtilities.toLocalTime(value))
    end

    local var2 = DateTimeCalendarDayAppearanceUtilities.resolveHighlightDates(selectedDates, tbl1.hoveredDate)
    local isSelectable = DateTimeCalendarDayAppearanceUtilities.isDaySelectable(dateTime, tbl1.selectableDateRange)
    local isSelected = DateTimeCalendarDayAppearanceUtilities.isDaySelected(dateTime, tbl2, true)
    local var5 = DateTimeCalendarDayAppearanceUtilities.isDayHighlighted(dateTime, var2, true)

    local var6, var7, var8 = DateTimeCalendarDayAppearanceUtilities.getRangeBand(dateTime, var2, true, isSelected)

    local onHoverEnter = React.useMemo(function(): (() -> ())?
        return if tbl1.onHoverEnter == nil then nil else function()
            tbl1.onHoverEnter(dateTime)
        end
    end, { tbl1.onHoverEnter, dateTime })

    local var10 = var5 and not isSelected
    local bool1 = not (var8 == nil) and var8 ~= ""
    local createElement = React.createElement
    local var11 = View
    local tbl3 = {
        LayoutOrder = tbl1.LayoutOrder,
        Size = UDim2.fromOffset(tbl1.cellSize, tbl1.cellSize)
    }
    local tbl4 = {
        RangeFill = if var10 then React.createElement(
            View,
            {
                backgroundStyle = var1.Color.ActionStandard.Background,
                tag = {
                    ["size-full"] = true,
                    [var8] = bool1
                },
                ZIndex = 0
            }
        ) else nil,
        Day = 0
    }

    local createElement2 = React.createElement
    local var12 = CalendarGridDayLabel
    local tbl5 = {
        bandPosition = 0,
        bandRadiusTag = 0,
        bandSize = 0,
        emphasizeText = 0,
        highlight = false,
        isSelectable = 0,
        isSelected = 0,
        LayoutOrder = 1,
        label = 0,
        onActivated = 0,
        onHoverEnter = 0,
        testId = 0
    }

    if not isSelected then
        var6 = nil
    end

    tbl5.bandPosition = var6
    if not isSelected then
        var8 = nil
    end

    tbl5.bandRadiusTag = var8
    if not isSelected then
        var7 = nil
    end

    tbl5.bandSize = var7
    tbl5.emphasizeText = isSelectable and not isSelected

    tbl5.isSelectable = isSelectable
    tbl5.isSelected = isSelected

    tbl5.label = tostring(tbl1.day)
    function tbl5.onActivated()
        tbl1.onDayActivated(dateTime)
    end
    tbl5.onHoverEnter = onHoverEnter
    tbl5.testId = `{tbl1.testId}--day-{tbl1.year}-{tbl1.month}-{tbl1.day}`
    tbl4.Day = createElement2(var12, tbl5)
    return createElement(var11, tbl3, tbl4)
end

return RangeCalendarDayCell
