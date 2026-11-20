-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:00:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local MetricChart = require(script.Components.MetricChart.MetricChart)
local _MetricChartTypes = require(script.Components.MetricChart.MetricChartTypes)
local MetricChartView = require(script.Components.MetricChart.MetricChartView)
local chartLayout = require(script.Components.MetricChart.chartLayout)
return {
    MetricChart = MetricChart,
    MetricChartView = MetricChartView,
    deriveChartAxes = require(script.Utils.deriveChartAxes),
    chartLayout = chartLayout,
    ["jest.config"] = script["jest.config"]
}
