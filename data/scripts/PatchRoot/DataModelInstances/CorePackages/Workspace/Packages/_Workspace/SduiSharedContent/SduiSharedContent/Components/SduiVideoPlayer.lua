-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:01:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)
local SduiCoreSystem = require(SduiSharedContentParent.SduiCoreSystem)
local findAnalyticsFieldInAncestors = SduiCoreSystem.findAnalyticsFieldInAncestors
local VideoUtils = require(SduiSharedContentParent.VideoUtils)

local FFlagLuaAppHomeMomentVideoFallback = require(SduiSharedContentParent.SharedFlags).FFlagLuaAppHomeMomentVideoFallback
local FFlagLuaAppVideoPlayerTrimAndMusic = require(SduiSharedContentParent.SharedFlags).FFlagLuaAppVideoPlayerTrimAndMusic

local tbl1 = { PlayWhenReady = "PlayWhenReady" }

local function resolvePlaybackState(str1: string?, bool1: boolean?): (boolean, boolean) -- Luacid: unused: defined but never referenced
    if bool1 ~= nil then
        return bool1, true
    elseif (str1 or "PlayWhenReady") ~= "PlayWhenReady" then
        return false, false
    end

    return true, true
end

local function asString(arg1): string -- Luacid: Inlined by compiler; 2 call sites recovered
    if arg1 == nil then
        return ""
    end

    return tostring(arg1)
end

local function normalizeAssetId(videoAssetId: string?) -- Luacid: Inlined by compiler; 1 call site recovered
    if videoAssetId == nil or videoAssetId == "" then
        return nil
    elseif string.find(videoAssetId, "://", 1, true) then
        return videoAssetId
    end
    return `rbxassetid://{videoAssetId}`
end

local function SduiVideoPlayer(tbl2)
    local video = normalizeAssetId(tbl2.videoAssetId)
    local loop = not (tbl2.loop == nil) and tbl2.loop
    local muted = tbl2.muted == nil or tbl2.muted
    local var3 = tbl2.disableControls == nil or tbl2.disableControls
    local scaleType = tbl2.scaleType or Enum.ScaleType.Crop

    local playbackBehavior = tbl2.playbackBehavior
    local isPlaybackEnabledByClient = tbl2.isPlaybackEnabledByClient
    local bool1

    if isPlaybackEnabledByClient ~= nil then
        bool1 = true
    elseif (playbackBehavior or tbl1.PlayWhenReady) == tbl1.PlayWhenReady then
        bool1 = true
        isPlaybackEnabledByClient = true
    else
        bool1 = false
        isPlaybackEnabledByClient = false
    end

    local source = asString((findAnalyticsFieldInAncestors("source", tbl2.analyticsContext)))
    local sourceId = asString((findAnalyticsFieldInAncestors("sourceId", tbl2.analyticsContext)))
    local videoPlaybackContext = tbl2.sduiContext.videoPlaybackContext

    local videoAnalyticsContext = React.useMemo(function()
        return {
            videoAnalyticsData = { source = source, sourceId = sourceId },
            getPlaybackSessionId = function()
                return if videoPlaybackContext then videoPlaybackContext.videoPlaybackCoordinator.currentPlaybackSessionId else nil
            end
        }
    end, { source, sourceId, videoPlaybackContext })

    local defaultLoadingImageComponent = if tbl2.loadingImage == nil or tbl2.loadingImage == "" then tbl2.defaultLoadingImageComponent else nil

    React.useEffect(function()
        if not video then
            tbl2.sduiContext.dependencies.logger.reportError(
                SduiCoreSystem.SduiErrors.SduiErrorType.InvalidProps,
                {
                    componentType = SduiCoreSystem.SduiComponentType.VideoPlayer,
                    propName = "videoAssetId",
                    value = tbl2.videoAssetId or "",
                    message = "Missing videoAssetId for video player"
                },
                tbl2.sduiContext.appPage
            )
        end

        if not bool1 then
            tbl2.sduiContext.dependencies.logger.reportError(
                SduiCoreSystem.SduiErrors.SduiErrorType.InvalidProps,
                {
                    componentType = SduiCoreSystem.SduiComponentType.VideoPlayer,
                    propName = "playbackBehavior",
                    value = tbl2.playbackBehavior,
                    message = "Unsupported playbackBehavior for video player"
                },
                tbl2.sduiContext.appPage
            )
        end

        if source ~= "" and sourceId ~= "" then
            return
        end

        tbl2.sduiContext.dependencies.logger.reportError(
            SduiCoreSystem.SduiErrors.SduiErrorType.InvalidProps,
            {
                componentType = SduiCoreSystem.SduiComponentType.VideoPlayer,
                propName = "analyticsData",
                value = "",
                message = "Missing source or sourceId for video player analytics"
            },
            tbl2.sduiContext.appPage
        )
    end, {
        bool1,
        tbl2.playbackBehavior,
        tbl2.sduiContext,
        tbl2.videoAssetId,
        source,
        sourceId,
        video
    })

    if not video then
        return nil
    end

    return React.createElement(VideoUtils.VideoPlayer, {
        video = video,
        accessContext = if FFlagLuaAppHomeMomentVideoFallback then tbl2.accessContext else nil,
        trimStartTime = if FFlagLuaAppVideoPlayerTrimAndMusic then tbl2.trimStartTime else nil,
        trimEndTime = if FFlagLuaAppVideoPlayerTrimAndMusic then tbl2.trimEndTime else nil,
        musicAssetId = if FFlagLuaAppVideoPlayerTrimAndMusic then tbl2.musicAssetId else nil,
        musicStartTime = if FFlagLuaAppVideoPlayerTrimAndMusic then tbl2.musicStartTime else nil,
        thumbnail = tbl2.loadingImage,
        thumbnailComponentOverride = defaultLoadingImageComponent,
        shouldStartPlayback = isPlaybackEnabledByClient,
        muted = muted,
        looped = loop,
        disableActivation = var3,
        hideCenterPlayButton = var3,
        Size = UDim2.fromScale(1, 1),
        ScaleType = scaleType,
        cornerRadius = tbl2.cornerRadius,
        onVideoLoaded = tbl2.onVideoLoaded,
        onVideoLooped = tbl2.onVideoLooped,
        videoAnalyticsContext = videoAnalyticsContext
    })
end

return SduiVideoPlayer
