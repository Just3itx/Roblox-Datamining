-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T18:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")

local AnalyticsUnit = require(BuildExperience.Analytics.AnalyticsUnit)

local function scaleValueToUnit(num1: number, temporal): number
    return if temporal == AnalyticsUnit.Temporal then num1 * 60 else num1
end

return scaleValueToUnit
