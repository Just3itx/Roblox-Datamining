-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:11:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local LocalizationService = game:GetService("LocalizationService")

local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization

local DataStatus = require(BuildExperienceParent.DataHydration.CreatorAnalytics).DataStatus
local _AnalyticsWindow = require(BuildExperience.Analytics.AnalyticsWindow)
local _GoalTypes = require(BuildExperience.Analytics.Goals.GoalTypes)
local useGoalMetricSummary = require(BuildExperience.Analytics.Goals.useGoalMetricSummary)
local AnalyticsUnit = require(BuildExperience.Analytics.AnalyticsUnit)
local formatStatNumber = require(BuildExperience.Analytics.formatStatNumber)
local FFlagBuildAnalyticsTwoDecimalPlaces = require(BuildExperience.Flags.FFlagBuildAnalyticsTwoDecimalPlaces)
local metricValueRoundsToZero = require(BuildExperience.Analytics.metricValueRoundsToZero)
local roundToDecimals = require(BuildExperience.Analytics.roundToDecimals)
local scaleValueToUnit = require(BuildExperience.Analytics.scaleValueToUnit)
local metricUnitTemplate = require(BuildExperience.Analytics.metricUnitTemplate)
local noDataPlaceholder = require(BuildExperience.Components.Analytics.noDataPlaceholder)

local _GoalMetricRowView = require(script.Parent.GoalMetricRowView)

local function getNumberValueText(summary, arg1): {template: any, type: string, values: {number: any}} | {type: string, value: any}
    local robloxLocaleId = LocalizationService.RobloxLocaleId
    local var1 = formatStatNumber(arg1.value, summary.format.unit, "Regular", robloxLocaleId)
    local template = metricUnitTemplate.templateFor(summary.format.unit)

    return if template == nil then { type = "raw", value = var1 } else {
        type = "translationTemplate",
        template = template,
        values = { number = var1 }
    }
end

local function getBreakdownValueText(summary, arg1)
    local format = summary.format
    if format.type == "custom" then
        return {
            type = "raw",
            value = format.formatter(arg1.metric, arg1.breakdown)
        }
    end
    local key = format.translationKeyFor(arg1.metric, arg1.breakdown)
    return if key == nil then { type = "empty" } else { type = "translationKey", key = key }
end

local function getNumberDelta(summary, arg1)
    local robloxLocaleId = LocalizationService.RobloxLocaleId
    local priorValue = arg1.priorValue
    local trendPct = arg1.trendPct

    if priorValue == nil or trendPct == nil then
        return nil
    end

    if metricValueRoundsToZero(scaleValueToUnit(priorValue, summary.format.unit), summary.format.unit, nil, robloxLocaleId)
        or metricValueRoundsToZero(trendPct, AnalyticsUnit.Percent, nil, robloxLocaleId)
    then
        return nil
    end

    local num1 = if FFlagBuildAnalyticsTwoDecimalPlaces then 2 else 1
    local magnitude = roundToDecimals(math.abs(trendPct) * 100, num1) / 100
    return if magnitude == 0 then nil else {
        magnitude = magnitude,
        isPositive = trendPct > 0
    }
end

local function getDeltaValueText(tbl1): {template: any, type: string, values: {number: any}} | {type: string, value: any}
    local robloxLocaleId = LocalizationService.RobloxLocaleId
    local var1 = formatStatNumber(tbl1.magnitude, AnalyticsUnit.Percent, "Regular", robloxLocaleId)
    local template = metricUnitTemplate.templateFor(AnalyticsUnit.Percent)

    return if template == nil then { type = "raw", value = var1 } else {
        type = "translationTemplate",
        template = template,
        values = { number = var1 }
    }
end

local function buildLocalizationRequest(tbl1)
    local localizationRequest = ({})
    for value, value2 in tbl1 do
        if value2.type == "translationTemplate" then
            local tbl2 = { value2.template }
            for value3, value4 in value2.values do
                tbl2[value3] = value4
            end
            localizationRequest[value] = tbl2
        elseif value2.type == "translationKey" then
            localizationRequest[value] = value2.key
        end
    end

    return localizationRequest
end

local function useGoalMetricRowViewModel(tbl1)
    local summary = tbl1.summary
    local var1 = useGoalMetricSummary(tbl1.universeId, summary.source, tbl1.window, tbl1.latestAvailableTime)
    local value = var1.value

    local bool1 = tbl1.latestAvailableTime ~= nil
    local isLoading = tbl1.metadataStatus == DataStatus.NotReady
        or tbl1.metadataStatus == DataStatus.Ready and bool1 and var1.status == DataStatus.NotReady
    local var2 = nil
    if value == nil then
        var2 = { type = "empty" }
    elseif summary.kind == "number" then
        var2 = getNumberValueText(summary, value)
    elseif summary.kind == "breakdown" then
        var2 = getBreakdownValueText(summary, value)
    end

    local numberDelta = if value == nil or summary.kind ~= "number" then nil else getNumberDelta(summary, value)
    local deltaText = numberDelta == nil and { type = "empty" } or getDeltaValueText(numberDelta)

    local var4 = useLocalization((buildLocalizationRequest({ valueText = var2, deltaText = deltaText })))
    local valueText = if var2.type == "empty" then noDataPlaceholder elseif var2.type == "raw" then var2.value else var4.valueText
    local var6 = nil
    if deltaText.type == "raw" then
        var6 = deltaText.value
    elseif deltaText.type ~= "empty" then
        var6 = var4.deltaText
    end

    return {
        title = tbl1.title,
        valueText = valueText,
        icon = if summary.kind == "number" then summary.icon else nil,
        deltaText = var6,
        isDeltaPositive = not (numberDelta == nil) and numberDelta.isPositive,
        isLoading = isLoading,
        layoutOrder = tbl1.layoutOrder,
        testId = tbl1.testId
    }
end

return useGoalMetricRowViewModel
