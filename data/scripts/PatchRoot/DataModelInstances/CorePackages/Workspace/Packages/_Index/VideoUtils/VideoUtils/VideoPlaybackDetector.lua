-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:11:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExperienceService = game:GetService("ExperienceService")
local AppLifecycleObserverService = game:GetService("AppLifecycleObserverService")
local VideoUtils = script:FindFirstAncestor("VideoUtils")

local VideoUtilsParent = VideoUtils.Parent
local _AppCommonLib = require(VideoUtilsParent.AppCommonLib)
local React = require(VideoUtilsParent.React)

local Responsive = require(VideoUtilsParent.Responsive)
local useLastInput = Responsive.useLastInput

local FFlagLuaAppOneByTwoHoverIdleAutoplay = require(VideoUtilsParent.SharedFlags).FFlagLuaAppOneByTwoHoverIdleAutoplay

local _VideoAnalyticsTypes = require(VideoUtils.Analytics.VideoAnalyticsTypes)
local VideoEndReason = require(VideoUtils.Analytics.Enums).VideoEndReason
local VideoPlaybackCoordinator = require(VideoUtils.VideoPlaybackCoordinator)
local VideoHoverPlaybackDetector = require(VideoUtils.VideoHoverPlaybackDetector)
local VideoPlaybackDetectionMethod = require(VideoUtils.VideoPlaybackDetectionMethod)
local VideoSelectionPlaybackDetector = require(VideoUtils.VideoSelectionPlaybackDetector)
local VideoViewportPlaybackDetector = require(VideoUtils.VideoViewportPlaybackDetector)
local _ViewportVideoAutoplayController = require(VideoUtils.ViewportVideoAutoplayController)

local FFlagLuaAppEdpMediaGalleryVideoPreview = require(VideoUtilsParent.SharedFlags).FFlagLuaAppEdpMediaGalleryVideoPreview

local FFlagLuaAppGameTileSelectionVideoPlayback = require(VideoUtilsParent.SharedFlags).FFlagLuaAppGameTileSelectionVideoPlayback

local FFlagLuaAppSuppressVideoDetectorDuringScroll = require(VideoUtilsParent.SharedFlags).FFlagLuaAppSuppressVideoDetectorDuringScroll

local FFlagLuaAppSduiSuppressVideoDetectorDuringScroll = require(VideoUtilsParent.SharedFlags).FFlagLuaAppSduiSuppressVideoDetectorDuringScroll

local function VideoPlaybackDetector(tbl1)
    local videoPlaybackCoordinator = tbl1.videoPlaybackCoordinator or VideoPlaybackCoordinator.default

    local var2, var3 = React.useState(false)
    local var4 = if FFlagLuaAppEdpMediaGalleryVideoPreview or FFlagLuaAppGameTileSelectionVideoPlayback then nil else useLastInput()

    local requestVideoPlayback = React.useCallback(function(bool1: boolean)
        if tbl1.onPlaybackCandidate then
            tbl1.onPlaybackCandidate()
        end

        if tbl1.isVideoEligible then
            videoPlaybackCoordinator:requestPlayback(
                tbl1.videoKey,
                bool1,
                tbl1.videoDwellTimeInSec,
                tbl1.itemIndex,
                tbl1.videoAnalytics
            )
        elseif tbl1.onVideoIneligible then
            tbl1.onVideoIneligible(videoPlaybackCoordinator.currentPlaybackSessionId)
        end
    end, {
        tbl1.videoKey,
        tbl1.itemIndex,
        tbl1.videoAnalytics,
        tbl1.isVideoEligible,
        tbl1.onVideoIneligible,
        tbl1.onPlaybackCandidate,
        tbl1.videoDwellTimeInSec,
        videoPlaybackCoordinator
    })

    local cancelVideoPlayback = React.useCallback(function(str1: string)
        videoPlaybackCoordinator:cancelPlayback(tbl1.videoKey, str1, tbl1.itemIndex, tbl1.videoAnalytics)
    end, {
        tbl1.videoKey,
        tbl1.itemIndex,
        tbl1.videoAnalytics,
        videoPlaybackCoordinator
    })

    local suppressDetectorsDuringScroll = if FFlagLuaAppSuppressVideoDetectorDuringScroll or FFlagLuaAppSduiSuppressVideoDetectorDuringScroll then not (tbl1.viewportVideoAutoplayController == nil) and tbl1.viewportVideoAutoplayController.suppressDetectorsDuringScroll else nil
    local useEffect = React.useEffect
    local function func1()
        local function checkAndUpdateState(videoKey: string?) -- Luacid: Inlined by compiler; 2 call sites recovered
            local bool1 = videoKey == tbl1.videoKey

            if bool1 ~= var2 then
                tbl1.onPlaybackChange(bool1)
                var3(bool1)
            end
        end

        if (FFlagLuaAppSuppressVideoDetectorDuringScroll or FFlagLuaAppSduiSuppressVideoDetectorDuringScroll)
            and suppressDetectorsDuringScroll
            and videoPlaybackCoordinator.playingVideoKey ~= tbl1.videoKey
        then
            tbl1.onPlaybackChange(false)
        end

        checkAndUpdateState(videoPlaybackCoordinator.playingVideoKey)

        local connection = videoPlaybackCoordinator.changed:connect(function(videoKey)
            checkAndUpdateState(videoKey)
        end)

        return function()
            if connection ~= nil then
                connection:disconnect()
                connection = nil
            end
        end
    end

    local videoKey = tbl1.videoKey
    local onPlaybackChange = tbl1.onPlaybackChange
    local var7 = if FFlagLuaAppSuppressVideoDetectorDuringScroll or FFlagLuaAppSduiSuppressVideoDetectorDuringScroll then suppressDetectorsDuringScroll else nil
    useEffect(func1, { videoKey, onPlaybackChange, videoPlaybackCoordinator, var2, var7 })

    React.useEffect(function()
        local viewportVideoAutoplayController = tbl1.viewportVideoAutoplayController
        local current = tbl1.itemFrameRef.current

        local connection = AppLifecycleObserverService.OnHide:Connect(function()
            if viewportVideoAutoplayController then
                viewportVideoAutoplayController:reset(VideoEndReason.AppBackgrounded)
                return
            end
            cancelVideoPlayback(VideoEndReason.AppBackgrounded)
        end)

        local connection2 = ExperienceService:RegisterForExperienceJoin(function()
            if viewportVideoAutoplayController then
                viewportVideoAutoplayController:reset(VideoEndReason.ExperienceLaunched)
                return
            end
            cancelVideoPlayback(VideoEndReason.ExperienceLaunched)
        end)

        return function()
            if viewportVideoAutoplayController and current then
                if not ((FFlagLuaAppSuppressVideoDetectorDuringScroll or FFlagLuaAppSduiSuppressVideoDetectorDuringScroll)
                    and viewportVideoAutoplayController.suppressDetectorsDuringScroll
                    and viewportVideoAutoplayController.isScrolling) then
                    viewportVideoAutoplayController:resetIfActiveInstance(current, VideoEndReason.Unmounted)
                end
            else
                cancelVideoPlayback(VideoEndReason.Unmounted)
            end

            if connection2 then
                connection2:Disconnect()
                connection2 = nil
            end

            if connection then
                connection:Disconnect()
                connection = nil
            end
        end
    end, { cancelVideoPlayback, tbl1.viewportVideoAutoplayController, tbl1.itemFrameRef })

    if not FFlagLuaAppOneByTwoHoverIdleAutoplay then
        if FFlagLuaAppGameTileSelectionVideoPlayback then
            if tbl1.playbackDetectionMethod == VideoPlaybackDetectionMethod.Hover then
                return React.createElement(VideoHoverPlaybackDetector, {
                    videoPlaybackCoordinator = videoPlaybackCoordinator,
                    requestVideoPlayback = requestVideoPlayback,
                    cancelVideoPlayback = cancelVideoPlayback,
                    isHovered = tbl1.isHovered
                })
            end

            if tbl1.playbackDetectionMethod == VideoPlaybackDetectionMethod.Viewport then
                return React.createElement(VideoViewportPlaybackDetector, {
                    videoPlaybackCoordinator = videoPlaybackCoordinator,
                    requestVideoPlayback = requestVideoPlayback,
                    cancelVideoPlayback = cancelVideoPlayback,
                    itemFrameRef = tbl1.itemFrameRef,
                    isItemOccluded = tbl1.isItemOccluded,
                    videoVisiblePercent = tbl1.videoVisiblePercent,
                    viewportVideoAutoplayController = tbl1.viewportVideoAutoplayController
                })
            end

            if tbl1.playbackDetectionMethod == VideoPlaybackDetectionMethod.Selection then
                return React.createElement(
                    VideoSelectionPlaybackDetector,
                    {
                        requestVideoPlayback = requestVideoPlayback,
                        cancelVideoPlayback = cancelVideoPlayback,
                        isSelected = tbl1.isSelected
                    }
                )
            end
        else
            if tbl1.isHoverSupported then
                return React.createElement(VideoHoverPlaybackDetector, {
                    videoPlaybackCoordinator = videoPlaybackCoordinator,
                    requestVideoPlayback = requestVideoPlayback,
                    cancelVideoPlayback = cancelVideoPlayback,
                    isHovered = tbl1.isHovered
                })
            end

            if FFlagLuaAppEdpMediaGalleryVideoPreview and tbl1.autoplay or var4 == Responsive.Input.Touch then
                return React.createElement(VideoViewportPlaybackDetector, {
                    videoPlaybackCoordinator = videoPlaybackCoordinator,
                    requestVideoPlayback = requestVideoPlayback,
                    cancelVideoPlayback = cancelVideoPlayback,
                    itemFrameRef = tbl1.itemFrameRef,
                    isItemOccluded = tbl1.isItemOccluded,
                    videoVisiblePercent = tbl1.videoVisiblePercent,
                    viewportVideoAutoplayController = tbl1.viewportVideoAutoplayController
                })
            end
        end

        return nil
    end

    if tbl1.playbackDetectionMethod == VideoPlaybackDetectionMethod.Hover then
        if tbl1.viewportVideoAutoplayController ~= nil and tbl1.viewportVideoAutoplayController:isUserIntentWithSelectiveAutoplay() then
            return React.createElement(VideoViewportPlaybackDetector, {
                videoKey = tbl1.videoKey,
                videoPlaybackCoordinator = videoPlaybackCoordinator,
                requestVideoPlayback = requestVideoPlayback,
                cancelVideoPlayback = cancelVideoPlayback,
                itemFrameRef = tbl1.itemFrameRef,
                isItemOccluded = tbl1.isItemOccluded,
                videoVisiblePercent = tbl1.videoVisiblePercent,
                viewportVideoAutoplayController = tbl1.viewportVideoAutoplayController,
                hasVideoPlaybackUserIntent = tbl1.hasVideoPlaybackUserIntent
            })
        end

        return React.createElement(VideoHoverPlaybackDetector, {
            videoPlaybackCoordinator = videoPlaybackCoordinator,
            requestVideoPlayback = requestVideoPlayback,
            cancelVideoPlayback = cancelVideoPlayback,
            isHovered = tbl1.isHovered
        })
    elseif tbl1.playbackDetectionMethod == VideoPlaybackDetectionMethod.Viewport then
        return React.createElement(VideoViewportPlaybackDetector, {
            videoKey = tbl1.videoKey,
            videoPlaybackCoordinator = videoPlaybackCoordinator,
            requestVideoPlayback = requestVideoPlayback,
            cancelVideoPlayback = cancelVideoPlayback,
            itemFrameRef = tbl1.itemFrameRef,
            isItemOccluded = tbl1.isItemOccluded,
            videoVisiblePercent = tbl1.videoVisiblePercent,
            viewportVideoAutoplayController = tbl1.viewportVideoAutoplayController
        })
    elseif tbl1.playbackDetectionMethod == VideoPlaybackDetectionMethod.Selection then
        return React.createElement(
            VideoSelectionPlaybackDetector,
            {
                requestVideoPlayback = requestVideoPlayback,
                cancelVideoPlayback = cancelVideoPlayback,
                isSelected = tbl1.isSelected
            }
        )
    elseif FFlagLuaAppEdpMediaGalleryVideoPreview and tbl1.autoplay or var4 == Responsive.Input.Touch then
        return React.createElement(VideoViewportPlaybackDetector, {
            videoPlaybackCoordinator = videoPlaybackCoordinator,
            requestVideoPlayback = requestVideoPlayback,
            cancelVideoPlayback = cancelVideoPlayback,
            itemFrameRef = tbl1.itemFrameRef,
            isItemOccluded = tbl1.isItemOccluded,
            videoVisiblePercent = tbl1.videoVisiblePercent,
            viewportVideoAutoplayController = tbl1.viewportVideoAutoplayController
        })
    else
        return nil
    end
end
return VideoPlaybackDetector
