-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:00:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLuaAnalyticsParent = script:FindFirstAncestor("SocialLuaAnalytics").Parent

local Cryo = require(SocialLuaAnalyticsParent.Cryo)

local AnalyticsFactory = require(script.Parent.AnalyticsFactory)

local _Types = require(script.Parent.Parent.Types)

local function setUpAnalyticsFactory(tbl1)
    return function(tbl2)
        local infoForAllEvents = Cryo.Dictionary.join(tbl1.staticInfoForAllEvents or {}, tbl2 and tbl2.infoForAllEvents or {})

        return AnalyticsFactory(Cryo.Dictionary.join(tbl1, { infoForAllEvents = infoForAllEvents }))
    end
end

return setUpAnalyticsFactory
