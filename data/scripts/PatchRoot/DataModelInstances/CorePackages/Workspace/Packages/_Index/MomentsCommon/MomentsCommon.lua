-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:00:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Analytics = require(script.Analytics)
local MediaSurfaceContext = require(script.Media.Components.MediaSurfaceContext)
local _MediaTypes = require(script.Media.MediaTypes)

local CaptureKind = require(script.Enums.CaptureKind)
local FormFactor = require(script.Enums.FormFactor)
local LoadingState = require(script.Enums.LoadingState)
local MusicThumbnailIconSize = require(script.Enums.MusicThumbnailIconSize)
local ReactionSize = require(script.Enums.ReactionSize)
local ReactionType = require(script.Enums.ReactionType)

local GradientBackdrop = require(script.Components.GradientBackdrop)
local MusicThumbnailIcon = require(script.Components.MusicThumbnailIcon)
local Reaction = require(script.Components.Reaction.Reaction)
local ScrollingGridView = require(script.Components.ScrollingGridView)
local OverlayDisplay = require(script.Components.OverlayDisplay)
local TextOverlay = require(script.Components.TextOverlay)
local TextOverlayDisplay = require(script.Components.TextOverlayDisplay)
local StickerOverlay = require(script.Components.StickerOverlay)
local ReactionAssets = require(script.Components.Reaction.ReactionAssets)

local Performance = require(script.Performance)

local GetFFlagEnableMomentTextGeneration = require(script.Flags.GetFFlagEnableMomentTextGeneration)
local GetFFlagMomentsCreationSaveDraft = require(script.Flags.GetFFlagMomentsCreationSaveDraft)
local GetFFlagMomentsNonInfiniteScroll = require(script.Flags.GetFFlagMomentsNonInfiniteScroll)
local GetFFlagMomentsStickerButton = require(script.Flags.GetFFlagMomentsStickerButton)
local GetFFlagMomentsUseUploadPostAsync = require(script.Flags.GetFFlagMomentsUseUploadPostAsync)
local GetFFlagMomentsUseMomentsServiceForUpload = require(script.Flags.GetFFlagMomentsUseMomentsServiceForUpload)
local FFlagMomentsFeedMediaLoadAttemptedEvent = require(script.Flags.FFlagMomentsFeedMediaLoadAttemptedEvent)
local FFlagMomentsVideoPermissionContextFix = require(script.Flags.FFlagMomentsVideoPermissionContextFix)
local FFlagMomentsEngagementMetricsFeature = require(script.Flags.FFlagMomentsEngagementMetricsFeature)
local FFlagMomentTextGenerationFilteredSignal = require(script.Flags.FFlagMomentTextGenerationFilteredSignal)
local FFlagMomentsCreationBackCta = require(script.Flags.FFlagMomentsCreationBackCta)
local FFlagMomentsTextOverlayV2Redesign = require(script.Flags.FFlagMomentsTextOverlayV2Redesign)
local FFlagMomentsSmartVideoFill = require(script.Flags.FFlagMomentsSmartVideoFill)
local FFlagMomentsAudioSaveButton = require(script.Flags.FFlagMomentsAudioSaveButton)
local FFlagMomentsParentTimeLimit = require(script.Flags.FFlagMomentsParentTimeLimit)
local FFlagMomentsTextOverlayChipGrowAboveKeyboard = require(script.Flags.FFlagMomentsTextOverlayChipGrowAboveKeyboard)
local FFlagMomentsTextOverlayEdgeClipFix = require(script.Flags.FFlagMomentsTextOverlayEdgeClipFix)
local GetFFlagMomentsCoachmarkPersistence = require(script.Flags.GetFFlagMomentsCoachmarkPersistence)
local GetFIntMomentsCoachmarkMaxImpressions = require(script.Flags.GetFIntMomentsCoachmarkMaxImpressions)
local GetFIntMomentsCoachmarkAutoDismissSeconds = require(script.Flags.GetFIntMomentsCoachmarkAutoDismissSeconds)

local Hooks = {
    useDeviceInsets = require(script.Hooks.useDeviceInsets),
    useFormFactor = require(script.Hooks.useFormFactor),
    useImageLoadingState = require(script.Hooks.useImageLoadingState),
    useIsMultiTouchActive = require(script.Hooks.useIsMultiTouchActive),
    useMomentsGating = function(...)
        return require(script.Hooks.useMomentsGating)(...)
    end,
    useScreenSize = require(script.Hooks.useScreenSize),
    useStatusBarHeight = require(script.Hooks.useStatusBarHeight),
    useTextOverlayPreviewGestures = require(script.Hooks.useTextOverlayPreviewGestures),
    useToggleState = require(script.Hooks.useToggleState)
}

local module = { Analytics = Analytics }

function module.canRenderNativeMoments(tbl2)
    return tbl2.isTabEnabled or tbl2.isFlyoutEntryEnabled and tbl2.platformIntegrationEnabled
end

module.Flags = {
    GetFFlagEnableMomentTextGeneration = GetFFlagEnableMomentTextGeneration,
    GetFFlagMomentsCreationSaveDraft = GetFFlagMomentsCreationSaveDraft,
    GetFFlagMomentsNonInfiniteScroll = GetFFlagMomentsNonInfiniteScroll,
    GetFFlagMomentsStickerButton = GetFFlagMomentsStickerButton,
    FFlagMomentsFeedMediaLoadAttemptedEvent = FFlagMomentsFeedMediaLoadAttemptedEvent,
    FFlagMomentsVideoPermissionContextFix = FFlagMomentsVideoPermissionContextFix,
    FFlagMomentsEngagementMetricsFeature = FFlagMomentsEngagementMetricsFeature,
    FFlagMomentTextGenerationFilteredSignal = FFlagMomentTextGenerationFilteredSignal,
    FFlagMomentsCreationBackCta = FFlagMomentsCreationBackCta,
    FFlagMomentsTextOverlayV2Redesign = FFlagMomentsTextOverlayV2Redesign,
    FFlagMomentsSmartVideoFill = FFlagMomentsSmartVideoFill,
    FFlagMomentsAudioSaveButton = FFlagMomentsAudioSaveButton,
    FFlagMomentsParentTimeLimit = FFlagMomentsParentTimeLimit,
    FFlagMomentsTextOverlayChipGrowAboveKeyboard = FFlagMomentsTextOverlayChipGrowAboveKeyboard,
    FFlagMomentsTextOverlayEdgeClipFix = FFlagMomentsTextOverlayEdgeClipFix,
    GetFFlagMomentsUseUploadPostAsync = GetFFlagMomentsUseUploadPostAsync,
    GetFFlagMomentsUseMomentsServiceForUpload = GetFFlagMomentsUseMomentsServiceForUpload,
    GetFFlagMomentsCoachmarkPersistence = GetFFlagMomentsCoachmarkPersistence,
    GetFIntMomentsCoachmarkMaxImpressions = GetFIntMomentsCoachmarkMaxImpressions,
    GetFIntMomentsCoachmarkAutoDismissSeconds = GetFIntMomentsCoachmarkAutoDismissSeconds
}
module.Components = {
    GradientBackdrop = GradientBackdrop,
    MusicThumbnailIcon = MusicThumbnailIcon,
    Reaction = Reaction,
    OverlayDisplay = OverlayDisplay,
    TextOverlay = TextOverlay,
    TextOverlayDisplay = TextOverlayDisplay,
    StickerOverlay = StickerOverlay,
    ReactionAssets = ReactionAssets
}
module.Enums = {
    CaptureKind = CaptureKind,
    FormFactor = FormFactor,
    LoadingState = LoadingState,
    MusicThumbnailIconSize = MusicThumbnailIconSize,
    ReactionSize = ReactionSize,
    ReactionType = ReactionType
}
module.Hooks = Hooks

module.ScrollingGridView = ScrollingGridView

module.Media = {
    createMediaPreloadCoordinator = require(script.Media.createMediaPreloadCoordinator),
    mediaTelemetry = require(script.Media.Telemetry.mediaTelemetry),
    selectPreloadPolicy = require(script.Media.Preload.selectPreloadPolicy),
    MediaPreloadProvider = require(script.Media.Components.MediaPreloadProvider),
    MediaSurfaceContext = MediaSurfaceContext,
    MomentMediaView = require(script.Media.Components.MomentMediaView),
    MomentMediaTile = require(script.Media.Components.MomentMediaTile),
    useMomentMediaController = require(script.Media.Components.useMomentMediaController),
    feedPlaybackSuspension = require(script.Media.feedPlaybackSuspension),
    reportModalCovering = require(script.Media.reportModalCovering),
    audioDuckingFastInts = require(script.Media.audioDuckingFastInts)
}
module.Performance = Performance
module.Stores = {
    GetMomentsCapabilities = require(script.Stores.GetMomentsCapabilities)
}
module.Utils = {
    clampOverlayPosition = require(script.Utils.clampOverlayPosition),
    clampTextOverlayPosition = require(script.Utils.clampOverlayPosition),
    getCropSize = require(script.Utils.getCropSize),
    getEasingNumberSequence = require(script.Utils.getEasingNumberSequence),
    getFitSize = require(script.Utils.getFitSize),
    getScale = require(script.Utils.getScale),
    getSmartFillScaleType = require(script.Utils.getSmartFillScaleType),
    isStudio = require(script.Utils.isStudio),
    logMomentsLayerExposure = require(script.Utils.logMomentsLayerExposure),
    Oklab = require(script.Utils.Oklab)
}

module["jest.config"] = script["jest.config"]

return module
