-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:20:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local DateTimeUtilities = require(Foundation.Components.DateTimePicker.DateTimeUtilities)
local Dropdown = require(Foundation.Components.Dropdown)
local InputSize = require(Foundation.Enums.InputSize)
local LocalizationService = require(Foundation.Utility.Wrappers).Services.LocalizationService
local Translator = require(Foundation.Utility.Localization.Translator)
local useScaledValue = require(Foundation.Utility.useScaledValue)
local withDefaults = require(Foundation.Utility.withDefaults)

local tbl1 = {
    dateTime = DateTime.fromLocalTime(2000, 1, 1, 0, 0, 0),
    testId = "--foundation-time-dropdown"
}

local function TimeSelector(tbl2)
    local var1 = withDefaults(tbl2, tbl1)

    local var2 = DateTimeUtilities.roundDownToNearestMinute(var1.dateTime)
    local var3 = var2:ToLocalTime()

    local maxHeight = useScaledValue(200)

    return React.createElement(Dropdown.Root, {
        items = (function()
            local result = {}
            local bool1 = var3.Minute % 30 ~= 0

            for i = 0, 47 do
                local hour = math.floor(i / 2)
                local minute = i % 2 * 30

                local dateTime = DateTime.fromLocalTime(var3.Year, var3.Month, var3.Day, hour, minute, var3.Second)

                if bool1 and var2.UnixTimestamp < dateTime.UnixTimestamp then
                    table.insert(result, {
                        icon = nil,
                        id = var2.UnixTimestamp,
                        isChecked = true,
                        isDisabled = true,
                        text = var2:FormatLocalTime("LT", LocalizationService.RobloxLocaleId)
                    })
                    bool1 = false
                end

                table.insert(result, {
                    icon = nil,
                    id = dateTime.UnixTimestamp,
                    isChecked = dateTime.UnixTimestamp == var2.UnixTimestamp,
                    isDisabled = dateTime.UnixTimestamp == var2.UnixTimestamp,
                    text = dateTime:FormatLocalTime("LT", LocalizationService.RobloxLocaleId)
                })
            end

            return result
        end)(),
        label = "",
        LayoutOrder = var1.LayoutOrder,
        maxHeight = maxHeight,
        onItemChanged = var1.onItemChanged,
        placeholder = Translator:FormatByKey("CommonUI.Controls.Label.SelectTheTime"),
        size = InputSize.Medium,
        testId = var1.testId,
        width = var1.width,
        value = var2.UnixTimestamp
    })
end

return TimeSelector
