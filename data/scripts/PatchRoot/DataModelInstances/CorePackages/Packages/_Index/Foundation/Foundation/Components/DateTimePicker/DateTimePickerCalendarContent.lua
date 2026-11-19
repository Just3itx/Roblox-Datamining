-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:41:00Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local _DateTimeUtilities = require(script.Parent.DateTimeUtilities)
local SingleMonthCalendar = require(script.Parent.Calendar.SingleMonthCalendar)

local DateTimePickerVariant = require(Foundation.Enums.DateTimePickerVariant)

local Divider = require(Foundation.Components.Divider)
local View = require(Foundation.Components.View)

local function DateTimePickerCalendarContent(tbl1)
    local testId = `{tbl1.testId}--calendar`

    if tbl1.variant ~= DateTimePickerVariant.DualWithPresets then
        return React.createElement(SingleMonthCalendar, {
            isDateRange = tbl1.variant == DateTimePickerVariant.Dual,
            LayoutOrder = 1,
            onSelectedDateChanged = tbl1.onSelectedDatesChanged,
            referenceDate = tbl1.referenceDate,
            selectableDateRange = tbl1.selectableDateRange,
            selectedDates = tbl1.selectedDates,
            showTimeList = tbl1.variant == DateTimePickerVariant.SingleWithTime,
            testId = testId,
            viewAnchorDate = tbl1.viewAnchorDate
        })
    end

    local twoMonthCalendar = require(script.Parent.Calendar.TwoMonthCalendar)
    local dateRangePresets = require(script.Parent.Presets.DateRangePresets)
    return React.createElement(View, { tag = "col size-full-0 auto-y" }, {
        Calendar = React.createElement(twoMonthCalendar, {
            LayoutOrder = 1,
            onDayActivated = tbl1.onDayActivated,
            referenceDate = tbl1.referenceDate,
            selectableDateRange = tbl1.selectableDateRange,
            selectedDates = tbl1.selectedDates,
            testId = testId,
            viewAnchorDate = tbl1.viewAnchorDate
        }),
        PresetsDivider = React.createElement(Divider, { LayoutOrder = 2 }),
        PresetsBar = React.createElement(
            View,
            { LayoutOrder = 3, tag = "row size-full-0 auto-y padding-x-large padding-y-medium" },
            {
                Presets = React.createElement(dateRangePresets, {
                    LayoutOrder = 1,
                    onPresetSelected = tbl1.onPresetSelected,
                    referenceDate = tbl1.referenceDate,
                    selectableDateRange = tbl1.selectableDateRange,
                    selectedDates = tbl1.selectedDates,
                    testId = `{testId}--presets`
                })
            }
        )
    })
end

return DateTimePickerCalendarContent
