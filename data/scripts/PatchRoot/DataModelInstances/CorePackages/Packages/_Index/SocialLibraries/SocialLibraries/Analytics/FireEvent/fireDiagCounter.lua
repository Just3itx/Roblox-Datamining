-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _Types = require(script.Parent.Types)
local getEventInfo = require(script.Parent.getEventInfo)
local optionallyLog = require(script.Parent.optionallyLog)
local compose = require(script.Parent.Parent.Parent.RoduxTools.compose)
local reportCounter = require(script.Parent.reportCounter)

local function func1(arg1)
    return "Fired diagCounter: " .. arg1.name .. ", count: " .. (arg1.count and tostring(arg1.count) or "1")
end

return function(tbl1)
    return function(arg1)
        return compose(reportCounter(tbl1.diagImpl), optionallyLog(tbl1.loggerImpl, func1), getEventInfo(tbl1.eventList))(arg1)
    end
end
