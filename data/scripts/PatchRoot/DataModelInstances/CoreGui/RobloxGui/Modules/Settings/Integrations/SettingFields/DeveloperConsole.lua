-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:10:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local CorePackages = game:GetService("CorePackages")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Settings = script:FindFirstAncestor("Settings")

local PlayerPermissionsModule = require(RobloxGui.Modules.PlayerPermissionsModule)
local Constants = require(Settings.Integrations.Constants)
local SettingsService = require(CorePackages.Workspace.Packages.SettingsService)
local ValueChangedSignal = SettingsService.ValueChangedSignal
local AvailabilitySignal = SettingsService.AvailabilitySignal
local SettingEnum = SettingsService.SettingEnum
local DevConsoleMaster = require(script.Parent.Parent.Parent.Parent.DevConsoleMaster)

local LAYOUT_ORDER = Constants.GAMESETTINGS.LAYOUT_ORDER

local function DeveloperConsoleValue() -- Luacid: Inlined by compiler; 1 call site recovered
    local valueChangedSignal = ValueChangedSignal.new()

    valueChangedSignal:connect(function()
        if not DevConsoleMaster then
            return
        end

        DevConsoleMaster:SetVisibility(true)

        local settingsHub = require(script.Parent.Parent.Parent.SettingsHub)
        if settingsHub then
            settingsHub:SetVisibility(false)
        end
    end)

    return valueChangedSignal
end

local onActivated = DeveloperConsoleValue()

local function DeveloperConsoleAvailability()
    local availabilitySignal = AvailabilitySignal.new(false)

    if RunService:IsStudio() then
        availabilitySignal:set(true)
        return availabilitySignal
    end
    spawn(function()
        local var2 = PlayerPermissionsModule.CanPlayerManagePlaceAsync(Players.LocalPlayer)
        availabilitySignal:set(var2)
    end)

    return availabilitySignal
end

local availability = DeveloperConsoleAvailability()

return {
    field_type = SettingEnum.TextButton,
    id = "developer-console",
    onActivated = onActivated,
    label = "CoreScripts.InGameMenu.GameSettings.DeveloperConsole",
    text = "CoreScripts.InGameMenu.GameSettings.Open",
    layoutOrder = LAYOUT_ORDER.DeveloperConsoleButton,
    alreadyLocalized = false,
    availability = availability
}
