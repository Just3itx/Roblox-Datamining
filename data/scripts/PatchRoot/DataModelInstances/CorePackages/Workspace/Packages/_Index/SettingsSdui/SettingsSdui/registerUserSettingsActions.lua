-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T16:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SettingsSdui = script:FindFirstAncestor("SettingsSdui")
local SettingsSduiParent = SettingsSdui.Parent

local SduiCoreSystem = require(SettingsSduiParent.SduiCoreSystem)
local SduiActionType = SduiCoreSystem.SduiActionType
local getSduiActionHandlerRegistry = SduiCoreSystem.getSduiActionHandlerRegistry

local function registerUserSettingsActions()
    local tbl1 = {
        [SduiActionType.UpdateUserSettings] = {
            lazyHandler = function()
                return require(SettingsSdui.SduiUpdateUserSettingsAction)
            end,
            skipUnifiedLogging = false
        }
    }

    getSduiActionHandlerRegistry().registerActionHandlerConfigs(tbl1)
end

return registerUserSettingsActions
