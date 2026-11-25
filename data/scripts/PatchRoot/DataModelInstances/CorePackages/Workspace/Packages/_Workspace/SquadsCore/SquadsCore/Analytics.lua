-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:40:56Z
-- Luau bytecode version: 14 | Luau type version: 3
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local SquadsCoreParent = script:FindFirstAncestor("SquadsCore").Parent

local SocialLuaAnalytics = require(SquadsCoreParent.SocialLuaAnalytics)

local AnalyticsFactory = SocialLuaAnalytics.Analytics.AnalyticsFactory
local DefaultAnalyticsService = SocialLuaAnalytics.Analytics.DefaultAnalyticsService

local EventNames = require(script.EventNames)
local EventStreamActionList = require(script.EventStreamActionList)

local playSessionId = RbxAnalyticsService:GetPlaySessionId()

local staticInfoForAllEvents = {
    playSessionId = 0,
    placeId = 0,
    universeId = 0,
    placeInstanceId = 0
}

if playSessionId == "" then
    playSessionId = nil
end

staticInfoForAllEvents.playSessionId = playSessionId
local var1 = if game.PlaceId > 0 then tostring(game.PlaceId) else nil
staticInfoForAllEvents.placeId = var1
local var2 = if game.GameId > 0 then tostring(game.GameId) else nil
staticInfoForAllEvents.universeId = var2
local var3 = if game.JobId == "" then nil else tostring(game.JobId)
staticInfoForAllEvents.placeInstanceId = var3

return {
    Analytics = AnalyticsFactory.setUpAnalyticsFactory({
        eventLists = { EventStream = EventStreamActionList, Diag = nil },
        analyticsImpl = {
            EventStream = DefaultAnalyticsService.EventStream,
            Diag = nil
        },
        staticInfoForAllEvents = staticInfoForAllEvents
    }),
    EventNames = EventNames,
    logInExpCoplayTelemetry = require(script.logInExpCoplayTelemetry)
}
