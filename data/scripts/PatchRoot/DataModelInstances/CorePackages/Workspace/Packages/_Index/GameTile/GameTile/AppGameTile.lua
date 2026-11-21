-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:20:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContentProvider = game:GetService("ContentProvider")
local GameTile = script:FindFirstAncestor("GameTile")
local GridTileIconTextFooter = require(GameTile.Footer.GridTileIconTextFooter)
local GridTileFriendFooter = require(GameTile.Footer.GridTileFriendFooter).GridTileFriendFooter
local GridTileTextFooter = require(GameTile.Footer.GridTileTextFooter)
local GameStats = require(GameTile.Footer.GameStats)
local GridTileSponsoredFooter = require(GameTile.Footer.GridTileSponsoredFooter)
local RatingWithGenreFooter = require(GameTile.Footer.RatingWithGenreFooter)
local GameTileThumbnailBadges = require(GameTile.Overlays.GameTileThumbnailBadges)
local sortFriendsByPresenceAndRecencyFactory = require(GameTile.sortFriendsByPresenceAndRecencyFactory)
local OpenCentralOverlayForPlacesList = require(GameTile.OpenCentralOverlayForPlacesList)
local GameTileView = require(GameTile.GameTileView)
local AppExperienceActionRow = require(GameTile.AppExperienceActionRow)
local GameTileConstants = require(GameTile.GameTileConstants)
local OpenSponsoredTooltip = require(GameTile.OpenSponsoredTooltip)
local GameTileTypes = require(GameTile.GameTileTypes)
local useIsHoveredTile = require(GameTile.useIsHoveredTile)
local HoverTileCoordinator = require(GameTile.HoverTileCoordinator)
local getGameTileLayoutData = require(GameTile.getGameTileLayoutData)
local GameTileViewConfig = require(GameTile.GameTileViewConfig)
local useHasInGameFriends = require(GameTile.useHasInGameFriends)
local useInGameUserIds = require(GameTile.useInGameUserIds)

local useValidTileBadges = require(GameTile.Overlays.useValidTileBadges)
local GameTileVideoThumbnail = require(GameTile.GameTileVideoThumbnail)
local VideoEndReason = require(GameTile.Video.Analytics.VideoEndReason)
local GameVideoPlaybackDetector = require(GameTile.Video.GameVideoPlaybackDetector)
local useHasVideoThumbnailSelector = require(GameTile.Video.useHasVideoThumbnailSelector)
local getLayoutDataVideo = require(GameTile.getLayoutDataVideo)
local formatExperienceIcon = require(GameTile.formatExperienceIcon)
local formatExperienceThumbnail = require(GameTile.formatExperienceThumbnail)
local HiddenTileContent = require(GameTile.HiddenGameTile.HiddenTileContent)
local ItemLayoutDataParsingUtils = require(GameTile.ItemLayoutDataParsingUtils)

local GameTileParent = GameTile.Parent
local GameCollectionItemTypes = require(GameTileParent.DiscoveryTypes).GameCollectionItemTypes
local AppBlox = require(GameTileParent.AppBlox)
local React = require(GameTileParent.React)
local None = React.None
local Roact = require(GameTileParent.Roact)
local RoactRodux = require(GameTileParent.RoactRodux)
local Cryo = require(GameTileParent.Cryo)
local Foundation = require(GameTileParent.Foundation)
local RoactServices = require(GameTileParent.RoactServices).RoactServices
local RoactNetworking = require(GameTileParent.RoactServiceTags).RoactNetworking
local VideoUtils = require(GameTileParent.VideoUtils)
local t = require(GameTileParent.t)
local UIBlox = require(GameTileParent.UIBlox)
local SharedFlags = require(GameTileParent.SharedFlags)
local FFlagLuaAppGameTileNotInterestedDirectAction = SharedFlags.FFlagLuaAppGameTileNotInterestedDirectAction
local FFlagSignalsNavP3fGameDetails = SharedFlags.FFlagSignalsNavP3fGameDetails

local withStyle = UIBlox.Style.withStyle
local Images = UIBlox.App.ImageSet.Images
local AspectRatioModeEnum = UIBlox.App.Tile.AspectRatioModeEnum
local ImpressionsTagUtility = require(GameTileParent.Impressions).ImpressionsTagUtility
local useUiModeInfo = require(GameTileParent.RobloxAppHooks).useUiModeInfo
local useRoactService = require(GameTileParent.RobloxAppHooks).useRoactService
local UiMode = require(GameTileParent.RobloxAppEnums).UiMode
local memoize = require(GameTileParent.AppCommonLib).memoize
local IntervalPerformanceTracker = require(GameTileParent.IntervalPerformanceTracker).IntervalPerformanceTracker
local GameInfosReducer = require(GameTileParent.GameInfosRodux).GameInfosReducer
local toLegacyGameInfoModel = require(GameTileParent.GameInfosRodux).toLegacyGameInfoModel
local useSelector = require(GameTileParent.RoactUtils).Hooks.RoactRodux.useSelector
local _DataHydration = require(GameTileParent.DataHydration)
local GameHydrationReact = require(GameTileParent.GameHydrationReact)
local useTokens = require(GameTileParent.Foundation).Hooks.useTokens
local getOverflowMenuSignalStore = AppBlox.getOverflowMenuSignalStore
local useOverflowMenuOpen = AppBlox.useOverflowMenuOpen
local useTriggerFeedback = require(GameTileParent.InteractionFeedback).useTriggerFeedback
local DiscoveryAnalytics = require(GameTileParent.DiscoveryAnalytics)
local gameTileOverflowMenuAction = DiscoveryAnalytics.Events.gameTileOverflowMenuAction
local sponsoredGamesRecordClick = DiscoveryAnalytics.Requests.sponsoredGamesRecordClick

local Responsive = require(GameTileParent.Responsive)
local usePreferredInput = Responsive.usePreferredInput
local useTagAsViewportAutoplayCandidate = VideoUtils.useTagAsViewportAutoplayCandidate

local DiscoveryAppLaunchTracker = require(GameTileParent.AppLaunchTracker).DiscoveryAppLaunchTracker

local GetFFlagEnableNavigationPerformanceIntervals = require(GameTileParent.SharedFlags).GetFFlagEnableNavigationPerformanceIntervals
local FFlagLuaAppMigrateGameTileHoverFixes = require(GameTileParent.SharedFlags).FFlagLuaAppMigrateGameTileHoverFixes

local FFlagLuaAppMigrateGameTileFixConsoleMetadataText = require(GameTileParent.SharedFlags).FFlagLuaAppMigrateGameTileFixConsoleMetadataText

local FFlagLuaAppUnifyPlayButtonTile = require(GameTileParent.SharedFlags).FFlagLuaAppUnifyPlayButtonTile
local FFlagLuaAppEdpMediaGalleryVideoPreview = require(GameTileParent.SharedFlags).FFlagLuaAppEdpMediaGalleryVideoPreview
local FFlagLuaAppEdpMediaGalleryFullScreen = require(GameTileParent.SharedFlags).FFlagLuaAppEdpMediaGalleryFullScreen
local FFlagLuaAppGameDetailsAttributionFix = require(GameTileParent.SharedFlags).FFlagLuaAppGameDetailsAttributionFix

local FFlagLuaAppMigrateGameTileActiveFriendsHydrationFix = require(GameTileParent.SharedFlags).FFlagLuaAppMigrateGameTileActiveFriendsHydrationFix
local FFlagGameTileMigrateOffLegacyPresence = require(GameTileParent.SharedFlags).FFlagGameTileMigrateOffLegacyPresence
local useGetOnlineFriendsByUniverseId = if FFlagGameTileMigrateOffLegacyPresence then require(GameTileParent.FriendsHydrationReact).useGetOnlineFriendsByUniverseId else nil
local FFlagLuaAppEnableReportExperience = require(GameTileParent.SharedFlags).FFlagLuaAppEnableReportExperience
local FFlagLuaAppNarrowTileHideRating = require(GameTileParent.SharedFlags).FFlagLuaAppNarrowTileHideRating
local FFlagLuaAppNarrowTileHidePlayerCount = require(GameTileParent.SharedFlags).FFlagLuaAppNarrowTileHidePlayerCount
local FIntLuaAppGameTileVideoDwellTimeInSec = require(GameTileParent.SharedFlags).FIntLuaAppGameTileVideoDwellTimeInSec
local FIntLuaAppGameTileVideoVisiblePercent = require(GameTileParent.SharedFlags).FIntLuaAppGameTileVideoVisiblePercent
local FFlagLuaAppTileVideoCandidateOnly = require(GameTileParent.SharedFlags).FFlagLuaAppTileVideoCandidateOnly
local FFlagLuaAppOneByTwoHoverIdleAutoplay = require(GameTileParent.SharedFlags).FFlagLuaAppOneByTwoHoverIdleAutoplay
local bool1 = game:DefineFastFlag("LuaAppKeepTileBadgesDuringVideo", false)
local FFlagLuaAppVideoTileDisableActivation = require(GameTileParent.SharedFlags).FFlagLuaAppVideoTileDisableActivation
local FFlagLuaAppFixHiddenTileVideoCleanup = require(GameTileParent.SharedFlags).FFlagLuaAppFixHiddenTileVideoCleanup

local FFlagLuaAppUsePrevalidatedVideoGamePlayability = require(GameTileParent.SharedFlags).FFlagLuaAppUsePrevalidatedVideoGamePlayability
local FFlagLuaAppContinueSortInstantPlay = require(GameTileParent.SharedFlags).FFlagLuaAppContinueSortInstantPlay

local FFlagLuaAppGameTileExtractGameDetailsCallback = require(GameTileParent.SharedFlags).FFlagLuaAppGameTileExtractGameDetailsCallback
local FFlagLuaAppDemoModePlayButtonTelemetry = require(GameTileParent.SharedFlags).FFlagLuaAppDemoModePlayButtonTelemetry
local InstantPlayLauncher = require(GameTile.InstantPlayLauncher)
local InstantPlayButton = require(GameTile.InstantPlayButton)
local FFlagLuaAppGenreRatingFooter = require(GameTileParent.SharedFlags).FFlagLuaAppGenreRatingFooter

local FFlagLuaAppGameTileSelectionVideoPlayback = require(GameTileParent.SharedFlags).FFlagLuaAppGameTileSelectionVideoPlayback

local FFlagLuaAppSuppressVideoDetectorDuringScroll = require(GameTileParent.SharedFlags).FFlagLuaAppSuppressVideoDetectorDuringScroll
local FFlagLuaAppHomeThumbnailPrefetch = require(GameTileParent.SharedFlags).FFlagLuaAppHomeThumbnailPrefetch
local FFlagLuaAppHomeMomentVideoFallback = require(GameTileParent.SharedFlags).FFlagLuaAppHomeMomentVideoFallback
local resolveGameTileThumbnailUri = if FFlagLuaAppHomeThumbnailPrefetch then require(GameTile.resolveGameTileThumbnailUri) else nil
local VideoPlaybackCoordinator = require(GameTileParent.VideoUtils).VideoPlaybackCoordinator

local GameTileContextualActions = require(GameTile.GameTileContextualActions)
local GameTileOverflowMenu = require(GameTile.GameTileOverflowMenu)
local getAvailableGameTileOverflowMenuItems = require(GameTile.getAvailableGameTileOverflowMenuItems)

local tbl1 = {}

game:DefineFastInt("LuaAppGameTileHoverDelayMs", 130)

local function getHoverDelay(): number -- Luacid: Inlined by compiler; 1 call site recovered
    return game:GetFastInt("LuaAppGameTileHoverDelayMs") / 1000
end

local var1 = FFlagLuaAppContinueSortInstantPlay
    and {
        Treatment1 = "SDUI.InstantPlay.Treatment1",
        Treatment2 = "SDUI.InstantPlay.Treatment2",
        Treatment3 = "SDUI.InstantPlay.Treatment3"
    }
    or nil
local tbl2

if FFlagLuaAppContinueSortInstantPlay then
    tbl2 = {}
    tbl2[var1.Treatment1] = true
    tbl2[var1.Treatment2] = true
    tbl2[var1.Treatment3] = true
else
    tbl2 = nil
end

local var2 = if FFlagLuaAppContinueSortInstantPlay then table.freeze({ isActive = false, isTreatment1 = false, isTreatment2 = false, isTreatment3 = false }) else nil

local var3 = FFlagLuaAppContinueSortInstantPlay and function(bool2: boolean?, str1: string?)
    if bool2 ~= true or str1 == nil or tbl2[str1] ~= true then
        return var2
    end

    return {
        isActive = true,
        isTreatment1 = str1 == var1.Treatment1,
        isTreatment2 = str1 == var1.Treatment2,
        isTreatment3 = str1 == var1.Treatment3
    }
end or nil

local var4 = Roact.PureComponent:extend("AppGameTile")

var4.validateProps = t.strictInterface({
    entry = t.table,
    reportGameDetailOpened = t.callback,
    reportExperienceLaunched = t.optional(t.callback),
    Size = t.optional(t.union(t.UDim2, t.table)),
    ZIndex = t.optional(t.number),
    useHoverTile = t.optional(t.boolean),
    hasBackground = t.boolean,
    useGridTile = t.boolean,
    playerCountStyle = t.optional(t.string),
    isSponsoredFooterAllowed = t.optional(t.boolean),
    isSponsoredRatingFooterAllowed = t.optional(t.boolean),
    useExperienceTileMetadata = t.boolean,
    hideGameStats = t.optional(t.boolean),
    gameTileLayoutType = t.optional(t.string),
    topicId = t.optional(t.string),
    playButtonStyle = t.optional(t.string),
    onGuiStateChanged = t.optional(t.callback),
    isDisabled = t.optional(t.boolean),
    onActivated = t.optional(t.callback),
    onSelectionGained = if FFlagLuaAppGameTileSelectionVideoPlayback then t.callback else t.optional(t.callback),
    onSelectionLost = if FFlagLuaAppGameTileSelectionVideoPlayback then t.callback else t.optional(t.callback),
    friendFooterEnabled = t.optional(t.boolean),
    index = t.optional(t.number),
    layoutOrder = t.optional(t.number),
    source = t.optional(t.string),
    referralSource = t.optional(t.string),
    onPeekViewClosed = t.optional(t.callback),
    rowNum = t.optional(t.number),
    showFriendActivity = t.boolean,
    contentTextLineCount = t.optional(t.number),
    metadataTextLineCount = t.optional(t.number),
    thumbnailAspectRatioOverride = t.optional(t.string),
    impressionsTag = t.optional(t.string),
    launchExperienceEventContext = t.optional(t.string),
    navigateToGameDetails = t.callback,
    isContained = t.optional(t.boolean),
    hideTitle = t.optional(t.boolean),
    hideMetadata = t.optional(t.boolean),
    textSizeOffset = t.optional(t.number),
    foundationTokens = t.optional(t.table),
    videoAnalytics = t.optional(t.table),
    hasPrevalidatedVideoGamePlayability = if FFlagLuaAppUsePrevalidatedVideoGamePlayability then t.optional(t.boolean) else nil,
    videoPlaybackContext = t.optional(t.table),
    SelectionOrder = t.optional(t.number),
    enableExplicitFeedback = t.optional(t.boolean),
    setGameHidden = t.optional(t.callback),
    appPage = t.optional(t.string),
    isHidden = t.optional(t.boolean),
    isNarrowScreenXSmall = t.optional(t.boolean),
    sponsoredUserCohort = t.optional(t.string),
    enableSponsoredFeedback = t.optional(t.boolean),
    availableMenuItems = t.optional(t.table),
    enableReportAd = t.optional(t.boolean),
    enableReportExperience = if FFlagLuaAppEnableReportExperience then t.optional(t.boolean) else nil,
    compactMetadataFormat = t.optional(t.boolean),
    hideRating = if FFlagLuaAppNarrowTileHideRating then t.optional(t.boolean) else nil,
    hidePlayerCount = if FFlagLuaAppNarrowTileHidePlayerCount then t.optional(t.boolean) else nil,
    game = t.optional(t.table),
    universeId = t.string,
    navigationUniverseId = t.optional(t.string),
    name = t.optional(t.string),
    friendActivityTitle = t.optional(t.string),
    friendVisitedString = t.optional(t.string),
    imageThumbnail = t.string,
    wideThumbnail = t.optional(t.string),
    videoThumbnail = t.optional(t.string),
    videoAccessContext = if FFlagLuaAppHomeMomentVideoFallback then t.optional(t.string) else nil,
    friendVisits = t.table,
    hidePlayButton = t.boolean,
    footerLayoutData = t.optional(t.table),
    openContextualMenu = t.callback,
    openSponsoredTooltip = t.callback,
    networking = t.callback,
    hoverRef = t.table,
    isHoverSupported = t.optional(t.boolean),
    isHovered = t.optional(t.boolean),
    gameIconUrl = t.optional(t.string),
    isSelected = if FFlagLuaAppGameTileSelectionVideoPlayback then t.boolean else nil,
    isVideoPlaying = t.boolean,
    tileBadges = t.optional(t.table),
    users = t.optional(t.table),
    inGameUsersByGame = t.optional(t.table),
    hasInGameFriends = t.boolean,
    inGameUserIds = if FFlagLuaAppMigrateGameTileActiveFriendsHydrationFix then t.table else nil,
    badgeOverride = t.optional(t.table),
    forceHideAgeRatings = t.optional(t.boolean),
    onGameTileActivated = if FFlagLuaAppGameDetailsAttributionFix then t.optional(t.callback) else nil,
    recordSponsoredGameClick = if FFlagLuaAppGameDetailsAttributionFix then t.optional(t.callback) else nil,
    overflowMenuOpen = t.optional(t.boolean),
    hoverKey = t.optional(t.string),
    triggerFeedback = t.callback,
    videoPlaybackDetector = t.optional(t.table),
    enableInstantPlay = if FFlagLuaAppContinueSortInstantPlay then t.optional(t.boolean) else nil,
    instantPlayTreatment = if FFlagLuaAppContinueSortInstantPlay then t.optional(t.string) else nil,
    isTouchPreferredInput = if FFlagLuaAppContinueSortInstantPlay then t.optional(t.boolean) else nil
})

local Narrow = GameTileTypes.GameTileLayoutType.Narrow
var4.defaultProps = {
    useHoverTile = false,
    hasBackground = false,
    useExperienceTileMetadata = false,
    useGridTile = false,
    thumbnailAspectRatioOverride = AspectRatioModeEnum.Square,
    gameTileLayoutType = Narrow,
    contentTextLineCount = GameTileConstants.TileTextLines[Narrow].titleTextLines,
    hideGameStats = false
}

function var4.init(arg1)
    if DiscoveryAppLaunchTracker.isEnabled() and DiscoveryAppLaunchTracker.default then
        DiscoveryAppLaunchTracker.default:trackTileInit()
    end

    arg1.state = {
        isHovered = false,
        canDisplayFriendFooter = false,
        isSelected = if FFlagLuaAppGameTileSelectionVideoPlayback then nil else false,
        instantPlayRequested = not FFlagLuaAppContinueSortInstantPlay and nil
    }

    arg1.gameInfoSubscription = GameHydrationReact.subscribeGameInfo({
        universeId = arg1.props.entry.universeId,
        onChange = function(arg2)
            arg1:setState({ gameInfo = arg2.gameInfo or None, storeVotes = arg2.votes or None })
        end
    })

    function arg1.onMenuOpenChanged(bool2: boolean, availableMenuItems: string?)
        local tbl3 = {
            universeId = arg1.props.universeId,
            sortId = arg1.props.topicId,
            actionType = if bool2 then "GameTileOverflowMenuClosed" else "GameTileOverflowMenuOpened",
            availableMenuItems = availableMenuItems
        }

        gameTileOverflowMenuAction(tbl3, arg1.props.appPage or "Unknown")
    end

    function arg1.onTouchLongPress()
        if next(arg1.props.availableMenuItems) == nil then
            return
        end

        if arg1.props.triggerFeedback and not arg1.props.overflowMenuOpen then
            local tbl3 = {
                universeId = arg1.props.universeId,
                sortId = arg1.props.topicId
            }

            arg1.props.triggerFeedback("TileLongPress", "Press", arg1.props.appPage or "Unknown", tbl3)
        end
        getOverflowMenuSignalStore().openMenu(arg1.props.hoverKey)
        local tbl3 = {}
        for k, _ in arg1.props.availableMenuItems do
            table.insert(tbl3, k)
        end

        arg1.onMenuOpenChanged(false, table.concat(tbl3, ","))
    end

    arg1.reportExperienceLaunched = FFlagLuaAppContinueSortInstantPlay and function(...)
        if FFlagLuaAppGameDetailsAttributionFix then
            arg1.props.recordSponsoredGameClick()
        else
            arg1.recordSponsoredGameClick()
        end

        if arg1.props.isHovered then
            HoverTileCoordinator.default:reset()
        end

        if arg1.props.reportExperienceLaunched then
            arg1.props.reportExperienceLaunched(...)
        end

        if arg1.props.videoPlaybackContext and arg1.props.videoPlaybackContext.videoPlaybackCoordinator then
            arg1.props.videoPlaybackContext.videoPlaybackCoordinator:reset(
                VideoEndReason.ExperienceLaunched,
                nil,
                arg1.props.navigationUniverseId,
                nil
            )
            return
        end

        VideoPlaybackCoordinator.default:reset(VideoEndReason.ExperienceLaunched, nil, arg1.props.navigationUniverseId, nil)
    end or nil

    arg1.reportExperienceLaunchedFromInstantPlay = FFlagLuaAppContinueSortInstantPlay and function(str1: string?)
        local reportExperienceLaunched = arg1.reportExperienceLaunched
        local entry = arg1.props.entry
        local referralSource = arg1.props.referralSource
        local str2 = "ExperienceTile"
        local instantPlay = DiscoveryAnalytics.Constants.Context.InstantPlay
        local index = arg1.props.index
        if not FFlagLuaAppDemoModePlayButtonTelemetry then
            str1 = nil
        end

        reportExperienceLaunched(entry, referralSource, str2, instantPlay, index, str1)
    end or nil

    arg1.reportExperienceLaunchedFromActionBar = not FFlagLuaAppContinueSortInstantPlay and function(...)
        if FFlagLuaAppGameDetailsAttributionFix then
            arg1.props.recordSponsoredGameClick()
        else
            arg1.recordSponsoredGameClick()
        end

        if arg1.props.isHovered then
            HoverTileCoordinator.default:reset()
        end

        if arg1.props.reportExperienceLaunched then
            arg1.props.reportExperienceLaunched(...)
        end

        if arg1.props.videoPlaybackContext and arg1.props.videoPlaybackContext.videoPlaybackCoordinator then
            arg1.props.videoPlaybackContext.videoPlaybackCoordinator:reset(
                VideoEndReason.ExperienceLaunched,
                nil,
                arg1.props.navigationUniverseId,
                nil
            )
            return
        end

        VideoPlaybackCoordinator.default:reset(VideoEndReason.ExperienceLaunched, nil, arg1.props.navigationUniverseId, nil)
    end or arg1.reportExperienceLaunched

    function arg1.renderAppExperienceActionRow(_)
        return Roact.createElement(AppExperienceActionRow, {
            universeId = arg1.props.navigationUniverseId,
            referralSource = arg1.props.referralSource,
            launchSource = "ExperienceTile",
            reportExperienceLaunched = arg1.reportExperienceLaunchedFromActionBar,
            openGameDetails = if FFlagLuaAppGameTileExtractGameDetailsCallback then arg1.onGameDetailsActivated else FFlagLuaAppGameDetailsAttributionFix and function()
                arg1.props.onGameTileActivated(arg1.isMounted)
            end or arg1.onActivated,
            entry = arg1.props.entry,
            launchExperienceEventContext = arg1.props.launchExperienceEventContext,
            horizontalPadding = if arg1.props.useGridTile then 0 else nil,
            index = arg1.props.index,
            isUnifiedGameTileEnabled = if FFlagLuaAppUnifyPlayButtonTile then true else nil,
            placeIdOverride = arg1.props.entry.placeIdOverride,
            launchDataOverride = arg1.props.entry.launchDataOverride
        })
    end

    arg1.onInstantPlayActivated = FFlagLuaAppContinueSortInstantPlay and function()
        if var3(arg1.props.enableInstantPlay, arg1.props.instantPlayTreatment).isActive then
            arg1:setState({ instantPlayRequested = true })
        end
    end or nil

    arg1.onInstantPlayAttemptCompleted = FFlagLuaAppContinueSortInstantPlay and function()
        arg1:setState({ instantPlayRequested = false })
    end or nil

    function arg1.onHoverChanged(isHovered)
        if isHovered and arg1.props.triggerFeedback then
            arg1.props.triggerFeedback("Default", "Hover")
        end

        arg1:setState({ isHovered = isHovered })
    end

    arg1.gameTileRef = Roact.createRef()

    function arg1.getTilePosition()
        if arg1.gameTileRef.current then
            return arg1.gameTileRef.current.AbsolutePosition
        end

        return nil
    end

    function arg1.getTileSize()
        if arg1.gameTileRef.current then
            return arg1.gameTileRef.current.AbsoluteSize
        end

        return nil
    end

    arg1.recordSponsoredGameClick = not FFlagLuaAppGameDetailsAttributionFix and function()
        local networking = arg1.props.networking
        local entry = arg1.props.entry
        if entry.isSponsored then
            sponsoredGamesRecordClick(networking, entry.adId)
        end
    end or nil

    arg1.onActivated = not FFlagLuaAppGameDetailsAttributionFix and function()
        if arg1.props.isHovered then
            HoverTileCoordinator.default:reset()
        end

        if arg1.props.videoPlaybackContext and arg1.props.videoPlaybackContext.videoPlaybackCoordinator then
            arg1.props.videoPlaybackContext.videoPlaybackCoordinator:reset(
                VideoEndReason.TileClicked,
                nil,
                arg1.props.navigationUniverseId,
                nil
            )
        else
            VideoPlaybackCoordinator.default:reset(VideoEndReason.TileClicked, nil, arg1.props.navigationUniverseId, nil)
        end

        if not arg1.isMounted then
            return
        end

        if arg1.props.onActivated then
            arg1.props.onActivated()
        end
        local navigationUniverseId = arg1.props.navigationUniverseId
        local tbl3 = {
            source = arg1.props.source,
            index = arg1.props.index,
            referralSource = arg1.props.referralSource,
            onPeekViewClosed = arg1.props.onPeekViewClosed,
            placeIdOverride = arg1.props.entry.placeIdOverride,
            experienceJoinData = {
                launchData = if arg1.props.entry.launchDataOverride then arg1.props.entry.launchDataOverride else nil,
                tileType = arg1.props.entry.tileType or GameCollectionItemTypes.GameCollectionItemType.GameTile,
                nativeAdData = arg1.props.entry.adId
            }
        }

        if GetFFlagEnableNavigationPerformanceIntervals() then
            IntervalPerformanceTracker:startTracking("AppGameTile_to_GameDetail", 2)
        end
        arg1.props.navigateToGameDetails(navigationUniverseId, tbl3)

        local index = arg1.props.index
        arg1.props.reportGameDetailOpened(index, navigationUniverseId)

        arg1.recordSponsoredGameClick()
    end or nil

    arg1.onGameDetailsActivated = FFlagLuaAppGameDetailsAttributionFix and function()
        arg1.props.onGameTileActivated(arg1.isMounted)
    end or arg1.onActivated

    function arg1.onFriendFooterActivated()
        if not arg1.isMounted then
            return
        end

        local gameInfo = arg1.state.gameInfo
        local game = arg1.props.game

        if not game then
            if gameInfo then
                game = toLegacyGameInfoModel(gameInfo)
            else
                game = nil
            end
        end

        local tileSize = arg1.getTileSize()
        arg1.props.openContextualMenu(game, tileSize, arg1.getTilePosition())
    end

    function arg1.onActivateSponsoredTooltip()
        if arg1.isMounted then
            arg1.props.openSponsoredTooltip(Responsive.GetInputModeStore(false).getLastInputType(false))
        end
    end

    function arg1.loadWideThumbnail()
        local wideThumbnail = arg1.props.wideThumbnail
        if wideThumbnail == nil then
            return
        end

        task.spawn(function()
            ContentProvider:PreloadAsync({ wideThumbnail })
        end)
    end

    function arg1.getVisitedFriends()
        local result = {}

        local friendVisits = arg1.props.friendVisits
        for i = 1, #friendVisits do
            local userId = tostring(friendVisits[i].userId)
            if FFlagLuaAppMigrateGameTileActiveFriendsHydrationFix then
                table.insert(result, userId)
            elseif arg1.props.users and arg1.props.users[userId] then
                table.insert(result, { userId = userId, displayName = arg1.props.users[userId].displayName })
            end
        end

        return result
    end

    arg1.getSortedFriends = memoize(function(arg2, arg3)
        if not (arg2 and arg3) then
            return {}
        end

        local result = {}
        for _, value in pairs(arg3) do
            local var5 = arg2[value]
            if var5 and var5.isFriend then
                table.insert(result, { userId = var5.id, displayName = var5.displayName })
            end
        end

        local var5 = sortFriendsByPresenceAndRecencyFactory("displayName")
        table.sort(result, var5)

        return result
    end)

    function arg1.onSelectionGained()
        if not FFlagLuaAppGameTileSelectionVideoPlayback then
            arg1:setState({ isSelected = true })
        end

        if arg1.props.onSelectionGained or FFlagLuaAppGameTileSelectionVideoPlayback then
            arg1.props.onSelectionGained(arg1.props.entry, arg1.props.index, arg1.props.navigationUniverseId)
        end
    end
    function arg1.onSelectionLost()
        if not FFlagLuaAppGameTileSelectionVideoPlayback then
            arg1:setState({ isSelected = false })
        end

        if arg1.props.onSelectionLost or FFlagLuaAppGameTileSelectionVideoPlayback then
            arg1.props.onSelectionLost()
        end
    end
end

local function getTextLiteralForTextFooter(footerLayoutData) -- Luacid: Inlined by compiler; 1 call site recovered
    if footerLayoutData == nil then
        return nil
    end
    if footerLayoutData.type ~= "TextLabel" then
        return nil
    end
    local text = footerLayoutData.text
    return if text == nil then nil else text.textLiteral
end

local var5 = nil
var5 = FFlagLuaAppGenreRatingFooter and function(arg1)
    if arg1 == nil then
        return nil
    end
    if arg1.type ~= "RatingWithGenre" then
        return nil
    end
    local genre = arg1.genre
    return if genre == nil then nil else genre.textLiteral
end or var5

function var4.renderGridTilesFooter(arg1)
    local var6 = if FFlagLuaAppContinueSortInstantPlay then var3(arg1.props.enableInstantPlay, arg1.props.instantPlayTreatment) else nil

    if FFlagLuaAppContinueSortInstantPlay and (var6.isTreatment2 or var6.isTreatment3) then
        return React.createElement(
            InstantPlayButton,
            {
                onActivated = arg1.onInstantPlayActivated,
                showIcon = var6.isTreatment2,
                showText = var6.isTreatment3
            }
        )
    end

    local var7 = arg1.props.useHoverTile or arg1.props.useExperienceTileMetadata

    local friendFooterEnabled = arg1.props.friendFooterEnabled
    local hasInGameFriends = arg1.props.hasInGameFriends
    local inGameUserIds = if FFlagLuaAppMigrateGameTileActiveFriendsHydrationFix then arg1.props.inGameUserIds else nil
    local users = arg1.props.users
    local inGameUsersByGame = arg1.props.inGameUsersByGame
    local friends = if FFlagLuaAppMigrateGameTileActiveFriendsHydrationFix then nil else arg1.getSortedFriends(users, inGameUsersByGame)

    if friendFooterEnabled then
        if FFlagLuaAppMigrateGameTileActiveFriendsHydrationFix then
            hasInGameFriends = inGameUserIds and #inGameUserIds > 0
        end
    else
        hasInGameFriends = friendFooterEnabled
    end

    local var8 = arg1.props.friendVisits and #arg1.props.friendVisits > 0

    local textLiteralForTextFooter = getTextLiteralForTextFooter(arg1.props.footerLayoutData)
    local genreText = if FFlagLuaAppGenreRatingFooter then var5(arg1.props.footerLayoutData) else nil
    local bool2 = false
    local gameAgeDisplayName

    if arg1.props.hidePlayButton or arg1.props.forceHideAgeRatings then
        gameAgeDisplayName = nil
    else
        local gameInfo = arg1.state.gameInfo
        local gameMinimumAge = gameInfo and gameInfo.gameMinimumAge or 0
        gameAgeDisplayName = gameInfo and gameInfo.gameAgeDisplayName or ""
        if gameMinimumAge == 0 or gameAgeDisplayName == "" then
            gameAgeDisplayName = nil
        end
    end

    if (arg1.props.isHovered
        or (if FFlagLuaAppGameTileSelectionVideoPlayback then arg1.props.isSelected else arg1.state.isSelected))
        and gameAgeDisplayName
        and not arg1.props.hidePlayButton
    then
        textLiteralForTextFooter = gameAgeDisplayName
        bool2 = true
    end

    local bool3 = textLiteralForTextFooter ~= nil
    local var10 = if FFlagLuaAppGenreRatingFooter then genreText ~= nil else nil
    local entry = arg1.props.entry
    local var11 = entry.isSponsored
        and (entry.isShowSponsoredLabel or arg1.props.isSponsoredFooterAllowed or arg1.props.isSponsoredRatingFooterAllowed)

    if FFlagLuaAppMigrateGameTileFixConsoleMetadataText
        and arg1.props.gameTileLayoutType == GameTileTypes.GameTileLayoutType.Narrow
        and arg1.props.useExperienceTileMetadata
        and (var11 or bool3 or FFlagLuaAppGenreRatingFooter and var10)
        or arg1.props.compactMetadataFormat
    then
        var7 = false
    end

    local storeVotes = arg1.state.storeVotes
    local totalUpVotes = if storeVotes then storeVotes.upVotes else 0
    local totalDownVotes = if storeVotes then storeVotes.downVotes else 0

    local gameStatsElement = Roact.createElement(GameStats, {
        stats = {
            totalUpVotes = totalUpVotes,
            totalDownVotes = totalDownVotes,
            playerCount = if arg1.props.playerCountStyle == GameTileConstants.PlayerCountStyleValues.Footer then arg1.props.entry.playerCount else nil
        },
        isGridTile = arg1.props.useGridTile,
        hideGameStats = arg1.props.hideGameStats,
        useLargerFont = var7,
        isUnifiedGameTile = true,
        gameTileLayoutType = arg1.props.gameTileLayoutType,
        compactMetadataFormat = arg1.props.compactMetadataFormat,
        hideRating = if FFlagLuaAppNarrowTileHideRating then arg1.props.hideRating else nil,
        hidePlayerCount = if FFlagLuaAppNarrowTileHidePlayerCount then arg1.props.hidePlayerCount else nil
    })

    if arg1.props.hideMetadata then
        if arg1.props.isHovered then
            if var11 then
                return React.createElement(GridTileSponsoredFooter, {
                    useLargerFont = var7,
                    onActivateSponsoredTooltip = arg1.onActivateSponsoredTooltip,
                    isUnifiedGameTile = true,
                    gameTileLayoutType = arg1.props.gameTileLayoutType,
                    isNarrowScreenXSmall = arg1.props.isNarrowScreenXSmall,
                    enableSponsoredFeedback = arg1.props.enableSponsoredFeedback,
                    isSponsoredRatingFooterAllowed = arg1.props.isSponsoredRatingFooterAllowed,
                    gameStatsElement = gameStatsElement
                })
            end

            if bool2 then
                return React.createElement(
                    GridTileTextFooter,
                    {
                        text = textLiteralForTextFooter,
                        useLargerFont = var7,
                        isUnifiedGameTile = true
                    }
                )
            end
        end

        return nil
    elseif var11 then
        return (React.createElement(GridTileSponsoredFooter, {
            useLargerFont = var7,
            onActivateSponsoredTooltip = arg1.onActivateSponsoredTooltip,
            isUnifiedGameTile = true,
            gameTileLayoutType = arg1.props.gameTileLayoutType,
            isNarrowScreenXSmall = arg1.props.isNarrowScreenXSmall,
            enableSponsoredFeedback = arg1.props.enableSponsoredFeedback,
            isSponsoredRatingFooterAllowed = arg1.props.isSponsoredRatingFooterAllowed,
            gameStatsElement = gameStatsElement
        }))
    elseif FFlagLuaAppGenreRatingFooter and var10 and not bool2 then
        return (React.createElement(RatingWithGenreFooter, {
            useLargerFont = var7,
            totalUpVotes = totalUpVotes,
            totalDownVotes = totalDownVotes,
            genreText = genreText,
            isUnifiedGameTile = true
        }))
    elseif bool3 then
        return (React.createElement(
            GridTileTextFooter,
            { text = textLiteralForTextFooter, useLargerFont = var7, isUnifiedGameTile = true }
        ))
    elseif hasInGameFriends then
        if FFlagLuaAppMigrateGameTileActiveFriendsHydrationFix then
            return (Roact.createElement(GridTileFriendFooter, {
                showOnlineBorder = false,
                useLargerFont = var7,
                friendUserIds = inGameUserIds,
                onFriendFooterActivated = arg1.onFriendFooterActivated
            }))
        end

        return (Roact.createElement(GridTileFriendFooter, { showOnlineBorder = false, friends = friends, useLargerFont = var7 }))
    elseif arg1.props.friendVisitedString then
        return (Roact.createElement(GridTileIconTextFooter, {
            icon = Images["icons/menu/recent"],
            text = arg1.props.friendVisitedString,
            iconSize = if var7 then 32 else 24,
            useLargerFont = var7
        }))
    elseif var8 then
        if FFlagLuaAppMigrateGameTileActiveFriendsHydrationFix then
            return (Roact.createElement(
                GridTileFriendFooter,
                {
                    showOnlineBorder = false,
                    friendUserIds = arg1.getVisitedFriends(),
                    useLargerFont = var7
                }
            ))
        end

        return (Roact.createElement(
            GridTileFriendFooter,
            {
                showOnlineBorder = false,
                friends = arg1.getVisitedFriends(),
                useLargerFont = var7
            }
        ))
    else
        return gameStatsElement
    end
end

function var4.renderContent(arg1, reducedMotion, arg2, arg3)
    local var6 = arg1.props.Size or UDim2.fromScale(1, 1)
    local imageThumbnail = arg1.props.imageThumbnail
    local onGameTileActivated = arg1.props.onGameTileActivated
    local var7 = if FFlagLuaAppContinueSortInstantPlay then var3(arg1.props.enableInstantPlay, arg1.props.instantPlayTreatment) else nil
    local var8 = arg1.props.playerCountStyle == GameTileConstants.PlayerCountStyleValues.Always
        or arg1.props.isHovered and arg1.props.playerCountStyle == GameTileConstants.PlayerCountStyleValues.Hover

    local imageAspectRatio = GameTileViewConfig.getImageAspectRatio(arg1.props.gameTileLayoutType)
    local var9 = arg1:renderGridTilesFooter()
    local name = if arg1.props.hideTitle then nil else arg1.props.name or arg1.state.gameInfo and arg1.state.gameInfo.name or ""
    local element = if var8 then React.createElement(
        GameStats,
        {
            stats = {
                playerCount = arg1.props.entry.playerCount,
                displayConcurrentUsersPill = true
            }
        }
    ) else nil
    local playButtonHeight = GameTileViewConfig.getElementSizes(
        arg2.Tokens,
        arg1.props.textSizeOffset,
        arg1.props.contentTextLineCount,
        arg1.props.foundationTokens,
        true
    ).playButtonHeight
    local element2

    if arg1.props.isHidden then
        element2 = React.createElement(HiddenTileContent, {
            appPage = arg1.props.appPage,
            collectionId = arg1.props.topicId,
            setGameHidden = arg1.props.setGameHidden,
            universeId = arg1.props.universeId,
            parentRef = arg1.props.hoverRef,
            isSponsored = arg1.props.entry.isSponsored
        })
    elseif arg1.props.videoThumbnail then
        local createElement = React.createElement
        local var10 = GameTileVideoThumbnail

        local tbl3 = {
            video = arg1.props.videoThumbnail,
            accessContext = if FFlagLuaAppHomeMomentVideoFallback then arg1.props.videoAccessContext else nil,
            image = imageThumbnail,
            playing = arg1.props.isVideoPlaying,
            looped = true,
            Size = UDim2.fromScale(1, 1),
            isTileContained = arg1.props.isContained,
            cornerRadius = arg2.Tokens.Size.Size_200,
            ZIndex = -2,
            onActivated = if FFlagLuaAppVideoTileDisableActivation then nil elseif FFlagLuaAppContinueSortInstantPlay and var7.isTreatment1 then arg1.onInstantPlayActivated elseif FFlagLuaAppEdpMediaGalleryFullScreen then if FFlagLuaAppGameTileExtractGameDetailsCallback then arg1.onGameDetailsActivated else FFlagLuaAppGameDetailsAttributionFix and function()
                onGameTileActivated(arg1.isMounted)
            end or arg1.onActivated else nil,
            itemIndex = arg1.props.index,
            videoAnalytics = arg1.props.videoAnalytics,
            universeId = arg1.props.universeId,
            videoPlaybackCoordinator = if arg1.props.videoPlaybackContext then arg1.props.videoPlaybackContext.videoPlaybackCoordinator else nil
        }

        element2 = createElement(var10, tbl3)
    else
        element2 = nil
    end

    if not bool1 and arg1.props.isVideoPlaying then
        element = nil
    elseif arg1.props.tileBadges then
        element = Roact.createFragment({
            SocialFeaturePill = element,
            Badge = React.createElement(GameTileThumbnailBadges, { tileBadgesByPosition = arg1.props.tileBadges })
        })
    end

    local var10

    if FFlagLuaAppContinueSortInstantPlay and var7.isTreatment1 and not arg1.props.isHidden then
        var10 = React.createElement(Foundation.View, {
            tag = "align-x-center align-y-center anchor-bottom-left size-600-600 radius-medium",
            backgroundStyle = arg3.Color.Extended.Black.Black_70,
            Position = UDim2.new(0, arg3.Padding.XSmall, 1, -arg3.Padding.XSmall)
        }, {
            Icon = React.createElement(Foundation.Icon, {
                name = Foundation.Enums.IconName.PlaySmall,
                size = Foundation.Enums.IconSize.Small,
                style = arg3.Color.Extended.White.White_100
            })
        })

        if element then
            var10 = Roact.createFragment({ Existing = element, PlayOverlay = var10 })
        end
    else
        var10 = element
    end

    local isHidden = arg1.props.isHidden
    local element3

    if next(arg1.props.availableMenuItems) == nil
        or not (arg1.props.isHovered
            or arg1.props.overflowMenuOpen
            or (if FFlagLuaAppGameTileSelectionVideoPlayback then arg1.props.isSelected else arg1.state.isSelected))
        or isHidden
    then
        element3 = nil
    else
        element3 = React.createElement(
            if FFlagLuaAppGameTileNotInterestedDirectAction then GameTileContextualActions else GameTileOverflowMenu,
            {
                isHovered = arg1.props.isHovered,
                isSelected = if FFlagLuaAppGameTileSelectionVideoPlayback then arg1.props.isSelected else arg1.state.isSelected,
                universeId = arg1.props.universeId,
                placeId = arg1.props.entry.placeId,
                collectionId = arg1.props.topicId,
                appPage = arg1.props.appPage,
                setGameHidden = arg1.props.setGameHidden,
                menuKey = arg1.props.hoverKey,
                menuOpen = arg1.props.overflowMenuOpen,
                onMenuOpenChanged = arg1.onMenuOpenChanged,
                parentRef = arg1.props.hoverRef,
                isSponsored = arg1.props.entry.isSponsored,
                payerName = arg1.props.entry.payerName,
                sponsoredUserCohort = arg1.props.sponsoredUserCohort,
                adId = arg1.props.entry.adId,
                availableMenuItems = arg1.props.availableMenuItems,
                onGameDetailsActivated = if FFlagLuaAppContinueSortInstantPlay and var7.isActive then arg1.onGameDetailsActivated else nil
            }
        )
    end

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl3 = {
        Size = var6,
        ZIndex = arg1.props.ZIndex,
        BackgroundTransparency = 1,
        LayoutOrder = arg1.props.layoutOrder,
        ref = arg1.gameTileRef
    }
    local tbl4 = { Tile = 0, VideoPlaybackDetector = 0, InstantPlayLauncher = 0 }
    local createElement2 = React.createElement
    local var11 = GameTileView
    local tbl5 = {
        SelectionOrder = arg1.props.SelectionOrder,
        Selectable = not isHidden,
        hoverPadding = if FFlagLuaAppMigrateGameTileHoverFixes or arg1.props.useGridTile then nil else arg2.Tokens.Size.Size_200,
        numLinesForTitle = arg1.props.contentTextLineCount,
        numLinesForMetadata = arg1.props.metadataTextLineCount,
        imageAspectRatio = imageAspectRatio,
        isContained = arg1.props.isContained,
        containmentSidePadding = GameTileViewConfig.getContainmentSidePadding(arg2.Tokens, arg1.props.gameTileLayoutType, arg1.props.foundationTokens),
        Size = UDim2.fromScale(1, 1),
        image = imageThumbnail,
        thumbnailComponent = element2,
        title = 0,
        isDisabled = 0,
        onActivated = 0,
        onGuiStateChanged = 0,
        onSelectionGained = 0,
        onSelectionLost = 0,
        onTouchLongPress = 0,
        onMetadataActivated = 0,
        reducedMotion = 0,
        isHovered = 0,
        forwardRef = 0,
        hidePlayButton = 0,
        hoverActionRow = 0,
        thumbnailOverlay = 0,
        overflowMenu = 0,
        footerMetadata = 0,
        isUnifiedGameTile = true,
        textSizeOffset = 0,
        hideMetadata = 0,
        isTouchPreferredInput = 0
    }

    if isHidden then
        name = nil
    end

    tbl5.title = name
    tbl5.isDisabled = if isHidden then true else arg1.props.isDisabled
    tbl5.onActivated = if FFlagLuaAppContinueSortInstantPlay and var7.isTreatment1 and not isHidden then arg1.onInstantPlayActivated elseif FFlagLuaAppGameTileExtractGameDetailsCallback then if isHidden then arg1.onActivated else arg1.onGameDetailsActivated else FFlagLuaAppGameDetailsAttributionFix and not isHidden and function()
        onGameTileActivated(arg1.isMounted)
    end or arg1.onActivated

    tbl5.onGuiStateChanged = arg1.props.onGuiStateChanged
    tbl5.onSelectionGained = arg1.onSelectionGained
    tbl5.onSelectionLost = arg1.onSelectionLost
    tbl5.onTouchLongPress = if isHidden then nil else arg1.onTouchLongPress
    tbl5.onMetadataActivated = if FFlagLuaAppContinueSortInstantPlay and var7.isTreatment1 and not isHidden then arg1.onGameDetailsActivated else nil

    tbl5.reducedMotion = reducedMotion
    tbl5.isHovered = not isHidden and arg1.props.isHovered
    tbl5.forwardRef = arg1.props.hoverRef
    tbl5.hidePlayButton = if isHidden then true else arg1.props.hidePlayButton
    local var12

    if arg1.props.hidePlayButton or isHidden or FFlagLuaAppContinueSortInstantPlay and var7.isActive then
        var12 = nil
    else
        local createElement3 = React.createElement
        local var13 = AppExperienceActionRow

        local tbl6 = {
            universeId = arg1.props.navigationUniverseId,
            referralSource = arg1.props.referralSource,
            launchSource = "ExperienceTile",
            reportExperienceLaunched = arg1.reportExperienceLaunchedFromActionBar,
            openGameDetails = if FFlagLuaAppGameTileExtractGameDetailsCallback then arg1.onGameDetailsActivated else FFlagLuaAppGameDetailsAttributionFix and function()
                onGameTileActivated(arg1.isMounted)
            end or arg1.onActivated,
            entry = arg1.props.entry,
            launchExperienceEventContext = arg1.props.launchExperienceEventContext,
            fetchDelayInSeconds = getHoverDelay(),
            index = arg1.props.index,
            horizontalPadding = 0,
            verticalPadding = 0,
            height = playButtonHeight,
            showButtonText = imageAspectRatio > 1,
            isUnifiedGameTileEnabled = if FFlagLuaAppUnifyPlayButtonTile then true else nil,
            placeIdOverride = arg1.props.entry.placeIdOverride,
            launchDataOverride = arg1.props.entry.launchDataOverride
        }

        var12 = createElement3(var13, tbl6)
    end

    tbl5.hoverActionRow = var12

    if isHidden then
        var10 = nil
    end

    tbl5.thumbnailOverlay = var10
    tbl5.overflowMenu = element3
    if isHidden then
        var9 = nil
    end

    tbl5.footerMetadata = var9

    tbl5.textSizeOffset = arg1.props.textSizeOffset
    tbl5.hideMetadata = arg1.props.hideMetadata
    tbl5.isTouchPreferredInput = if FFlagLuaAppContinueSortInstantPlay then arg1.props.isTouchPreferredInput else nil
    tbl4.Tile = createElement2(var11, tbl5)

    tbl4.VideoPlaybackDetector = arg1.props.videoPlaybackDetector
    local element4

    if FFlagLuaAppContinueSortInstantPlay and var7.isActive and arg1.state.instantPlayRequested then
        element4 = React.createElement(InstantPlayLauncher, {
            universeId = arg1.props.navigationUniverseId,
            referralSource = arg1.props.referralSource,
            eventContext = DiscoveryAnalytics.Constants.Context.InstantPlay,
            launchSource = "ExperienceTile",
            launchData = arg1.props.entry.launchDataOverride,
            placeId = arg1.props.entry.placeIdOverride,
            reportExperienceLaunched = arg1.reportExperienceLaunchedFromInstantPlay,
            openGameDetails = arg1.onGameDetailsActivated,
            onLaunchAttemptCompleted = arg1.onInstantPlayAttemptCompleted
        })
    else
        element4 = nil
    end

    tbl4.InstantPlayLauncher = element4
    return createElement(str1, tbl3, tbl4)
end

function var4.render(arg1)
    if DiscoveryAppLaunchTracker.isEnabled() and DiscoveryAppLaunchTracker.default then
        DiscoveryAppLaunchTracker.default:trackTileRender()
    end

    if arg1.props.game == nil then
        return nil
    end

    return withStyle(function(arg2)
        local reducedMotion = arg2.Settings.ReducedMotion
        return arg1:renderContent(reducedMotion, arg2, arg1.props.foundationTokens)
    end)
end

function var4.didMount(arg1)
    arg1.isMounted = true
    ImpressionsTagUtility.AddTag(arg1.gameTileRef, arg1.props.impressionsTag, arg1.props.index)

    if not arg1.props.useGridTile and arg1.props.friendFooterEnabled and arg1.props.hasInGameFriends then
        arg1:setState({ canDisplayFriendFooter = true })
    end

    if arg1.props.useGridTile then
        arg1.loadWideThumbnail()
    end
end

function var4.willUnmount(arg1)
    arg1.isMounted = false
    ImpressionsTagUtility.RemoveTag(arg1.gameTileRef, arg1.props.impressionsTag, arg1.props.index)
    arg1.gameInfoSubscription.dispose()
end

function var4.didUpdate(arg1, arg2)
    arg1.gameInfoSubscription.update(arg1.props.entry.universeId)

    if arg2.impressionsTag ~= arg1.props.impressionsTag or arg2.index ~= arg1.props.index then
        ImpressionsTagUtility.RemoveTag(arg1.gameTileRef, arg2.impressionsTag, arg2.index)
        ImpressionsTagUtility.AddTag(arg1.gameTileRef, arg1.props.impressionsTag, arg1.props.index)
    end

    if arg1.props.useGridTile and arg2.universeId ~= arg1.props.universeId then
        arg1.loadWideThumbnail()
    end

    if not arg1.props.useGridTile
        and (arg2.friendFooterEnabled ~= arg1.props.friendFooterEnabled or arg2.hasInGameFriends ~= arg1.props.hasInGameFriends)
        and arg1.props.friendFooterEnabled
        and arg1.props.hasInGameFriends
    then
        arg1:setState({ canDisplayFriendFooter = true })
    end
end

local var6 = RoactRodux.connect(function(arg1, arg2)
    local universeId = arg2.entry.universeId
    local var6 = if FFlagLuaAppGameDetailsAttributionFix then nil elseif arg2.entry.navigationUniverseId and arg2.entry.navigationUniverseId ~= "" and arg2.entry.navigationUniverseId ~= "0" then arg2.entry.navigationUniverseId else arg2.entry.universeId
    local game = arg1.Personalization[GameInfosReducer.key][universeId]
    local friendActivityTitle = if game then game.friendActivityTitle or nil else nil
    local hidePlayButton = if arg2.gameTileLayoutType == "Event" then arg2.playButtonStyle ~= GameTileConstants.PlayButtonStyleValues.Enabled else arg2.gameTileLayoutType == "Wide" and arg2.playButtonStyle == GameTileConstants.PlayButtonStyleValues.Disabled
    local gameTileLayoutData = getGameTileLayoutData(game, arg2.topicId)

    local gameIconUrl = arg2.gameIconUrl
    local var8, var9

    if FFlagLuaAppHomeThumbnailPrefetch then
        local function resolveThumbnail(useGridTile: boolean) -- Luacid: Inlined by compiler; 2 call sites recovered
            return resolveGameTileThumbnailUri({
                iconUrl = gameIconUrl,
                universeId = universeId,
                placeId = arg2.entry.placeId,
                useGridTile = useGridTile,
                perEntryWideAssetId = arg2.entry.primaryWideImageAssetId,
                game = game,
                topicId = arg2.topicId
            })
        end

        var8 = resolveThumbnail(arg2.useGridTile == true)
        if arg2.useGridTile then
            var9 = var8
        else
            var9 = resolveThumbnail(true)
        end
    else
        local var10 = if arg2.entry.primaryWideImageAssetId then arg2.entry.primaryWideImageAssetId else ItemLayoutDataParsingUtils.getWideImageAssetId(gameTileLayoutData)

        if not var10 then
            if game then
                var10 = game.primaryWideAssetId or nil
            else
                var10 = nil
            end
        end

        var9 = formatExperienceThumbnail(var10, arg2.entry.placeId)

        if arg2.useGridTile then
            var8 = var9
        else
            var8 = formatExperienceIcon(gameIconUrl, universeId)
        end
    end

    local accessContext = nil
    local var10

    if FFlagLuaAppHomeMomentVideoFallback then
        local layoutDataVideo = getLayoutDataVideo(gameTileLayoutData, arg2.entry.primaryWideVideoAssetId)
        var10 = layoutDataVideo and layoutDataVideo.assetId
        accessContext = layoutDataVideo and layoutDataVideo.accessContext
    elseif arg2.entry.primaryWideVideoAssetId then
        var10 = arg2.entry.primaryWideVideoAssetId
    else
        var10 = gameTileLayoutData and gameTileLayoutData.primaryMediaAsset and gameTileLayoutData.primaryMediaAsset.wideVideoAssetId
    end

    local videoThumbnail = if var10 then `rbxassetid://{var10}` else nil
    local friendVisits = game and game.friendVisits or tbl1
    local friendVisitedString = if game and game.friendVisitedString ~= "" then game.friendVisitedString else nil
    local footer = if gameTileLayoutData then gameTileLayoutData.footer or nil else nil
    local title = gameTileLayoutData and gameTileLayoutData.title

    local tbl3 = {
        game = game,
        universeId = universeId,
        navigationUniverseId = 0,
        name = 0,
        imageThumbnail = 0,
        wideThumbnail = 0,
        videoThumbnail = 0,
        videoAccessContext = 0,
        friendActivityTitle = 0,
        friendVisits = 0,
        friendVisitedString = 0,
        hidePlayButton = 0,
        footerLayoutData = 0
    }

    if FFlagLuaAppGameDetailsAttributionFix then
        var6 = nil
    end

    tbl3.navigationUniverseId = var6
    tbl3.name = title
    tbl3.imageThumbnail = var8
    tbl3.wideThumbnail = var9
    tbl3.videoThumbnail = videoThumbnail
    if not FFlagLuaAppHomeMomentVideoFallback then
        accessContext = nil
    end

    tbl3.videoAccessContext = accessContext
    tbl3.friendActivityTitle = friendActivityTitle
    tbl3.friendVisits = friendVisits
    tbl3.friendVisitedString = friendVisitedString
    tbl3.hidePlayButton = hidePlayButton
    tbl3.footerLayoutData = footer
    return tbl3
end, function(arg1)
    return {
        openContextualMenu = function(arg2, arg3, arg4)
            arg1(OpenCentralOverlayForPlacesList(arg2, arg3, arg4))
        end,
        openSponsoredTooltip = function(arg2)
            return arg1(OpenSponsoredTooltip(arg2))
        end
    }
end)(var4)

if not FFlagLuaAppGameDetailsAttributionFix then
    var6 = RoactServices.connect({ networking = RoactNetworking })(var6)
end

local function func1(arg1)
    local var7 = React.useRef(nil)
    local foundationTokens = useTokens()
    local useHoverTile = arg1.useHoverTile

    local gameIconUrl = GameHydrationReact.useGameIcon(arg1.entry.universeId)

    local str1 = `{arg1.impressionsTag or ""}_{arg1.index or "0"}_{arg1.gameTileLayoutType or "Narrow"}`
    if arg1.impressionsTag == nil or arg1.index == nil then
        useHoverTile = false
    end

    local isHovered = useIsHoveredTile(var7, str1, useHoverTile)

    local bool2 = useUiModeInfo().uiMode == UiMode.TenFoot
    local hasBackground = if bool2 then true else arg1.useHoverTile

    if arg1.useExperienceTileMetadata ~= nil then
        bool2 = arg1.useExperienceTileMetadata
    end

    local tileBadges = useValidTileBadges(arg1.entry.universeId, arg1.topicId, arg1.badgeOverride)

    local var13 = useSelector(function(arg2)
        return arg2.LocalUserId
    end)

    local users = if FFlagLuaAppMigrateGameTileActiveFriendsHydrationFix then nil else useSelector(function(arg2)
        return arg2.Users
    end)

    local inGameUsersByGame = useSelector(function(arg2)
        return arg2.InGameUsersByGame[arg1.entry.universeId]
    end)

    local hasInGameFriends = useHasInGameFriends(var13, users, inGameUsersByGame)
    local var17 = if FFlagGameTileMigrateOffLegacyPresence then useGetOnlineFriendsByUniverseId(arg1.entry.universeId) else nil

    local var18 = if FFlagGameTileMigrateOffLegacyPresence then React.useMemo(function()
        return Cryo.List.map(var17 or {}, function(arg2)
            return arg2.id
        end)
    end, { var17 }) else nil

    if FFlagLuaAppMigrateGameTileActiveFriendsHydrationFix then
        if not FFlagGameTileMigrateOffLegacyPresence then
            var18 = useInGameUserIds(var13, inGameUsersByGame)
        end
    else
        var18 = nil
    end

    local isVideoPlaying, onPlaybackChange = React.useState(false)

    local var21 = nil
    local var22 = nil
    local onSelectionGained, onSelectionLost

    if FFlagLuaAppGameTileSelectionVideoPlayback then
        local var23
        var21, var23 = React.useState(false)
        var22 = var23

        onSelectionGained = React.useCallback(function(arg2, arg3, arg4)
            var22(true)

            if arg1.onSelectionGained then
                arg1.onSelectionGained(arg2, arg3, arg4)
            end
        end, { arg1.onSelectionGained })

        onSelectionLost = React.useCallback(function()
            var22(false)

            if arg1.onSelectionLost then
                arg1.onSelectionLost()
            end
        end, { arg1.onSelectionLost })
    else
        onSelectionGained = nil
        onSelectionLost = nil
    end

    local bool3 = not (arg1.videoPlaybackContext == nil) and arg1.videoPlaybackContext.disablePlayback == true
    local bool4 = FFlagLuaAppSuppressVideoDetectorDuringScroll

    if bool4 then
        if arg1.videoPlaybackContext == nil then
            bool4 = false
        else
            bool4 = arg1.videoPlaybackContext.disableDetectors == true
        end
    end

    React.useEffect(function()
        if FFlagLuaAppFixHiddenTileVideoCleanup and arg1.isHidden or bool3 then
            onPlaybackChange(false)
        end
    end, { arg1.isHidden, bool3 })

    local var23 = nil
    local var24 = nil
    local var25 = nil
    local var26 = nil

    if FFlagLuaAppGameDetailsAttributionFix then
        var23 = useRoactService(RoactNetworking)

        if arg1.entry.navigationUniverseId and arg1.entry.navigationUniverseId ~= "" and arg1.entry.navigationUniverseId ~= "0" then
            var24 = arg1.entry.navigationUniverseId
        else
            var24 = arg1.entry.universeId
        end
        var26 = React.useCallback(function()
            local entry = arg1.entry
            if entry.isSponsored then
                sponsoredGamesRecordClick(var23, entry.adId)
            end
        end, { var23, arg1.entry.isSponsored, arg1.entry.adId })

        var25 = React.useCallback(function(arg2)
            if arg1.isHovered then
                HoverTileCoordinator.default:reset()
            end

            if arg1.videoPlaybackContext and arg1.videoPlaybackContext.videoPlaybackCoordinator then
                arg1.videoPlaybackContext.videoPlaybackCoordinator:reset(VideoEndReason.TileClicked, nil, var24, nil)
            else
                VideoPlaybackCoordinator.default:reset(VideoEndReason.TileClicked, nil, var24, nil)
            end

            if not arg2 then
                return
            end

            if arg1.onActivated then
                arg1.onActivated()
            end

            local tbl3 = {
                source = arg1.source,
                index = arg1.index,
                referralSource = arg1.referralSource,
                onPeekViewClosed = arg1.onPeekViewClosed,
                placeIdOverride = arg1.entry.placeIdOverride,
                experienceJoinData = {
                    launchData = if arg1.entry.launchDataOverride then arg1.entry.launchDataOverride else nil,
                    tileType = arg1.entry.tileType or GameCollectionItemTypes.GameCollectionItemType.GameTile,
                    nativeAdData = arg1.entry.adId
                }
            }

            if GetFFlagEnableNavigationPerformanceIntervals() then
                IntervalPerformanceTracker:startTracking("AppGameTile_to_GameDetail", 2)
            end
            arg1.navigateToGameDetails(var24, tbl3)

            arg1.reportGameDetailOpened(arg1.index, var24)

            var26()
        end, {
            arg1.isHovered,
            arg1.index,
            arg1.videoAnalytics,
            arg1.onActivated,
            arg1.source,
            arg1.referralSource,
            arg1.onPeekViewClosed,
            arg1.navigateToGameDetails,
            arg1.reportGameDetailOpened,
            var24,
            var26,
            arg1.entry.placeIdOverride,
            arg1.entry.launchDataOverride,
            if arg1.videoPlaybackContext then arg1.videoPlaybackContext.videoPlaybackCoordinator else nil
        })
    end

    local overflowMenuOpen = useOverflowMenuOpen(str1)
    local triggerFeedback = useTriggerFeedback()
    local var29 = if FFlagLuaAppContinueSortInstantPlay then var3(arg1.enableInstantPlay, arg1.instantPlayTreatment) else nil

    local availableMenuItems = React.useMemo(function()
        return getAvailableGameTileOverflowMenuItems({
            isSponsored = arg1.entry.isSponsored,
            enableExplicitFeedback = arg1.enableExplicitFeedback,
            enableSponsoredFeedback = arg1.enableSponsoredFeedback,
            enableReportAd = arg1.enableReportAd,
            enableGameDetails = if FFlagLuaAppContinueSortInstantPlay then var29.isTreatment1 else nil,
            enableReportExperience = if FFlagLuaAppEnableReportExperience then arg1.enableReportExperience else nil
        })
    end, {
        arg1.entry.isSponsored,
        arg1.enableExplicitFeedback,
        arg1.enableSponsoredFeedback,
        arg1.enableReportAd,
        if FFlagLuaAppContinueSortInstantPlay then var29.isTreatment1 else nil,
        if FFlagLuaAppEnableReportExperience then arg1.enableReportExperience else nil
    })

    local var31 = useHasVideoThumbnailSelector(arg1.entry.universeId, arg1.topicId)

    local var32 = arg1.entry.primaryWideVideoAssetId ~= nil or var31

    useTagAsViewportAutoplayCandidate(
        var7,
        arg1.videoPlaybackContext,
        if FFlagLuaAppTileVideoCandidateOnly then var32 else nil,
        if FFlagLuaAppFixHiddenTileVideoCleanup then arg1.isHidden else nil,
        nil,
        nil,
        nil,
        if FFlagLuaAppOneByTwoHoverIdleAutoplay then var32 and {
            videoKey = str1,
            isUserIntentModeAutoplayCandidate = false
        } or nil else nil
    )
    local var33 = if FFlagLuaAppGameTileSelectionVideoPlayback or not FFlagLuaAppEdpMediaGalleryVideoPreview then nil else usePreferredInput()
    local element

    if var32 and not (arg1.isHidden or FFlagLuaAppSuppressVideoDetectorDuringScroll and bool4) and not bool3 then
        element = React.createElement(GameVideoPlaybackDetector, {
            videoKey = str1,
            itemIndex = arg1.index,
            universeId = arg1.entry.universeId,
            tileRef = var7,
            isHoverSupported = useHoverTile,
            isHovered = isHovered,
            isSelected = if FFlagLuaAppGameTileSelectionVideoPlayback then var21 else nil,
            autoplay = if FFlagLuaAppGameTileSelectionVideoPlayback or not FFlagLuaAppEdpMediaGalleryVideoPreview then nil else var33 == Responsive.Input.Touch,
            onPlaybackChange = onPlaybackChange,
            videoAnalytics = arg1.videoAnalytics,
            videoDwellTimeInSec = FIntLuaAppGameTileVideoDwellTimeInSec,
            videoVisiblePercent = FIntLuaAppGameTileVideoVisiblePercent,
            hasPrevalidatedVideoGamePlayability = if FFlagLuaAppUsePrevalidatedVideoGamePlayability then arg1.hasPrevalidatedVideoGamePlayability else nil,
            pageContext = arg1.appPage,
            videoPlaybackContext = arg1.videoPlaybackContext
        })
    else
        element = nil
    end

    local createElement = React.createElement
    local var34 = var6
    local join = Cryo.Dictionary.join
    local tbl3 = {
        useExperienceTileMetadata = bool2,
        hasBackground = hasBackground,
        gameIconUrl = gameIconUrl,
        hoverRef = var7,
        isHoverSupported = useHoverTile,
        isHovered = isHovered,
        isSelected = 0,
        isVideoPlaying = 0,
        tileBadges = 0,
        foundationTokens = 0,
        users = 0,
        inGameUsersByGame = 0,
        hasInGameFriends = 0,
        inGameUserIds = 0,
        networking = 0,
        navigationUniverseId = 0,
        onGameTileActivated = 0,
        recordSponsoredGameClick = 0,
        overflowMenuOpen = 0,
        hoverKey = 0,
        triggerFeedback = 0,
        availableMenuItems = 0,
        onSelectionGained = 0,
        onSelectionLost = 0,
        videoPlaybackDetector = 0
    }

    if not FFlagLuaAppGameTileSelectionVideoPlayback then
        var21 = nil
    end

    tbl3.isSelected = var21
    tbl3.isVideoPlaying = isVideoPlaying
    tbl3.tileBadges = tileBadges
    tbl3.foundationTokens = foundationTokens
    tbl3.users = users
    tbl3.inGameUsersByGame = inGameUsersByGame
    tbl3.hasInGameFriends = hasInGameFriends
    if not FFlagLuaAppMigrateGameTileActiveFriendsHydrationFix then
        var18 = nil
    end

    tbl3.inGameUserIds = var18
    tbl3.networking = if FFlagLuaAppGameDetailsAttributionFix then var23 else nil
    tbl3.navigationUniverseId = if FFlagLuaAppGameDetailsAttributionFix then var24 else nil
    if not FFlagLuaAppGameDetailsAttributionFix then
        var25 = nil
    end

    tbl3.onGameTileActivated = var25
    tbl3.recordSponsoredGameClick = if FFlagLuaAppGameDetailsAttributionFix then var26 else nil
    tbl3.overflowMenuOpen = overflowMenuOpen
    tbl3.hoverKey = str1
    tbl3.triggerFeedback = triggerFeedback
    tbl3.availableMenuItems = availableMenuItems
    if not FFlagLuaAppGameTileSelectionVideoPlayback then
        onSelectionGained = arg1.onSelectionGained
    end

    tbl3.onSelectionGained = onSelectionGained

    if not FFlagLuaAppGameTileSelectionVideoPlayback then
        onSelectionLost = arg1.onSelectionLost
    end

    tbl3.onSelectionLost = onSelectionLost

    tbl3.videoPlaybackDetector = element
    return (createElement(var34, join(arg1, tbl3)))
end

if FFlagSignalsNavP3fGameDetails then
    func1 = React.memo(func1)
end

return func1
