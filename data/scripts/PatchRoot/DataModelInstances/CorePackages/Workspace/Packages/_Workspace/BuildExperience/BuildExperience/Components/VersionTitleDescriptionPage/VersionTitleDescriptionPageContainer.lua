-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:21:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)

local VersionTitleDescriptionPageView = require(script.Parent.VersionTitleDescriptionPageView)
local useVersionTitleDescriptionPageViewModel = require(script.Parent.useVersionTitleDescriptionPageViewModel)

local function VersionTitleDescriptionPageContainer(arg1)
    local var1 = useVersionTitleDescriptionPageViewModel(arg1)
    return React.createElement(VersionTitleDescriptionPageView, var1)
end

return VersionTitleDescriptionPageContainer
