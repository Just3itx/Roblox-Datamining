-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:01:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLuaAnalyticsParent = script:FindFirstAncestor("SocialLuaAnalytics").Parent

local getPlatformTarget = require(SocialLuaAnalyticsParent.Analytics).getPlatformTarget

return function(arg1)
    return function(_, str1: string, str2: string, tbl1)
        arg1:sendEventDeferred(getPlatformTarget(), str1, str2, tbl1)
    end
end
