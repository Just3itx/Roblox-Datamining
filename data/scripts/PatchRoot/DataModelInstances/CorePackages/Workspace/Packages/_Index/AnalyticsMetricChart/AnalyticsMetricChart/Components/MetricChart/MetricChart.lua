-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:00:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AnalyticsMetricChartParent = script:FindFirstAncestor("AnalyticsMetricChart").Parent

local React = require(AnalyticsMetricChartParent.React)

local _MetricChartTypes = require(script.Parent.MetricChartTypes)
local MetricChartView = require(script.Parent.MetricChartView)
local useMetricChartViewModel = require(script.Parent.useMetricChartViewModel)

local function MetricChart(arg1)
    local var1 = useMetricChartViewModel(arg1)
    return React.createElement(MetricChartView, var1)
end

return MetricChart
