-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:11:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local LocalizationService = game:GetService("LocalizationService")

local _AnalyticsMetricChart = require(BuildExperienceParent.AnalyticsMetricChart)
local React = require(BuildExperienceParent.React)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization

local AnalyticsKeys = require(BuildExperience.Analytics.AnalyticsKeys)
local _CreatorAnalytics = require(BuildExperienceParent.DataHydration.CreatorAnalytics)
local _AnalyticsMetric = require(BuildExperience.Analytics.AnalyticsMetric)
local AnalyticsUnit = require(BuildExperience.Analytics.AnalyticsUnit)
local _AnalyticsWindow = require(BuildExperience.Analytics.AnalyticsWindow)
local fillMetricSeriesGaps = require(BuildExperience.Analytics.fillMetricSeriesGaps)
local formatMetricValue = require(BuildExperience.Analytics.formatMetricValue)
local formatMetricTimestamp = require(BuildExperience.Analytics.formatMetricTimestamp)
local metricValueRoundsToZero = require(BuildExperience.Analytics.metricValueRoundsToZero)
local _metricUnitTemplate = require(BuildExperience.Analytics.metricUnitTemplate)
local scaleValueToUnit = require(BuildExperience.Analytics.scaleValueToUnit)
local FFlagBuildAnalyticsGoals = require(BuildExperience.Flags.FFlagBuildAnalyticsGoals)

local noDataPlaceholder = require(BuildExperience.Components.Analytics.noDataPlaceholder)

local tbl1 = {
    AnalyticsKeys.ANALYTICS_MONTH_JAN,
    AnalyticsKeys.ANALYTICS_MONTH_FEB,
    AnalyticsKeys.ANALYTICS_MONTH_MAR,
    AnalyticsKeys.ANALYTICS_MONTH_APR,
    AnalyticsKeys.ANALYTICS_MONTH_MAY,
    AnalyticsKeys.ANALYTICS_MONTH_JUN,
    AnalyticsKeys.ANALYTICS_MONTH_JUL,
    AnalyticsKeys.ANALYTICS_MONTH_AUG,
    AnalyticsKeys.ANALYTICS_MONTH_SEP,
    AnalyticsKeys.ANALYTICS_MONTH_OCT,
    AnalyticsKeys.ANALYTICS_MONTH_NOV,
    AnalyticsKeys.ANALYTICS_MONTH_DEC
}

local function useMetricChartContent(tbl2)
    local robloxLocaleId = LocalizationService.RobloxLocaleId
    local metric = tbl2.metric

    local unit = metric.unit

    local tbl3 = {
        title = metric.titleKey,
        percent = AnalyticsKeys.ANALYTICS_PERCENT_TEMPLATE,
        duration = if FFlagBuildAnalyticsGoals and unit == AnalyticsUnit.Minutes then AnalyticsKeys.ANALYTICS_DURATION_MINUTES_TEMPLATE else AnalyticsKeys.ANALYTICS_DURATION_TEMPLATE
    }

    for value, value2 in tbl1 do
        tbl3["month" .. value] = value2
    end
    local var1 = useLocalization(tbl3)
    local title = var1.title
    local tbl4 = ({})
    for value, _ in tbl1 do
        tbl4[value] = var1["month" .. value]
    end
    local tbl5 = {
        percent = var1.percent,
        duration = var1.duration
    }

    local var2 = React.useMemo(function()
        local var2 = nil
        if tbl2.window ~= nil and tbl2.latestAvailableTime ~= nil then
            local dateTime = DateTime.fromIsoDate(tbl2.latestAvailableTime)
            var2 = dateTime ~= nil and {
                lookbackSeconds = tbl2.window.lookbackSeconds,
                endUnix = dateTime.UnixTimestamp
            } or var2
        end

        return fillMetricSeriesGaps(tbl2.series, var2)
    end, { tbl2.series, tbl2.window, tbl2.latestAvailableTime })

    local dataPoints = if var2 == nil then nil else var2.dataPoints
    local var3 = if var2 == nil then "None" else var2.granularity

    local var4 = scaleValueToUnit(tbl2.latest or 0, unit)
    local valueText = if tbl2.hasData and tbl2.latest ~= nil then formatMetricValue(var4, unit, robloxLocaleId, tbl5) else noDataPlaceholder
    local var6 = if tbl2.priorValue == nil then nil else scaleValueToUnit(tbl2.priorValue, unit)
    local bool1 = var6 == nil or not metricValueRoundsToZero(var6, unit, nil, robloxLocaleId)

    local var7 = nil
    local bool2 = false
    if tbl2.hasData then
        if bool1 then
            if not metricValueRoundsToZero(tbl2.trendPct, AnalyticsUnit.Percent, nil, robloxLocaleId) then
                var7 = formatMetricValue(math.abs(tbl2.trendPct), AnalyticsUnit.Percent, robloxLocaleId, tbl5)
                bool2 = tbl2.trendPct > 0
            end
        elseif not metricValueRoundsToZero(var4, unit, nil, robloxLocaleId) then
            var7 = formatMetricValue(var4, unit, robloxLocaleId, tbl5)
            if var4 > 0 then
                bool2 = true
            else
                bool2 = false
            end
        end
    end
    local module = {
        layoutOrder = tbl2.layoutOrder,
        plotId = metric.id,
        series = dataPoints ~= nil and {{
            id = metric.id,
            name = title,
            points = dataPoints
        }} or nil,
        hasData = tbl2.hasData,
        title = title,
        summary = tbl2.summary,
        valueText = valueText,
        icon = if tbl2.hideIcon then nil else metric.chartIcon or metric.icon,
        deltaText = var7,
        isDeltaPositive = bool2,
        yAxisFormatter = 0,
        xAxisFormatter = 0,
        tooltipFormatters = 0
    }

    function module.yAxisFormatter(tbl6)
        return formatMetricValue(scaleValueToUnit(tbl6.value, unit), unit, robloxLocaleId, tbl5)
    end
    function module.xAxisFormatter(tbl6)
        return formatMetricTimestamp(tbl6.value, var3, tbl4)
    end
    module.tooltipFormatters = {
        formatXForPoint = function(str1: string)
            return formatMetricTimestamp(str1, var3, tbl4)
        end,
        formatSeriesValueForPoint = function(tbl6)
            return formatMetricValue(scaleValueToUnit(tbl6.y, unit), unit, robloxLocaleId, tbl5, "Full")
        end
    }

    return module
end

return useMetricChartContent
