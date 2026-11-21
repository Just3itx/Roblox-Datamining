-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:20:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTile = script:FindFirstAncestor("GameTile")
local UserGameSettings = UserSettings():GetService("UserGameSettings")

local GameTileView = require(GameTile.GameTileView)
local getGameTileLayoutData = require(GameTile.getGameTileLayoutData)
local _GameTileTypes = require(GameTile.GameTileTypes)
local formatExperienceThumbnail = require(GameTile.formatExperienceThumbnail)
local GameStats = require(GameTile.Footer.GameStats)
local GameTileConstants = require(GameTile.GameTileConstants)
local GameTileViewConfig = require(GameTile.GameTileViewConfig)
local CreatorNameMetadata = require(GameTile.Footer.CreatorNameMetadata)
local AppExperienceActionRow = require(GameTile.AppExperienceActionRow)
local useIsHoveredTile = require(GameTile.useIsHoveredTile)
local GridTileTextFooter = require(GameTile.Footer.GridTileTextFooter)
local ItemLayoutDataParsingUtils = require(GameTile.ItemLayoutDataParsingUtils)
local HoverTileCoordinator = require(GameTile.HoverTileCoordinator)
local getTileBadgeByPositionConfigFromEntry = require(GameTile.getTileBadgeByPositionConfigFromEntry)
local GameTileVideoThumbnail = require(GameTile.GameTileVideoThumbnail)
local GameVideoPlaybackDetector = require(GameTile.Video.GameVideoPlaybackDetector)

local GameTileParent = GameTile.Parent
local GameCollectionItemTypes = require(GameTileParent.DiscoveryTypes).GameCollectionItemTypes
local React = require(GameTileParent.React)
local Responsive = require(GameTileParent.Responsive)
local usePreferredInput = Responsive.usePreferredInput
local RoactUtils = require(GameTileParent.RoactUtils)
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local GameInfosReducer = require(GameTileParent.GameInfosRodux).GameInfosReducer
local GameHydrationReact = require(GameTileParent.GameHydrationReact)
local ApiFetchGameDetails = require(GameTileParent.GameDetailRodux).GameDetails.ApiFetchGameDetails
local RoactNetworking = require(GameTileParent.RoactServiceTags).RoactNetworking
local useRoactService = require(GameTileParent.RobloxAppHooks).useRoactService
local ImpressionsTagUtility = require(GameTileParent.Impressions).ImpressionsTagUtility
local useTokens = require(GameTileParent.Foundation).Hooks.useTokens
local useDesignTokens = require(GameTileParent.Style).useDesignTokens
local IsVRAppBuild = require(GameTileParent.AppCommonLib).IsVRAppBuild
local sponsoredGamesRecordClick = require(GameTileParent.DiscoveryAnalytics).Requests.sponsoredGamesRecordClick
local VideoUtils = require(GameTileParent.VideoUtils)
local useTagAsViewportAutoplayCandidate = VideoUtils.useTagAsViewportAutoplayCandidate
local VideoPlaybackCoordinator = VideoUtils.VideoPlaybackCoordinator
local VideoEndReason = VideoUtils.AnalyticsEnums.VideoEndReason

local GameTileThumbnailBadges = require(GameTile.Overlays.GameTileThumbnailBadges)
local FFlagLuaAppTileVideoCandidateOnly = require(GameTileParent.SharedFlags).FFlagLuaAppTileVideoCandidateOnly
local FFlagLuaAppOneByTwoHoverIdleAutoplay = require(GameTileParent.SharedFlags).FFlagLuaAppOneByTwoHoverIdleAutoplay
local FFlagLuaAppHomeThumbnailPrefetch = require(GameTileParent.SharedFlags).FFlagLuaAppHomeThumbnailPrefetch
local FFlagLuaAppEdpMediaGalleryVideoPreview = require(GameTileParent.SharedFlags).FFlagLuaAppEdpMediaGalleryVideoPreview
local FFlagLuaAppEmphasisGameTileVideo = require(GameTileParent.SharedFlags).FFlagLuaAppEmphasisGameTileVideo

local FFlagLuaAppSuppressVideoDetectorDuringScroll = require(GameTileParent.SharedFlags).FFlagLuaAppSuppressVideoDetectorDuringScroll
local FIntLuaAppGameTileVideoDwellTimeInSec = require(GameTileParent.SharedFlags).FIntLuaAppGameTileVideoDwellTimeInSec
local FIntLuaAppGameTileVideoVisiblePercent = require(GameTileParent.SharedFlags).FIntLuaAppGameTileVideoVisiblePercent

local FFlagLuaAppGameTileSelectionVideoPlayback = require(GameTileParent.SharedFlags).FFlagLuaAppGameTileSelectionVideoPlayback
local resolveGameTileThumbnailUri = if FFlagLuaAppHomeThumbnailPrefetch then require(GameTile.resolveGameTileThumbnailUri) else nil

return function(tbl1)
    local var1 = useDesignTokens()
    local var2 = useTokens()

    local universeId = tbl1.entry.universeId

    local game = useSelector(function(arg1)
        return arg1.Personalization[GameInfosReducer.key][universeId]
    end)

    local var4 = GameHydrationReact.useGameInfo(universeId)
    local var5 = GameHydrationReact.useGameVotes(universeId)
    local var6 = useSelector(function(arg1)
        return arg1.GameDetails[universeId]
    end)

    local var7 = useRoactService(RoactNetworking)
    local var8 = useDispatch()
    React.useEffect(function()
        if var6 then
            return
        end

        var8(ApiFetchGameDetails.Fetch(var7, { universeId }))
    end, {
        var6,
        universeId,
        var7,
        var8
    })
    local gameTileLayoutData = getGameTileLayoutData(game, tbl1.topicId)

    local gameTileLayoutType = tbl1.gameTileLayoutType or "Narrow"
    local bool1 = gameTileLayoutType == "Wide" or gameTileLayoutType == "Event"

    local var9 = GameHydrationReact.useLargeGameIcon(universeId) or ""

    if FFlagLuaAppHomeThumbnailPrefetch then
        var9 = resolveGameTileThumbnailUri({
            iconUrl = var9,
            universeId = universeId,
            placeId = tbl1.entry.placeId,
            useGridTile = bool1,
            isEmphasized = true,
            perEntryWideAssetId = tbl1.entry.primaryWideImageAssetId,
            game = game,
            topicId = tbl1.topicId
        })
    else
        local var10 = if tbl1.entry.primaryWideImageAssetId then tbl1.entry.primaryWideImageAssetId else ItemLayoutDataParsingUtils.getWideImageAssetId(gameTileLayoutData)

        if not var10 then
            if game then
                var10 = game.primaryWideAssetId or nil
            else
                var10 = nil
            end
        end

        local var11 = formatExperienceThumbnail(var10, tbl1.entry.placeId, true)
        if bool1 then
            var9 = var11
        end
    end
    local imageAspectRatio = GameTileViewConfig.getImageAspectRatio(gameTileLayoutType)

    local title = gameTileLayoutData and gameTileLayoutData.title or var4 and var4.name or ""
    local isHoverSupported = not (IsVRAppBuild() or not tbl1.useHoverTile) and tbl1.impressionsTag ~= nil
    local var11 = React.useRef(nil)
    local videoKey = `{tbl1.impressionsTag or ""}_{tbl1.index}_{gameTileLayoutType}`
    local isHovered = useIsHoveredTile(var11, videoKey, isHoverSupported)

    local videoPlaybackCoordinator = if FFlagLuaAppEmphasisGameTileVideo then if tbl1.videoPlaybackContext and tbl1.videoPlaybackContext.videoPlaybackCoordinator then tbl1.videoPlaybackContext.videoPlaybackCoordinator else VideoPlaybackCoordinator.default else nil

    local useCallback = React.useCallback
    local function func1()
        if isHovered then
            HoverTileCoordinator.default:reset()
        end

        if FFlagLuaAppEmphasisGameTileVideo then
            videoPlaybackCoordinator:reset(VideoEndReason.TileClicked, nil, universeId, nil)
        end

        local tbl2 = {
            source = tbl1.source,
            index = tbl1.index,
            referralSource = tbl1.referralSource,
            onPeekViewClosed = tbl1.onPeekViewClosed,
            experienceJoinData = {
                tileType = tbl1.entry.tileType or GameCollectionItemTypes.GameCollectionItemType.EmphasisTile,
                nativeAdData = tbl1.entry.adId
            }
        }

        tbl1.navigateToGameDetails(universeId, tbl2)

        tbl1.reportGameDetailOpened(tbl1.index, universeId)

        if tbl1.entry.isSponsored then
            sponsoredGamesRecordClick(var7, tbl1.entry.adId)
        end
    end

    local source = tbl1.source
    local onPeekViewClosed = tbl1.onPeekViewClosed
    local isSponsored = tbl1.entry.isSponsored
    local adId = tbl1.entry.adId
    local tileType = if FFlagLuaAppEmphasisGameTileVideo then tbl1.entry.tileType else nil
    local reportGameDetailOpened = tbl1.reportGameDetailOpened

    local navigateToGameDetails = tbl1.navigateToGameDetails
    local referralSource = tbl1.referralSource
    local index = tbl1.index
    local var14 = if FFlagLuaAppEmphasisGameTileVideo then videoPlaybackCoordinator else nil
    local var15 = useCallback(func1, {
        universeId,
        source,
        onPeekViewClosed,
        isSponsored,
        adId,
        tileType,
        reportGameDetailOpened,
        var7,
        navigateToGameDetails,
        referralSource,
        index,
        isHovered,
        var14
    })

    local showDescription = tbl1.showDescription or false

    local upVotes = var5 and var5.upVotes or 0
    local downVotes = var5 and var5.downVotes or 0

    local hasVerifiedBadge = var6 and var6.creator and var6.creator.hasVerifiedBadge
    local description = var6 and var6.description or ""
    local licenseDescription = if var6 then var6.licenseDescription or nil else nil
    local localizedFiatPrice = if var6 then var6.localizedFiatPrice or nil else nil
    local text = licenseDescription or localizedFiatPrice

    local hideGameStats = tbl1.hideGameStats or showDescription or text ~= nil

    local name = var4 and var4.creator and var4.creator.name
    local var3 = name ~= "" and name or var6 and var6.creator and var6.creator.name

    local linesOfText = if text then 2 else 3

    local numLinesForMetadata = React.useMemo(function(): number
        local num2 = 0

        if var3 and var3 ~= "" then
            num2 += 1
        end
        if showDescription then
            num2 += linesOfText
        end
        if not hideGameStats then
            num2 += 1
        end
        if text then
            num2 += 1
        end

        return num2
    end, {
        var3,
        showDescription,
        hideGameStats,
        text,
        linesOfText
    })

    local isContained = tbl1.isContained or false

    local playButtonHeight = GameTileViewConfig.getElementSizes(var1, tbl1.textSizeOffset, 1, var2, true, numLinesForMetadata).playButtonHeight

    local useCallback2 = React.useCallback
    local function func2(...)
        if isHovered then
            HoverTileCoordinator.default:reset()
        end

        if tbl1.reportExperienceLaunched then
            tbl1.reportExperienceLaunched(...)
        end

        if FFlagLuaAppEmphasisGameTileVideo then
            videoPlaybackCoordinator:reset(VideoEndReason.ExperienceLaunched, nil, universeId, nil)
        end
    end

    local reportExperienceLaunched = tbl1.reportExperienceLaunched
    local var20 = if FFlagLuaAppEmphasisGameTileVideo then universeId else nil
    local var21 = if FFlagLuaAppEmphasisGameTileVideo then videoPlaybackCoordinator else nil
    local var10 = useCallback2(func2, { isHovered, reportExperienceLaunched, var20, var21 })

    local var23 = React.useMemo(function()
        return React.createElement(AppExperienceActionRow, {
            universeId = universeId,
            referralSource = tbl1.referralSource,
            launchSource = "FeaturedSearchTile",
            reportExperienceLaunched = var10,
            openGameDetails = var15,
            entry = tbl1.entry,
            launchExperienceEventContext = tbl1.launchExperienceEventContext,
            showButtonText = imageAspectRatio > 1,
            horizontalPadding = 0,
            verticalPadding = 0,
            height = playButtonHeight,
            index = tbl1.index,
            isUnifiedGameTileEnabled = true
        })
    end, {
        universeId,
        tbl1.referralSource,
        var10,
        var15,
        tbl1.entry,
        tbl1.launchExperienceEventContext,
        playButtonHeight,
        tbl1.index,
        imageAspectRatio
    })

    local footerMetadata = React.useMemo(function()
        local createElement = React.createElement
        local fragment = React.Fragment
        local tbl2 = {}
        local tbl3 = {
            UIListLayout = React.createElement(
                "UIListLayout",
                {
                    FillDirection = Enum.FillDirection.Vertical,
                    SortOrder = Enum.SortOrder.LayoutOrder
                }
            ),
            ExtraMetadata = if text then React.createElement(
                GridTileTextFooter,
                { text = text, LayoutOrder = 1, useLargerFont = true, isUnifiedGameTile = true }
            ) else nil,
            CreatorName = React.createElement(CreatorNameMetadata, { name = var3, hasVerifiedBadge = hasVerifiedBadge, LayoutOrder = 2 }),
            GameStats = React.createElement(GameStats, {
                stats = {
                    totalUpVotes = upVotes,
                    totalDownVotes = downVotes,
                    playerCount = if tbl1.playerCountStyle == GameTileConstants.PlayerCountStyleValues.Footer then tbl1.entry.playerCount else nil
                },
                isGridTile = bool1,
                hideGameStats = hideGameStats,
                gameTileLayoutType = gameTileLayoutType,
                LayoutOrder = 3,
                useLargerFont = true,
                isUnifiedGameTile = true
            }),
            Description = if showDescription then React.createElement(GridTileTextFooter, {
                text = description,
                LayoutOrder = 4,
                linesOfText = linesOfText,
                useLargerFont = true,
                isUnifiedGameTile = true,
                TextYAlignment = Enum.TextYAlignment.Top,
                ClipsDescendants = true,
                TextWrapped = true
            }) else nil
        }
        return createElement(fragment, tbl2, tbl3)
    end, {
        var3,
        upVotes,
        downVotes,
        tbl1.playerCountStyle,
        tbl1.entry.playerCount,
        bool1,
        hideGameStats,
        gameTileLayoutType,
        showDescription,
        description,
        text,
        hasVerifiedBadge,
        linesOfText
    })

    local var25, var26 = React.useState(Vector2.new(0, 0))

    local var27 = React.useMemo(function()
        local tileHeight = GameTileViewConfig.getTileHeight(
            var1,
            var25.X,
            gameTileLayoutType,
            isContained,
            false,
            false,
            tbl1.textSizeOffset,
            nil,
            1,
            numLinesForMetadata,
            var2,
            true
        )

        return var25.Y - tileHeight
    end, {
        var1,
        var25,
        gameTileLayoutType,
        isContained,
        tbl1.textSizeOffset,
        1,
        numLinesForMetadata,
        var2
    })

    local ref = React.useRef(nil)
    React.useEffect(function()
        ImpressionsTagUtility.AddTag(ref, tbl1.impressionsTag, tbl1.index)
        return function()
            ImpressionsTagUtility.RemoveTag(ref, tbl1.impressionsTag, tbl1.index)
        end
    end, { tbl1.impressionsTag, tbl1.index })

    local var29 = nil
    local var30 = nil
    local var31 = nil
    local var32 = nil
    local var33 = nil
    local var34 = nil
    local onSelectionGained = nil
    local onSelectionLost = nil
    local var35 = nil

    local var36 = nil
    local bool3

    if FFlagLuaAppEmphasisGameTileVideo then
        var35 = not (tbl1.videoPlaybackContext == nil) and tbl1.videoPlaybackContext.disablePlayback == true
        bool3 = FFlagLuaAppSuppressVideoDetectorDuringScroll

        if bool3 then
            if tbl1.videoPlaybackContext == nil then
                bool3 = false
            else
                bool3 = tbl1.videoPlaybackContext.disableDetectors == true
            end
        end

        local var37
        var29, var37 = React.useState(false)
        var30 = var37
        var31 = React.useCallback(function(bool4: boolean)
            var30(bool4)
        end, {})
        if tbl1.entry.primaryWideVideoAssetId then
            var32 = tbl1.entry.primaryWideVideoAssetId
        else
            var32 = gameTileLayoutData and gameTileLayoutData.primaryMediaAsset and gameTileLayoutData.primaryMediaAsset.wideVideoAssetId
        end
        if FFlagLuaAppGameTileSelectionVideoPlayback then
            local var38
            var33, var38 = React.useState(false)
            var34 = var38

            onSelectionGained = React.useCallback(function(...)
                var34(true)

                if tbl1.onSelectionGained then
                    tbl1.onSelectionGained(...)
                end
            end, { tbl1.onSelectionGained })

            onSelectionLost = React.useCallback(function(...)
                var34(false)

                if tbl1.onSelectionLost then
                    tbl1.onSelectionLost(...)
                end
            end, { tbl1.onSelectionLost })
        end

        if not FFlagLuaAppGameTileSelectionVideoPlayback then
            if FFlagLuaAppEdpMediaGalleryVideoPreview then
                var36 = usePreferredInput()
            else
                var36 = nil
            end
        end
        React.useEffect(function()
            if var35 then
                var30(false)
            end
        end, { var35 })
    else
        bool3 = nil
    end

    local var37 = FFlagLuaAppEmphasisGameTileVideo and var32 ~= nil

    useTagAsViewportAutoplayCandidate(
        if FFlagLuaAppEmphasisGameTileVideo then var11 else ref,
        tbl1.videoPlaybackContext,
        if FFlagLuaAppTileVideoCandidateOnly then if FFlagLuaAppEmphasisGameTileVideo then var37 else false else nil,
        nil,
        nil,
        nil,
        nil,
        if FFlagLuaAppOneByTwoHoverIdleAutoplay then var37 and {
            videoKey = videoKey,
            isUserIntentModeAutoplayCandidate = false
        } or nil else nil
    )
    local element, var38

    if FFlagLuaAppEmphasisGameTileVideo then
        if var37 then
            element = React.createElement(GameTileVideoThumbnail, {
                video = `rbxassetid://{var32}`,
                image = var9,
                playing = var29,
                looped = true,
                Size = UDim2.fromScale(1, 1),
                isTileContained = isContained,
                cornerRadius = var2.Radius.Medium,
                ZIndex = -2,
                itemIndex = tbl1.index,
                videoAnalytics = tbl1.videoAnalytics,
                universeId = universeId,
                videoPlaybackCoordinator = videoPlaybackCoordinator
            })
        else
            element = nil
        end

        if var37 and not (var35 or FFlagLuaAppSuppressVideoDetectorDuringScroll and bool3) then
            local createElement = React.createElement
            local var39 = GameVideoPlaybackDetector
            local tbl2 = {
                videoKey = videoKey,
                itemIndex = tbl1.index,
                universeId = tostring(universeId),
                tileRef = var11,
                isHoverSupported = isHoverSupported,
                isHovered = isHovered,
                isSelected = 0,
                autoplay = 0,
                onPlaybackChange = 0,
                videoAnalytics = 0,
                videoDwellTimeInSec = 0,
                videoVisiblePercent = 0,
                pageContext = 0,
                videoPlaybackContext = 0
            }

            if not FFlagLuaAppGameTileSelectionVideoPlayback then
                var33 = nil
            end

            tbl2.isSelected = var33
            tbl2.autoplay = if FFlagLuaAppGameTileSelectionVideoPlayback or not FFlagLuaAppEdpMediaGalleryVideoPreview then nil else var36 == Responsive.Input.Touch

            tbl2.onPlaybackChange = var31
            tbl2.videoAnalytics = tbl1.videoAnalytics
            tbl2.videoDwellTimeInSec = FIntLuaAppGameTileVideoDwellTimeInSec
            tbl2.videoVisiblePercent = FIntLuaAppGameTileVideoVisiblePercent
            tbl2.pageContext = tbl1.appPage
            tbl2.videoPlaybackContext = tbl1.videoPlaybackContext
            var38 = createElement(var39, tbl2)
        else
            var38 = nil
        end
    else
        element = nil
        var38 = nil
    end

    local tileBadgesByPosition = getTileBadgeByPositionConfigFromEntry(tbl1.entry)
    local thumbnailOverlay = if tileBadgesByPosition then React.createElement(GameTileThumbnailBadges, { tileBadgesByPosition = tileBadgesByPosition }) else nil
    local createElement = React.createElement
    local str2 = "Frame"
    local tbl2 = {
        BackgroundTransparency = 1,
        LayoutOrder = tbl1.layoutOrder,
        ZIndex = -tbl1.index
    }
    local tbl3 = { EmphasisTileContainer = 0 }
    local createElement2 = React.createElement
    local str3 = "Frame"
    local tbl4 = {
        AnchorPoint = Vector2.new(0, 0),
        Position = UDim2.fromScale(0, 0),
        Size = tbl1.size,
        BackgroundTransparency = 1,
        ref = ref
    }

    tbl4[React.Change.AbsoluteSize] = function(arg1)
        var26(arg1.AbsoluteSize)
    end
    local tbl5 = { GameTileView = 0, VideoPlaybackDetector = 0 }
    local createElement3 = React.createElement
    local var39 = GameTileView
    local tbl6 = {
        forwardRef = var11,
        SelectionOrder = tbl1.SelectionOrder,
        isDisabled = tbl1.isDisabled,
        onActivated = var15,
        onSelectionGained = 0,
        onSelectionLost = 0,
        image = 0,
        thumbnailComponent = 0,
        title = 0,
        numLinesForTitle = 1,
        numLinesForMetadata = 0,
        isHovered = 0,
        footerMetadata = 0,
        isUnifiedGameTile = true,
        imageAspectRatio = 0,
        isContained = 0,
        extraFooterContent = 0,
        extraFooterSpace = 0,
        hidePlayButton = true,
        reducedMotion = 0,
        thumbnailOverlay = 0
    }

    if not (FFlagLuaAppEmphasisGameTileVideo and FFlagLuaAppGameTileSelectionVideoPlayback) then
        onSelectionGained = tbl1.onSelectionGained
    end

    tbl6.onSelectionGained = onSelectionGained

    if not (FFlagLuaAppEmphasisGameTileVideo and FFlagLuaAppGameTileSelectionVideoPlayback) then
        onSelectionLost = tbl1.onSelectionLost
    end

    tbl6.onSelectionLost = onSelectionLost

    tbl6.image = var9
    if not FFlagLuaAppEmphasisGameTileVideo then
        element = nil
    end

    tbl6.thumbnailComponent = element
    tbl6.title = title

    tbl6.numLinesForMetadata = numLinesForMetadata
    tbl6.isHovered = isHovered
    tbl6.footerMetadata = footerMetadata

    tbl6.imageAspectRatio = imageAspectRatio
    tbl6.isContained = isContained
    if showDescription then
        var23 = nil
    end

    tbl6.extraFooterContent = var23
    if showDescription then
        var27 = nil
    end

    tbl6.extraFooterSpace = var27

    tbl6.reducedMotion = UserGameSettings.ReducedMotion
    tbl6.thumbnailOverlay = thumbnailOverlay
    tbl5.GameTileView = createElement3(var39, tbl6)

    if not FFlagLuaAppEmphasisGameTileVideo then
        var38 = nil
    end

    tbl5.VideoPlaybackDetector = var38
    tbl3.EmphasisTileContainer = createElement2(str3, tbl4, tbl5)
    return createElement(str2, tbl2, tbl3)
end
