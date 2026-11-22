-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:00:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local MediaGallery = script:FindFirstAncestor("MediaGallery")
local MediaGalleryParent = MediaGallery.Parent

local React = require(MediaGalleryParent.React)
local Foundation = require(MediaGalleryParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local useCursor = Foundation.Hooks.useCursor
local CursorType = Foundation.Enums.CursorType
local AppCommonLib = require(MediaGalleryParent.AppCommonLib)
local Signal = AppCommonLib.Signal

local FFlagLuaAppMediaGalleryGamepadSupport = require(MediaGalleryParent.SharedFlags).FFlagLuaAppMediaGalleryGamepadSupport
local FFlagLuaAppEdpMomentVideo = require(MediaGalleryParent.SharedFlags).FFlagLuaAppEdpMomentVideo
local FFlagLuaAppVideoPlayerTrimAndMusic = require(MediaGalleryParent.SharedFlags).FFlagLuaAppVideoPlayerTrimAndMusic

local Responsive = require(MediaGalleryParent.Responsive)
local useBreakpointXOrSmaller = Responsive.useBreakpointXOrSmaller
local useLastInput = Responsive.useLastInput

local FFlagLuaAppMediaGalleryHideScrollArrowsOnTouch = require(MediaGalleryParent.SharedFlags).FFlagLuaAppMediaGalleryHideScrollArrowsOnTouch

local FFlagLuaAppMediaGalleryPageIndicatorOpacity = require(MediaGalleryParent.SharedFlags).FFlagLuaAppMediaGalleryPageIndicatorOpacity

local useGamepadSupports = require(MediaGalleryParent.RoactUtils).Hooks.useGamepadSupports

local bool1 = game:DefineFastFlag("LuaAppMediaGalleryGamepadSupportsPagingIcons", false)

local tbl1 = FFlagLuaAppMediaGalleryGamepadSupport and { Enum.KeyCode.ButtonL2, Enum.KeyCode.ButtonR2 }
    or { Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1 }

local tbl2 = { Enum.KeyCode.ButtonR3 }

local CarouselScrollButtons = require(MediaGalleryParent.CollectionViews).CarouselScrollButtons

local VideoUtils = require(MediaGalleryParent.VideoUtils)
local VideoPlaybackCoordinator = VideoUtils.VideoPlaybackCoordinator
local RoundIconButton = VideoUtils.RoundIconButton

local enableAudioPlaybackInApp = require(MediaGalleryParent.MediaPlayback).enableAudioPlaybackInApp

local MediaGalleryPageIndicators = require(MediaGallery.MediaGalleryPageIndicators)
local MediaGalleryConstants = require(MediaGallery.MediaGalleryConstants)
local _MediaGalleryTypes = require(MediaGallery.MediaGalleryTypes)
local MediaGalleryImageItem = require(MediaGallery.MediaGalleryImageItem)
local MediaGalleryVideoItem = require(MediaGallery.MediaGalleryVideoItem)
local isYouTubeVideo = require(MediaGallery.isYouTubeVideo)
local isValidIdentifier = require(MediaGallery.isValidIdentifier)

local useSnapScroll = require(MediaGallery.Hooks.useSnapScroll)
local useAutoAdvance = require(MediaGallery.Hooks.useAutoAdvance)
local useTouchDragScroll = require(MediaGallery.Hooks.useTouchDragScroll)
local useCarouselGamepadInput = require(MediaGallery.Hooks.useCarouselGamepadInput)
local isAudioPlaybackAllowedForDevice = require(MediaGallery.isAudioPlaybackAllowedForDevice)

local FFlagLuaAppVideoLoadFailureFallback = require(MediaGalleryParent.SharedFlags).FFlagLuaAppVideoLoadFailureFallback

local SLIDING_WINDOW_SIZE = MediaGalleryConstants.SLIDING_WINDOW_SIZE

local function getVisibleIndices(num1: number, currentIndex: number)
    local visibleIndices = {}
    for i = 1, SLIDING_WINDOW_SIZE do
        local num2 = currentIndex + i - math.floor(SLIDING_WINDOW_SIZE / 2) - 1
        if num2 >= 1 and num2 <= num1 then
            table.insert(visibleIndices, num2)
        end
    end
    return visibleIndices
end

return React.memo(function(tbl3) -- name: MediaGalleryCarousel
    local var1 = useTokens()
    local itemPadding = tbl3.itemPadding or var1.Padding.Medium
    local var2 = tbl3.aspectRatio or MediaGalleryConstants.ITEM_ASPECT_RATIO
    local cornerRadius = tbl3.cornerRadius or var1.Radius.Medium
    local itemsLen = #tbl3.items

    local var4 = React.useMemo(function()
        for _, item in tbl3.items do
            if isValidIdentifier(item.videoId) and not isYouTubeVideo(item.assetTypeId) then
                return true
            end
        end
        return false
    end, { tbl3.items })

    React.useEffect(function()
        if var4 and isAudioPlaybackAllowedForDevice() then
            task.delay(0, enableAudioPlaybackInApp)
        end
    end, { var4 })

    local onScrollComplete = React.useCallback(function(num1: number, bool2: boolean?)
        if tbl3.onMediaChanged then
            tbl3.onMediaChanged(num1, bool2)
        end
    end, { tbl3.onMediaChanged })

    local var6 = useSnapScroll({
        itemCount = itemsLen,
        itemPadding = itemPadding,
        springConfig = MediaGalleryConstants.SPRING_CONFIG,
        targetIndex = tbl3.startIndex,
        onScrollComplete = onScrollComplete
    })

    local visibleIndices = getVisibleIndices(itemsLen, var6.currentIndex)

    local toggleVideoPlaybackSignal = React.useMemo(function()
        return Signal.new()
    end, {})
    local toggleMuteSignal = React.useMemo(function()
        return Signal.new()
    end, {})
    local isMuted, onMutedChanged = React.useState(true)

    local var11, setIsVideoActive = React.useState(false)

    local var13 = React.useMemo(function()
        return VideoPlaybackCoordinator.new()
    end, {})
    local videoPlaybackCoordinator = tbl3.videoPlaybackCoordinator or var13

    local var15 = nil
    local var16 = nil
    local var17 = nil
    local var18 = nil
    local var19, var20

    if FFlagLuaAppMediaGalleryGamepadSupport then
        local var21
        var15, var21 = React.useState(false)
        var16 = var21

        var19 = React.useCallback(function(bool2: boolean)
            var16(bool2)
        end, {})

        local var22
        var17, var22 = React.useState(false)
        var18 = var22

        var20 = React.useCallback(function(bool2: boolean)
            var18(bool2)
        end, {})

        React.useEffect(function()
            if not var11 then
                var16(false)
                var18(false)
            end
        end, { var11 })
    else
        var19 = nil
        var20 = nil
    end
    local scrollRight = React.useCallback(function()
        var6.scrollInDirection("Right", true)
    end, { var6.scrollInDirection })

    local var22 = useAutoAdvance({
        enabled = tbl3.autoAdvanceEnabled ~= false,
        intervalSeconds = tbl3.autoAdvanceIntervalSeconds,
        galleryRef = var6.scrollingFrameRef,
        isMediaGalleryOccluded = tbl3.isMediaGalleryOccluded,
        isAutoAdvanceTimerSuspended = var11,
        scrollRight = scrollRight
    })

    local var23 = React.useCallback(function(arg1, arg2)
        var22.resetProgress()
        var6.scrollInDirection(arg1, arg2)
    end, { var22.resetProgress, var6.scrollInDirection })

    local var24 = if FFlagLuaAppVideoLoadFailureFallback then React.useCallback(function()
        var23("Right", true)
    end, { var23 }) else nil

    local var25 = useBreakpointXOrSmaller(Responsive.Keys.Small)

    local size200 = var1.Size.Size_200
    local var26 = if var25 then var1.Size.Size_400 else var1.Size.Size_700
    local gradientOverlayHeight = tbl3.gradientOverlayHeight or size200 + var26 + var1.Size.Size_1000

    local videoAnalyticsContext = React.useMemo(function()
        return {
            videoAnalyticsData = {
                source = tbl3.analyticsSource or "MediaGallery",
                sourceId = tbl3.analyticsSourceId or nil
            },
            getPlaybackSessionId = function()
                return videoPlaybackCoordinator.currentPlaybackSessionId
            end
        }
    end, { tbl3.analyticsSource, tbl3.analyticsSourceId, videoPlaybackCoordinator })

    local onFullscreenToggle = if tbl3.fullscreenEnabled == false then nil else tbl3.onFullscreenToggle

    local var29 = React.useCallback(function()
        if onFullscreenToggle then
            onFullscreenToggle(var6.currentIndex)
        end
    end, { onFullscreenToggle, var6.currentIndex })

    local var30 = useLastInput()
    local var31 = if FFlagLuaAppMediaGalleryGamepadSupport and AppCommonLib.isSpatial() then Responsive.Input.Pointer else var30
    local bool2 = var31 == Responsive.Input.Directional
    local var32 = if bool1 then useGamepadSupports(tbl1, var31) else false
    local var33 = if bool1 then bool2 and var32 else bool2
    local bool3 = if FFlagLuaAppMediaGalleryHideScrollArrowsOnTouch then var31 == Responsive.Input.Pointer
        or var31 == Responsive.Input.Touch and tbl3.isFullscreen == true
        or bool1 and bool2 and not var32 else var31 == Responsive.Input.Pointer or bool1 and not var32
    local var34

    if FFlagLuaAppMediaGalleryGamepadSupport then
        local var35 = useGamepadSupports(tbl2, var30)
        var34 = bool2 and var35
    else
        var34 = false
    end

    local var35 = React.useCallback(function()
        var23("Left")
    end, { var23 })

    local var36 = React.useCallback(function()
        var23("Right")
    end, { var23 })

    local var37 = useCursor(CursorType.Invisible)

    local var38 = React.useCallback(function()
        if var11 then
            toggleVideoPlaybackSignal:fire()
        end
    end, { var11, toggleVideoPlaybackSignal })

    local var39 = useCarouselGamepadInput
    local tbl4 = {
        isFullscreen = tbl3.isFullscreen,
        isVideoActive = var11,
        isVideoPlaying = 0,
        isVideoReady = 0,
        isMuted = 0,
        toggleMuteSignal = 0,
        onFullscreenToggle = 0,
        scrollLeft = 0,
        scrollRight = 0
    }

    if not FFlagLuaAppMediaGalleryGamepadSupport then
        var15 = nil
    end

    tbl4.isVideoPlaying = var15
    if not FFlagLuaAppMediaGalleryGamepadSupport then
        var17 = nil
    end

    tbl4.isVideoReady = var17
    tbl4.isMuted = isMuted
    tbl4.toggleMuteSignal = toggleMuteSignal
    tbl4.onFullscreenToggle = var29
    tbl4.scrollLeft = var35
    tbl4.scrollRight = var36
    local ref = var39(tbl4)

    useTouchDragScroll(
        var6.scrollingFrameRef,
        if FFlagLuaAppMediaGalleryHideScrollArrowsOnTouch then var23 else var6.scrollInDirection
    )

    local tbl5 = {
        Layout = React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Horizontal,
            Padding = UDim.new(0, itemPadding)
        })
    }
    for _, visibleIndex in visibleIndices do
        local item = tbl3.items[visibleIndex]
        if not item then
            continue
        end

        local element

        if isValidIdentifier(item.videoId) and not isYouTubeVideo(item.assetTypeId) then
            local tbl6 = {
                videoId = item.videoId,
                videoAccessContext = if FFlagLuaAppEdpMomentVideo then item.videoAccessContext else nil,
                trimStartTime = if FFlagLuaAppVideoPlayerTrimAndMusic then item.trimStartTime else nil,
                trimEndTime = if FFlagLuaAppVideoPlayerTrimAndMusic then item.trimEndTime else nil,
                musicAssetId = if FFlagLuaAppVideoPlayerTrimAndMusic then item.musicAssetId else nil,
                musicStartTime = if FFlagLuaAppVideoPlayerTrimAndMusic then item.musicStartTime else nil,
                attributionComponent = if FFlagLuaAppEdpMomentVideo then item.attributionComponent else nil,
                thumbnail = item.imageId,
                Size = UDim2.fromScale(1, 1),
                itemIndex = visibleIndex,
                overlay = item.overlay,
                currentIndex = var6.currentIndex,
                videoPlaybackCoordinator = videoPlaybackCoordinator,
                toggleVideoPlaybackSignal = toggleVideoPlaybackSignal,
                toggleMuteSignal = toggleMuteSignal,
                onVideoEnded = var22.onVideoEnded,
                onVideoLoadFailed = if FFlagLuaAppVideoLoadFailureFallback then var24 else nil,
                onVideoProgressChanged = var22.onVideoProgressChanged,
                onMutedChanged = onMutedChanged,
                onPlayingChanged = if FFlagLuaAppMediaGalleryGamepadSupport then var19 else nil,
                onVideoReadyChanged = if FFlagLuaAppMediaGalleryGamepadSupport then var20 else nil,
                setIsVideoActive = setIsVideoActive,
                isFullscreen = tbl3.isFullscreen,
                isMediaGalleryOccluded = tbl3.isMediaGalleryOccluded,
                videoAnalytics = tbl3.videoAnalytics,
                videoAnalyticsContext = videoAnalyticsContext,
                videoDwellTimeHundredthsSec = tbl3.videoDwellTimeHundredthsSec,
                videoVisiblePercent = tbl3.videoVisiblePercent,
                autoplay = tbl3.autoplay,
                muted = tbl3.muted,
                looped = tbl3.looped,
                showPlayButton = tbl3.showPlayButton,
                showProgressBar = tbl3.showProgressBar,
                cornerRadius = cornerRadius,
                onMediaResolved = if visibleIndex == 1 then tbl3.onMediaResolved else nil
            }
            if item.itemProps then
                for k, itemProp in item.itemProps do
                    tbl6[k] = itemProp
                end
            end
            element = React.createElement(MediaGalleryVideoItem, tbl6)
        else
            local tbl6 = {
                imageId = item.imageId,
                isYouTubeVideo = isYouTubeVideo(item.assetTypeId),
                videoHash = item.videoHash,
                videoTitle = item.videoTitle,
                Size = UDim2.fromScale(1, 1),
                itemIndex = visibleIndex,
                overlay = item.overlay,
                cornerRadius = cornerRadius,
                showGradient = tbl3.showGradient,
                onYouTubeVideoPlay = tbl3.onYouTubeVideoPlay,
                gradientOverlayHeight = gradientOverlayHeight,
                onMediaResolved = if visibleIndex == 1 then tbl3.onMediaResolved else nil
            }
            if item.itemProps then
                for k, itemProp in item.itemProps do
                    tbl6[k] = itemProp
                end
            end
            element = React.createElement(MediaGalleryImageItem, tbl6)
        end

        local var41 = "Item" .. visibleIndex
        local createElement = React.createElement

        local tbl6 = {
            LayoutOrder = visibleIndex,
            Size = var6.absoluteSizeBinding:map(function(vector2: Vector2): UDim2
                return UDim2.new(1, 0, 0, vector2.X / var2)
            end),
            BackgroundTransparency = 1,
            BorderSizePixel = 0
        }

        tbl5[var41] = createElement("Frame", tbl6, { Content = element })
    end

    local size500 = var1.Size.Size_500
    local size350 = var1.Size.Size_350

    local tbl6 = { Carousel = 0 }
    local createElement = React.createElement
    local str1 = "TextButton"
    local tbl7 = {
        BackgroundTransparency = 1,
        Size = tbl3.Size or UDim2.fromScale(1, 1),
        AnchorPoint = tbl3.AnchorPoint,
        Position = tbl3.Position,
        ref = ref,
        AutoButtonColor = false,
        Text = "",
        [React.Event.Activated] = var38,
        SelectionBehaviorRight = Enum.SelectionBehavior.Stop
    }

    if not tbl3.isFullscreen then
        var37 = nil
    end

    tbl7.SelectionImageObject = var37
    tbl7.SelectionGroup = true
    local tbl8 = {
        ScrollingFrame = 0,
        PageIndicators = 0,
        ScrollButtons = 0,
        FullscreenButton = 0,
        CarouselOverlay = 0,
        SizeConstraint = 0
    }
    local createElement2 = React.createElement

    local tbl9 = {
        Selectable = false,
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.fromScale(0, 0.5),
        Size = var6.absoluteSizeBinding:map(function(vector2: Vector2): UDim2
            return UDim2.new(1, 0, 0, vector2.X / var2)
        end),
        AutomaticCanvasSize = Enum.AutomaticSize.XY,
        CanvasPosition = var6.canvasPosition,
        ScrollingEnabled = false,
        ScrollBarImageTransparency = 1,
        ScrollBarThickness = 0,
        ScrollingDirection = Enum.ScrollingDirection.X,
        ClipsDescendants = true,
        ZIndex = 1,
        [React.Change.AbsoluteSize] = var6.onAbsoluteSizeChanged,
        ref = var6.scrollingFrameRef
    }

    tbl8.ScrollingFrame = createElement2("ScrollingFrame", tbl9, tbl5)
    local var41

    if itemsLen > 1 and tbl3.showPageIndicators ~= false and not tbl3.isFullscreen then
        local createElement3 = React.createElement
        local str2 = "Frame"
        local tbl10 = {
            AnchorPoint = Vector2.new(0.5, 1),
            AutomaticSize = Enum.AutomaticSize.X,
            BackgroundTransparency = 1,
            Size = UDim2.fromOffset(0, var1.Size.Size_200),
            Position = UDim2.new(0.5, 0, 1, -var26),
            ZIndex = 2
        }
        local tbl11 = {
            UIListLayout = React.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Horizontal,
                Padding = UDim.new(0, size350),
                VerticalAlignment = Enum.VerticalAlignment.Center
            }),
            PageLeftGamepadIcon = 0,
            Indicators = 0,
            PageRightGamepadIcon = 0
        }
        local var42

        if var33 then
            local createElement4 = React.createElement
            local str3 = "ImageLabel"
            local tbl12 = {
                BackgroundTransparency = 1,
                LayoutOrder = -1,
                Image = 0,
                ImageTransparency = 0,
                Size = 0
            }

            local userInputService = UserInputService
            local keyCode = if FFlagLuaAppMediaGalleryGamepadSupport then Enum.KeyCode.ButtonL2 else Enum.KeyCode.ButtonL1
            tbl12.Image = userInputService:GetImageForKeyCode(keyCode)

            tbl12.ImageTransparency = if var6.currentIndex <= 1 then 0.5 else nil
            tbl12.Size = UDim2.fromOffset(size500, size500)
            var42 = createElement4(str3, tbl12)
        else
            var42 = nil
        end

        tbl11.PageLeftGamepadIcon = var42

        tbl11.Indicators = React.createElement(MediaGalleryPageIndicators, {
            numberOfItems = itemsLen,
            startIndex = tbl3.startIndex or 1,
            currentItemProgressBinding = if FFlagLuaAppMediaGalleryPageIndicatorOpacity and tbl3.autoAdvanceEnabled == false and not var11 then nil else var22.progressBinding,
            mediaGalleryScrolledSignal = var6.scrolledSignal,
            useSpring = true,
            springConfig = MediaGalleryConstants.SPRING_CONFIG
        })
        local var43

        if var33 then
            local createElement4 = React.createElement
            local str3 = "ImageLabel"
            local tbl12 = {
                BackgroundTransparency = 1,
                LayoutOrder = 2,
                Image = 0,
                ImageTransparency = 0,
                Size = 0
            }

            local userInputService = UserInputService
            local keyCode = if FFlagLuaAppMediaGalleryGamepadSupport then Enum.KeyCode.ButtonR2 else Enum.KeyCode.ButtonR1
            tbl12.Image = userInputService:GetImageForKeyCode(keyCode)

            tbl12.ImageTransparency = if itemsLen <= var6.currentIndex then 0.5 else nil
            tbl12.Size = UDim2.fromOffset(size500, size500)
            var43 = createElement4(str3, tbl12)
        else
            var43 = nil
        end

        tbl11.PageRightGamepadIcon = var43
        var41 = createElement3(str2, tbl10, tbl11)
    else
        var41 = nil
    end

    tbl8.PageIndicators = var41
    local element

    if bool3 and not tbl3.isMediaGalleryOccluded then
        element = React.createElement(CarouselScrollButtons, {
            AnchorPoint = Vector2.new(0.5, 0),
            Position = UDim2.fromScale(0.5, 0),
            Size = UDim2.new(1, if tbl3.isFullscreen then 0 else var1.Size.Size_1000, 1, 0),
            buttonOffsetFromEdge = if tbl3.isFullscreen then var1.Size.Size_500 else nil,
            ZIndex = 10,
            leftScrollingEnabled = var6.currentIndex > 1,
            rightScrollingEnabled = var6.currentIndex < itemsLen,
            handleScrollLeft = var35,
            handleScrollRight = var36
        })
    else
        element = nil
    end

    tbl8.ScrollButtons = element
    local element2

    if onFullscreenToggle and not (FFlagLuaAppMediaGalleryGamepadSupport and var34) then
        element2 = React.createElement(RoundIconButton, {
            icon = if tbl3.isFullscreen then "two-arrows-to-center" else "two-arrows-from-center",
            onActivated = var29,
            AnchorPoint = Vector2.new(1, 0),
            Position = UDim2.new(1, -var1.Size.Size_500, 0, var1.Size.Size_500),
            ZIndex = 4,
            Selectable = false
        })
    else
        element2 = nil
    end

    tbl8.FullscreenButton = element2

    tbl8.CarouselOverlay = if tbl3.overlay then React.createElement(
        "Frame",
        {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            ZIndex = 15
        },
        {
            Overlay = tbl3.overlay
        }
    ) else nil

    tbl8.SizeConstraint = React.createElement("UISizeConstraint", {
        MinSize = var6.absoluteSizeBinding:map(function(vector2: Vector2): Vector2
            return Vector2.new(0, vector2.X / var2)
        end)
    })

    tbl6.Carousel = createElement(str1, tbl7, tbl8)
    return tbl6
end)
