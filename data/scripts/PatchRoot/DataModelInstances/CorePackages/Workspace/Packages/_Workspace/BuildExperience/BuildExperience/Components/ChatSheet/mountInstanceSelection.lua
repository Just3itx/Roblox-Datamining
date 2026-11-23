-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:41:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local ExperienceStateCaptureService = game:GetService("ExperienceStateCaptureService")
local UserInputService = game:GetService("UserInputService")

local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local ReactRoblox = require(BuildExperienceParent.ReactRoblox)

local BuildExperienceCompositionStyleSheet = require(BuildExperience.Components.BuildExperienceCompositionStyleSheet)
local InstanceSelectionShell = require(script.Parent.InstanceSelectionShell)

local function isTouchInput(): boolean
    return UserInputService.PreferredInput == Enum.PreferredInput.Touch
end

local function mountInstanceSelection()
    local experienceStateCaptureSelectionMode = Enum.ExperienceStateCaptureSelectionMode
    if experienceStateCaptureSelectionMode ~= nil then
        ExperienceStateCaptureService.SelectionMode = experienceStateCaptureSelectionMode.SafetyHighlightMode
    end
    if game:GetEngineFeature("ExperienceStateCaptureHiddenSelection") then
        ExperienceStateCaptureService.HiddenSelectionEnabled = true
    end

    local buildExperienceInstanceSelection = Instance.new("ScreenGui")
    buildExperienceInstanceSelection.Name = "BuildExperienceInstanceSelection"
    buildExperienceInstanceSelection.ClipToDeviceSafeArea = false
    buildExperienceInstanceSelection.DisplayOrder = 9
    buildExperienceInstanceSelection.IgnoreGuiInset = true
    buildExperienceInstanceSelection.ResetOnSpawn = false
    buildExperienceInstanceSelection.SafeAreaCompatibility = Enum.SafeAreaCompatibility.None
    buildExperienceInstanceSelection.ScreenInsets = Enum.ScreenInsets.None
    buildExperienceInstanceSelection.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    buildExperienceInstanceSelection.Parent = CoreGui

    local root = ReactRoblox.createRoot(buildExperienceInstanceSelection)
    root:render(
        React.createElement(Foundation.FoundationProvider, {
            colorMode = Foundation.Enums.ColorMode.Dark
        }, {
            CompositionStyleSheet = React.createElement(BuildExperienceCompositionStyleSheet),
            Shell = React.createElement(
                InstanceSelectionShell,
                {
                    itemSelected = ExperienceStateCaptureService.ItemSelectedInCaptureMode,
                    isTouchInput = isTouchInput
                }
            )
        })
    )
    return root
end

return mountInstanceSelection
