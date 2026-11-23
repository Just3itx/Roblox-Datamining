-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:31:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local SocialLuaAnalytics = require(scriptParentParentParent.SocialLuaAnalytics)

local fireDiagCounter = SocialLuaAnalytics.Analytics.FireEvent.fireDiagCounter
local fireEventStream = SocialLuaAnalytics.Analytics.FireEvent.fireEventStream
local fireTelemetry = SocialLuaAnalytics.Analytics.FireEvent.fireTelemetry

local DiagActionList = require(script.Parent.DiagActionList)
local _EventNames = require(script.Parent.EventNames)
local EventStreamActionList = require(script.Parent.EventStreamActionList)
local TelemetryActionList = require(script.Parent.TelemetryActionList)

return function(tbl1)
    local var1 = fireEventStream({
        eventStreamImpl = tbl1.analytics.EventStream,
        eventList = EventStreamActionList,
        infoForAllEvents = tbl1.infoForAllEvents
    })

    local var2 = fireDiagCounter({ diagImpl = tbl1.analytics.Diag, eventList = DiagActionList })

    local var3 = fireTelemetry({ telemetryImpl = tbl1.analytics.Telemetry, eventList = TelemetryActionList })

    return function(arg1, arg2)
        if DiagActionList[arg1] then
            var2(arg1)
        end

        if TelemetryActionList[arg1] then
            var3(arg1, arg2)
        end

        if EventStreamActionList[arg1] then
            var1(arg1, arg2)
        end
    end
end
