-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:01:17Z
-- Luau bytecode version: 14 | Luau type version: 3
local CrossExperienceVoice = script:FindFirstAncestor("CrossExperienceVoice")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local CrossExperienceVoiceParent = CrossExperienceVoice.Parent

local SocialLuaAnalytics = require(CrossExperienceVoiceParent.SocialLuaAnalytics)

local AnalyticsFactory = SocialLuaAnalytics.Analytics.AnalyticsFactory
local DefaultAnalyticsService = SocialLuaAnalytics.Analytics.DefaultAnalyticsService

local EventNames = require(script.EventNames)
local EventStreamActionList = require(script.EventStreamActionList)
local DiagActionList = require(script.DiagActionList)
local TelemetryActionList = require(script.TelemetryActionList)

local playSessionId = RbxAnalyticsService:GetPlaySessionId()

local staticInfoForAllEvents = { playSessionId = 0, placeId = 0, universeId = 0 }
if playSessionId == "" then
    playSessionId = nil
end

staticInfoForAllEvents.playSessionId = playSessionId
local var1 = if game.PlaceId > 0 then tostring(game.PlaceId) else nil
staticInfoForAllEvents.placeId = var1
local var2 = if game.GameId > 0 then tostring(game.GameId) else nil
staticInfoForAllEvents.universeId = var2

return {
    Analytics = AnalyticsFactory.setUpAnalyticsFactory({
        eventLists = {
            EventStream = EventStreamActionList,
            Diag = DiagActionList,
            Telemetry = TelemetryActionList
        },
        analyticsImpl = {
            EventStream = DefaultAnalyticsService.EventStream,
            Diag = DefaultAnalyticsService.Diag,
            Telemetry = DefaultAnalyticsService.Telemetry
        },
        staticInfoForAllEvents = staticInfoForAllEvents
    }),
    EventNames = EventNames
}
