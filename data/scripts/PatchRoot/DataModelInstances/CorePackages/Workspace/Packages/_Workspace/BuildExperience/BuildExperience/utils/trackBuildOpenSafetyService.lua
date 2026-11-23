-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:20:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)
local buildUIVisibility = require(BuildExperience.utils.buildUIVisibility)

local function trackBuildOpenSafetyService(bool1: boolean)
    React.useEffect(function()
        if not bool1 then
            return nil
        end

        buildUIVisibility.acquire()
        return function()
            buildUIVisibility.release()
        end
    end, { bool1 })
end

return trackBuildOpenSafetyService
