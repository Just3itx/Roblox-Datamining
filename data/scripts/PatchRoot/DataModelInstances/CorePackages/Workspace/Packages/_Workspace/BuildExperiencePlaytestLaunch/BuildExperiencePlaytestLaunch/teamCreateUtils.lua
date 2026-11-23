-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:04:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperiencePlaytestLaunch = script:FindFirstAncestor("BuildExperiencePlaytestLaunch")
local FFlagBuildExperienceLibrary = require(BuildExperiencePlaytestLaunch.Parent.SharedFlags).FFlagBuildExperienceLibrary

return {
    isViewer = function(arg1)
        local var1 = arg1 or game
        return FFlagBuildExperienceLibrary
            and var1:GetEngineFeature("IsTeamCreateViewerEnabled")
            and var1:GetService("RunService"):IsTeamCreateViewer()
    end
}
