-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DiscoveryAnalyticsParent = script:FindFirstAncestor("DiscoveryAnalytics").Parent

local ArgCheck = require(DiscoveryAnalyticsParent.ArgCheck)

local num1 = game:DefineFastInt("LuaAppJoinGameFailureInfluxHundredthsPercentage", 0)

return function(arg1, arg2, arg3)
    ArgCheck.isType(arg2, "string", "documentName")
    arg1:reportSeries(arg2, arg3 or {}, num1)
end
