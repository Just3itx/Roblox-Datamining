-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfileBackgroundParent = script:FindFirstAncestor("EditProfileBackground").Parent
local AnalyticsFactory = require(EditProfileBackgroundParent.SocialLuaAnalytics).Analytics.AnalyticsFactory

local DiagActionList = require(script.Parent.DiagActionList)
local EventStreamActionList = require(script.Parent.EventStreamActionList)
local TelemetryActionList = require(script.Parent.TelemetryActionList)

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
