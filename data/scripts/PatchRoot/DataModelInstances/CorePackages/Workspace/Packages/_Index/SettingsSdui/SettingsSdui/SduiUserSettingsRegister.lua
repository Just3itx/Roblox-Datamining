-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T16:11:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SettingsSdui = script:FindFirstAncestor("SettingsSdui")
local SettingsSduiParent = SettingsSdui.Parent
local React = require(SettingsSduiParent.React)

local registerUserSettingsActions = require(SettingsSdui.registerUserSettingsActions)

return React.memo(function() -- name: SduiUserSettingsRegister
    React.useEffect(function()
        registerUserSettingsActions()
    end, {})
    return nil
end)
