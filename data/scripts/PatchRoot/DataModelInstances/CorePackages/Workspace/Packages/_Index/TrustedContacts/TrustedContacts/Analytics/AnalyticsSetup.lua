-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T00:51:13Z
-- Luau bytecode version: 14 | Luau type version: 3
local TrustedContactsParent = script:FindFirstAncestor("TrustedContacts").Parent

local SocialLuaAnalytics = require(TrustedContactsParent.SocialLuaAnalytics)
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
