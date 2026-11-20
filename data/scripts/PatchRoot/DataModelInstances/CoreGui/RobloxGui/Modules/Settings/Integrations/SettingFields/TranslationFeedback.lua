-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:10:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local CorePackages = game:GetService("CorePackages")
local RunService = game:GetService("RunService")
local Settings = script:FindFirstAncestor("Settings")
local ExperienceStateCaptureService = game:GetService("ExperienceStateCaptureService")
local SafetyService = game:GetService("SafetyService")

local Constants = require(Settings.Integrations.Constants)
local SettingsService = require(CorePackages.Workspace.Packages.SettingsService)
local ValueChangedSignal = SettingsService.ValueChangedSignal
local AvailabilitySignal = SettingsService.AvailabilitySignal
local SettingEnum = SettingsService.SettingEnum

local isEnabled = require(RobloxGui.Modules.TenFootInterface):IsEnabled()

local LAYOUT_ORDER = Constants.GAMESETTINGS.LAYOUT_ORDER

local function TranslationFeedbackValue() -- Luacid: Inlined by compiler; 1 call site recovered
    local valueChangedSignal = ValueChangedSignal.new()

    valueChangedSignal:connect(function()
        if game:GetEngineFeature("ExperienceStateCaptureMinMemEnabled") and not ExperienceStateCaptureService:CanEnterCaptureMode() then
            return
        end

        local settingsHub = require(script.Parent.Parent.Parent.SettingsHub)
        if settingsHub then
            settingsHub:SetVisibility(false)
        end

        if game:GetEngineFeature("SafetyServiceCaptureModeReportProp") then
            SafetyService.IsCaptureModeForReport = false
        end
        if game:GetEngineFeature("CaptureModeEnabled") then
            ExperienceStateCaptureService:ToggleCaptureMode()
        end
    end)

    return valueChangedSignal
end

local function TranslationFeedbackAvailability() -- Luacid: Inlined by compiler; 1 call site recovered
    local availabilitySignal = AvailabilitySignal.new(true)

    if RunService:IsStudio() or game:GetEngineFeature("CaptureModeEnabled") == false or isEnabled then
        availabilitySignal:set(false)
    end

    return availabilitySignal
end

local onActivated = TranslationFeedbackValue()
local availability = TranslationFeedbackAvailability()
return {
    field_type = SettingEnum.TextButton,
    id = "translation-feedback",
    onActivated = onActivated,
    label = "CoreScripts.InGameMenu.GameSettings.GiveTranslationFeedback",
    text = "CoreScripts.InGameMenu.GameSettings.GiveFeedback",
    layoutOrder = LAYOUT_ORDER.FeedbackModeButton,
    alreadyLocalized = false,
    availability = availability
}
