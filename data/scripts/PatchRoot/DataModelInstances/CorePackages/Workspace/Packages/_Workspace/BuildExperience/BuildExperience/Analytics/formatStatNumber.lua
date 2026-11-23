-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T18:50:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local NumberLocalization = require(BuildExperienceParent.Localization).NumberLocalization

local AnalyticsUnit = require(BuildExperience.Analytics.AnalyticsUnit)
local roundToDecimals = require(BuildExperience.Analytics.roundToDecimals)
local FFlagBuildAnalyticsTwoDecimalPlaces = require(BuildExperience.Flags.FFlagBuildAnalyticsTwoDecimalPlaces)

local function formatNumber(num1: number, str1: string?, str2: string)
    if str1 == "Regular" then
        return NumberLocalization.localizeDecimal(num1, str2, 2)
    elseif FFlagBuildAnalyticsTwoDecimalPlaces then
        return NumberLocalization.abbreviateDecimal(num1, str2, 2)
    end
    return NumberLocalization.abbreviate(num1, str2)
end

local function formatStatNumber(num1: number, arg1, str1: string?, str2: string)
    if arg1 == AnalyticsUnit.Minutes then
        return NumberLocalization.localizeDecimal(num1, str2, 2)
    end

    if arg1 == AnalyticsUnit.Percent then
        return formatNumber(num1 * 100, str1, str2)
    end

    if arg1 ~= AnalyticsUnit.Temporal then
        return formatNumber(num1, str1, str2)
    end

    local num2 = num1 / 60
    if not (math.abs(num2) < 1) then
        return formatNumber(roundToDecimals(num2, if FFlagBuildAnalyticsTwoDecimalPlaces then 2 else 1), str1, str2)
    end

    local var1 = roundToDecimals(num2, 2)
    return NumberLocalization.localizeDecimal(var1, str2, 2)
end

return formatStatNumber
