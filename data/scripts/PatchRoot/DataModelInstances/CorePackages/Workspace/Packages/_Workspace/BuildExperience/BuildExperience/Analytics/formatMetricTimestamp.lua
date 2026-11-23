-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T18:41:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local _CreatorAnalytics = require(BuildExperienceParent.DataHydration.CreatorAnalytics)

local function formatMetricTimestamp(str1: string, arg1, tbl1): string
    local _, var1, var2, var3, var4 = string.match(str1, "(%d+)%-(%d+)%-(%d+)T(%d+):(%d+):%d+")
    if var1 == nil then
        return str1
    elseif arg1 == "OneMinute" or arg1 == "HalfHour" or arg1 == "OneHour" then
        return `{var3}:{var4}`
    end

    return `{tbl1[tonumber(var1)] or var1} {tonumber(var2)}`
end

return formatMetricTimestamp
