-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:01:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLuaAnalyticsParent = script:FindFirstAncestor("SocialLuaAnalytics").Parent

local fireEventStream = require(script.Parent.fireEventStream)
local fireDiag = require(script.Parent.fireDiag)
local fireTelemetry = require(script.Parent.fireTelemetry)
local _Types = require(script.Parent.Parent.Types)
local FFlagPymkCarouselExtendProps = require(SocialLuaAnalyticsParent.SharedFlags).FFlagPymkCarouselExtendProps

local function setupFireEvent(tbl1, tbl2): (T, U) -> (T, U)
    local var1

    if tbl1.analytics.EventStream and tbl2.EventStream then
        var1 = fireEventStream({
            eventStreamImpl = tbl1.analytics.EventStream,
            eventList = tbl2.EventStream,
            infoForAllEvents = tbl1.infoForAllEvents,
            getInfoForAllEvents = tbl1.getInfoForAllEvents,
            loggerImpl = tbl1.loggerImpl,
            context = if FFlagPymkCarouselExtendProps then tbl1.context else nil
        })
    else
        var1 = nil
    end

    local var2 = if tbl1.analytics.Diag and tbl2.Diag then fireDiag({ diagImpl = tbl1.analytics.Diag, eventList = tbl2.Diag, loggerImpl = tbl1.loggerImpl }) else nil
    local var3 = if tbl1.analytics.Telemetry and tbl2.Telemetry then fireTelemetry({
        telemetryImpl = tbl1.analytics.Telemetry,
        eventList = tbl2.Telemetry,
        getInfoForAllEvents = tbl1.getInfoForAllEvents,
        loggerImpl = tbl1.loggerImpl
    }) else nil

    return function<T, U>(arg1: T, arg2: U): (T, U)
        if var2 and tbl2.Diag and tbl2.Diag[arg1] then
            var2(arg1, arg2)
        end

        if var1 and tbl2.EventStream and tbl2.EventStream[arg1] then
            var1(arg1, arg2)
        end

        if var3 and tbl2.Telemetry and tbl2.Telemetry[arg1] then
            var3(arg1, arg2)
        end

        return arg1, arg2
    end
end

local function createFireEvent(tbl1)
    return function(tbl2)
        return (setupFireEvent(tbl2, tbl1))
    end
end

return createFireEvent
