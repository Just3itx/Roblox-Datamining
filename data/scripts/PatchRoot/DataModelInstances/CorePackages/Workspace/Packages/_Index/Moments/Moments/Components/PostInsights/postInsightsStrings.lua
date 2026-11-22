-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:41:15Z
-- Luau bytecode version: 14 | Luau type version: 3
local MENU_KEYS = table.freeze({ analytics = "Feature.Moments.Action.Analytics" })

local PAGE_KEYS = table.freeze({
    title = "Feature.Moments.PostInsights.Stats",
    overview = "Feature.Moments.Label.Overview",
    engagement = "Feature.Moments.Label.Engagement",
    totalViews = "Feature.Moments.Label.TotalViews",
    averageWatchTime = "Feature.Moments.Label.AverageWatchTime",
    averageCompletion = "Feature.Moments.Label.AverageCompletion",
    gameJoinConversion = "Feature.Moments.Label.GameJoinConversion",
    totalReactions = "Feature.Moments.Label.TotalReactions"
})

local TOOLTIP_KEYS = table.freeze({ title = "Feature.Moments.Tooltip.PostInsightsTitle", text = "Feature.Moments.Tooltip.PostInsightsBody" })

return table.freeze({
    MENU_KEYS = MENU_KEYS,
    PAGE_KEYS = PAGE_KEYS,
    TOOLTIP_KEYS = TOOLTIP_KEYS,
    DURATION_SECONDS_KEY = "Feature.Moments.Label.DurationSeconds",
    PERCENT_KEY = "Feature.Build.Analytics.Percent",
    POSTED_ON_DATE_KEY = "Feature.Moments.Label.PostedOnDate"
})
