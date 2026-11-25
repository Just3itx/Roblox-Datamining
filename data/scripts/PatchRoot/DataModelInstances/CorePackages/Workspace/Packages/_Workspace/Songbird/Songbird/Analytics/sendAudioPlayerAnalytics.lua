-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:51:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Songbird = script:FindFirstAncestor("Songbird")

local LoggingProtocol = require(Songbird.Parent.LoggingProtocol)
local _AnalyticActions = require(Songbird.Analytics.AnalyticActions)

local getFIntSongbirdTelemetryThrottle = require(Songbird.Flags.getFIntSongbirdTelemetryThrottle)

local tbl1 = {
    eventName = "AudioPlayerEvents",
    backends = { LoggingProtocol.TelemetryBackends.EventIngest },
    throttlingPercentage = getFIntSongbirdTelemetryThrottle(),
    lastUpdated = { 25, 10, 24 },
    description = " Analytics for AudioPlayer component to track playback, favoriting, and reporting flows ",
    links = ""
}

local function createCounterEventConfig(action: string)
    return {
        eventName = `{tbl1.eventName}_{action}`,
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = tbl1.throttlingPercentage,
        lastUpdated = tbl1.lastUpdated,
        description = tbl1.description,
        links = tbl1.links
    }
end

local function sendAudioPlayerAnalytics(tbl2)
    local counterEventConfig = createCounterEventConfig(tbl2.action)

    LoggingProtocol.default:logRobloxTelemetryEvent(tbl1, nil, tbl2)
    LoggingProtocol.default:logRobloxTelemetryCounter(counterEventConfig, 1)
end

return sendAudioPlayerAnalytics
