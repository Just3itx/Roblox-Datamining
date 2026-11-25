-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:10:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)
local View = require(SduiSharedContentParent.Foundation).View

local DetailsPageLayoutContext = require(SduiSharedContentParent.AppBlox).DetailsPageLayout.DetailsPageLayoutContext

local sendMediaGalleryFullscreenEvent = require(SduiSharedContentParent.DiscoveryAnalytics).Events.sendMediaGalleryFullscreenEvent

local _VideoUtils = require(SduiSharedContentParent.VideoUtils)

local FocusNavigationUtils = require(SduiSharedContentParent.FocusNavigationUtils)
local FocusNavigableSurfaceWrapper = FocusNavigationUtils.FocusNavigableSurfaceWrapper
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local SduiSharedUtilities = require(SduiSharedContentParent.SduiSharedUtilities)
local SduiFocusTags = SduiSharedUtilities.SduiFocusTags
local useOnNavigateBack = SduiSharedUtilities.useOnNavigateBack
local MediaGallery = require(SduiSharedContentParent.MediaGallery)
local MediaGalleryCarousel = MediaGallery.MediaGalleryCarousel
local MediaGalleryConstants = MediaGallery.MediaGalleryConstants
local isValidIdentifier = MediaGallery.isValidIdentifier
local isYouTubeVideo = MediaGallery.isYouTubeVideo

local ITEM_ASPECT_RATIO = MediaGalleryConstants.ITEM_ASPECT_RATIO

local function useMediaGalleryFullscreen(tbl1)
    local var1 = React.useContext(DetailsPageLayoutContext)
    local setFullscreenContent = var1.setFullscreenContent
    local setOnExitFullscreenOverlay = var1.setOnExitFullscreenOverlay

    local isFullscreen, var3 = React.useState(false)
    local var4, var5 = React.useState(1)

    local var6 = React.useRef(1)

    local var7 = React.useRef(nil)
    local var8 = React.useCallback(function()
        if var7.current then
            var7.current(var6.current)
        end
    end, {})
    local ref = useOnNavigateBack(var8)

    local onMediaChanged = React.useCallback(function(current: number, bool1: boolean?)
        var6.current = current
        if tbl1.onFullscreenMediaChanged then
            tbl1.onFullscreenMediaChanged(current, bool1)
        end
    end, { tbl1.onFullscreenMediaChanged })

    local var11 = React.useRef(setFullscreenContent)
    var11.current = setFullscreenContent
    local var12 = React.useRef(setOnExitFullscreenOverlay)
    var12.current = setOnExitFullscreenOverlay

    React.useEffect(function()
        return function()
            if var11.current then
                var11.current(nil)
            end
            if var12.current then
                var12.current(nil)
            end
        end
    end, {})

    local var13 = React.useCallback(function(num1: number)
        var7.current = nil
        var5(num1)
        if setFullscreenContent then
            setFullscreenContent(nil)
        end
        if setOnExitFullscreenOverlay then
            setOnExitFullscreenOverlay(nil)
        end
        var3(false)
        local filteredItem = tbl1.filteredItems[num1]
        local var13 = not (filteredItem == nil) and (isValidIdentifier(filteredItem.videoId) or isYouTubeVideo(filteredItem.assetTypeId))
        sendMediaGalleryFullscreenEvent(
            tbl1.eventIngest,
            tbl1.mediaGalleryAnalyticsContext,
            "mediaGalleryExitFullscreen",
            tbl1.placeId,
            tbl1.universeId,
            num1,
            var13
        )
    end, {
        setFullscreenContent,
        setOnExitFullscreenOverlay,
        tbl1.filteredItems,
        tbl1.eventIngest,
        tbl1.placeId,
        tbl1.universeId,
        tbl1.mediaGalleryAnalyticsContext
    })

    local var14 = React.useCallback(function()
        if var7.current then
            var7.current(var6.current)
        end
    end, {})

    local onFullscreenToggle = React.useCallback(function(num1: number)
        if tbl1.fullscreenEnabled == false or not setFullscreenContent then
            return
        end
        var7.current = var13
        var5(num1)
        var6.current = num1
        var3(true)
        if setOnExitFullscreenOverlay then
            setOnExitFullscreenOverlay(function()
                return var14
            end)
        end

        local var15, var16 = React.createBinding(UDim2.fromOffset(0, 0))

        local content = React.createElement(View, {
            tag = "size-full bg-surface-0",
            onAbsoluteSizeChanged = function(arg1)
                local absoluteSizeX = arg1.AbsoluteSize.X
                local absoluteSizeY = arg1.AbsoluteSize.Y

                local num2 = math.floor(absoluteSizeY * ITEM_ASPECT_RATIO)
                if absoluteSizeX < num2 then
                    absoluteSizeY = math.floor(absoluteSizeX / ITEM_ASPECT_RATIO)
                else
                    absoluteSizeX = num2
                end
                var16(UDim2.fromOffset(absoluteSizeX, absoluteSizeY))
            end
        }, {
            MediaGallery = React.createElement(MediaGalleryCarousel, {
                items = tbl1.filteredItems,
                Size = var15,
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.5),
                itemPadding = 0,
                startIndex = num1,
                isFullscreen = true,
                showGradient = false,
                showPlayButton = true,
                showProgressBar = true,
                onYouTubeVideoPlay = tbl1.onYouTubeVideoPlay,
                onFullscreenToggle = var13,
                onMediaChanged = onMediaChanged,
                videoPlaybackCoordinator = tbl1.videoPlaybackCoordinator,
                videoAnalytics = tbl1.videoAnalytics,
                analyticsSourceId = tbl1.universeId,
                cornerRadius = tbl1.cornerRadius,
                overlay = tbl1.overlay
            })
        })

        local var17 = setFullscreenContent
        local createElement = React.createElement
        local var18 = FocusNavigableSurfaceWrapper
        local tbl2 = {
            surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp,
            isIsolated = true
        }
        local tbl3 = {
            NavigateBackFrame = React.createElement(
                "Frame",
                {
                    ref = ref,
                    Size = UDim2.fromScale(1, 1),
                    BackgroundTransparency = 1,
                    [React.Tag] = SduiFocusTags.SuppressBindings
                },
                { Content = content }
            )
        }
        var17(createElement(var18, tbl2, tbl3))

        local filteredItem = tbl1.filteredItems[num1]
        local var19 = not (filteredItem == nil) and (isValidIdentifier(filteredItem.videoId) or isYouTubeVideo(filteredItem.assetTypeId))
        sendMediaGalleryFullscreenEvent(
            tbl1.eventIngest,
            tbl1.mediaGalleryAnalyticsContext,
            "mediaGalleryEnterFullscreen",
            tbl1.placeId,
            tbl1.universeId,
            num1,
            var19
        )
    end, {
        tbl1.fullscreenEnabled,
        setFullscreenContent,
        setOnExitFullscreenOverlay,
        var14,
        tbl1.filteredItems,
        tbl1.universeId,
        var13,
        tbl1.onYouTubeVideoPlay,
        tbl1.videoPlaybackCoordinator,
        tbl1.videoAnalytics,
        onMediaChanged,
        tbl1.cornerRadius,
        tbl1.overlay,
        tbl1.eventIngest,
        tbl1.placeId,
        tbl1.mediaGalleryAnalyticsContext,
        ref
    })

    return {
        isFullscreen = isFullscreen,
        onFullscreenToggle = onFullscreenToggle,
        previewStartIndex = math.clamp(var4, 1, math.max(1, #tbl1.filteredItems))
    }
end

return useMediaGalleryFullscreen
