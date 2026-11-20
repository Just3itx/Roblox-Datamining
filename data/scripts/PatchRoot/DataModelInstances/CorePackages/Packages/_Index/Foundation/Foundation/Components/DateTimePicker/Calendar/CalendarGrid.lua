-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:11:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local CalendarGridDayLabel = require(script.Parent.CalendarGridDayLabel)
local DateTimeCalendarConstants = require(script.Parent.Parent.Utilities.DateTimeCalendarConstants)

local DateTimeCalendarDayAppearanceUtilities = require(script.Parent.Parent.Utilities.DateTimeCalendarDayAppearanceUtilities)
local DateTimeCalendarDayConfigUtilities = require(script.Parent.Parent.Utilities.DateTimeCalendarDayConfigUtilities)
local _DateTimeCalendarViewUtilities = require(script.Parent.Parent.Utilities.DateTimeCalendarViewUtilities)
local DateTimeUtilities = require(script.Parent.Parent.DateTimeUtilities)

local Text = require(Foundation.Components.Text)
local View = require(Foundation.Components.View)
local useTokens = require(Foundation.Providers.Style.useTokens)

local buildCalendarDayConfigs = DateTimeCalendarDayConfigUtilities.buildCalendarDayConfigs
local DAYS_PER_WEEK = DateTimeCalendarConstants.DAYS_PER_WEEK
local getDayCellAppearance = DateTimeCalendarDayAppearanceUtilities.getDayCellAppearance

local var1 = React.memo(function(tbl1) -- name: CalendarGridDayCell
    local var1 = useTokens()

    local onHoverEnter = React.useMemo(function(): (() -> ())?
        return if tbl1.onHoverEnter == nil then nil else function()
            tbl1.onHoverEnter(DateTime.fromLocalTime(tbl1.year, tbl1.month, tbl1.day))
        end
    end, {
        tbl1.onHoverEnter,
        tbl1.year,
        tbl1.month,
        tbl1.day
    })
    local onActivated = React.useCallback(function()
        tbl1.handleDateActivated(tbl1.day, tbl1.month, tbl1.year)
    end, {
        tbl1.handleDateActivated,
        tbl1.day,
        tbl1.month,
        tbl1.year
    })

    local var4 = tbl1.isHighlighted and not tbl1.isSelected
    local bool1 = not (tbl1.bandRadiusTag == nil) and tbl1.bandRadiusTag ~= ""
    local createElement = React.createElement
    local var5 = View
    local tbl2 = {
        LayoutOrder = tbl1.LayoutOrder,
        tag = "size-full"
    }
    local tbl3 = {
        RangeFill = if var4 then React.createElement(View, {
            backgroundStyle = var1.Color.ActionStandard.Background,
            tag = {
                ["size-full"] = true,
                [tbl1.bandRadiusTag] = bool1
            },
            ZIndex = 0
        }) else nil,
        Day = React.createElement(CalendarGridDayLabel, {
            bandPosition = if tbl1.isSelected then tbl1.bandPosition else nil,
            bandRadiusTag = if tbl1.isSelected then tbl1.bandRadiusTag else nil,
            bandSize = if tbl1.isSelected then tbl1.bandSize else nil,
            emphasizeText = if tbl1.applyEmphasis then tbl1.isSelectable and not tbl1.isSelected else nil,
            highlight = false,
            isSelectable = tbl1.isSelectable,
            isSelected = tbl1.isSelected,
            LayoutOrder = 1,
            onActivated = onActivated,
            onHoverEnter = onHoverEnter,
            testId = tbl1.testId,
            label = tostring(tbl1.day)
        })
    }
    return createElement(var5, tbl2, tbl3)
end)
return {
    CalendarGrid = function(tbl1)
        local none = useTokens().Padding.None
        local ref = React.useRef(nil)

        React.useEffect(function()
            local current = ref.current
            local onHoverLeave = tbl1.onHoverLeave
            if current ~= nil and onHoverLeave ~= nil then
                local connection = current.MouseLeave:Connect(onHoverLeave)
                return function()
                    connection:Disconnect()
                end
            end
        end, { tbl1.onHoverLeave })

        local var3 = React.useMemo(function()
            return buildCalendarDayConfigs(tbl1.currViewDate)
        end, { tbl1.currViewDate })

        local var4 = React.useMemo(function()
            local result = ({})
            for _, value in var3 do
                local str1 = `{value.keyPrefix}-{value.day}`
                local dateTime = DateTime.fromLocalTime(value.year, value.month, value.day)
                result[str1] = getDayCellAppearance(
                    dateTime,
                    tbl1.localSelectedDateTimes,
                    tbl1.highlightDates,
                    tbl1.isDateRange,
                    tbl1.selectableDateRange
                )
            end
            return result
        end, {
            var3,
            tbl1.highlightDates,
            tbl1.isDateRange,
            tbl1.localSelectedDateTimes,
            tbl1.selectableDateRange
        })

        local tbl2 = { React.createElement("UIGridLayout", {
                CellPadding = UDim2.fromOffset(none, none),
                CellSize = UDim2.fromOffset(tbl1.scaledCalendarWidth / DAYS_PER_WEEK, tbl1.scaledCalendarWidth / DAYS_PER_WEEK),
                FillDirection = Enum.FillDirection.Horizontal,
                FillDirectionMaxCells = DAYS_PER_WEEK,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                key = "layout",
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Center
            }) }

        local num1 = 1
        for _, key in DateTimeUtilities.weekdays do
            table.insert(
                tbl2,
                React.createElement(
                    Text,
                    {
                        key = key,
                        LayoutOrder = num1,
                        tag = "text-body-small text-align-x-center text-align-y-center",
                        Text = key
                    }
                )
            )
            num1 += 1
        end

        for _, value in var3 do
            local key = `{value.keyPrefix}-{value.day}`
            local var5 = var4[key]
            table.insert(
                tbl2,
                React.createElement(var1, {
                    key = key,
                    applyEmphasis = value.applyEmphasis,
                    bandPosition = var5.bandPosition,
                    bandRadiusTag = var5.bandRadiusTag,
                    bandSize = var5.bandSize,
                    day = value.day,
                    handleDateActivated = tbl1.handleDateActivated,
                    isHighlighted = var5.isHighlighted,
                    isSelectable = var5.isSelectable,
                    isSelected = var5.isSelected,
                    LayoutOrder = value.LayoutOrder,
                    month = value.month,
                    onHoverEnter = tbl1.onHoverEnter,
                    testId = `{tbl1.testId}--{value.keyPrefix}-calendar-day-{value.day}`,
                    year = value.year
                })
            )
        end

        return React.createElement(View, {
            LayoutOrder = tbl1.LayoutOrder,
            ref = ref,
            Size = tbl1.Size,
            tag = "size-full-0 auto-y",
            testId = `{tbl1.testId}--weekAndDates`
        }, tbl2)
    end
}
