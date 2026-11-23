-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T18:50:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local _CreatorAnalytics = require(BuildExperienceParent.DataHydration.CreatorAnalytics)
local _AnalyticsMetric = require(BuildExperience.Analytics.AnalyticsMetric)
local _AnalyticsWindow = require(BuildExperience.Analytics.AnalyticsWindow)
local FFlagBuildAnalyticsGoals = require(BuildExperience.Flags.FFlagBuildAnalyticsGoals)

local function getMetricQueryParams(universeId: number, arg1, arg2, endTime: string)
    return {
        universeId = universeId,
        metric = arg1.id,
        granularity = arg2.granularity,
        lookbackSeconds = arg2.lookbackSeconds * 2,
        endTime = endTime,
        filters = if FFlagBuildAnalyticsGoals then arg1.filters else nil
    }
end

return getMetricQueryParams
