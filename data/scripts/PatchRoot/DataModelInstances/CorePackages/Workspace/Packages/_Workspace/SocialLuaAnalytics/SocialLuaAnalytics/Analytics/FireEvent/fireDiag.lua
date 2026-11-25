-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:01:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLuaAnalyticsParent = script:FindFirstAncestor("SocialLuaAnalytics").Parent

local Dash = require(SocialLuaAnalyticsParent.Dash)

local _Types = require(script.Parent.Parent.Types)
local getEventInfo = require(script.Parent.getEventInfo)
local optionallyLog = require(script.Parent.optionallyLog)

local reportDiagEvent = require(script.Parent.reportDiagEvent)
local getFormattedDiagEventInfo = require(script.Parent.getFormattedDiagEventInfo)

local function func1(arg1): string
    return `Fired Diag {arg1.type}: {arg1.name}, {arg1.value}`
end

return function(tbl1)
    return function(arg1, arg2)
        return Dash.pipe(
            getEventInfo(tbl1.eventList),
            getFormattedDiagEventInfo(),
            reportDiagEvent(tbl1.diagImpl),
            optionallyLog(tbl1.loggerImpl, func1)
        )(
            arg1,
            arg2
        )
    end
end
