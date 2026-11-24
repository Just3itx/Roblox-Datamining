-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:31:29Z
-- Luau bytecode version: 14 | Luau type version: 3
local CreatorAnalyticsStoreTypes = require(script.CreatorAnalyticsStoreTypes)
local _GoalMilestonesTypes = require(script.GoalMilestonesTypes)

return {
    createCreatorAnalyticsStore = require(script.createCreatorAnalyticsStore),
    getCreatorAnalyticsStore = require(script.getCreatorAnalyticsStore),
    createExperienceAnalyticsStore = require(script.createCreatorAnalyticsStore),
    getExperienceAnalyticsStore = require(script.getCreatorAnalyticsStore),
    createGoalMilestonesStore = require(script.createGoalMilestonesStore),
    getGoalMilestonesStore = require(script.getGoalMilestonesStore),
    MetricId = CreatorAnalyticsStoreTypes.MetricId,
    MetricGranularity = CreatorAnalyticsStoreTypes.MetricGranularity,
    FilterOperation = CreatorAnalyticsStoreTypes.FilterOperation,
    ResourceType = CreatorAnalyticsStoreTypes.ResourceType,
    DataStatus = CreatorAnalyticsStoreTypes.DataStatus
}
