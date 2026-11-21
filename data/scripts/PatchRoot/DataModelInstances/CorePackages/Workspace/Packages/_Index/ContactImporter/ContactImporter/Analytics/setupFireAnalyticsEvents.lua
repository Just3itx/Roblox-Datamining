-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:20:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local SocialLuaAnalytics = require(scriptParentParent.dependencies).SocialLuaAnalytics

local EventNames = require(script.Parent.Enums.EventNames)
local fireReportStats = require(script.Parent.fireReportStats)
local fireEventStream = SocialLuaAnalytics.Analytics.FireEvent.fireEventStream
local fireDiagCounter = SocialLuaAnalytics.Analytics.FireEvent.fireDiagCounter
local AnalyticsEvents = require(script.Parent.AnalyticsEvents)
local DiagEvents = require(script.Parent.DiagEvents)

return function(tbl1)
    local var1 = fireEventStream({
        eventStreamImpl = if tbl1.analytics then tbl1.analytics.EventStream else tbl1.eventStreamImpl,
        eventList = AnalyticsEvents,
        infoForAllEvents = tbl1.defaultAnalyticsInfo
    })

    local var2 = fireDiagCounter({ diagImpl = if tbl1.analytics then tbl1.analytics.Diag else tbl1.diag, eventList = DiagEvents })

    local var3 = fireReportStats({ diagImpl = if tbl1.analytics then tbl1.analytics.Diag else tbl1.diag, eventList = DiagEvents })

    return function(contactImportingTime, arg1)
        if DiagEvents[contactImportingTime] then
            if contactImportingTime == EventNames.ContactImportingTime then
                var3(EventNames.ContactImportingTime, arg1)
            else
                var2(contactImportingTime)
            end
        end

        if AnalyticsEvents[contactImportingTime] then
            var1(contactImportingTime, arg1)
        end
    end
end
