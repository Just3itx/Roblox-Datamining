-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
local UserSearchParent = script:FindFirstAncestor("UserSearch").Parent

local SocialLuaAnalytics = require(UserSearchParent.SocialLuaAnalytics)

local AnalyticsFactory = SocialLuaAnalytics.Analytics.AnalyticsFactory
local DefaultAnalyticsService = SocialLuaAnalytics.Analytics.DefaultAnalyticsService

local EventStreamActionList = require(script.Parent.EventStreamActionList)
local DiagEventsList = require(script.Parent.DiagEventsList)

return AnalyticsFactory.setUpAnalyticsFactory({
    eventLists = { EventStream = EventStreamActionList, Diag = DiagEventsList },
    analyticsImpl = {
        EventStream = DefaultAnalyticsService.EventStream,
        Diag = DefaultAnalyticsService.Diag
    }
})
