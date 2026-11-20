-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:10:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Settings = script:FindFirstAncestor("Settings")
local CorePackages = game:GetService("CorePackages")
local GameSettings = UserSettings().GameSettings

local SettingsService = require(CorePackages.Workspace.Packages.SettingsService)
local ValueChangedSignal = SettingsService.ValueChangedSignal
local SettingEnum = SettingsService.SettingEnum
local LAYOUT_ORDER = require(Settings.Integrations.Constants).GAMESETTINGS.LAYOUT_ORDER

local function ReducedMotionValue() -- Luacid: Inlined by compiler; 1 call site recovered
    local reducedMotion = GameSettings.ReducedMotion
    local valueChangedSignal = ValueChangedSignal.new(reducedMotion)

    valueChangedSignal:connect(function(reducedMotion2: boolean)
        if GameSettings.ReducedMotion == reducedMotion2 then
            return
        end

        GameSettings.ReducedMotion = reducedMotion2
    end)

    return valueChangedSignal
end

return {
    id = "reduced-motion",
    field_type = SettingEnum.Toggle,
    label = "CoreScripts.InGameMenu.GameSettings.ReduceMotionLabel",
    description = "CoreScripts.InGameMenu.GameSettings.ReduceMotionDescription",
    alreadyLocalized = false,
    onChanged = ReducedMotionValue(),
    layoutOrder = LAYOUT_ORDER.ReducedMotionFrame
}
