-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:10:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Settings = script:FindFirstAncestor("Settings")
local CorePackages = game:GetService("CorePackages")
local UserInputService = game:GetService("UserInputService")
local GameSettings = UserSettings().GameSettings

local SettingsService = require(CorePackages.Workspace.Packages.SettingsService)
local ValueChangedSignal = SettingsService.ValueChangedSignal
local AvailabilitySignal = SettingsService.AvailabilitySignal
local SettingEnum = SettingsService.SettingEnum
local LAYOUT_ORDER = require(Settings.Integrations.Constants).GAMESETTINGS.LAYOUT_ORDER

local function UINavValue() -- Luacid: Inlined by compiler; 1 call site recovered
    local valueChangedSignal = ValueChangedSignal.new(GameSettings.UiNavigationKeyBindEnabled)

    valueChangedSignal:connect(function(uiNavigationKeyBindEnabled)
        if GameSettings.UiNavigationKeyBindEnabled == uiNavigationKeyBindEnabled then
            return
        end

        GameSettings.UiNavigationKeyBindEnabled = uiNavigationKeyBindEnabled
    end)

    return valueChangedSignal
end

local function UINavAvailability() -- Luacid: Inlined by compiler; 1 call site recovered
    local availabilitySignal = AvailabilitySignal.new(UserInputService.KeyboardEnabled)

    UserInputService:GetPropertyChangedSignal("KeyboardEnabled"):Connect(function()
        availabilitySignal:set(UserInputService.KeyboardEnabled)
    end)

    return availabilitySignal
end

return {
    id = "ui-nav-toggle",
    field_type = SettingEnum.Toggle,
    label = "CoreScripts.InGameMenu.GameSettings.UINavToggle",
    description = "CoreScripts.InGameMenu.GameSettings.UINavToggleDescription",
    alreadyLocalized = false,
    onChanged = UINavValue(),
    availability = UINavAvailability(),
    layoutOrder = LAYOUT_ORDER.UiNavigationKeyBindEnabledFrame
}
