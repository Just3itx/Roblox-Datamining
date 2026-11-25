-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:10:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLuaAnalytics = script:FindFirstAncestor("SocialLuaAnalytics")

local DiagEventTypes = require(SocialLuaAnalytics.Analytics.Enums).DiagEventTypes
local getPlatformSuffix = require(script.Parent.getPlatformSuffix)

local _Types = require(script.Parent.Parent.Types)

return function(tbl1)
    return function(arg1)
        local str1 = `{arg1.name}{getPlatformSuffix(arg1.platformSpecificity)}`

        if arg1.type == DiagEventTypes.Stats then
            tbl1:reportStats(str1, arg1.value)
        else
            tbl1:reportCounter(str1, arg1.value)
        end

        return arg1
    end
end
