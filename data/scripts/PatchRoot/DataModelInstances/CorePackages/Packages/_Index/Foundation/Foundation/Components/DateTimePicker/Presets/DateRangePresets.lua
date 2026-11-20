-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:20:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local DateTimeEqualityUtilities = require(script.Parent.Parent.Utilities.DateTimeEqualityUtilities)
local DateTimePickerDateRangePreset = require(Foundation.Enums.DateTimePickerDateRangePreset)
local DateTimePresetRangesUtilities = require(script.Parent.Parent.Utilities.DateTimePresetRangesUtilities)
local _DateTimeUtilities = require(script.Parent.Parent.DateTimeUtilities)

local ChipGroup = require(Foundation.Components.ChipGroup)
local ChipSize = require(Foundation.Enums.ChipSize)
local Translator = require(Foundation.Utility.Localization.Translator)

local tbl1 = {
    DateTimePickerDateRangePreset.Today,
    DateTimePickerDateRangePreset.ThisWeek,
    DateTimePickerDateRangePreset.LastWeek,
    DateTimePickerDateRangePreset.ThisMonth,
    DateTimePickerDateRangePreset.ThisYear,
    DateTimePickerDateRangePreset.LastYear
}

local function buildPresetChip(arg1, selectedDates, referenceDate, selectableDateRange, callback: (...any) -> (...any))
    local var1 = DateTimePresetRangesUtilities.resolvePresetRange(arg1, referenceDate)

    if selectableDateRange and not DateTimeEqualityUtilities.isRangeWithinSelectableRange(var1, selectableDateRange) then
        return nil
    end

    return {
        text = Translator:FormatByKey(`CommonUI.Controls.Label.{arg1}`),
        isChecked = DateTimeEqualityUtilities.areDatesSameDayAsRange(selectedDates, var1),
        onActivated = function()
            callback(var1)
        end
    }
end

local function DateRangePresets(tbl2)
    local chips = React.useMemo(function()
        local result = {}
        for i = 1, #tbl1 do
            local presetChip = buildPresetChip(tbl1[i], tbl2.selectedDates, tbl2.referenceDate, tbl2.selectableDateRange, tbl2.onPresetSelected)

            if presetChip then
                table.insert(result, presetChip)
            end
        end
        return result
    end, {
        tbl2.selectedDates,
        tbl2.referenceDate,
        tbl2.onPresetSelected,
        tbl2.selectableDateRange
    })
    return React.createElement(
        ChipGroup,
        {
            chips = chips,
            LayoutOrder = tbl2.LayoutOrder,
            size = ChipSize.Small,
            testId = tbl2.testId
        }
    )
end
return DateRangePresets
