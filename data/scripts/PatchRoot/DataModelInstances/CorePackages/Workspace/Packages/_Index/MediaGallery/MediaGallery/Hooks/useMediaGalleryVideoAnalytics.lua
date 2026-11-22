-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:51:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MediaGalleryParent = script:FindFirstAncestor("MediaGallery").Parent

local React = require(MediaGalleryParent.React)

local LoggingProtocol = require(MediaGalleryParent.LoggingProtocol)

local DiscoveryAnalytics = require(MediaGalleryParent.DiscoveryAnalytics)
local discoveryVideoPlayEvent = DiscoveryAnalytics.Events.discoveryVideoPlayEvent
local discoveryVideoEndEvent = DiscoveryAnalytics.Events.discoveryVideoEndEvent

local VideoUtils = require(MediaGalleryParent.VideoUtils)
local VideoActions = VideoUtils.AnalyticsEnums.VideoActions
local VideoLogger = VideoUtils.VideoLogger

local reportWarning = DiscoveryAnalytics.Points.reportWarning

local FFlagLuaAppDiscoveryMomentVideoTelemetry = require(MediaGalleryParent.SharedFlags).FFlagLuaAppDiscoveryMomentVideoTelemetry

local function useMediaGalleryVideoAnalytics(str1: string, rootPlaceId: string?, tbl1)
    local reportVideoPlay = React.useCallback(function(num1: number?, videoPlaybackSessionId: string?)
        if not (num1 and tbl1) then
            return
        end

        local var1 = tbl1[num1]
        if not var1 then
            reportWarning(LoggingProtocol.default, "EventLogging", "reportVideoPlay requires a valid entry")
            return
        end

        if not var1.videoId then
            reportWarning(LoggingProtocol.default, "EventLogging", "reportVideoPlay requires a valid videoAssetId")
        end

        discoveryVideoPlayEvent("GameDetails", {
            videoAssetId = var1.videoId,
            videoPlaybackSessionId = videoPlaybackSessionId or "INVALID_SESSION_ID",
            universeId = str1,
            rootPlaceId = rootPlaceId,
            isMoment = if FFlagLuaAppDiscoveryMomentVideoTelemetry then var1.isMoment == true else nil
        })
    end, { str1, rootPlaceId, tbl1 })

    local reportVideoLoad = React.useCallback(function(num1: number?, playbackSessionId: string?, _: number, loadTime: number)
        if not (num1 and tbl1) then
            return
        end

        local var2 = tbl1[num1]
        if not var2 then
            reportWarning(LoggingProtocol.default, "EventLogging", "reportVideoLoad requires a valid entry")
            return
        end

        if not var2.videoId then
            reportWarning(LoggingProtocol.default, "EventLogging", "reportVideoLoad requires a valid videoAssetId")
        end

        VideoLogger.reportVideoAction(VideoActions.load, "GameDetails", {
            videoAssetId = var2.videoId,
            source = "MediaGallery",
            sourceId = str1,
            playbackSessionId = playbackSessionId or "INVALID_SESSION_ID"
        }, { loadTime = loadTime })
    end, { str1, tbl1 })

    local reportVideoMute = React.useCallback(function(num1: number?, playbackSessionId: string?, bool1: boolean)
        if not (num1 and tbl1) then
            return
        end

        local var3 = tbl1[num1]
        if not (var3 and var3.videoId) then
            return
        end

        VideoLogger.reportVideoAction(VideoActions.volume, "GameDetails", {
            videoAssetId = var3.videoId,
            source = "MediaGallery",
            sourceId = str1,
            playbackSessionId = playbackSessionId or "INVALID_SESSION_ID",
            volumeLevel = if bool1 then 0 else 1
        })
    end, { str1, tbl1 })

    local reportVideoEnd = React.useCallback(function(num1: number?, endReason: string, videoPlaybackSessionId: string?, playbackTime: number, targetUniverseId: string?)
        if not (num1 and tbl1) then
            return
        end

        local var4 = tbl1[num1]
        if not var4 then
            reportWarning(LoggingProtocol.default, "EventLogging", "reportVideoEnd requires a valid entry")
            return
        end

        if not var4.videoId then
            reportWarning(LoggingProtocol.default, "EventLogging", "reportVideoEnd requires a valid videoAssetId")
        end

        discoveryVideoEndEvent("GameDetails", {
            videoAssetId = var4.videoId,
            videoPlaybackSessionId = videoPlaybackSessionId or "INVALID_SESSION_ID",
            endReason = endReason,
            playbackTime = playbackTime,
            universeId = str1,
            rootPlaceId = rootPlaceId,
            targetUniverseId = targetUniverseId,
            isMoment = if FFlagLuaAppDiscoveryMomentVideoTelemetry then var4.isMoment == true else nil
        })
    end, { str1, rootPlaceId, tbl1 })

    return (React.useMemo(function()
        return {
            reportVideoPlay = reportVideoPlay,
            reportVideoLoad = reportVideoLoad,
            reportVideoMute = reportVideoMute,
            reportVideoEnd = reportVideoEnd
        }
    end, {
        reportVideoPlay,
        reportVideoLoad,
        reportVideoMute,
        reportVideoEnd
    }))
end
return useMediaGalleryVideoAnalytics
