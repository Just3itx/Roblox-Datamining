-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:41:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GroupsParent = script:FindFirstAncestor("Groups").Parent

local React = require(GroupsParent.React)
local SettingsTextInputFieldView = require(script.Parent.SettingsTextInputFieldView)
local useSettingsTextInputFieldViewModel = require(script.Parent.useSettingsTextInputFieldViewModel)

local function SettingsTextInputFieldContainer(arg1)
    local var1 = useSettingsTextInputFieldViewModel(arg1)
    return React.createElement(SettingsTextInputFieldView, var1)
end

return SettingsTextInputFieldContainer
