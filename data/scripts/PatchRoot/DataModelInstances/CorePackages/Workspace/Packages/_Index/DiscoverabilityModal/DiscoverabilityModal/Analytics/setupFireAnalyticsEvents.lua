-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:11:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local SocialLuaAnalytics = require(scriptParentParent.dependencies).SocialLuaAnalytics

local DiagEvents = require(script.Parent.DiagEvents)
local fireEventStream = SocialLuaAnalytics.Analytics.FireEvent.fireEventStream
local fireDiagCounter = SocialLuaAnalytics.Analytics.FireEvent.fireDiagCounter
local AnalyticsEvents = require(script.Parent.AnalyticsEvents)

return function(tbl1)
    local var1 = fireEventStream({
        eventStreamImpl = if tbl1.analytics then tbl1.analytics.EventStream else tbl1.eventStreamImpl,
        eventList = AnalyticsEvents,
        infoForAllEvents = tbl1.defaultAnalyticsInfo
    })

    local var2 = fireDiagCounter({ diagImpl = if tbl1.analytics then tbl1.analytics.Diag else tbl1.diag, eventList = DiagEvents })

    return function(arg1, arg2)
        var2(arg1)
        var1(arg1, arg2)
    end
end
