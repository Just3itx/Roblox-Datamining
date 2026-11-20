-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AnalyticsMetricChart = script:FindFirstAncestor("AnalyticsMetricChart")
local AnalyticsMetricChartParent = AnalyticsMetricChart.Parent

local Foundation = require(AnalyticsMetricChartParent.Foundation)
local React = require(AnalyticsMetricChartParent.React)
local ReactRoblox = require(AnalyticsMetricChartParent.Dev.ReactRoblox)

local FoundationProvider = Foundation.FoundationProvider
local ColorMode = Foundation.Enums.ColorMode
local Device = Foundation.Enums.Device

local tbl1 = {
    Light = ColorMode.Light,
    Dark = ColorMode.Dark
}

return {
    name = "AnalyticsMetricChart",
    roact = React,
    reactRoblox = ReactRoblox,
    mapStory = function(arg1)
        return function(arg2)
            return React.createElement(FoundationProvider, {
                colorMode = tbl1[arg2.theme],
                device = Device[arg2.platform],
                preferences = arg2.settings,
                scale = arg2.settings and arg2.settings.scale
            }, {
                Child = React.createElement(arg1, arg2)
            })
        end
    end,
    storyRoots = { AnalyticsMetricChart }
}
