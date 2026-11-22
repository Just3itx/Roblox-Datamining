-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MediaGallery = script:FindFirstAncestor("MediaGallery")
local MediaGalleryParent = MediaGallery.Parent

local React = require(MediaGalleryParent.React)
local _AppCommonLib = require(MediaGalleryParent.AppCommonLib)
local useTokens = require(MediaGalleryParent.Foundation).Hooks.useTokens

local VideoUtils = require(MediaGalleryParent.VideoUtils)
local VideoPlaybackDetectionMethod = VideoUtils.VideoPlaybackDetectionMethod
local VideoPlaybackCoordinator = VideoUtils.VideoPlaybackCoordinator
local VideoPlaybackDetector = VideoUtils.VideoPlaybackDetector
local VideoPlayer = VideoUtils.VideoPlayer

local FFlagLuaAppMediaGalleryGamepadSupport = require(MediaGalleryParent.SharedFlags).FFlagLuaAppMediaGalleryGamepadSupport

local FFlagLuaAppGameTileSelectionVideoPlayback = require(MediaGalleryParent.SharedFlags).FFlagLuaAppGameTileSelectionVideoPlayback
local FFlagMediaGalleryVideoVisiblePercent = require(MediaGalleryParent.SharedFlags).FFlagMediaGalleryVideoVisiblePercent
local FFlagLuaAppEdpMomentVideo = require(MediaGalleryParent.SharedFlags).FFlagLuaAppEdpMomentVideo
local FFlagLuaAppVideoPlayerTrimAndMusic = require(MediaGalleryParent.SharedFlags).FFlagLuaAppVideoPlayerTrimAndMusic

local getImageUri = require(MediaGallery.getImageUri)
local MediaGalleryConstants = require(MediaGallery.MediaGalleryConstants)

local FFlagLuaAppVideoLoadFailureFallback = require(MediaGalleryParent.SharedFlags).FFlagLuaAppVideoLoadFailureFallback
local FFlagFixNonVisibleEdpVideoPlayback = require(MediaGalleryParent.SharedFlags).FFlagFixNonVisibleEdpVideoPlayback

return React.memo(function(tbl1) -- name: MediaGalleryVideoItem
    local var1 = useTokens()

    local video = `rbxassetid://{tbl1.videoId}`
    local thumbnail = getImageUri(tbl1.thumbnail or "")
    local videoPlaybackCoordinator = tbl1.videoPlaybackCoordinator or VideoPlaybackCoordinator.default
    local videoAnalytics = tbl1.videoAnalytics
    local bool1 = tbl1.currentIndex == nil or tbl1.itemIndex == tbl1.currentIndex
    local setIsVideoActive = tbl1.setIsVideoActive
    local cornerRadius = tbl1.cornerRadius or var1.Radius.Medium
    local isFullscreen = tbl1.isFullscreen

    local videoDwellTimeInSec = (tbl1.videoDwellTimeHundredthsSec or MediaGalleryConstants.VIDEO_DWELL_TIME_HUNDREDTHS_SEC) / 100

    local videoVisiblePercent = tbl1.videoVisiblePercent

    if not videoVisiblePercent then
        if FFlagMediaGalleryVideoVisiblePercent then
            videoVisiblePercent = MediaGalleryConstants.VIDEO_PLAYBACK_VISIBLE_PERCENT
        else
            videoVisiblePercent = MediaGalleryConstants.VIDEO_VISIBLE_PERCENT
        end
    end
    local videoKey = `media_gallery_item_{tbl1.itemIndex or "0"}_video_{tbl1.videoId or "0"}{if isFullscreen then "_fullscreen" else ""}`
    local toggleVideoPlaybackSignal = if bool1 then tbl1.toggleVideoPlaybackSignal else nil
    local toggleMuteSignal = if bool1 then tbl1.toggleMuteSignal else nil
    local onVideoEnded = if bool1 then tbl1.onVideoEnded else nil
    local onVideoProgressChanged = if bool1 then tbl1.onVideoProgressChanged else nil
    local onMutedChanged = if bool1 then tbl1.onMutedChanged else nil
    local onPlayingChanged = if FFlagLuaAppMediaGalleryGamepadSupport and bool1 then tbl1.onPlayingChanged else nil
    local onVideoReadyChanged = if FFlagLuaAppMediaGalleryGamepadSupport and bool1 then tbl1.onVideoReadyChanged else nil
    local bool2, onPlaybackChange = React.useState(false)
    local var6 = React.useRef(nil)

    React.useEffect(function()
        if not (bool1 and setIsVideoActive) then
            return nil
        end

        setIsVideoActive(true)
        return function()
            setIsVideoActive(false)
        end
    end, { bool1, setIsVideoActive })

    local onVideoLoaded = React.useCallback(function(num1: number, num2: number)
        if videoAnalytics then
            videoAnalytics.reportVideoLoad(tbl1.itemIndex, videoPlaybackCoordinator.currentPlaybackSessionId, num1, num2)
        end

        if tbl1.onMediaResolved then
            tbl1.onMediaResolved(true)
        end
    end, {
        tbl1.itemIndex,
        tbl1.onMediaResolved,
        videoAnalytics,
        videoPlaybackCoordinator.currentPlaybackSessionId
    })

    local onMuteButtonActivated = React.useCallback(function(bool3: boolean)
        if videoAnalytics and videoAnalytics.reportVideoMute then
            videoAnalytics.reportVideoMute(tbl1.itemIndex, videoPlaybackCoordinator.currentPlaybackSessionId, bool3)
        end
    end, { tbl1.itemIndex, videoAnalytics, videoPlaybackCoordinator.currentPlaybackSessionId })

    local createElement = React.createElement
    local str3 = "Frame"
    local tbl2 = {
        Size = tbl1.Size,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = tbl1.ZIndex,
        ref = var6
    }
    local tbl3 = { VideoPlayer = 0, VideoPlaybackDetector = 0, ItemOverlay = 0, Attribution = 0 }
    local createElement2 = React.createElement
    local var9 = VideoPlayer
    local tbl4 = {
        video = video,
        accessContext = if FFlagLuaAppEdpMomentVideo then tbl1.videoAccessContext else nil,
        trimStartTime = if FFlagLuaAppVideoPlayerTrimAndMusic then tbl1.trimStartTime else nil,
        trimEndTime = if FFlagLuaAppVideoPlayerTrimAndMusic then tbl1.trimEndTime else nil,
        musicAssetId = if FFlagLuaAppVideoPlayerTrimAndMusic then tbl1.musicAssetId else nil,
        musicStartTime = if FFlagLuaAppVideoPlayerTrimAndMusic then tbl1.musicStartTime else nil,
        thumbnail = thumbnail,
        shouldStartPlayback = 0,
        muted = 0,
        looped = 0,
        Size = 0,
        cornerRadius = 0,
        showMuteButton = true,
        onMuteButtonActivated = 0,
        showPlayButton = 0,
        showProgressBar = 0,
        videoAnalyticsContext = 0,
        onVideoLoaded = 0,
        onVideoProgressChanged = 0,
        onVideoEnded = 0,
        onVideoLoadFailed = 0,
        toggleVideoPlaybackSignal = 0,
        toggleMuteSignal = 0,
        onMutedChanged = 0,
        onPlayingChanged = 0,
        onVideoLoadedChanged = 0
    }

    if FFlagFixNonVisibleEdpVideoPlayback and bool2 then
        bool2 = bool1 and not tbl1.isMediaGalleryOccluded
    end

    tbl4.shouldStartPlayback = bool2

    tbl4.muted = tbl1.muted == nil or tbl1.muted
    tbl4.looped = not (tbl1.looped == nil) and tbl1.looped
    tbl4.Size = UDim2.fromScale(1, 1)
    tbl4.cornerRadius = cornerRadius

    tbl4.onMuteButtonActivated = onMuteButtonActivated
    tbl4.showPlayButton = if tbl1.showPlayButton == nil then isFullscreen else tbl1.showPlayButton
    if tbl1.showProgressBar ~= nil then
        isFullscreen = tbl1.showProgressBar
    end

    tbl4.showProgressBar = isFullscreen
    tbl4.videoAnalyticsContext = tbl1.videoAnalyticsContext
    tbl4.onVideoLoaded = onVideoLoaded
    tbl4.onVideoProgressChanged = onVideoProgressChanged
    tbl4.onVideoEnded = onVideoEnded
    tbl4.onVideoLoadFailed = if FFlagLuaAppVideoLoadFailureFallback and bool1 and not tbl1.isMediaGalleryOccluded then tbl1.onVideoLoadFailed else nil

    tbl4.toggleVideoPlaybackSignal = toggleVideoPlaybackSignal
    tbl4.toggleMuteSignal = toggleMuteSignal
    tbl4.onMutedChanged = onMutedChanged
    tbl4.onPlayingChanged = onPlayingChanged
    tbl4.onVideoLoadedChanged = onVideoReadyChanged
    tbl3.VideoPlayer = createElement2(var9, tbl4)

    tbl3.VideoPlaybackDetector = React.createElement(VideoPlaybackDetector, {
        videoKey = videoKey,
        itemIndex = tbl1.itemIndex,
        itemFrameRef = var6,
        isItemOccluded = tbl1.isMediaGalleryOccluded,
        playbackDetectionMethod = if FFlagLuaAppGameTileSelectionVideoPlayback and (tbl1.autoplay == nil or tbl1.autoplay) then VideoPlaybackDetectionMethod.Viewport else nil,
        autoplay = if FFlagLuaAppGameTileSelectionVideoPlayback then nil else tbl1.autoplay == nil or tbl1.autoplay,
        videoPlaybackCoordinator = videoPlaybackCoordinator,
        onPlaybackChange = onPlaybackChange,
        videoDwellTimeInSec = videoDwellTimeInSec,
        videoVisiblePercent = videoVisiblePercent,
        isVideoEligible = true,
        videoAnalytics = videoAnalytics
    })

    tbl3.ItemOverlay = if tbl1.overlay then React.createElement(
        "Frame",
        {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            ZIndex = 5
        },
        {
            Overlay = tbl1.overlay
        }
    ) else nil

    tbl3.Attribution = if FFlagLuaAppEdpMomentVideo and tbl1.attributionComponent then React.createElement(
        "Frame",
        {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            ZIndex = 6
        },
        {
            AttributionContent = tbl1.attributionComponent
        }
    ) else nil
    return createElement(str3, tbl2, tbl3)
end)
