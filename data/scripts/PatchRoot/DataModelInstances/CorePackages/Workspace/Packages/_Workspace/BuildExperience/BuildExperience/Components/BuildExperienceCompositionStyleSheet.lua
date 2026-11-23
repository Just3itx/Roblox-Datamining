-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:21:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local AppComposition = require(BuildExperienceParent.AppComposition)
local React = require(BuildExperienceParent.React)

local CompositionStyleSheet = AppComposition.CompositionStyleSheet

local function BuildExperienceCompositionStyleSheet()
    if CompositionStyleSheet then
        return (React.createElement(CompositionStyleSheet))
    end

    return nil
end

return BuildExperienceCompositionStyleSheet
