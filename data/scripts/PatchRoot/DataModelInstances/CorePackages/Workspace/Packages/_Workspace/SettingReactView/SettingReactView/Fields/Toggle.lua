-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:50:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SettingReactViewParent = script:FindFirstAncestor("SettingReactView").Parent

local _SettingsService = require(SettingReactViewParent.SettingsService)
local React = require(SettingReactViewParent.React)
local Toggle = require(SettingReactViewParent.Foundation).Toggle

return function(arg1)
    local isChecked, var2 = React.useState(arg1.onChanged:get())
    arg1.onChanged:connect(function(bool1: boolean)
        var2(bool1)
    end)
    local onActivated = React.useCallback(function()
        arg1.onChanged:set(not isChecked)
    end, { isChecked })

    return React.createElement(Toggle, { label = "", isDisabled = false, isChecked = isChecked, onActivated = onActivated })
end
