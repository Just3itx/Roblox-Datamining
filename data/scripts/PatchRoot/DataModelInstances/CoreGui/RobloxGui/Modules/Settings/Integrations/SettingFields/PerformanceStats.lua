-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:10:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Settings = script:FindFirstAncestor("Settings")
local CorePackages = game:GetService("CorePackages")
local GameSettings = UserSettings().GameSettings
local CachedPolicyService = require(CorePackages.Workspace.Packages.CachedPolicyService)

local SettingsService = require(CorePackages.Workspace.Packages.SettingsService)
local ValueChangedSignal = SettingsService.ValueChangedSignal
local AvailabilitySignal = SettingsService.AvailabilitySignal
local SettingEnum = SettingsService.SettingEnum
local LAYOUT_ORDER = require(Settings.Integrations.Constants).GAMESETTINGS.LAYOUT_ORDER

local availabilitySignal = AvailabilitySignal.new(not CachedPolicyService:IsSubjectToChinaPolicies())

return {
    id = "perf-stats",
    field_type = SettingEnum.Toggle,
    alreadyLocalized = false,
    label = "CoreScripts.InGameMenu.GameSettings.ShowPerfStats",
    onChanged = (function() -- name: PerfStatsValue
        local valueChangedSignal = ValueChangedSignal.new(GameSettings.PerformanceStatsVisible)

        valueChangedSignal:connect(function(performanceStatsVisible)
            if GameSettings.PerformanceStatsVisible == performanceStatsVisible then
                return
            end

            GameSettings.PerformanceStatsVisible = performanceStatsVisible
        end)

        GameSettings.PerformanceStatsVisibleChanged:Connect(function()
            valueChangedSignal:set(GameSettings.PerformanceStatsVisible)
        end)

        return valueChangedSignal
    end)(),
    availability = availabilitySignal,
    layoutOrder = LAYOUT_ORDER.PerformanceStatsFrame
}
