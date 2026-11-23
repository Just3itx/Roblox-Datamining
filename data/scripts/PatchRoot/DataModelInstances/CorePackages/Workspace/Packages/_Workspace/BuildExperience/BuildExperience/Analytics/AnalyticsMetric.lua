-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T18:41:28Z
-- Luau bytecode version: 14 | Luau type version: 3
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)

local AnalyticsKeys = require(BuildExperience.Analytics.AnalyticsKeys)
local CreatorAnalytics = require(BuildExperienceParent.DataHydration.CreatorAnalytics)
local AnalyticsUnit = require(BuildExperience.Analytics.AnalyticsUnit)
local FFlagBuildAnalyticsGoals = require(BuildExperience.Flags.FFlagBuildAnalyticsGoals)
local MetricId = CreatorAnalytics.MetricId
local IconName = Foundation.Enums.IconName

local DailyActiveUsers = {
    id = MetricId.DailyActiveUsers,
    titleKey = if FFlagBuildAnalyticsGoals then AnalyticsKeys.ANALYTICS_OVERVIEW_METRIC_TITLE_DAILY_ACTIVE_USERS else AnalyticsKeys.ANALYTICS_METRIC_TITLE_DAILY_ACTIVE_USERS,
    unit = AnalyticsUnit.Scalar,
    chartIcon = IconName.ThreePeople,
    summaryKey = if FFlagBuildAnalyticsGoals then AnalyticsKeys.ANALYTICS_METRIC_SUMMARY_AVERAGE_OVER_SELECTED_PERIOD else AnalyticsKeys.ANALYTICS_METRIC_SUMMARY_DAILY_ACTIVE_USERS,
    descriptionKey = if FFlagBuildAnalyticsGoals then AnalyticsKeys.ANALYTICS_OVERVIEW_METRIC_DESC_DAILY_ACTIVE_USERS else AnalyticsKeys.ANALYTICS_METRIC_DESC_DAILY_ACTIVE_USERS,
    improvementKey = AnalyticsKeys.ANALYTICS_IMPROVE_DAILY_ACTIVE_USERS,
    analyzeNameKey = AnalyticsKeys.ANALYTICS_METRIC_ANALYZE_NAME_DAILY_ACTIVE_USERS,
    overviewPath = "analytics/engagement"
}

local TotalPlaytime = {
    id = MetricId.TotalPlayTimeHours,
    titleKey = AnalyticsKeys.ANALYTICS_METRIC_TITLE_TOTAL_PLAYTIME,
    unit = AnalyticsUnit.Temporal,
    chartIcon = IconName.Clock,
    summaryKey = AnalyticsKeys.ANALYTICS_METRIC_SUMMARY_TOTAL_PLAYTIME,
    descriptionKey = AnalyticsKeys.ANALYTICS_METRIC_DESC_TOTAL_PLAYTIME,
    analyzeNameKey = AnalyticsKeys.ANALYTICS_METRIC_ANALYZE_NAME_TOTAL_PLAYTIME,
    overviewPath = "analytics/engagement"
}

local PlaythroughRate = {
    id = MetricId.RFYPlayThroughRate,
    titleKey = AnalyticsKeys.ANALYTICS_METRIC_TITLE_PLAYTHROUGH_RATE,
    unit = AnalyticsUnit.Percent,
    chartIcon = IconName.CirclePlay,
    summaryKey = if FFlagBuildAnalyticsGoals then AnalyticsKeys.ANALYTICS_METRIC_SUMMARY_AVERAGE_OVER_SELECTED_PERIOD else AnalyticsKeys.ANALYTICS_METRIC_SUMMARY_PLAYTHROUGH_RATE,
    descriptionKey = AnalyticsKeys.ANALYTICS_METRIC_DESC_PLAYTHROUGH_RATE,
    analyzeNameKey = AnalyticsKeys.ANALYTICS_METRIC_ANALYZE_NAME_PLAYTHROUGH_RATE,
    overviewPath = "analytics/acquisition",
    requiredMilestone = "universe_first_home_recommendation_impression_achieved"
}

local D1Retention = {
    id = MetricId.ForwardD1Retention,
    titleKey = if FFlagBuildAnalyticsGoals then AnalyticsKeys.ANALYTICS_OVERVIEW_METRIC_TITLE_D1_RETENTION else AnalyticsKeys.ANALYTICS_METRIC_TITLE_D1_RETENTION,
    unit = AnalyticsUnit.Percent,
    chartIcon = IconName.ArrowRotateRight,
    summaryKey = if FFlagBuildAnalyticsGoals then AnalyticsKeys.ANALYTICS_METRIC_SUMMARY_AVERAGE_OVER_SELECTED_PERIOD else AnalyticsKeys.ANALYTICS_METRIC_SUMMARY_D1_RETENTION,
    descriptionKey = if FFlagBuildAnalyticsGoals then AnalyticsKeys.ANALYTICS_OVERVIEW_METRIC_DESC_D1_RETENTION else AnalyticsKeys.ANALYTICS_METRIC_DESC_D1_RETENTION,
    improvementKey = AnalyticsKeys.ANALYTICS_IMPROVE_D1_RETENTION,
    analyzeNameKey = AnalyticsKeys.ANALYTICS_METRIC_ANALYZE_NAME_D1_RETENTION,
    overviewPath = "analytics/retention"
}

local PayerConversion = {
    id = MetricId.PayingUsersCVR,
    titleKey = if FFlagBuildAnalyticsGoals then AnalyticsKeys.ANALYTICS_OVERVIEW_METRIC_TITLE_PAYER_CONVERSION else AnalyticsKeys.ANALYTICS_METRIC_TITLE_PAYER_CONVERSION,
    unit = AnalyticsUnit.Percent,
    chartIcon = IconName.PersonCheck,
    summaryKey = if FFlagBuildAnalyticsGoals then AnalyticsKeys.ANALYTICS_METRIC_SUMMARY_AVERAGE_OVER_SELECTED_PERIOD else AnalyticsKeys.ANALYTICS_METRIC_SUMMARY_PAYER_CONVERSION,
    descriptionKey = if FFlagBuildAnalyticsGoals then AnalyticsKeys.ANALYTICS_OVERVIEW_METRIC_DESC_PAYER_CONVERSION else AnalyticsKeys.ANALYTICS_METRIC_DESC_PAYER_CONVERSION,
    improvementKey = AnalyticsKeys.ANALYTICS_IMPROVE_PAYER_CONVERSION,
    analyzeNameKey = AnalyticsKeys.ANALYTICS_METRIC_ANALYZE_NAME_PAYER_CONVERSION,
    overviewPath = "analytics/monetization"
}

local Arppu = {
    id = MetricId.AverageRevenuePerPayingUser,
    titleKey = AnalyticsKeys.ANALYTICS_METRIC_TITLE_ARPPU,
    unit = AnalyticsUnit.Scalar,
    icon = IconName.Robux,
    chartIcon = IconName.Robux,
    summaryKey = AnalyticsKeys.ANALYTICS_METRIC_SUMMARY_ARPPU,
    descriptionKey = AnalyticsKeys.ANALYTICS_METRIC_DESC_ARPPU,
    analyzeNameKey = AnalyticsKeys.ANALYTICS_METRIC_ANALYZE_NAME_ARPPU,
    overviewPath = "analytics/monetization"
}

local NewUserSessionTime = {
    id = MetricId.AveragePlayTimeMinutesPerDAU,
    titleKey = if FFlagBuildAnalyticsGoals then AnalyticsKeys.ANALYTICS_OVERVIEW_METRIC_TITLE_NEW_USER_SESSION_TIME else AnalyticsKeys.ANALYTICS_METRIC_TITLE_NEW_USER_SESSION_TIME,
    summaryKey = AnalyticsKeys.ANALYTICS_METRIC_SUMMARY_AVERAGE_OVER_SELECTED_PERIOD,
    unit = AnalyticsUnit.Minutes,
    analyzeNameKey = if FFlagBuildAnalyticsGoals then AnalyticsKeys.ANALYTICS_OVERVIEW_METRIC_TITLE_NEW_USER_SESSION_TIME else AnalyticsKeys.ANALYTICS_METRIC_TITLE_NEW_USER_SESSION_TIME,
    descriptionKey = AnalyticsKeys.ANALYTICS_METRIC_DESC_NEW_USER_SESSION_TIME,
    improvementKey = AnalyticsKeys.ANALYTICS_IMPROVE_NEW_USER_SESSION_TIME,
    overviewPath = "analytics/engagement",
    filters = {{
        dimension = "IsNewUser",
        values = { "New" },
        operation = "Equals"
    }}
}
local D7Retention = {
    id = MetricId.ForwardD7Retention,
    titleKey = if FFlagBuildAnalyticsGoals then AnalyticsKeys.ANALYTICS_OVERVIEW_METRIC_TITLE_D7_RETENTION else AnalyticsKeys.ANALYTICS_METRIC_TITLE_D7_RETENTION,
    summaryKey = AnalyticsKeys.ANALYTICS_METRIC_SUMMARY_AVERAGE_OVER_SELECTED_PERIOD,
    unit = AnalyticsUnit.Percent,
    analyzeNameKey = if FFlagBuildAnalyticsGoals then AnalyticsKeys.ANALYTICS_OVERVIEW_METRIC_TITLE_D7_RETENTION else AnalyticsKeys.ANALYTICS_METRIC_TITLE_D7_RETENTION,
    descriptionKey = AnalyticsKeys.ANALYTICS_METRIC_DESC_D7_RETENTION,
    improvementKey = AnalyticsKeys.ANALYTICS_IMPROVE_D7_RETENTION,
    overviewPath = "analytics/retention"
}

local RobuxSpent = {
    id = MetricId.DailyRevenue,
    titleKey = if FFlagBuildAnalyticsGoals then AnalyticsKeys.ANALYTICS_OVERVIEW_METRIC_TITLE_ROBUX_SPENT else AnalyticsKeys.ANALYTICS_METRIC_TITLE_ROBUX_SPENT,
    summaryKey = AnalyticsKeys.ANALYTICS_METRIC_SUMMARY_AVERAGE_OVER_SELECTED_PERIOD,
    unit = AnalyticsUnit.Scalar,
    analyzeNameKey = if FFlagBuildAnalyticsGoals then AnalyticsKeys.ANALYTICS_OVERVIEW_METRIC_TITLE_ROBUX_SPENT else AnalyticsKeys.ANALYTICS_METRIC_TITLE_ROBUX_SPENT,
    descriptionKey = AnalyticsKeys.ANALYTICS_METRIC_DESC_ROBUX_SPENT,
    improvementKey = AnalyticsKeys.ANALYTICS_IMPROVE_ROBUX_SPENT,
    overviewPath = "analytics/monetization"
}

local OverviewMetrics = {
    DailyActiveUsers,
    TotalPlaytime,
    PlaythroughRate,
    D1Retention,
    PayerConversion,
    Arppu
}

local MetricById = {}
for _, value in OverviewMetrics do
    MetricById[value.id] = value
end

return {
    OverviewMetrics = OverviewMetrics,
    MetricById = MetricById,
    DailyActiveUsers = DailyActiveUsers,
    TotalPlaytime = TotalPlaytime,
    PlaythroughRate = PlaythroughRate,
    D1Retention = D1Retention,
    PayerConversion = PayerConversion,
    Arppu = Arppu,
    NewUserSessionTime = NewUserSessionTime,
    D7Retention = D7Retention,
    RobuxSpent = RobuxSpent
}
