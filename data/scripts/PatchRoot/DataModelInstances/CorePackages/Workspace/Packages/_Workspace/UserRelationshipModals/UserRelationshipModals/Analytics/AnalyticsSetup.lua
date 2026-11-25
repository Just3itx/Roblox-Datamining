-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:10:53Z
-- Luau bytecode version: 14 | Luau type version: 3
local UserRelationshipModalsParent = script:FindFirstAncestor("UserRelationshipModals").Parent

local SocialLuaAnalytics = require(UserRelationshipModalsParent.SocialLuaAnalytics)
local AnalyticsFactory = SocialLuaAnalytics.Analytics.AnalyticsFactory
local DefaultAnalyticsService = SocialLuaAnalytics.Analytics.DefaultAnalyticsService

local TelemetryActionList = require(script.Parent.TelemetryActionList)

return AnalyticsFactory.setUpAnalyticsFactory(
    {
        eventLists = { Telemetry = TelemetryActionList },
        analyticsImpl = {
            Telemetry = DefaultAnalyticsService.Telemetry
        }
    }
)
