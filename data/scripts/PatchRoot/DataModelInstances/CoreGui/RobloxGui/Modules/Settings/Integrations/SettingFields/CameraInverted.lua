-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:01:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Settings = script:FindFirstAncestor("Settings")
local CorePackages = game:GetService("CorePackages")
local GameSettings = UserSettings().GameSettings

local SettingsService = require(CorePackages.Workspace.Packages.SettingsService)
local ValueChangedSignal = SettingsService.ValueChangedSignal
local AvailabilitySignal = SettingsService.AvailabilitySignal
local SettingEnum = SettingsService.SettingEnum
local LAYOUT_ORDER = require(Settings.Integrations.Constants).GAMESETTINGS.LAYOUT_ORDER

local function CameraInvertedValue() -- Luacid: Inlined by compiler; 1 call site recovered
    local valueChangedSignal = ValueChangedSignal.new(GameSettings.CameraYInverted)

    valueChangedSignal:connect(function(cameraYInverted: boolean)
        if GameSettings.CameraYInverted == cameraYInverted then
            return
        end
        GameSettings.CameraYInverted = cameraYInverted
    end, true)

    return valueChangedSignal
end

local function CameraInvertedAvailability() -- Luacid: Inlined by compiler; 1 call site recovered
    local availabilitySignal = AvailabilitySignal.new(GameSettings.IsUsingCameraYInverted)

    GameSettings.Changed:Connect(function(arg1)
        if arg1 == "IsUsingCameraYInverted" then
            availabilitySignal:set(GameSettings.IsUsingCameraYInverted)
        end
    end)

    return availabilitySignal
end

return {
    id = "camera-inverted",
    field_type = SettingEnum.Toggle,
    label = "CoreScripts.InGameMenu.GameSettings.InvertedCamera",
    alreadyLocalized = false,
    onChanged = CameraInvertedValue(),
    availability = CameraInvertedAvailability(),
    layoutOrder = LAYOUT_ORDER.CameraInvertedFrame
}
