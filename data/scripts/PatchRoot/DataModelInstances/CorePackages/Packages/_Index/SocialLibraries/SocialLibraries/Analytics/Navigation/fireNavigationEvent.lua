-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:41:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local fireEventStream = require(script.Parent.Parent.FireEvent.fireEventStream)
local fireDiagCounter = require(script.Parent.Parent.FireEvent.fireDiagCounter)
local DiagEventList = require(script.Parent.DiagEventList)
local EventStreamEventList = require(script.Parent.EventStreamEventList)
local _Types = require(script.Parent.Parent.FireEvent.Types)

return function(tbl1)
    local var1 = fireEventStream({
        eventStreamImpl = tbl1.analytics.EventStream,
        eventList = EventStreamEventList,
        loggerImpl = tbl1.loggerImpl,
        infoForAllEvents = tbl1.infoForAllEvents
    })
    local var2 = fireDiagCounter({ diagImpl = tbl1.analytics.Diag, eventList = DiagEventList, loggerImpl = tbl1.loggerImpl })

    return function(arg1, arg2): DateTime
        if EventStreamEventList[arg1] then
            var1(arg1, arg2)
        end

        if DiagEventList[arg1] then
            var2(arg1)
        end

        return DateTime.now()
    end
end
