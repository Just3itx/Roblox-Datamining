-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:10:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local _VideoAnalyticsTypes = require(script.Analytics.VideoAnalyticsTypes)
local ViewportVideoAutoplayMode = require(script.ViewportVideoAutoplayMode)
local FeedVideoPlaybackContext = require(script.FeedVideoPlaybackContext)
local VideoPlaybackCoordinator = require(script.VideoPlaybackCoordinator)
local VideoPlaybackDetectionMethod = require(script.VideoPlaybackDetectionMethod)
local VideoPlaybackDetector = require(script.VideoPlaybackDetector)
local ViewportVideoAutoplayController = require(script.ViewportVideoAutoplayController)
local VideoPlayer = require(script.VideoPlayer)
local EdpVideoBlockingConfig = require(script.EdpVideoBlockingConfig)

return {
    FeedVideoPlaybackContext = FeedVideoPlaybackContext,
    VideoPlaybackCoordinator = VideoPlaybackCoordinator,
    ViewportVideoAutoplayMode = ViewportVideoAutoplayMode,
    VideoPlaybackDetectionMethod = VideoPlaybackDetectionMethod,
    VideoPlaybackDetector = VideoPlaybackDetector,
    ViewportVideoAutoplayController = ViewportVideoAutoplayController,
    ViewportVideoAutoplaySync = require(script.ViewportVideoAutoplaySync),
    VideoPlayer = VideoPlayer,
    AnalyticsEnums = require(script.Analytics.Enums),
    VideoLogger = require(script.Analytics.VideoLogger),
    getIsInstanceVisible = require(script.getIsInstanceVisible),
    getPlaybackDetectionMethod = require(script.getPlaybackDetectionMethod),
    isVideoEligibleForPlayability = require(script.isVideoEligibleForPlayability),
    RoundIconButton = require(script.RoundIconButton),
    useCanDevicePlayVideoPreview = require(script.useCanDevicePlayVideoPreview),
    useFeedVideoPlaybackContext = require(script.useFeedVideoPlaybackContext),
    useTagAsViewportAutoplayCandidate = require(script.useTagAsViewportAutoplayCandidate),
    EdpVideoBlockingConfig = EdpVideoBlockingConfig,
    VideoBlockingHelpers = require(script.VideoBlockingHelpers),
    ["jest.config"] = script["jest.config"]
}
