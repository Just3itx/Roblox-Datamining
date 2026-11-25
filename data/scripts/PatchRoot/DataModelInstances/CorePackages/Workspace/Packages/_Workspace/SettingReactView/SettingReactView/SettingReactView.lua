-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:50:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local _SettingsService = require(scriptParentParent.SettingsService)
local FieldRow = require(scriptParent.FieldRow)
local React = require(scriptParentParent.React)
local View = require(scriptParentParent.Foundation).View

local function _createPageView(tbl1)
    return React.createElement(View, {
        tag = "padding-x-medium align-x-center align-y-top padding-small col size-full auto-y gui-object-defaults",
        Visible = tbl1.visible
    }, {
        ((function() -- name: getFields
            local fields = {}
            for _, setting in tbl1.settings do
                fields[setting.id] = React.createElement(FieldRow, setting)
            end
            return fields
        end)())
    })
end

return _createPageView
