-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T16:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local SocialLuaAnalytics = require(scriptParentParent.dependencies).SocialLuaAnalytics

local TelemetryActionList = require(script.Parent.TelemetryActionList)
local DiagActionList = require(script.Parent.DiagActionList)
local EventStreamActionList = require(script.Parent.EventStreamActionList)
local AnalyticsFactory = SocialLuaAnalytics.Analytics.AnalyticsFactory

return function(tbl1)
    return AnalyticsFactory.setUpAnalyticsFactory({
        eventLists = {
            EventStream = EventStreamActionList,
            Diag = DiagActionList,
            Telemetry = TelemetryActionList
        },
        analyticsImpl = tbl1.analytics
    })(
        tbl1
    ).fireAnalyticsEvent
end
