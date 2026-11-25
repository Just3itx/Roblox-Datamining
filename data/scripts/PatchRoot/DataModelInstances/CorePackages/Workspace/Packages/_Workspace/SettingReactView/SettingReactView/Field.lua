-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local SettingEnum = require(scriptParentParent.SettingsService).SettingEnum
local React = require(scriptParentParent.React)
local Fields = scriptParent.Fields
local Toggle = require(Fields.Toggle)
local TextButton = require(Fields.TextButton)

return function(arg1)
    local result = {}
    if arg1.field_type == SettingEnum.Toggle then
        return (React.createElement(Toggle, arg1))
    end

    if arg1.field_type == SettingEnum.TextButton then
        result = React.createElement(TextButton, arg1)
    end
    return result
end
