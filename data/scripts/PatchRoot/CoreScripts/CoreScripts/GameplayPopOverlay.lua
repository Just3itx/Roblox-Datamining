-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:31:22Z
-- Luau bytecode version: 14 | Luau type version: 3
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")

local React = require(CorePackages.Packages.React)
local ReactRoblox = require(CorePackages.Packages.ReactRoblox)
local PopLatencyOverlay = require(CorePackages.Workspace.Packages.PopLatencyOverlay)
local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)

local GameplayPopOverlay = Instance.new("Folder")
GameplayPopOverlay.Name = "GameplayPopOverlay"
GameplayPopOverlay.Parent = CoreGui

local root = ReactRoblox.createRoot(GameplayPopOverlay)
local var1 = if SharedFlags.FFlagEnableGameplayPopLatencyOverlay then PopLatencyOverlay.gameplay else PopLatencyOverlay.gameplayAdminOnly
root:render(React.createElement(var1, { experienceService = game:GetService("ExperienceService") }))
