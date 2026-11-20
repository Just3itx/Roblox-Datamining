-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:10:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Settings = script:FindFirstAncestor("Settings")
local CorePackages = game:GetService("CorePackages")
local GameSettings = UserSettings().GameSettings
local GuiService = game:GetService("GuiService")

local SettingsService = require(CorePackages.Workspace.Packages.SettingsService)
local ValueChangedSignal = SettingsService.ValueChangedSignal
local AvailabilitySignal = SettingsService.AvailabilitySignal
local SettingEnum = SettingsService.SettingEnum
local Constants = require(Settings.Integrations.Constants)
local Utils = require(Settings.Integrations.Utils)

local LAYOUT_ORDER = Constants.GAMESETTINGS.LAYOUT_ORDER

local function FullScreenValue()
    local valueChangedSignal = ValueChangedSignal.new(GameSettings:InFullScreen())

    valueChangedSignal:connect(function(arg1)
        if arg1 == GameSettings:InFullScreen() then
            return
        end
        GuiService:ToggleFullscreen()
    end, true)

    GameSettings.FullscreenChanged:Connect(function(isFullscreen: boolean)
        valueChangedSignal:set(isFullscreen)
    end)

    return valueChangedSignal
end

local onChanged = FullScreenValue()

local function initAvailability(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return Utils.getDeviceType() == Utils.DeviceTypes.Desktop or Utils.getDeviceType() == Utils.DeviceTypes.Unknown
end

local availabilitySignal = AvailabilitySignal.new((initAvailability()))

return {
    id = "fullscreen",
    field_type = SettingEnum.Toggle,
    label = "CoreScripts.InGameMenu.GameSettings.FullScreen",
    layoutOrder = LAYOUT_ORDER.FullScreenFrame,
    onChanged = onChanged,
    alreadyLocalized = false,
    availability = availabilitySignal
}
