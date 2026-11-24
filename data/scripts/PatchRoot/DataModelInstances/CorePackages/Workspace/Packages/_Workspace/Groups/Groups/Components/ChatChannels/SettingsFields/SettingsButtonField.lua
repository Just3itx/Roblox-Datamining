-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:40:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GroupsParent = script:FindFirstAncestor("Groups").Parent

local React = require(GroupsParent.React)
local Foundation = require(GroupsParent.Foundation)
local SettingsFieldBase = require(script.Parent.SettingsFieldBase)

local function SettingsButtonField(tbl1)
    local createElement = React.createElement
    local var1 = SettingsFieldBase
    local tbl2 = {
        title = tbl1.title,
        description = tbl1.description,
        trailing = 0,
        LayoutOrder = 0,
        testId = 0
    }
    local createElement2 = React.createElement
    local view = Foundation.View
    local tbl3 = { tag = "auto-xy" }

    local tbl4 = {
        Button = React.createElement(Foundation.Button, {
            text = tbl1.buttonText,
            variant = tbl1.buttonVariant,
            onActivated = tbl1.onClick,
            size = Foundation.Enums.InputSize.Medium,
            testId = if tbl1.testId then `{tbl1.testId}--button` else nil
        })
    }
    tbl2.trailing = createElement2(view, tbl3, tbl4)

    tbl2.LayoutOrder = tbl1.LayoutOrder
    tbl2.testId = tbl1.testId
    return createElement(var1, tbl2)
end

return SettingsButtonField
