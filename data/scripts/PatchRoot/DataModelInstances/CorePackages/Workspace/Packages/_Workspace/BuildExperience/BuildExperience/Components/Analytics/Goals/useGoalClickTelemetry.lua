-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:11:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)

local AnalyticsEventContext = require(BuildExperience.Analytics.AnalyticsEventContext)
local AnalyticsPageEvents = require(BuildExperience.Analytics.AnalyticsPageEvents)
local FFlagBuildExperienceEventContextTelemetry = require(BuildExperience.Flags.FFlagBuildExperienceEventContextTelemetry)

local function useGoalClickTelemetry(num1: number)
    local var1 = if FFlagBuildExperienceEventContextTelemetry then React.useContext(AnalyticsEventContext) else nil

    return React.useCallback(function(str1: string)
        AnalyticsPageEvents.goalClick(num1, str1, var1)
    end, { num1, var1 })
end

return useGoalClickTelemetry
