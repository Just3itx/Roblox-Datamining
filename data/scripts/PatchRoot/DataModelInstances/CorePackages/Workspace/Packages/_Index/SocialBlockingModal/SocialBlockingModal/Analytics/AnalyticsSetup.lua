-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T16:41:23Z
-- Luau bytecode version: 14 | Luau type version: 3
local SocialBlockingModalParent = script:FindFirstAncestor("SocialBlockingModal").Parent

local SocialLuaAnalytics = require(SocialBlockingModalParent.SocialLuaAnalytics)
local DefaultAnalyticsService = SocialLuaAnalytics.Analytics.DefaultAnalyticsService
local AnalyticsFactory = SocialLuaAnalytics.Analytics.AnalyticsFactory

local TelemetryActionList = require(script.Parent.TelemetryActionList)

return AnalyticsFactory.setUpAnalyticsFactory(
    {
        eventLists = { Telemetry = TelemetryActionList },
        analyticsImpl = {
            Telemetry = DefaultAnalyticsService.Telemetry
        }
    }
)
