-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T18:50:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")

local AnalyticsKeys = require(BuildExperience.Analytics.AnalyticsKeys)
local AnalyticsUnit = require(BuildExperience.Analytics.AnalyticsUnit)

return {
    templateFor = function(arg1)
        if arg1 == AnalyticsUnit.Percent then
            return AnalyticsKeys.ANALYTICS_PERCENT_TEMPLATE
        end

        if arg1 == AnalyticsUnit.Minutes then
            return AnalyticsKeys.ANALYTICS_DURATION_MINUTES_TEMPLATE
        end

        if arg1 == AnalyticsUnit.Temporal then
            return AnalyticsKeys.ANALYTICS_DURATION_TEMPLATE
        end

        return nil
    end,
    fillTemplate = function(str1: string, str2: string)
        return (string.gsub(str1, "{number}", function()
            return str2
        end))
    end
}
