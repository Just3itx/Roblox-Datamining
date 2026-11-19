-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:40:57Z
-- Luau bytecode version: 14 | Luau type version: 3
local CorePackages = game:GetService("CorePackages")

local FFlagEnableInExperienceHandheldControls = require(CorePackages.Workspace.Packages.SharedFlags).FFlagEnableInExperienceHandheldControls

local Chrome = script.Parent.Parent.Parent.Chrome
local FFlagUnibarMenuOpenHamburger = require(Chrome.Flags.FFlagUnibarMenuOpenHamburger)
local FFlagUnibarMenuOpenSubmenu = require(Chrome.Flags.FFlagUnibarMenuOpenSubmenu)

return FFlagUnibarMenuOpenHamburger or FFlagUnibarMenuOpenSubmenu or FFlagEnableInExperienceHandheldControls
