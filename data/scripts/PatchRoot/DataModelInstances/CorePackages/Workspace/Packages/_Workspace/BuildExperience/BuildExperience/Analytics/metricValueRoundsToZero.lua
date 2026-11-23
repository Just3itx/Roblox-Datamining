-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T18:50:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")

local _AnalyticsUnit = require(BuildExperience.Analytics.AnalyticsUnit)
local formatStatNumber = require(BuildExperience.Analytics.formatStatNumber)

local function metricValueRoundsToZero(num1: number, arg1, arg2, str1: string): boolean
    return formatStatNumber(math.abs(num1), arg1, arg2, str1) == formatStatNumber(0, arg1, arg2, str1)
end

return metricValueRoundsToZero
