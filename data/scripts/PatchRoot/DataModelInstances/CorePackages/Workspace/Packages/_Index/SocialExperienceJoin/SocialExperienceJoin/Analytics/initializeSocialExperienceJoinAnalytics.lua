-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:50:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialExperienceJoinParent = script:FindFirstAncestor("SocialExperienceJoin").Parent

local SocialLuaAnalytics = require(SocialExperienceJoinParent.SocialLuaAnalytics)
local AnalyticsFactory = SocialLuaAnalytics.Analytics.AnalyticsFactory
local DefaultAnalyticsService = SocialLuaAnalytics.Analytics.DefaultAnalyticsService

local getEventStreamActionList = require(script.Parent.getEventStreamActionList)
local TelemetryActionList = require(script.Parent.TelemetryActionList)

return function(arg1)
    local eventStream = getEventStreamActionList(arg1)
    return AnalyticsFactory.setUpAnalyticsFactory({
        eventLists = { EventStream = eventStream, Telemetry = TelemetryActionList },
        analyticsImpl = {
            EventStream = DefaultAnalyticsService.EventStream,
            Telemetry = DefaultAnalyticsService.Telemetry
        }
    })()
end
