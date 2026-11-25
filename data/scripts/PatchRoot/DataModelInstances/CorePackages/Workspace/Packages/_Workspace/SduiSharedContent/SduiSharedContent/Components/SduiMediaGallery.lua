-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:00:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)

local VideoPlaybackCoordinator = require(SduiSharedContentParent.VideoUtils).VideoPlaybackCoordinator

local getSduiComponentWrapper = require(SduiSharedContentParent.SduiCoreSystem).getSduiComponentWrapper

local DiscoveryAnalytics = require(SduiSharedContentParent.DiscoveryAnalytics)

local sendMediaGalleryMediaChanged = DiscoveryAnalytics.Events.sendMediaGalleryMediaChanged
local openYouTubeVideoEvent = DiscoveryAnalytics.Events.openYouTubeVideoEvent

local MediaGallery = require(SduiSharedContentParent.MediaGallery)
local MediaGalleryCarousel = MediaGallery.MediaGalleryCarousel
local isValidIdentifier = MediaGallery.isValidIdentifier
local isYouTubeVideo = MediaGallery.isYouTubeVideo
local openYouTubeVideoWithAgeCheck = MediaGallery.openYouTubeVideoWithAgeCheck
local useFilteredMediaItems = MediaGallery.useFilteredMediaItems
local useMediaGalleryVideoAnalytics = MediaGallery.useMediaGalleryVideoAnalytics

local useMediaGalleryFullscreen = require(script.Parent.useMediaGalleryFullscreen)

local FFlagLuaAppEdpMomentVideo = require(SduiSharedContentParent.SharedFlags).FFlagLuaAppEdpMomentVideo

return React.memo(function(tbl1) -- name: SduiMediaGallery
    local eventIngest = tbl1.sduiContext.dependencies.eventIngest
    local appPage = tbl1.sduiContext.appPage
    local universeId = tbl1.universeId or ""
    local placeId = tbl1.placeId
    local mediaGalleryAnalyticsContext = tbl1.mediaGalleryAnalyticsContext or "ExperienceDetailsPage"

    local videoPlaybackCoordinator = React.useMemo(function()
        return VideoPlaybackCoordinator.new()
    end, {})

    local var2 = if FFlagLuaAppEdpMomentVideo then React.useMemo(function()
        local var2 = table.create(#tbl1.items)
        for k, item in tbl1.items do
            local attributionComponentConfig = item.attributionComponentConfig
            if attributionComponentConfig == nil then
                var2[k] = item
            else
                local var3 = table.clone(item)
                var3.attributionComponent = React.createElement(getSduiComponentWrapper(attributionComponentConfig), {
                    componentConfig = attributionComponentConfig,
                    sduiContext = tbl1.sduiContext,
                    debugName = "SduiMediaGallery.AttributionComponent"
                })

                var2[k] = var3
            end
        end

        return var2
    end, { tbl1.items, tbl1.sduiContext }) else nil

    local var3 = useFilteredMediaItems

    if not FFlagLuaAppEdpMomentVideo then
        var2 = tbl1.items
    end

    local filteredItems = var3(var2, universeId, appPage)

    local videoAnalytics = useMediaGalleryVideoAnalytics(universeId, placeId or "", filteredItems)

    local dispatch = tbl1.sduiContext.dependencies.dispatch

    local onYouTubeVideoPlay = React.useCallback(function(arg1)
        openYouTubeVideoWithAgeCheck(arg1.videoHash, arg1.videoTitle, dispatch, function()
            openYouTubeVideoEvent(eventIngest, "gameDetailsAccordianImage", arg1.videoTitle, arg1.videoHash, universeId, "play")
        end)
    end, { eventIngest, universeId, dispatch })

    local onMediaChanged = React.useCallback(function(num1: number, bool1: boolean?)
        local var7 = filteredItems[num1]
        if not var7 then
            return
        end
        sendMediaGalleryMediaChanged(
            eventIngest,
            mediaGalleryAnalyticsContext,
            var7,
            universeId,
            bool1,
            isYouTubeVideo(var7.assetTypeId),
            placeId
        )
    end, {
        filteredItems,
        eventIngest,
        universeId,
        placeId,
        mediaGalleryAnalyticsContext
    })
    local onFullscreenMediaChanged = React.useCallback(function(num1: number, bool1: boolean?)
        local var8 = filteredItems[num1]
        if not var8 then
            return
        end
        sendMediaGalleryMediaChanged(eventIngest, "MediaGallerySnappingFull", var8, universeId, bool1, nil, placeId)
    end, {
        filteredItems,
        eventIngest,
        universeId,
        placeId
    })
    local var9 = useMediaGalleryFullscreen({
        fullscreenEnabled = tbl1.fullscreenEnabled,
        filteredItems = filteredItems,
        universeId = universeId,
        placeId = placeId,
        mediaGalleryAnalyticsContext = mediaGalleryAnalyticsContext,
        eventIngest = eventIngest,
        onYouTubeVideoPlay = onYouTubeVideoPlay,
        onFullscreenMediaChanged = onFullscreenMediaChanged,
        videoPlaybackCoordinator = videoPlaybackCoordinator,
        videoAnalytics = videoAnalytics,
        cornerRadius = tbl1.cornerRadius,
        overlay = tbl1.overlay
    })

    local items = React.useMemo(function()
        if #filteredItems > 0 then
            return filteredItems
        end
        local fallbackImageId = tbl1.fallbackImageId
        if not fallbackImageId and isValidIdentifier(placeId) then
            fallbackImageId = `rbxthumb://type=GameThumbnail&id={placeId}&w=768&h=432`
        end
        return if fallbackImageId then {{ imageId = fallbackImageId }} else filteredItems
    end, { filteredItems, tbl1.fallbackImageId, placeId })

    React.useEffect(function()
        for _, value in filteredItems do
            if isYouTubeVideo(value.assetTypeId) and value.videoHash then
                openYouTubeVideoEvent(eventIngest, "gameDetailsAccordianImage", value.videoTitle, value.videoHash, universeId, "view")

                return
            end
        end
    end, { eventIngest, filteredItems, universeId })

    local bool1 = #items == 0

    local var11 = React.useRef(false)
    local onMediaResolved = React.useCallback(function(mediaFound: boolean)
        if var11.current or not tbl1.onFirstMediaResolved then
            return
        end

        var11.current = true
        tbl1.onFirstMediaResolved(nil, nil, { metadata = { mediaFound = mediaFound } })
    end, { tbl1.onFirstMediaResolved })

    React.useEffect(function()
        if bool1 and not var11.current and tbl1.onFirstMediaResolved then
            onMediaResolved(false)
        end
    end, { bool1, onMediaResolved, tbl1.onFirstMediaResolved })

    if bool1 then
        return nil
    end

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        AnchorPoint = tbl1.anchorPoint,
        Position = tbl1.position,
        LayoutOrder = tbl1.layoutOrder,
        Size = UDim2.fromScale(1, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        BorderSizePixel = 0
    }

    local tbl3 = {
        MediaGallery = React.createElement(MediaGalleryCarousel, {
            items = items,
            startIndex = var9.previewStartIndex,
            analyticsSourceId = universeId,
            itemPadding = tbl1.itemPadding,
            aspectRatio = tbl1.aspectRatio,
            autoAdvanceEnabled = not (tbl1.autoAdvanceEnabled == false) and not var9.isFullscreen,
            autoAdvanceIntervalSeconds = tbl1.autoAdvanceIntervalSeconds,
            showPageIndicators = tbl1.showPageIndicators,
            isMediaGalleryOccluded = var9.isFullscreen,
            autoplay = tbl1.autoplay,
            muted = tbl1.muted,
            looped = tbl1.looped,
            showPlayButton = tbl1.showPlayButton,
            showProgressBar = tbl1.showProgressBar,
            showGradient = tbl1.showGradient,
            gradientOverlayHeight = tbl1.gradientOverlayHeight,
            onYouTubeVideoPlay = onYouTubeVideoPlay,
            onFullscreenToggle = var9.onFullscreenToggle,
            onMediaChanged = onMediaChanged,
            onMediaResolved = onMediaResolved,
            videoPlaybackCoordinator = videoPlaybackCoordinator,
            videoAnalytics = videoAnalytics,
            cornerRadius = tbl1.cornerRadius,
            fullscreenEnabled = tbl1.fullscreenEnabled,
            overlay = tbl1.overlay,
            Size = UDim2.fromScale(1, 0),
            AnchorPoint = tbl1.anchorPoint,
            Position = tbl1.position
        })
    }
    return createElement(str1, tbl2, tbl3)
end)
