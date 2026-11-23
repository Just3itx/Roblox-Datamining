-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T18:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local _CreatorAnalytics = require(BuildExperienceParent.DataHydration.CreatorAnalytics)
local AnalyticsMetric = require(BuildExperience.Analytics.AnalyticsMetric)
local _AnalyticsWindow = require(BuildExperience.Analytics.AnalyticsWindow)
local useExperienceMetricSeries = require(BuildExperience.Analytics.useExperienceMetricSeries)

local function useOverviewStats(num1: number, arg1, arg2)
    local function latestFor(arg3) -- Luacid: Inlined by compiler; 6 call sites recovered
        return if arg2 == nil then nil else arg2[arg3.id]
    end

    local var1 = useExperienceMetricSeries(num1, AnalyticsMetric.DailyActiveUsers, arg1, (latestFor(AnalyticsMetric.DailyActiveUsers)))

    local var2 = useExperienceMetricSeries(num1, AnalyticsMetric.TotalPlaytime, arg1, (latestFor(AnalyticsMetric.TotalPlaytime)))

    local var3 = useExperienceMetricSeries(num1, AnalyticsMetric.PlaythroughRate, arg1, (latestFor(AnalyticsMetric.PlaythroughRate)))

    local var4 = useExperienceMetricSeries(num1, AnalyticsMetric.D1Retention, arg1, (latestFor(AnalyticsMetric.D1Retention)))

    local var5 = useExperienceMetricSeries(num1, AnalyticsMetric.PayerConversion, arg1, (latestFor(AnalyticsMetric.PayerConversion)))

    local var6 = useExperienceMetricSeries(num1, AnalyticsMetric.Arppu, arg1, (latestFor(AnalyticsMetric.Arppu)))

    return {
        [AnalyticsMetric.DailyActiveUsers.id] = var1,
        [AnalyticsMetric.TotalPlaytime.id] = var2,
        [AnalyticsMetric.PlaythroughRate.id] = var3,
        [AnalyticsMetric.D1Retention.id] = var4,
        [AnalyticsMetric.PayerConversion.id] = var5,
        [AnalyticsMetric.Arppu.id] = var6
    }
end

return useOverviewStats
