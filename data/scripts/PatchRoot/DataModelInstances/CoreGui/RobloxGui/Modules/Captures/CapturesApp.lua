-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:21:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")

local RobloxGui = CoreGui:WaitForChild("RobloxGui")

local ChromeEnabled = require(CorePackages.Workspace.Packages.Chrome).Enabled

local CapturesInExperience = require(CorePackages.Workspace.Packages.CapturesInExperience)

local openCapturesGallery = require(script.Parent.openCapturesGallery)

local app = CapturesInExperience.App.createApp()

local ScreenshotsCarousel = Instance.new("ScreenGui")
ScreenshotsCarousel.DisplayOrder = CapturesInExperience.Constants.CarouselDisplayOrder
ScreenshotsCarousel.Name = "ScreenshotsCarousel"
ScreenshotsCarousel.ResetOnSpawn = false
ScreenshotsCarousel.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
ScreenshotsCarousel.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenshotsCarousel.Parent = CoreGui

local CaptureManager = Instance.new("ScreenGui")
CaptureManager.DisplayOrder = CapturesInExperience.Constants.CarouselDisplayOrder
CaptureManager.Name = "CaptureManager"
CaptureManager.ResetOnSpawn = false
CaptureManager.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
CaptureManager.Parent = CoreGui

local screenGui = Instance.new("ScreenGui")
screenGui.DisplayOrder = CapturesInExperience.Constants.OverlayDisplayOrder
screenGui.Name = CapturesInExperience.Constants.OverlayName
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = CoreGui

local MomentsCreationFlow = Instance.new("ScreenGui")
MomentsCreationFlow.DisplayOrder = CapturesInExperience.Constants.CreationFlowDisplayOrder
MomentsCreationFlow.Name = "MomentsCreationFlow"
MomentsCreationFlow.ResetOnSpawn = false
MomentsCreationFlow.ScreenInsets = Enum.ScreenInsets.None
MomentsCreationFlow.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
MomentsCreationFlow.Parent = CoreGui

app.mountCaptureManager(CaptureManager)
app.mountCarousel(ScreenshotsCarousel)

app.mountCoreUI(
    RobloxGui,
    ChromeEnabled(),
    CapturesInExperience.Flags.FFlagCapturesControlsGalleryButton and function() -- name: openGallery
        local settingsHub = require(RobloxGui.Modules.Settings.SettingsHub)
        return openCapturesGallery(settingsHub)
    end or nil
)
app.mountCaptureOverlay(screenGui)
app.mountMomentsCreationFlow(MomentsCreationFlow)

return app
