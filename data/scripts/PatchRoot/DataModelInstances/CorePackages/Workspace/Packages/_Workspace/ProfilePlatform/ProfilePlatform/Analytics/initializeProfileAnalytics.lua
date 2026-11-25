-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:40:42Z
-- Luau bytecode version: 14 | Luau type version: 3
local ProfilePlatformParent = script:FindFirstAncestor("ProfilePlatform").Parent

local SocialLuaAnalytics = require(ProfilePlatformParent.SocialLuaAnalytics)
local AnalyticsFactory = SocialLuaAnalytics.Analytics.AnalyticsFactory
local DefaultAnalyticsService = SocialLuaAnalytics.Analytics.DefaultAnalyticsService

local EventStreamActionList = require(script.Parent.EventStreamActionList)
local TelemetryActionList = require(script.Parent.TelemetryActionList)

return AnalyticsFactory.setUpAnalyticsFactory({
    eventLists = { EventStream = EventStreamActionList, Telemetry = TelemetryActionList },
    analyticsImpl = {
        EventStream = DefaultAnalyticsService.EventStream,
        Telemetry = DefaultAnalyticsService.Telemetry
    }
})
