-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GroupsParent = script:FindFirstAncestor("Groups").Parent

local React = require(GroupsParent.React)
local Foundation = require(GroupsParent.Foundation)
local SettingsFieldBase = require(script.Parent.SettingsFieldBase)

local function SettingsToggleField(tbl1)
    local createElement = React.createElement
    local var1 = SettingsFieldBase
    local tbl2 = {
        title = tbl1.title,
        description = tbl1.description,
        trailing = React.createElement(Foundation.Toggle, {
            label = "",
            isChecked = tbl1.value,
            onActivated = tbl1.onChange,
            size = Foundation.Enums.InputSize.Medium,
            testId = if tbl1.testId then `{tbl1.testId}--toggle` else nil
        }),
        LayoutOrder = tbl1.LayoutOrder,
        testId = tbl1.testId
    }
    return createElement(var1, tbl2)
end

return SettingsToggleField
