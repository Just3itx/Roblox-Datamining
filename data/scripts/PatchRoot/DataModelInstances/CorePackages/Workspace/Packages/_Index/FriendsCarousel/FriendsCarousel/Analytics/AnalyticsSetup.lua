-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T14:10:46Z
-- Luau bytecode version: 14 | Luau type version: 3
local FriendsCarouselParent = script:FindFirstAncestor("FriendsCarousel").Parent

local SocialLuaAnalytics = require(FriendsCarouselParent.SocialLuaAnalytics)
local AnalyticsFactory = SocialLuaAnalytics.Analytics.AnalyticsFactory
local DefaultAnalyticsService = SocialLuaAnalytics.Analytics.DefaultAnalyticsService

local EventStreamActionList = require(script.Parent.EventStreamActionList)
local DiagActionList = require(script.Parent.DiagActionList)

return AnalyticsFactory.setUpAnalyticsFactory({
    eventLists = { EventStream = EventStreamActionList, Diag = DiagActionList },
    analyticsImpl = {
        EventStream = DefaultAnalyticsService.EventStream,
        Diag = DefaultAnalyticsService.Diag
    }
})
