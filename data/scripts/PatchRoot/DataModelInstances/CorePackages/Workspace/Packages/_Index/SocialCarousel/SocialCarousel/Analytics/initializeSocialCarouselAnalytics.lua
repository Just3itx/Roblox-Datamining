-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T17:51:17Z
-- Luau bytecode version: 14 | Luau type version: 3
local SocialCarouselParent = script:FindFirstAncestor("SocialCarousel").Parent

local SocialLuaAnalytics = require(SocialCarouselParent.SocialLuaAnalytics)
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
