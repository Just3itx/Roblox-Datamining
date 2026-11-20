-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:10:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Settings = script:FindFirstAncestor("Settings")
local CorePackages = game:GetService("CorePackages")
local UserInputService = game:GetService("UserInputService")
local GameSettings = UserSettings().GameSettings
local Players = game:GetService("Players")

local SettingsService = require(CorePackages.Workspace.Packages.SettingsService)
local ValueChangedSignal = SettingsService.ValueChangedSignal
local AvailabilitySignal = SettingsService.AvailabilitySignal
local VisibilitySignal = SettingsService.VisibilitySignal
local SettingEnum = SettingsService.SettingEnum
local Constants = require(Settings.Integrations.Constants)
local LocalPlayer = Players.LocalPlayer

local LAYOUT_ORDER = Constants.GAMESETTINGS.LAYOUT_ORDER

local tbl1 = {
    [Enum.ControlMode.MouseLockSwitch] = true,
    [Enum.ControlMode.Classic] = false
}

local function ShiftLockValue() -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = tbl1[GameSettings.ControlMode]
    local valueChangedSignal = ValueChangedSignal.new(var1)
    valueChangedSignal:connect(function(bool1: boolean)
        if tbl1[GameSettings.ControlMode] == bool1 then
            return
        end

        local var2 = GameSettings
        var2.ControlMode = if bool1 then Enum.ControlMode.MouseLockSwitch else Enum.ControlMode.Classic
    end)
    return valueChangedSignal
end

local onChanged = ShiftLockValue()

local visibilitySignal = VisibilitySignal.new(true)

local function ShiftLockAvailability(_, arg1)
    local function available(): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
        local bool1 = not LocalPlayer or LocalPlayer.DevEnableMouseLock
        return UserInputService.MouseEnabled and UserInputService.KeyboardEnabled and bool1
    end
    local availabilitySignal = AvailabilitySignal.new((available()))

    availabilitySignal:connect(function(bool1: boolean)
        if bool1 then
            arg1:set(bool1)
        end
    end, true)

    if LocalPlayer then
        LocalPlayer.Changed:Connect(function(property: string)
            if property == "DevEnableMouseLock" then
                availabilitySignal:set((available()))
            end
        end)
    end

    UserInputService.Changed:Connect(function(property: string)
        if property == "MouseEnabled" or property == "KeyboardEnabled" then
            availabilitySignal:set((available()))
        end
    end)

    return availabilitySignal
end

local availability = ShiftLockAvailability(onChanged, visibilitySignal)

return {
    id = "shift-lock",
    field_type = SettingEnum.Toggle,
    label = "CoreScripts.InGameMenu.GameSettings.ShiftLock",
    alreadyLocalized = false,
    onChanged = onChanged,
    availability = availability,
    visibility = visibilitySignal,
    layoutOrder = LAYOUT_ORDER.ShiftLockFrame
}
