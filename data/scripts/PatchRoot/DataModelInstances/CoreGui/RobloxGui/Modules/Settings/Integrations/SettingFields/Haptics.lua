-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:10:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Settings = script:FindFirstAncestor("Settings")
local CorePackages = game:GetService("CorePackages")
local GameSettings = UserSettings().GameSettings

local SettingsService = require(CorePackages.Workspace.Packages.SettingsService)
local ValueChangedSignal = SettingsService.ValueChangedSignal
local SettingEnum = SettingsService.SettingEnum
local LAYOUT_ORDER = require(Settings.Integrations.Constants).GAMESETTINGS.LAYOUT_ORDER
local tbl1 = { ON = true, OFF = false }

local tbl2 = { MAX = 1, MIN = 0 }

return {
    id = "haptics",
    field_type = SettingEnum.Toggle,
    label = "CoreScripts.InGameMenu.GameSettings.Haptics",
    layoutOrder = LAYOUT_ORDER.HapticsFrame,
    onChanged = (function() -- name: HapticValue
        local function _(): boolean -- Luacid: unused: defined but never referenced
            return GameSettings.HapticStrength ~= 0
        end

        local valueChangedSignal = ValueChangedSignal.new(if GameSettings.HapticStrength == tbl2.MIN then tbl1.OFF else tbl1.ON)
        valueChangedSignal:connect(function(bool1: boolean)
            if (if GameSettings.HapticStrength == tbl2.MIN then tbl1.OFF else tbl1.ON) == bool1 then
                return
            end
            GameSettings.HapticStrength = if bool1 == true then 1 else 0
        end)

        return valueChangedSignal
    end)(),
    alreadyLocalized = false
}
