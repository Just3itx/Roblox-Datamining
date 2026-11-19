-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:40:57Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local DateTimePickerBeta = require(script.Parent.DateTimePickerBeta)
local _DateTimePickerProps = require(script.Parent.DateTimePickerProps)
local DateTimePickerVariant = require(Foundation.Enums.DateTimePickerVariant)
local withDefaults = require(Foundation.Utility.withDefaults)

local tbl1 = {
    variant = DateTimePickerVariant.Single,
    testId = "--foundation-date-time-picker"
}

return React.memo(function(arg1) -- name: DateTimePicker
    return React.createElement(DateTimePickerBeta, withDefaults(arg1, tbl1))
end)
