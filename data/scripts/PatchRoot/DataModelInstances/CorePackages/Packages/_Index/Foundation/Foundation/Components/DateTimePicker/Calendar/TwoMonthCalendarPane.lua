-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:40:53Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local DateTimeCalendarConstants = require(script.Parent.Parent.Utilities.DateTimeCalendarConstants)
local DateTimeCalendarDayConfigUtilities = require(script.Parent.Parent.Utilities.DateTimeCalendarDayConfigUtilities)
local DateTimeUtilities = require(script.Parent.Parent.DateTimeUtilities)

local RangeCalendarDayCell = require(script.Parent.RangeCalendarDayCell)
local Text = require(Foundation.Components.Text)
local View = require(Foundation.Components.View)

local DAYS_PER_WEEK = DateTimeCalendarConstants.DAYS_PER_WEEK
local buildTwoMonthPaneCellConfigs = DateTimeCalendarDayConfigUtilities.buildTwoMonthPaneCellConfigs

local function EmptyCell(tbl1)
    return React.createElement(View, { LayoutOrder = tbl1.LayoutOrder, Size = UDim2.fromOffset(tbl1.cellSize, tbl1.cellSize) })
end

local function TwoMonthCalendarPane(tbl1)
    local var1 = React.useMemo(function()
        return buildTwoMonthPaneCellConfigs(tbl1.month, tbl1.year)
    end, { tbl1.month, tbl1.year })

    local tbl2 = { React.createElement("UIGridLayout", {
            CellPadding = UDim2.fromOffset(0, 0),
            CellSize = UDim2.fromOffset(tbl1.cellSize, tbl1.cellSize),
            FillDirection = Enum.FillDirection.Horizontal,
            FillDirectionMaxCells = DAYS_PER_WEEK,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            key = "layout",
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center
        }) }

    local num1 = 1
    for _, weekday in DateTimeUtilities.weekdays do
        table.insert(
            tbl2,
            React.createElement(Text, {
                key = `weekday-{weekday}`,
                LayoutOrder = num1,
                Text = weekday,
                tag = "text-body-small text-align-x-center text-align-y-center"
            })
        )

        num1 += 1
    end

    for _, value in var1 do
        if value.day == nil then
            table.insert(
                tbl2,
                React.createElement(EmptyCell, { key = value.key, cellSize = tbl1.cellSize, LayoutOrder = value.LayoutOrder })
            )
        else
            table.insert(
                tbl2,
                React.createElement(RangeCalendarDayCell, {
                    key = value.key,
                    cellSize = tbl1.cellSize,
                    day = value.day,
                    hoveredDate = tbl1.hoveredDate,
                    LayoutOrder = value.LayoutOrder,
                    month = value.month,
                    onDayActivated = tbl1.onDayActivated,
                    onHoverEnter = tbl1.onHoverEnter,
                    selectableDateRange = tbl1.selectableDateRange,
                    selectedDates = tbl1.selectedDates,
                    testId = tbl1.testId,
                    year = value.year
                })
            )
        end
    end

    return React.createElement(View, {
        LayoutOrder = tbl1.LayoutOrder,
        Size = UDim2.fromOffset(tbl1.paneWidth, 0),
        tag = "auto-y",
        testId = `{tbl1.testId}--pane-{tbl1.LayoutOrder}`
    }, tbl2)
end

return TwoMonthCalendarPane
