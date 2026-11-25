-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:01:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local Dash = require(scriptParentParentParentParent.Dash)

local _Types = require(script.Parent.Parent.Types)
local getEventInfo = require(script.Parent.getEventInfo)
local optionallyLog = require(script.Parent.optionallyLog)

local reportCounter = require(script.Parent.reportCounter)

local function func1(arg1)
    return "Fired diagCounter: " .. arg1.name .. ", count: " .. (arg1.count and tostring(arg1.count) or "1")
end

return function(tbl1)
    return function(arg1)
        return Dash.pipe(getEventInfo(tbl1.eventList), optionallyLog(tbl1.loggerImpl, func1), reportCounter(tbl1.diagImpl))(arg1)
    end
end
