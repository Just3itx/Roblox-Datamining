-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:40:49Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local CalendarGrid = require(script.Parent.CalendarGrid).CalendarGrid
local CalendarHeader = require(script.Parent.CalendarHeader)
local DateTimeCalendarConstants = require(script.Parent.Parent.Utilities.DateTimeCalendarConstants)
local DateTimeCalendarViewUtilities = require(script.Parent.Parent.Utilities.DateTimeCalendarViewUtilities)
local DateTimeLayoutUtilities = require(script.Parent.Parent.Utilities.DateTimeLayoutUtilities)
local _DateTimeUtilities = require(script.Parent.Parent.DateTimeUtilities)

local TimeList = require(script.Parent.Parent.Time.TimeList)
local View = require(Foundation.Components.View)
local useSingleMonthCalendarState = require(script.Parent.useSingleMonthCalendarState)

local useScaledValue = require(Foundation.Utility.useScaledValue)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withDefaults = require(Foundation.Utility.withDefaults)

local tbl1 = { testId = "--foundation-calendar" }

local function CalendarPane(tbl2)
    local state = tbl2.state

    return React.createElement(View, {
        LayoutOrder = tbl2.LayoutOrder,
        Size = tbl2.Size,
        tag = {
            ["col gap-small padding-large"] = tbl2.showTimeList == true,
            ["col auto-y"] = tbl2.showTimeList ~= true
        },
        testId = tbl2.rootTestId
    }, {
        CalendarHeader = React.createElement(CalendarHeader, {
            LayoutOrder = 1,
            onNextMonth = state.navigateToNextMonth,
            onPreviousMonth = state.navigateToPreviousMonth,
            onViewDateChanged = state.onViewDateChanged,
            selectableDateRange = tbl2.selectableDateRange,
            testId = tbl2.testId,
            viewDate = state.currViewDate
        }),
        WeekAndDates = React.createElement(CalendarGrid, {
            currViewDate = state.currViewDate,
            handleDateActivated = state.handleDateActivated,
            highlightDates = state.highlightDates,
            isDateRange = state.isDateRange,
            localSelectedDateTimes = state.localSelectedDateTimes,
            LayoutOrder = 2,
            onHoverEnter = state.onHoverEnter,
            onHoverLeave = state.onHoverLeave,
            scaledCalendarWidth = tbl2.scaledCalendarWidth,
            selectableDateRange = tbl2.selectableDateRange,
            Size = tbl2.gridSize,
            testId = tbl2.testId
        })
    })
end

local function SingleMonthCalendar(tbl2)
    local var1 = withDefaults(tbl2, tbl1)
    local var2 = useTokens()
    local scaledCalendarWidth = useScaledValue(DateTimeLayoutUtilities.CALENDAR_WIDTH)
    local offset = useScaledValue(DateTimeLayoutUtilities.TIME_LIST_WIDTH)

    local state = useSingleMonthCalendarState({
        isDateRange = var1.isDateRange,
        onSelectedDateChanged = var1.onSelectedDateChanged,
        referenceDate = var1.referenceDate,
        selectableDateRange = var1.selectableDateRange,
        selectedDates = var1.selectedDates,
        showTimeList = var1.showTimeList,
        viewAnchorDate = var1.viewAnchorDate
    })

    if not var1.showTimeList then
        return React.createElement(CalendarPane, {
            LayoutOrder = var1.LayoutOrder,
            rootTestId = var1.testId,
            scaledCalendarWidth = scaledCalendarWidth,
            selectableDateRange = var1.selectableDateRange,
            Size = UDim2.fromOffset(scaledCalendarWidth, 0),
            state = state,
            testId = var1.testId
        })
    end

    local var4 = DateTimeLayoutUtilities.computeSingleWithTimeLayout(
        scaledCalendarWidth,
        offset,
        var2,
        DateTimeCalendarConstants.NUM_CALENDAR_GRID_ROWS
    )

    return React.createElement(
        View,
        {
            LayoutOrder = var1.LayoutOrder,
            tag = "row align-y-top auto-xy",
            testId = var1.testId
        },
        {
            CalendarPane = React.createElement(CalendarPane, {
                gridSize = UDim2.fromOffset(scaledCalendarWidth, var4.gridHeight),
                LayoutOrder = 1,
                scaledCalendarWidth = scaledCalendarWidth,
                selectableDateRange = var1.selectableDateRange,
                showTimeList = true,
                Size = UDim2.fromOffset(var4.calendarColumnWidth, var4.bodyHeight),
                state = state,
                testId = var1.testId
            }),
            Divider = React.createElement(View, {
                backgroundStyle = var2.Color.Stroke.Default,
                LayoutOrder = 2,
                Size = UDim2.fromOffset(var2.Stroke.Standard, var4.bodyHeight)
            }),
            TimeListColumn = React.createElement(
                View,
                {
                    LayoutOrder = 3,
                    Size = UDim2.fromOffset(var4.timeListColumnWidth, var4.bodyHeight),
                    tag = "col padding-large"
                },
                {
                    TimeList = React.createElement(TimeList, {
                        dateTime = state.selectedDateTimes[1],
                        dayAnchor = DateTimeCalendarViewUtilities.resolveAnchorDate(state.selectedDateTimes, var1.viewAnchorDate or var1.referenceDate),
                        height = var4.timeListHeight,
                        LayoutOrder = 1,
                        onItemChanged = state.onTimeListItemChanged,
                        testId = `{var1.testId}--time-list`,
                        width = UDim.new(0, offset)
                    })
                }
            )
        }
    )
end

return SingleMonthCalendar
