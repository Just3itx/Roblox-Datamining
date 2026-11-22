-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:30:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfileQRCodeParent = script:FindFirstAncestor("ProfileQRCode").Parent
local SocialLuaAnalytics = require(ProfileQRCodeParent.SocialLuaAnalytics)

local DiagActionList = require(script.Parent.DiagActionList)
local fireEventStream = SocialLuaAnalytics.Analytics.FireEvent.fireEventStream
local fireDiagCounter = SocialLuaAnalytics.Analytics.FireEvent.fireDiagCounter
local EventStreamActionList = require(script.Parent.EventStreamActionList)

return function(tbl1)
    local var1 = fireEventStream({
        eventStreamImpl = tbl1.analytics.EventStream,
        eventList = EventStreamActionList,
        infoForAllEvents = tbl1.infoForAllEvents
    })

    local var2 = fireDiagCounter({ diagImpl = tbl1.analytics.Diag, eventList = DiagActionList })

    return function(arg1, arg2)
        if DiagActionList[arg1] then
            var2(arg1)
        end

        return var1(arg1, arg2)
    end
end
