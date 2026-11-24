-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:31:38Z
-- Luau bytecode version: 14 | Luau type version: 3
local GroupsParent = script:FindFirstAncestor("Groups").Parent

local SocialLuaAnalytics = require(GroupsParent.SocialLuaAnalytics)
local AnalyticsFactory = SocialLuaAnalytics.Analytics.AnalyticsFactory
local DefaultAnalyticsService = SocialLuaAnalytics.Analytics.DefaultAnalyticsService

local EventStreamActionList = require(script.Parent.EventStreamActionList)

return AnalyticsFactory.setUpAnalyticsFactory({
    eventLists = { EventStream = EventStreamActionList },
    analyticsImpl = {
        EventStream = DefaultAnalyticsService.EventStream
    }
})
