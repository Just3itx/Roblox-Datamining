-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:11:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)
local Foundation = require(BuildExperienceParent.Foundation)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization

local View = Foundation.View
local FoundationText = Foundation.Text
local Skeleton = Foundation.Skeleton
local Radius = Foundation.Enums.Radius

local AnalyticsKeys = require(BuildExperience.Analytics.AnalyticsKeys)
local DataStatus = require(BuildExperienceParent.DataHydration.CreatorAnalytics).DataStatus
local _AnalyticsMetric = require(BuildExperience.Analytics.AnalyticsMetric)
local _AnalyticsWindow = require(BuildExperience.Analytics.AnalyticsWindow)
local useExperienceMetricSeries = require(BuildExperience.Analytics.useExperienceMetricSeries)
local FFlagBuildAnalyticsCreatorHubWindowFix = require(BuildExperience.Flags.FFlagBuildAnalyticsCreatorHubWindowFix)
local MetricChart = require(script.Parent.MetricChart)
local PLOT_HEIGHT = require(BuildExperienceParent.AnalyticsMetricChart).chartLayout.PLOT_HEIGHT

local function MetricChartSkeleton(tbl1)
    return React.createElement(
        View,
        {
            LayoutOrder = tbl1.layoutOrder,
            tag = "col gap-xsmall size-full-0 auto-y",
            testId = "MetricChart.Skeleton"
        },
        {
            Title = React.createElement(Skeleton, { LayoutOrder = 1, radius = Radius.Small, Size = UDim2.new(0.4, 0, 0, 22) }),
            Summary = React.createElement(Skeleton, { LayoutOrder = 2, radius = Radius.Small, Size = UDim2.new(0.6, 0, 0, 16) }),
            Value = React.createElement(Skeleton, { LayoutOrder = 3, radius = Radius.Small, Size = UDim2.new(0.25, 0, 0, 32) }),
            Plot = React.createElement(Skeleton, { LayoutOrder = 4, radius = Radius.Medium, Size = UDim2.new(1, 0, 0, PLOT_HEIGHT) })
        }
    )
end

local function MetricChartEmpty(tbl1)
    return React.createElement(
        View,
        {
            LayoutOrder = tbl1.layoutOrder,
            tag = "col gap-xsmall size-full-0 auto-y",
            testId = "MetricChart.Empty"
        },
        {
            Message = React.createElement(
                FoundationText,
                {
                    Text = tbl1.message,
                    tag = "size-full-0 auto-y text-body-medium text-align-x-left content-muted"
                }
            )
        }
    )
end

local function MetricChartContainer(tbl1)
    local latestAvailableTime = if tbl1.metadataStatus == DataStatus.Failed then nil else tbl1.latestAvailableTime
    local var1 = useExperienceMetricSeries(tbl1.universeId, tbl1.metric, tbl1.window, latestAvailableTime)

    local noData = useLocalization({ noData = AnalyticsKeys.ANALYTICS_NO_DATA }).noData

    if tbl1.metadataStatus == DataStatus.Failed or tbl1.metadataStatus == DataStatus.Ready and tbl1.latestAvailableTime == nil then
        return React.createElement(MetricChartEmpty, { layoutOrder = tbl1.layoutOrder, message = noData })
    elseif var1.status == DataStatus.NotReady then
        return React.createElement(MetricChartSkeleton, { layoutOrder = tbl1.layoutOrder })
    elseif if FFlagBuildAnalyticsCreatorHubWindowFix then not var1.hasData else var1.status == DataStatus.Failed or not var1.hasData then
        return React.createElement(MetricChartEmpty, { layoutOrder = tbl1.layoutOrder, message = noData })
    end

    return React.createElement(MetricChart, {
        series = var1.series,
        hasData = var1.hasData,
        latest = var1.latest,
        trendPct = var1.trendPct,
        priorValue = var1.priorValue,
        metric = tbl1.metric,
        window = tbl1.window,
        latestAvailableTime = latestAvailableTime,
        hideIcon = tbl1.hideIcon,
        summary = tbl1.summary,
        layoutOrder = tbl1.layoutOrder
    })
end

return MetricChartContainer
