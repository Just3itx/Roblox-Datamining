-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:51:15Z
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
    eventName = "NowPlayingChromeWindowAnalytics",
    backends = { LoggingProtocol.TelemetryBackends.EventIngest },
    throttlingPercentage = getFIntSongbirdTelemetryThrottle(),
    lastUpdated = { 24, 12, 10 },
    description = " Now Playing Chrome Window UI related analytics ",
    links = "https://roblox.atlassian.net/wiki/x/I4Fcqw"
}

local function sendChromeWindowAnalytics(arg1)
    local tbl2 = {
        placeid = tostring(game.PlaceId),
        sessionid = RbxAnalyticsService:GetSessionId(),
        universeid = tostring(game.GameId)
    }

    local var1 = Cryo.Dictionary.join(arg1, tbl2)

    default:logRobloxTelemetryEvent(tbl1, nil, var1)

    return nil
end

return sendChromeWindowAnalytics
