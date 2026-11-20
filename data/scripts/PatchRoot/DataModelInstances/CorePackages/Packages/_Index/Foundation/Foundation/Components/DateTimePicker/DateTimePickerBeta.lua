-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:20:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local BuilderIcons = require(FoundationParent.BuilderIcons)
local React = require(FoundationParent.React)

local Icon = BuilderIcons.Icon

local DateTimePickerCalendarContent = require(script.Parent.DateTimePickerCalendarContent)
local DateTimePickerPanel = require(script.Parent.DateTimePickerPanel)
local _DateTimePickerProps = require(script.Parent.DateTimePickerProps)

local useDateTimePickerState = require(script.Parent.useDateTimePickerState)

local DateTimePickerVariant = require(Foundation.Enums.DateTimePickerVariant)

local InputSize = require(Foundation.Enums.InputSize)
local Popover = require(Foundation.Components.Popover)
local PopoverAlign = require(Foundation.Enums.PopoverAlign)
local PopoverSide = require(Foundation.Enums.PopoverSide)
local TextInput = require(Foundation.Components.TextInput)
local Translator = require(Foundation.Utility.Localization.Translator)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local tbl1 = {
    variant = DateTimePickerVariant.Single,
    testId = "--foundation-date-time-picker"
}

return React.memo(function(arg1) -- name: DateTimePickerBeta
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useTokens()
    local variant = var1.variant or DateTimePickerVariant.Single
    local bool1 = variant == DateTimePickerVariant.DualWithPresets
    local bool2 = variant == DateTimePickerVariant.SingleWithTime
    local bool3 = bool1 or bool2

    local var4 = useDateTimePickerState(var1)

    local createElement = React.createElement
    local root = Popover.Root
    local tbl2 = {
        isOpen = var4.isOpen,
        testId = var1.testId
    }
    local tbl3 = {
        DateInput = React.createElement(
            TextInput,
            withCommonProps(var1, {
                hasError = var1.hasError,
                hint = var1.hint,
                iconTrailing = {
                    name = Icon.Calendar,
                    onActivated = var4.showDateTimePicker
                },
                isDisabled = var1.isDisabled,
                isRequired = var1.isRequired,
                key = "date-input",
                label = var1.label,
                onChanged = var4.updateInputText,
                onFocusGained = var4.onFocusGained,
                onFocusLost = var4.onFocusLost,
                placeholder = var1.placeholder or Translator:FormatByKey("CommonUI.Controls.Label.SelectDate"),
                ref = var4.textInputRef,
                selectableDateRange = var1.selectableDateRange,
                size = InputSize.Medium,
                testId = `{var1.testId}--text-input`,
                text = var4.inputText,
                width = var1.width
            })
        ),
        Anchor = React.createElement(Popover.Anchor, { anchorRef = var4.textInputRef }),
        PopoverContent = 0
    }
    local createElement2 = React.createElement
    local content = Popover.Content
    local tbl4 = {
        align = PopoverAlign.Start,
        hasArrow = false,
        onPressedOutside = var4.closeDateTimePicker,
        selection = var1.selection,
        selectionGroup = var1.selectionGroup,
        side = {
            offset = var2.Stroke.Standard + var2.Padding.Small,
            position = PopoverSide.Bottom
        }
    }
    local isOpen = var4.isOpen

    if isOpen then
        isOpen = React.createElement(
            DateTimePickerPanel,
            {
                isApplyButtonDisabled = var4.isApplyButtonDisabled,
                isResetButtonDisabled = var4.isResetButtonDisabled,
                isSectioned = bool3,
                onApply = var4.onApply,
                onCancel = var4.onCancel,
                onReset = if bool3 then var4.onReset else nil,
                sectionedLayout = if bool1 then "dual" elseif bool2 then "singleWithTime" else nil,
                showReset = bool3,
                testId = var1.testId
            },
            React.createElement(DateTimePickerCalendarContent, {
                onDayActivated = var4.onDayActivated,
                onPresetSelected = var4.onPresetSelected,
                onSelectedDatesChanged = var4.onSelectedDatesChanged,
                referenceDate = var1.referenceDate,
                selectableDateRange = var1.selectableDateRange,
                selectedDates = var4.selectedDates,
                testId = var1.testId,
                variant = variant,
                viewAnchorDate = var4.viewAnchorDate
            })
        )
    end

    tbl3.PopoverContent = createElement2(content, tbl4, isOpen)
    return createElement(root, tbl2, tbl3)
end)
