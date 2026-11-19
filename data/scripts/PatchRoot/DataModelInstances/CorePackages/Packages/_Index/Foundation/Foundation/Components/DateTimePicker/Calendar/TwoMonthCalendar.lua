-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:40:50Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local DateTimeCalendarViewUtilities = require(script.Parent.Parent.Utilities.DateTimeCalendarViewUtilities)
local DateTimeLayoutUtilities = require(script.Parent.Parent.Utilities.DateTimeLayoutUtilities)
local DateTimeUtilities = require(script.Parent.Parent.DateTimeUtilities)

local Divider = require(Foundation.Components.Divider)
local TwoMonthCalendarHeader = require(script.Parent.TwoMonthCalendarHeader)
local TwoMonthCalendarPane = require(script.Parent.TwoMonthCalendarPane)
local View = require(Foundation.Components.View)
local useScaledValue = require(Foundation.Utility.useScaledValue)

local function TwoMonthCalendar(tbl1)
    local paneWidth = useScaledValue(DateTimeLayoutUtilities.PANE_WIDTH)
    local cellSize = paneWidth / 7

    local currViewDate, var4 = React.useState(
        DateTimeCalendarViewUtilities.toViewDate(
            DateTimeCalendarViewUtilities.resolveAnchorDate(tbl1.selectedDates, tbl1.referenceDate)
        )
    )

    local hoveredDate, var6 = React.useState(function()
        return nil
    end)
    local ref = React.useRef(nil)

    React.useEffect(function()
        if not tbl1.viewAnchorDate then
            return
        end
        var4(DateTimeCalendarViewUtilities.toViewDate(tbl1.viewAnchorDate))
    end, { tbl1.viewAnchorDate })

    React.useEffect(function()
        if tbl1.viewAnchorDate or tbl1.selectedDates and tbl1.selectedDates[1] then
            return
        end

        if tbl1.referenceDate then
            var4(DateTimeCalendarViewUtilities.toViewDate(tbl1.referenceDate))
        end
    end, { tbl1.viewAnchorDate, tbl1.referenceDate, tbl1.selectedDates })

    React.useEffect(function()
        local selectedDates = tbl1.selectedDates
        if not selectedDates or not selectedDates[1] or selectedDates[2] then
            var6(nil)
        end
    end, { tbl1.selectedDates })

    React.useEffect(function()
        local current = ref.current
        if current == nil then
            return
        end

        local connection = current.MouseLeave:Connect(function()
            var6(nil)
        end)
        return function()
            connection:Disconnect()
        end
    end, {})

    local onPreviousMonth = React.useCallback(function()
        var4(function(arg1)
            local month, year = DateTimeUtilities.getPrevMonthInfo(arg1.month, arg1.year)
            return { month = month, year = year }
        end)
    end, {})

    local onNextMonth = React.useCallback(function()
        var4(function(arg1)
            local month, year = DateTimeUtilities.getNextMonthInfo(arg1.month, arg1.year)
            return { month = month, year = year }
        end)
    end, {})

    local onHoverEnter = React.useCallback(function(arg1)
        var6(arg1)
    end, {})

    local onDayActivated = React.useCallback(function(arg1)
        var6(nil)
        tbl1.onDayActivated(arg1)
    end, { tbl1.onDayActivated })

    local var12, var13 = DateTimeUtilities.getNextMonthInfo(currViewDate.month, currViewDate.year)

    return React.createElement(
        View,
        {
            LayoutOrder = tbl1.LayoutOrder,
            tag = "col size-full-0 auto-y",
            testId = tbl1.testId
        },
        {
            Header = React.createElement(TwoMonthCalendarHeader, {
                currViewDate = currViewDate,
                onNextMonth = onNextMonth,
                onPreviousMonth = onPreviousMonth,
                secondMonth = var12,
                secondYear = var13,
                testId = tbl1.testId
            }),
            HeaderDivider = React.createElement(Divider, { LayoutOrder = 2 }),
            Panes = React.createElement(
                View,
                {
                    LayoutOrder = 3,
                    ref = ref,
                    tag = "row align-y-top gap-large auto-xy padding-x-large padding-y-small"
                },
                {
                    FirstPane = React.createElement(TwoMonthCalendarPane, {
                        cellSize = cellSize,
                        hoveredDate = hoveredDate,
                        LayoutOrder = 1,
                        month = currViewDate.month,
                        onDayActivated = onDayActivated,
                        onHoverEnter = onHoverEnter,
                        paneWidth = paneWidth,
                        selectableDateRange = tbl1.selectableDateRange,
                        selectedDates = tbl1.selectedDates,
                        testId = tbl1.testId,
                        year = currViewDate.year
                    }),
                    SecondPane = React.createElement(TwoMonthCalendarPane, {
                        cellSize = cellSize,
                        hoveredDate = hoveredDate,
                        LayoutOrder = 2,
                        month = var12,
                        onDayActivated = onDayActivated,
                        onHoverEnter = onHoverEnter,
                        paneWidth = paneWidth,
                        selectableDateRange = tbl1.selectableDateRange,
                        selectedDates = tbl1.selectedDates,
                        testId = tbl1.testId,
                        year = var13
                    })
                }
            )
        }
    )
end

return TwoMonthCalendar
