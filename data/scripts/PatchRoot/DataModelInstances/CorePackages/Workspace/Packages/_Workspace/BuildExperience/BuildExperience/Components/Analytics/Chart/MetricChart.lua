-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:11:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local AnalyticsMetricChart = require(BuildExperienceParent.AnalyticsMetricChart)
local React = require(BuildExperienceParent.React)

local useMetricChartContent = require(script.Parent.useMetricChartContent)
local useMetricChartViewModel = require(script.Parent.useMetricChartViewModel)
local FFlagBuildAnalyticsSharedMetricChart = require(BuildExperience.Flags.FFlagBuildAnalyticsSharedMetricChart)

local function MetricChart(arg1)
    if FFlagBuildAnalyticsSharedMetricChart then
        local var1 = useMetricChartContent(arg1)
        return React.createElement(AnalyticsMetricChart.MetricChart, var1)
    end

    local var1 = useMetricChartViewModel(arg1)
    return React.createElement(AnalyticsMetricChart.MetricChartView, var1)
end

return MetricChart
