-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameJoinCard = script:FindFirstAncestor("GameJoinCard")
local GameJoinCardParent = GameJoinCard.Parent

local FFlagGameJoinCardAnalyticsCardId = require(GameJoinCardParent.SharedFlags).FFlagGameJoinCardAnalyticsCardId

local _Types = require(script.Parent.Types)
local _useGameJoinCardAnalytics = require(GameJoinCard.Analytics.useGameJoinCardAnalytics)

local function getTelemetryFields(arg1)
    local telemetry = arg1.telemetry
    local universeId = telemetry.universeId
    local tbl1 = {
        friendId = arg1.userId,
        universeId = 0,
        absolutePosition = 0,
        joinGameCardId = 0
    }

    if universeId == nil or universeId == "" then
        universeId = nil
    end

    tbl1.universeId = universeId
    tbl1.absolutePosition = telemetry.absolutePosition
    tbl1.joinGameCardId = if FFlagGameJoinCardAnalyticsCardId then telemetry.joinGameCardId else nil
    return tbl1
end

return getTelemetryFields
