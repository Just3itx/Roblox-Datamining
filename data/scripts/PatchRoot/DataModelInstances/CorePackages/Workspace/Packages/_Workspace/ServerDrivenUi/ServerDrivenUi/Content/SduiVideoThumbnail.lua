-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local Foundation = require(ServerDrivenUiParent.Foundation)
local React = require(ServerDrivenUiParent.React)
local Responsive = require(ServerDrivenUiParent.Responsive)
local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local Signals = require(ServerDrivenUiParent.Signals)
local SignalsReact = require(ServerDrivenUiParent.SignalsReact)
local VideoUtils = require(ServerDrivenUiParent.VideoUtils)

local FFlagLuaAppOneByTwoHoverIdleAutoplay = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppOneByTwoHoverIdleAutoplay

local FFlagLuaAppSduiSuppressVideoDetectorDuringScroll = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppSduiSuppressVideoDetectorDuringScroll

local useTokens = Foundation.Hooks.useTokens

local getSduiComponentWrapper = SduiCoreSystem.getSduiComponentWrapper
local getPlaybackDetectionMethod = VideoUtils.getPlaybackDetectionMethod
local VideoPlaybackDetectionMethod = VideoUtils.VideoPlaybackDetectionMethod
local useTagAsViewportAutoplayCandidate = VideoUtils.useTagAsViewportAutoplayCandidate

local signal = Signals.createSignal(false)

local function SduiVideoThumbnail(tbl1)
    local var1 = useTokens()
    local cornerRadius = tbl1.cornerRadius or var1.Radius.Medium

    local var3 = React.useRef(nil)
    local itemFrameRef = tbl1.playbackCandidateRef or var3
    if not FFlagLuaAppOneByTwoHoverIdleAutoplay then
        useTagAsViewportAutoplayCandidate(
            itemFrameRef,
            if tbl1.videoPlayer then tbl1.videoPlaybackContext else nil,
            tbl1.videoPlayer ~= nil,
            nil
        )
    end

    local str1 = `SduiVideoThumbnail_{SduiCoreSystem.useUidRefString().current}`
    if FFlagLuaAppOneByTwoHoverIdleAutoplay then
        str1 = React.useRef(str1).current
    end

    if FFlagLuaAppOneByTwoHoverIdleAutoplay then
        useTagAsViewportAutoplayCandidate(
            itemFrameRef,
            if tbl1.videoPlayer then tbl1.videoPlaybackContext else nil,
            tbl1.videoPlayer ~= nil,
            nil,
            nil,
            nil,
            nil,
            tbl1.videoPlayer and { videoKey = str1, isUserIntentModeAutoplayCandidate = false } or nil
        )
    end

    local var5 = Responsive.usePreferredInput()
    local isHoverSupported = var5 == Responsive.Input.Pointer

    local playbackDetectionMethod = getPlaybackDetectionMethod(var5, isHoverSupported)

    local isPlaybackEnabledByClient, var7 = React.useState(false)
    local onPlaybackChange = React.useCallback(function(bool2: boolean)
        var7(bool2)
    end, {})

    local videoPlaybackCoordinator = if tbl1.videoPlaybackContext then tbl1.videoPlaybackContext.videoPlaybackCoordinator else nil

    local onVideoLoaded = React.useCallback(function(num1: number, num2: number)
        if videoPlaybackCoordinator and tbl1.videoAnalytics then
            tbl1.videoAnalytics.reportVideoLoad(nil, videoPlaybackCoordinator.currentPlaybackSessionId, num1, num2)
        end
    end, { tbl1.videoAnalytics, videoPlaybackCoordinator })

    local onVideoLooped = React.useCallback(function()
        if videoPlaybackCoordinator and tbl1.videoAnalytics and tbl1.videoAnalytics.reportVideoLoop then
            tbl1.videoAnalytics.reportVideoLoop(nil, videoPlaybackCoordinator.currentPlaybackSessionId)
        end
    end, { tbl1.videoAnalytics, videoPlaybackCoordinator })

    local viewportVideoAutoplayController = if tbl1.videoPlaybackContext then tbl1.videoPlaybackContext.viewportVideoAutoplayController else nil
    local var11

    if FFlagLuaAppSduiSuppressVideoDetectorDuringScroll then
        local getDetectorsUnmounted = if viewportVideoAutoplayController then viewportVideoAutoplayController.getDetectorsUnmounted else nil
        var11 = SignalsReact.useSignalState(getDetectorsUnmounted or signal)
    else
        var11 = false
    end

    local var12

    if tbl1.videoPlayer then
        var12 = React.createElement(getSduiComponentWrapper(tbl1.videoPlayer), {
            componentConfig = tbl1.videoPlayer,
            sduiContext = tbl1.sduiContext,
            extraLocalProps = {
                defaultLoadingImageComponent = tbl1.imageComponent,
                isPlaybackEnabledByClient = isPlaybackEnabledByClient,
                cornerRadius = cornerRadius,
                onVideoLoaded = onVideoLoaded,
                onVideoLooped = onVideoLooped
            },
            debugName = "SduiVideoThumbnail.VideoPlayer"
        })
    else
        var12 = tbl1.imageComponent
    end
    local createElement = React.createElement
    local str2 = "Frame"
    local tbl2 = {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        ref = 0,
        Size = 0
    }

    if tbl1.playbackCandidateRef then
        var3 = nil
    end

    tbl2.ref = var3
    tbl2.Size = UDim2.fromScale(1, 1)
    local tbl3 = { MediaContent = var12, PlaybackDetector = 0 }
    local element

    if tbl1.videoPlayer and not (FFlagLuaAppSduiSuppressVideoDetectorDuringScroll and var11) then
        element = React.createElement(VideoUtils.VideoPlaybackDetector, {
            videoKey = str1,
            itemFrameRef = itemFrameRef,
            playbackDetectionMethod = playbackDetectionMethod,
            isHoverSupported = isHoverSupported,
            isHovered = tbl1.isHovered,
            isSelected = tbl1.isSelected,
            hasVideoPlaybackUserIntent = if FFlagLuaAppOneByTwoHoverIdleAutoplay and playbackDetectionMethod == VideoPlaybackDetectionMethod.Hover then tbl1.isHovered else nil,
            autoplay = var5 == Responsive.Input.Touch,
            videoPlaybackCoordinator = if tbl1.videoPlaybackContext then tbl1.videoPlaybackContext.videoPlaybackCoordinator else nil,
            onPlaybackChange = onPlaybackChange,
            videoAnalytics = tbl1.videoAnalytics,
            videoDwellTimeInSec = tbl1.videoDwellTimeInSec,
            videoVisiblePercent = tbl1.videoVisiblePercent,
            isVideoEligible = tbl1.isVideoEligible,
            onVideoIneligible = tbl1.onVideoIneligible,
            onPlaybackCandidate = tbl1.onPlaybackCandidate,
            viewportVideoAutoplayController = viewportVideoAutoplayController
        })
    else
        element = nil
    end

    tbl3.PlaybackDetector = element
    return createElement(str2, tbl2, tbl3)
end

return SduiVideoThumbnail
