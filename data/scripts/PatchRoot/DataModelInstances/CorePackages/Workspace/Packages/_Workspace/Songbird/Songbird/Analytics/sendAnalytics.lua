-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:51:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Songbird = script:FindFirstAncestor("Songbird")

local RbxAnalyticsService = game:GetService("RbxAnalyticsService")

local Cryo = require(Songbird.Parent.Cryo)
local LoggingProtocol = require(Songbird.Parent.LoggingProtocol)

local _types = require(Songbird.types)

local getFIntSongbirdTelemetryThrottle = require(Songbird.Flags.getFIntSongbirdTelemetryThrottle)

local default = LoggingProtocol.default

local tbl1 = {
    eventName = "NowPlayingPeekAnalytics",
    backends = { LoggingProtocol.TelemetryBackends.EventIngest },
    throttlingPercentage = getFIntSongbirdTelemetryThrottle(),
    lastUpdated = { 24, 30, 9 },
    description = " Peek UI related analytics ",
    links = "https://roblox.atlassian.net/l/cp/VLpzDBz5"
}

local function sendAnalytics(arg1)
    local tbl2 = {
        placeid = tostring(game.PlaceId),
        sessionid = RbxAnalyticsService:GetSessionId(),
        universeid = tostring(game.GameId)
    }

    local var1 = Cryo.Dictionary.join(arg1, tbl2)

    default:logRobloxTelemetryEvent(tbl1, nil, var1)

    return nil
end

return sendAnalytics
