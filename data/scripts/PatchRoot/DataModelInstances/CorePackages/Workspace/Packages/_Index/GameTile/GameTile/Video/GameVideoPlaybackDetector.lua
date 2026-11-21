-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:40:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTile = script:FindFirstAncestor("GameTile")
local GameTileParent = GameTile.Parent

local React = require(GameTileParent.React)
local RetrievalStatus = require(GameTileParent.Http).Enum.RetrievalStatus
local RoactNetworking = require(GameTileParent.RoactServiceTags).RoactNetworking
local RoactUtils = require(GameTileParent.RoactUtils)
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useRoactService = require(GameTileParent.RobloxAppHooks).useRoactService
local useIsVideoEligible = require(GameTile.Video.useIsVideoEligible)
local usePreferredInput = require(GameTileParent.Responsive).usePreferredInput

local VideoUtils = require(GameTileParent.VideoUtils)
local getPlaybackDetectionMethod = VideoUtils.getPlaybackDetectionMethod
local VideoPlaybackDetectionMethod = VideoUtils.VideoPlaybackDetectionMethod
local VideoPlaybackDetector = VideoUtils.VideoPlaybackDetector
local VideoEndReason = VideoUtils.AnalyticsEnums.VideoEndReason
local useCanDevicePlayVideoPreview = VideoUtils.useCanDevicePlayVideoPreview
local TileVideoBlockingConfig = require(GameTile.Video.TileVideoBlockingConfig)

local FetchGamePlayabilityAndProductInfo = require(GameTileParent.GameDetailRodux).FetchGamePlayabilityAndProductInfo

local FFlagLuaAppEdpMediaGalleryVideoPreview = require(GameTileParent.SharedFlags).FFlagLuaAppEdpMediaGalleryVideoPreview

local FFlagLuaAppUsePrevalidatedVideoGamePlayability = require(GameTileParent.SharedFlags).FFlagLuaAppUsePrevalidatedVideoGamePlayability

local FFlagLuaAppGameTileSelectionVideoPlayback = require(GameTileParent.SharedFlags).FFlagLuaAppGameTileSelectionVideoPlayback
local FFlagLuaAppOneByTwoHoverIdleAutoplay = require(GameTileParent.SharedFlags).FFlagLuaAppOneByTwoHoverIdleAutoplay

local FFlagLuaAppSuppressVideoDetectorDuringScroll = require(GameTileParent.SharedFlags).FFlagLuaAppSuppressVideoDetectorDuringScroll

local function GameVideoPlaybackDetector(tbl1)
    local var1 = useDispatch()
    local var2 = useRoactService(RoactNetworking)

    local var3 = useSelector(function(arg1)
        return FetchGamePlayabilityAndProductInfo.GetFetchingStatus(arg1, tbl1.universeId)
    end)

    local var4 = useIsVideoEligible(
        tbl1.universeId,
        if FFlagLuaAppUsePrevalidatedVideoGamePlayability then tbl1.hasPrevalidatedVideoGamePlayability else nil
    )

    local var5, var6 = React.useState(false)
    local var7 = if FFlagLuaAppSuppressVideoDetectorDuringScroll then React.useRef(false) else nil

    local var8 = useCanDevicePlayVideoPreview(TileVideoBlockingConfig, tbl1.universeId, tbl1.pageContext)

    local isVideoEligible = var4 and var5

    local useCallback = React.useCallback
    local function func1(arg1)
        if FFlagLuaAppSuppressVideoDetectorDuringScroll and var4 and var7.current then
            return
        end
        if tbl1.videoAnalytics and var3 == RetrievalStatus.Done then
            tbl1.videoAnalytics.reportVideoEnd(tbl1.itemIndex, VideoEndReason.PlayabilityCheckFailed, arg1, -1)
        end
    end

    local videoAnalytics = tbl1.videoAnalytics
    local var10 = if FFlagLuaAppSuppressVideoDetectorDuringScroll then var4 else nil
    local onVideoIneligible = useCallback(func1, { videoAnalytics, var3, var10 })

    local useCallback2 = React.useCallback
    local function func2()
        if (var3 == RetrievalStatus.NotStarted or var3 == RetrievalStatus.Failed)
            and not (FFlagLuaAppUsePrevalidatedVideoGamePlayability and tbl1.hasPrevalidatedVideoGamePlayability)
        then
            var1(FetchGamePlayabilityAndProductInfo.Fetch(var2, tbl1.universeId))
        end

        local current = var8()
        if FFlagLuaAppSuppressVideoDetectorDuringScroll then
            var7.current = current
        end
        var6(current)
    end

    local universeId = tbl1.universeId
    local hasPrevalidatedVideoGamePlayability = if FFlagLuaAppUsePrevalidatedVideoGamePlayability then tbl1.hasPrevalidatedVideoGamePlayability else nil
    local onPlaybackCandidate = useCallback2(func2, { universeId, var3, var1, var2, var8, hasPrevalidatedVideoGamePlayability })
    local playbackDetectionMethod

    if FFlagLuaAppGameTileSelectionVideoPlayback or FFlagLuaAppOneByTwoHoverIdleAutoplay then
        local var13 = usePreferredInput()

        playbackDetectionMethod = getPlaybackDetectionMethod(var13, tbl1.isHoverSupported)
    else
        playbackDetectionMethod = nil
    end

    return React.createElement(VideoPlaybackDetector, {
        videoKey = tbl1.videoKey,
        itemIndex = tbl1.itemIndex,
        itemFrameRef = tbl1.tileRef,
        playbackDetectionMethod = if FFlagLuaAppGameTileSelectionVideoPlayback or FFlagLuaAppOneByTwoHoverIdleAutoplay then playbackDetectionMethod else nil,
        isHoverSupported = if FFlagLuaAppGameTileSelectionVideoPlayback then nil else tbl1.isHoverSupported,
        isHovered = tbl1.isHovered,
        isSelected = if FFlagLuaAppGameTileSelectionVideoPlayback then tbl1.isSelected else nil,
        hasVideoPlaybackUserIntent = if FFlagLuaAppOneByTwoHoverIdleAutoplay and playbackDetectionMethod == VideoPlaybackDetectionMethod.Hover then tbl1.isHovered else nil,
        autoplay = if FFlagLuaAppGameTileSelectionVideoPlayback or not FFlagLuaAppEdpMediaGalleryVideoPreview then nil else tbl1.autoplay,
        videoPlaybackCoordinator = if tbl1.videoPlaybackContext then tbl1.videoPlaybackContext.videoPlaybackCoordinator else nil,
        onPlaybackChange = tbl1.onPlaybackChange,
        videoAnalytics = tbl1.videoAnalytics,
        videoDwellTimeInSec = tbl1.videoDwellTimeInSec,
        videoVisiblePercent = tbl1.videoVisiblePercent,
        isVideoEligible = isVideoEligible,
        onVideoIneligible = onVideoIneligible,
        onPlaybackCandidate = onPlaybackCandidate,
        viewportVideoAutoplayController = if tbl1.videoPlaybackContext then tbl1.videoPlaybackContext.viewportVideoAutoplayController else nil
    })
end

return GameVideoPlaybackDetector
