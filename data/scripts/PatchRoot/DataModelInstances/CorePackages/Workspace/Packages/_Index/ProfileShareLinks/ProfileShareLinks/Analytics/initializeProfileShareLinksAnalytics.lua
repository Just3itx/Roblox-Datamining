-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:51:24Z
-- Luau bytecode version: 14 | Luau type version: 3
local EventIngestService = game:GetService("EventIngestService")

local ProfileShareLinksParent = script:FindFirstAncestor("ProfileShareLinks").Parent

local SocialLuaAnalytics = require(ProfileShareLinksParent.SocialLuaAnalytics)
local AnalyticsFactory = SocialLuaAnalytics.Analytics.AnalyticsFactory
local DefaultAnalyticsService = SocialLuaAnalytics.Analytics.DefaultAnalyticsService

local EventStreamActionList = require(script.Parent.EventStreamActionList)
local TelemetryActionList = require(script.Parent.TelemetryActionList)
local setupSendEventDeferred = require(script.Parent.setupSendEventDeferred)
local setupSetRbxEventStream = require(script.Parent.setupSetRbxEventStream)

return AnalyticsFactory.setUpAnalyticsFactory({
    eventLists = { EventStream = EventStreamActionList, Telemetry = TelemetryActionList },
    analyticsImpl = {
        EventStream = {
            sendEventDeferred = setupSendEventDeferred(EventIngestService),
            setRBXEventStream = setupSetRbxEventStream(EventIngestService)
        },
        Telemetry = DefaultAnalyticsService.Telemetry
    }
})
