-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:51:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")

local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)
local ReactRoblox = require(BuildExperienceParent.ReactRoblox)

local BuildEventReceiver = require(BuildExperience.BuildEventReceiver)

local function mountCreatorAgentResumeToastReceiver(isBuildModeActive: boolean)
    local buildEventReceiver = Instance.new("Folder")
    buildEventReceiver.Name = "BuildEventReceiver"
    buildEventReceiver.Parent = CoreGui

    local root = ReactRoblox.createRoot(buildEventReceiver)
    root:render(React.createElement(BuildEventReceiver, { isInExperience = true, isBuildModeActive = isBuildModeActive }))

    return root
end

return mountCreatorAgentResumeToastReceiver
