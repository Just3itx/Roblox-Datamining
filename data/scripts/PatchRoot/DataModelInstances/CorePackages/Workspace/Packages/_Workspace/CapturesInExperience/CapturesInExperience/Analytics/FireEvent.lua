-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:31:26Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent

local Players = game:GetService("Players")

local AnalyticsService = require(scriptParentParent.Analytics.AnalyticsService)
local Constants = require(scriptParentParent.Constants)
local getLocalUserId = require(scriptParentParent.Utils.getLocalUserId)
return (require(scriptParentParent.Analytics.setupFireEvent)({
    analytics = AnalyticsService,
    infoForAllEvents = {
        isUnder13 = if Players.LocalPlayer then Players.LocalPlayer:GetUnder13() else nil,
        pid = tostring(game.PlaceId),
        source = Constants.AnalyticsSource,
        uid = getLocalUserId(Players)
    }
}))
