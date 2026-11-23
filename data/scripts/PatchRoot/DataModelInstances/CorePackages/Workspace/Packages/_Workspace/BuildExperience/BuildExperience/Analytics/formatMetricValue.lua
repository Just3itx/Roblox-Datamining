-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T18:41:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local NumberLocalization = require(BuildExperienceParent.Localization).NumberLocalization

local AnalyticsUnit = require(BuildExperience.Analytics.AnalyticsUnit)
local formatStatNumber = require(BuildExperience.Analytics.formatStatNumber)
local fillTemplate = require(BuildExperience.Analytics.metricUnitTemplate).fillTemplate

local function formatNumber(num1: number, arg1, str1: string, str2: string?)
    if str2 ~= "Full" then
        return formatStatNumber(num1, arg1, "Abbreviated", str1)
    end

    if arg1 == AnalyticsUnit.Percent then
        return NumberLocalization.localizeDecimal(num1 * 100, str1, 2)
    end

    if arg1 == AnalyticsUnit.Temporal then
        return NumberLocalization.localizeDecimal(num1 / 60, str1, 2)
    end

    local num2 = if num1 == math.floor(num1) then 0 else 2
    return NumberLocalization.localizeDecimal(num1, str1, num2)
end

local function formatMetricValue(num1: number, arg1, str1: string, arg2, str2: string?)
    local var1 = formatNumber(num1, arg1, str1, str2)
    if arg1 == AnalyticsUnit.Percent then
        return fillTemplate(arg2.percent, var1)
    elseif arg1 == AnalyticsUnit.Temporal or arg1 == AnalyticsUnit.Minutes then
        return fillTemplate(arg2.duration, var1)
    end
    return var1
end

return formatMetricValue
