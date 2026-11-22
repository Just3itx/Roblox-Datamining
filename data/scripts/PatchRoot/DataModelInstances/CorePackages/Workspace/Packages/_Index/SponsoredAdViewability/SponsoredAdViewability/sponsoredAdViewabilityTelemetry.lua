-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:41:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")

local _sponsoredAdViewabilityState = require(script.Parent.sponsoredAdViewabilityState)
local _sponsoredAdViewabilityTypes = require(script.Parent.sponsoredAdViewabilityTypes)

local standardizedFields = { "addSessionInfo", "addSessionId", "addOSInfo" }

local config = {
    eventName = "SponsoredAdLoad",
    backends = { "EventIngest", "Points" },
    throttlingPercentage = game:DefineFastInt("LuaAppSponsoredAdLoadTelemetryThrottlingHundredthsPercent", 0),
    lastUpdated = { 26, 6, 11 },
    description = "\t\tFires once per served sponsored ad when its tile begins to render on a surface.\n\t"
}

local config2 = {
    eventName = "SponsoredAdViewableImpression",
    backends = { "EventIngest", "Points" },
    throttlingPercentage = game:DefineFastInt("LuaAppSponsoredAdViewableImpressionTelemetryThrottlingHundredthsPercent", 0),
    lastUpdated = { 26, 6, 16 },
    description = "\t\t\tFires once per IAB viewable-impression milestone reached by a served sponsored ad\n\t\t\t(image: standard 50% / 1s, large 30% / 1s, full 100% / 1s;\n\t\t\tvideo: standard 50% / 2s while playing, full 100% / 1s while playing).\n\t\t"
}

local config3 = {
    eventName = "SponsoredAdUnload",
    backends = { "EventIngest", "Points" },
    throttlingPercentage = game:DefineFastInt("LuaAppSponsoredAdUnloadTelemetryThrottlingHundredthsPercent", 0),
    lastUpdated = { 26, 6, 25 },
    description = "\t\tFires once per served sponsored ad when its viewability session reaches a terminal\n\t\tboundary, carrying the session's dwell and in-view duration summary.\n\t"
}

local config4 = {
    eventName = "SponsoredAdVideoProgress",
    backends = { "EventIngest", "Points" },
    throttlingPercentage = game:DefineFastInt("LuaAppSponsoredAdVideoProgressTelemetryThrottlingHundredthsPercent", 0),
    lastUpdated = { 26, 7, 21 },
    description = "\t\t\tFires once for each 0 / 25 / 50 / 75 / 100 video-progress milestone reached\n\t\t\twithin a served sponsored ad session.\n\t\t"
}

local function buildGeometryFields(arg1)
    local adSize = arg1.adSize
    local viewportBounds = arg1.viewportBounds

    return {
        adWidth = if adSize.X > 0 then adSize.X else nil,
        adHeight = if adSize.Y > 0 then adSize.Y else nil,
        viewportWidth = viewportBounds.max.X - viewportBounds.min.X,
        viewportHeight = viewportBounds.max.Y - viewportBounds.min.Y
    }
end

return {
    logSponsoredAdLoad = function(arg1, arg2, viewabilitySessionStartTimestampMs: number, arg3)
        local geometryFields = buildGeometryFields(arg2)
        local customFields = {
            encryptedAdTrackingData = arg1.encryptedAdTrackingData,
            tileType = arg1.tileType,
            viewabilitySessionStartTimestampMs = viewabilitySessionStartTimestampMs,
            adWidth = geometryFields.adWidth,
            adHeight = geometryFields.adHeight,
            viewportWidth = geometryFields.viewportWidth,
            viewportHeight = geometryFields.viewportHeight
        }
        if arg1.mediaType == "video" then
            customFields.isFullScreen = arg1.isFullscreen == true
        end
        if arg3 ~= nil then
            customFields.videoLengthMs = arg3.videoLengthMs
        end

        TelemetryService:LogEvent(config, { standardizedFields = standardizedFields, customFields = customFields })
    end,
    logSponsoredAdViewableImpression = function(arg1, arg2)
        local geometryFields = buildGeometryFields(arg2.geometry)
        local customFields = {
            encryptedAdTrackingData = arg1.encryptedAdTrackingData,
            tileType = arg1.tileType,
            milestoneLabel = arg2.milestoneLabel,
            viewabilitySessionStartTimestampMs = arg2.viewabilitySessionStartTimestampMs,
            adWidth = geometryFields.adWidth,
            adHeight = geometryFields.adHeight,
            viewportWidth = geometryFields.viewportWidth,
            viewportHeight = geometryFields.viewportHeight,
            cumulative30PercentInViewDurationMs = arg2.cumulative30PercentInViewDurationMs,
            cumulative50PercentInViewDurationMs = arg2.cumulative50PercentInViewDurationMs,
            cumulative100PercentInViewDurationMs = arg2.cumulative100PercentInViewDurationMs,
            maxContinuous30PercentInViewDurationMs = arg2.maxContinuous30PercentInViewDurationMs,
            maxContinuous50PercentInViewDurationMs = arg2.maxContinuous50PercentInViewDurationMs,
            maxContinuous100PercentInViewDurationMs = arg2.maxContinuous100PercentInViewDurationMs
        }
        customFields.isFullScreen = arg2.isFullScreen
        customFields.videoLengthMs = arg2.videoLengthMs
        customFields.maxAudioLevel = arg2.maxAudioLevel
        customFields.cumulativeInGridViewDurationMs = arg2.cumulativeInGridViewDurationMs
        customFields.cumulativeFullScreenViewDurationMs = arg2.cumulativeFullScreenViewDurationMs

        TelemetryService:LogEvent(config2, { standardizedFields = standardizedFields, customFields = customFields })
    end,
    logSponsoredAdVideoProgress = function(arg1, arg2)
        local geometryFields = buildGeometryFields(arg2.geometry)

        TelemetryService:LogEvent(config4, {
            standardizedFields = standardizedFields,
            customFields = {
                encryptedAdTrackingData = arg1.encryptedAdTrackingData,
                tileType = arg1.tileType,
                isFullScreen = arg2.isFullScreen,
                adWidth = geometryFields.adWidth,
                adHeight = geometryFields.adHeight,
                viewportWidth = geometryFields.viewportWidth,
                viewportHeight = geometryFields.viewportHeight,
                viewabilitySessionStartTimestampMs = arg2.viewabilitySessionStartTimestampMs,
                cumulative30PercentInViewDurationMs = arg2.cumulative30PercentInViewDurationMs,
                cumulative50PercentInViewDurationMs = arg2.cumulative50PercentInViewDurationMs,
                cumulative100PercentInViewDurationMs = arg2.cumulative100PercentInViewDurationMs,
                maxContinuous30PercentInViewDurationMs = arg2.maxContinuous30PercentInViewDurationMs,
                maxContinuous50PercentInViewDurationMs = arg2.maxContinuous50PercentInViewDurationMs,
                maxContinuous100PercentInViewDurationMs = arg2.maxContinuous100PercentInViewDurationMs,
                videoProgress = arg2.videoProgress,
                videoLengthMs = arg2.videoLengthMs,
                videoCumulativePlaytimeMs = arg2.videoCumulativePlaytimeMs,
                cumulativeAudioPlaybackDurationMs = arg2.cumulativeAudioPlaybackDurationMs,
                cumulative100PercentAudibleTimeMs = arg2.cumulative100PercentAudibleTimeMs,
                maxAudioLevel = arg2.maxAudioLevel,
                audioOnAtEvent = arg2.audioOnAtEvent,
                cumulativeInGridViewDurationMs = arg2.cumulativeInGridViewDurationMs,
                cumulativeFullScreenViewDurationMs = arg2.cumulativeFullScreenViewDurationMs
            }
        })
    end,
    logSponsoredAdUnload = function(arg1, arg2, unloadReason: string)
        local geometryFields = buildGeometryFields(arg2.geometry)
        local customFields = {
            encryptedAdTrackingData = arg1.encryptedAdTrackingData,
            tileType = arg1.tileType,
            adWidth = geometryFields.adWidth,
            adHeight = geometryFields.adHeight,
            viewportWidth = geometryFields.viewportWidth,
            viewportHeight = geometryFields.viewportHeight,
            viewabilitySessionStartTimestampMs = arg2.viewabilitySessionStartTimestampMs,
            cumulative30PercentInViewDurationMs = arg2.cumulative30PercentInViewDurationMs,
            cumulative50PercentInViewDurationMs = arg2.cumulative50PercentInViewDurationMs,
            cumulative100PercentInViewDurationMs = arg2.cumulative100PercentInViewDurationMs,
            maxContinuous30PercentInViewDurationMs = arg2.maxContinuous30PercentInViewDurationMs,
            maxContinuous50PercentInViewDurationMs = arg2.maxContinuous50PercentInViewDurationMs,
            maxContinuous100PercentInViewDurationMs = arg2.maxContinuous100PercentInViewDurationMs,
            dwellDurationMs = arg2.dwellDurationMs,
            averagePercentSeen = arg2.averagePercentSeen,
            minPercentSeen = arg2.minPercentSeen,
            maxPercentSeen = arg2.maxPercentSeen,
            averageOnScreenRealEstate = arg2.averageOnScreenRealEstate,
            viewabilitySessionEndTimestampMs = arg2.viewabilitySessionEndTimestampMs,
            unloadReason = unloadReason
        }
        customFields.isFullScreen = arg2.isFullScreen
        customFields.videoProgress = arg2.videoProgress
        customFields.videoLengthMs = arg2.videoLengthMs
        customFields.videoCumulativePlaytimeMs = arg2.videoCumulativePlaytimeMs
        customFields.cumulativeAudioPlaybackDurationMs = arg2.cumulativeAudioPlaybackDurationMs
        customFields.cumulative100PercentAudibleTimeMs = arg2.cumulative100PercentAudibleTimeMs
        customFields.maxAudioLevel = arg2.maxAudioLevel
        customFields.audioOnAtEvent = arg2.audioOnAtEvent
        customFields.cumulativeInGridViewDurationMs = arg2.cumulativeInGridViewDurationMs
        customFields.cumulativeFullScreenViewDurationMs = arg2.cumulativeFullScreenViewDurationMs

        TelemetryService:LogEvent(config3, { standardizedFields = standardizedFields, customFields = customFields })
    end
}
