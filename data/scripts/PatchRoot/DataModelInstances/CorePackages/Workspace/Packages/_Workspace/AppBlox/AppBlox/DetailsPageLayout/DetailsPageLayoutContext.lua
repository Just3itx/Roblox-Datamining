-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:21:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent

return require(AppBloxParent.React).createContext({
    hasFullBleed = false,
    hasHeader = nil,
    hasActions = nil,
    setHasHeader = function() end,
    setHasActions = function() end,
    isFullscreen = false,
    headerBarHeight = 0,
    actionBarHeight = nil,
    setActionBarHeight = function() end,
    onCanvasPositionChanged = nil,
    contentTopOffset = nil,
    fullBleedOverlapOffset = 180,
    gradientTopBleedOffset = 80,
    gradientMidTransparency = nil,
    initialScrollY = 0,
    hasValidContainerSize = false,
    disableFocusNavEngineScroll = false,
    containerHeight = nil,
    headerOpacity = nil,
    stickyHeaderActive = false,
    onClose = nil,
    testId = nil,
    onCanvasSizeChanged = nil,
    isFullscreenOverlay = false,
    setFullscreenContent = nil,
    onExitFullscreenOverlay = nil,
    setOnExitFullscreenOverlay = nil
})
