-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:41:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DiscoveryAnalyticsParent = script:FindFirstAncestor("DiscoveryAnalytics").Parent

local Url = require(DiscoveryAnalyticsParent.Http).Url

return function(arg1, str1: string)
    return arg1(string.format("%sv1/sponsored-games/click", Url.ADS_URL), "POST", { postBody = "\"" .. str1 .. "\"" })
end
