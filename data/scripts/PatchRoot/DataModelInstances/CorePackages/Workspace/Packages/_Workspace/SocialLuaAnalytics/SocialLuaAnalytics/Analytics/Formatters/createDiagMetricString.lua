-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:10:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLuaAnalytics = script:FindFirstAncestor("SocialLuaAnalytics")
local SocialLuaAnalyticsParent = SocialLuaAnalytics.Parent

local Cryo = require(SocialLuaAnalyticsParent.Cryo)
local EventTypes = require(SocialLuaAnalytics.Analytics.Enums).EventTypes

local function createDiagMetricString(str1: string?, tbl1): string
    local var1 = str1 or EventTypes.LoadingTime
    local tbl2 = tbl1 or {}

    return table.concat(Cryo.Dictionary.values({ var1, tbl2.fetch, if tbl2.nextPage then "nextPage" else nil, tbl2.status }), "_")
end

return createDiagMetricString
