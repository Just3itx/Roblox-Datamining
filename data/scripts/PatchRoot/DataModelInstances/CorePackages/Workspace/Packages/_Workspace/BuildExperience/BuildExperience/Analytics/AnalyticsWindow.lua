-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T18:41:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local CreatorAnalytics = require(BuildExperienceParent.DataHydration.CreatorAnalytics)
local AnalyticsKeys = require(BuildExperience.Analytics.AnalyticsKeys)
local MetricGranularity = CreatorAnalytics.MetricGranularity

local WindowId = { LastWeek = "LastWeek", LastMonth = "LastMonth" }

local function dailyWindow(id: string, labelKey: string, days: number, creatorHubRangeType: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    return {
        id = id,
        labelKey = labelKey,
        lookbackSeconds = days * 86400,
        days = days,
        granularity = MetricGranularity.OneDay,
        creatorHubRangeType = creatorHubRangeType
    }
end

local LastWeek = dailyWindow(WindowId.LastWeek, AnalyticsKeys.ANALYTICS_WINDOW_LAST_WEEK, 7, "Last7Days")
local LastMonth = dailyWindow(WindowId.LastMonth, AnalyticsKeys.ANALYTICS_WINDOW_LAST_MONTH, 28, "Last28Days")

local Windows = { LastMonth, LastWeek }

local WindowById = {}
for _, value in Windows do
    WindowById[value.id] = value
end

return {
    Windows = Windows,
    WindowById = WindowById,
    WindowId = WindowId,
    LastWeek = LastWeek,
    LastMonth = LastMonth,
    DEFAULT_WINDOW_ID = WindowId.LastWeek
}
