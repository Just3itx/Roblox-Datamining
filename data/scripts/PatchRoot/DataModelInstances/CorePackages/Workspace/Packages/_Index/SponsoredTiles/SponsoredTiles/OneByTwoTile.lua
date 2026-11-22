-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SponsoredTiles = script:FindFirstAncestor("SponsoredTiles")

local SponsoredTilesParent = SponsoredTiles.Parent
local GameTile = require(SponsoredTilesParent.GameTile)
local React = require(SponsoredTilesParent.React)
local Foundation = require(SponsoredTilesParent.Foundation)
local Responsive = require(SponsoredTilesParent.Responsive)
local Image = Foundation.Image
local ButtonSize = Foundation.Enums.ButtonSize
local useTokens = Foundation.Hooks.useTokens
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local PlayButton = require(SponsoredTilesParent.GamePlayButton).PlayButton
local useLocalization = require(SponsoredTilesParent.Localization).Hooks.useLocalization
local DiscoveryTypes = require(SponsoredTilesParent.DiscoveryTypes)
local OmniRecommendationsContentType = DiscoveryTypes.OmniRecommendationsContentType
local GameCollectionItemTypes = DiscoveryTypes.GameCollectionItemTypes
local GameHydrationReact = require(SponsoredTilesParent.GameHydrationReact)
local useNavigation = require(SponsoredTilesParent.Navigation).useNavigation
local AppPage = require(SponsoredTilesParent.RobloxAppEnums).AppPage
local useRoactService = require(SponsoredTilesParent.RobloxAppHooks).useRoactService
local RoactServiceTags = require(SponsoredTilesParent.RoactServiceTags)
local RoactNetworking = RoactServiceTags.RoactNetworking
local AppSessionService = RoactServiceTags.AppSessionService
local RobloxAppSessionization = require(SponsoredTilesParent.RobloxAppSessionization)
local SetGamePlaySession = RobloxAppSessionization.SetGamePlaySession
local SessionType = RobloxAppSessionization.SessionType
local DiscoveryAnalytics = require(SponsoredTilesParent.DiscoveryAnalytics)
local sponsoredGamesRecordClick = DiscoveryAnalytics.Requests.sponsoredGamesRecordClick
local SponsoredTilesTelemetry = require(SponsoredTilesParent.SponsoredTilesTelemetry)
local OneByTwoTileTelemetry = SponsoredTilesTelemetry.OneByTwoTileTelemetry
local DiscoveryEventErrorLogger = require(SponsoredTilesParent.DiscoveryUtils).DiscoveryEventErrorLogger
local _types = require(SponsoredTiles.types)
local openAdClickoutUrl = require(SponsoredTiles.openAdClickoutUrl)

local VideoPlayer = require(SponsoredTilesParent.VideoPlayer)
local VideoDisplay = VideoPlayer.VideoDisplay
local VideoLoadingState = VideoPlayer.VideoLoadingState

local VideoUtils = require(SponsoredTilesParent.VideoUtils)
local VideoPlaybackDetector = VideoUtils.VideoPlaybackDetector
local VideoPlaybackDetectionMethod = VideoUtils.VideoPlaybackDetectionMethod
local VideoPlaybackCoordinator = VideoUtils.VideoPlaybackCoordinator
local useTagAsViewportAutoplayCandidate = VideoUtils.useTagAsViewportAutoplayCandidate
local AdsViewportAutoplayCandidateTag = require(script.Parent.AdsViewportAutoplayCandidateTag)
local useTagAsAdsViewportAutoplayCandidate = require(script.Parent.useTagAsAdsViewportAutoplayCandidate)
local getPlaybackDetectionMethod = VideoUtils.getPlaybackDetectionMethod
local useCanDevicePlayVideoPreview = VideoUtils.useCanDevicePlayVideoPreview
local VideoEndReason = VideoUtils.AnalyticsEnums.VideoEndReason

local useTagAsSponsoredAdViewabilityCandidate = require(SponsoredTilesParent.SponsoredAdViewability).useTagAsSponsoredAdViewabilityCandidate
local ImpressionsTagUtility = require(SponsoredTilesParent.Impressions).ImpressionsTagUtility

local useIsHoveredTile = GameTile.useIsHoveredTile
local useValidTileBadges = GameTile.useValidTileBadges
local GameTileThumbnailBadges = GameTile.GameTileThumbnailBadges
local HoverTileCoordinator = GameTile.HoverTileCoordinator
local TileVideoBlockingConfig = GameTile.TileVideoBlockingConfig
local getAvailableGameTileOverflowMenuItems = GameTile.getAvailableGameTileOverflowMenuItems
local SpanTileOverflowMenu = require(SponsoredTiles.SpanTileOverflowMenu.SpanTileOverflowMenu)

local AppBlox = require(SponsoredTilesParent.AppBlox)
local getOverflowMenuSignalStore = AppBlox.getOverflowMenuSignalStore
local useOverflowMenuOpen = AppBlox.useOverflowMenuOpen
local useTriggerFeedback = require(SponsoredTilesParent.InteractionFeedback).useTriggerFeedback

local SharedFlags = require(SponsoredTilesParent.SharedFlags)
local FFlagLuaAppDemoModePlayButtonTelemetry = SharedFlags.FFlagLuaAppDemoModePlayButtonTelemetry
local FFlagLuaAppFeatureTileHapticsFix = SharedFlags.FFlagLuaAppFeatureTileHapticsFix
local FIntLuaAppGameTileVideoDwellTimeInSec = SharedFlags.FIntLuaAppGameTileVideoDwellTimeInSec
local FIntLuaAppGameTileVideoVisiblePercent = SharedFlags.FIntLuaAppGameTileVideoVisiblePercent
local FFlagLuaAppGameTileSelectionVideoPlayback = SharedFlags.FFlagLuaAppGameTileSelectionVideoPlayback
local FFlagLuaAppSuppressVideoDetectorDuringScroll = SharedFlags.FFlagLuaAppSuppressVideoDetectorDuringScroll

local FFlagLuaAppSuppressOneByTwoVideoDetectorDuringScroll = SharedFlags.FFlagLuaAppSuppressOneByTwoVideoDetectorDuringScroll
local FFlagLuaAppSduiSponsoredOneByTwoTile = SharedFlags.FFlagLuaAppSduiSponsoredOneByTwoTile
local FFlagLuaAppAdClickoutDeeplink = SharedFlags.FFlagLuaAppAdClickoutDeeplink
local FFlagLuaAppOneByTwoHoverIdleAutoplay = SharedFlags.FFlagLuaAppOneByTwoHoverIdleAutoplay

local FFlagLuaAppVideoAutoplayOneByTwoConcurrentPlayback = SharedFlags.FFlagLuaAppVideoAutoplayOneByTwoConcurrentPlayback
local FFlagLuaAppEnableReportExperience = SharedFlags.FFlagLuaAppEnableReportExperience
local FFlagLuaAppEnableOneByTwoTileFunnelTelemetry = SharedFlags.FFlagLuaAppEnableOneByTwoTileFunnelTelemetry

local FFlagLuaAppSponsoredTileBadgeContentPadding = require(SponsoredTiles.Flags.FFlagLuaAppSponsoredTileBadgeContentPadding)
local FFlagLuaAppAdClickoutEvent = require(SponsoredTiles.Flags.FFlagLuaAppAdClickoutEvent)

local num1 = game:DefineFastInt("LuaAppOneByTwoTileLogoWidthPercentLandscape", 40)
local num2 = game:DefineFastInt("LuaAppOneByTwoTileLogoWidthPercentSquare", 25)

local num3 = game:DefineFastInt("LuaAppOneByTwoTileGradientBottomTransparencyPercent", 25)

local num4 = game:DefineFastInt("LuaAppOneByTwoTileGradientTopTransparencyPercent", 100)

local num5 = game:DefineFastInt("LuaAppOneByTwoTileGradientBottomHeightPercent", 50)

local xScale = num1 / 100
local num6 = num2 / 100
local str1 = if FFlagLuaAppFeatureTileHapticsFix then "TileLongPress" else "OneByTwoTileLongPress"
local num7 = num3 / 100
local num8 = num4 / 100
local num9 = num5 / 100

local function getTextOrDefault(str2: string?, str3: string?) -- Luacid: unused: defined but never referenced
    if str2 == nil or str2 == "" then
        if str3 == nil or str3 == "" then
            return nil
        end

        return str3
    end

    return str2
end

return React.memo(function(tbl1) -- name: OneByTwoTile
    local var1 = useTokens()
    local bool1 = Responsive.useResponsive({ Responsive.BreakpointConfig.sizes.Small }) == Responsive.Keys.Small

    local var2 = React.useRef(nil)
    local ref = React.useRef(nil)
    local hoverKey = tbl1.hoverKey
    local bool2 = Responsive.useLastInput() ~= Responsive.Input.Touch
    local isHovered = useIsHoveredTile(var2, hoverKey, bool2)
    local var5 = Responsive.usePreferredInput()
    local isSponsored = not (tbl1.adId == nil) and tbl1.adId ~= ""
    local bool4 = tbl1.contentType == OmniRecommendationsContentType.AdLink
    if bool4 then
        assert(not (tbl1.clickoutUrl == nil) and tbl1.clickoutUrl ~= "", "OneByTwoTile AdLink requires clickoutUrl")
    else
        assert(not (tbl1.universeId == nil) and tbl1.universeId ~= "", "OneByTwoTile Game requires universeId")
    end

    local headline = tbl1.headline
    local subtitle = tbl1.subtitle

    local var6 = GameHydrationReact.useGameInfo(tbl1.universeId or "")
    local name, gameAgeDisplayName

    if var6 then
        name = var6.name
        gameAgeDisplayName = var6.gameAgeDisplayName
    else
        name = nil
        gameAgeDisplayName = nil
    end
    if tbl1.contentType == OmniRecommendationsContentType.Game then
        local var7 = headline

        if var7 ~= nil and var7 ~= "" then
            headline = var7
        elseif name ~= nil and name ~= "" then
            headline = name
        else
            headline = nil
        end

        local var8 = subtitle

        if var8 ~= nil and var8 ~= "" then
            subtitle = var8
        elseif gameAgeDisplayName ~= nil and gameAgeDisplayName ~= "" then
            subtitle = gameAgeDisplayName
        else
            subtitle = nil
        end
    end
    local isSelected, var8 = React.useState(false)
    local var9 = useOverflowMenuOpen(hoverKey)
    local var10 = useTriggerFeedback()
    local var11 = React.useRef(false)
    local cellVerticalPadding

    if tbl1.cellVerticalPadding ~= nil then
        cellVerticalPadding = tbl1.cellVerticalPadding
    elseif tbl1.size == nil or not (tbl1.size.Height.Scale > 1) then
        cellVerticalPadding = nil
    else
        cellVerticalPadding = tbl1.size.Height.Offset / (tbl1.size.Height.Scale - 1)
    end
    local bool5 = cellVerticalPadding == nil
    local var12 = cellVerticalPadding or var1.Gap.Large

    React.useEffect(function()
        if bool5 then
            DiscoveryEventErrorLogger.reportError(
                "SponsoredTiles",
                "OneByTwoTile: could not resolve cellVerticalPadding for a 1x2 tile"
            )
        end
    end, { bool5 })

    React.useEffect(function()
        if tbl1.alignmentType ~= GameCollectionItemTypes.AlignmentType.LeftPin
            and tbl1.alignmentType ~= GameCollectionItemTypes.AlignmentType.RightPin
        then
            DiscoveryEventErrorLogger.reportError(
                "SponsoredTiles",
                "OneByTwoTile: 1x2 tile is neither left- nor right-pinned",
                {
                    alignmentType = tostring(tbl1.alignmentType)
                }
            )
        end
    end, { tbl1.alignmentType })

    if FFlagLuaAppEnableOneByTwoTileFunnelTelemetry then
        React.useEffect(function()
            if not tbl1.oneByTwoTileFlowId then
                return
            end

            OneByTwoTileTelemetry.logOneByTwoTileRendered({
                oneByTwoTileFlowId = tbl1.oneByTwoTileFlowId,
                recommendationsRequestId = tbl1.recommendationsRequestId,
                topicId = tbl1.topicId,
                contentType = tbl1.contentType,
                adId = tbl1.adId,
                componentType = GameCollectionItemTypes.GameCollectionItemType.OneByTwoTile,
                alignmentType = tbl1.alignmentType,
                isSdui = tbl1.isSdui == true
            })
        end, {
            tbl1.oneByTwoTileFlowId,
            tbl1.recommendationsRequestId,
            tbl1.topicId,
            tbl1.contentType,
            tbl1.adId,
            tbl1.alignmentType,
            tbl1.isSdui
        })
    end

    local viewportVideoAutoplayController = nil
    local var13 = nil
    local var14 = nil
    if FFlagLuaAppVideoAutoplayOneByTwoConcurrentPlayback then
        if tbl1.videoPlaybackContext then
            viewportVideoAutoplayController = tbl1.videoPlaybackContext.viewportVideoAutoplayController
        else
            viewportVideoAutoplayController = nil
        end

        local var15 = FFlagLuaAppOneByTwoHoverIdleAutoplay

        if var15 then
            if viewportVideoAutoplayController == nil then
                var15 = false
            else
                var15 = viewportVideoAutoplayController:isUserIntentWithSelectiveAutoplay()
            end
        end

        local var16 = if isSponsored then `{hoverKey}|{tbl1.adId}` else hoverKey
        local var17, var18 = React.useState(nil)
        local var19 = var17 == var16
            or not (viewportVideoAutoplayController == nil) and viewportVideoAutoplayController:hasCompletedAdsPlayback(var16)

        var13 = React.useMemo(function()
            if not viewportVideoAutoplayController or var15 or var19 then
                return nil
            end

            local adsPlaybackCoordinator = viewportVideoAutoplayController:getAdsPlaybackCoordinator()
            if adsPlaybackCoordinator then
                return adsPlaybackCoordinator
            end

            local videoPlaybackCoordinator = VideoPlaybackCoordinator.new()
            viewportVideoAutoplayController:attachAdsPlaybackCoordinator(videoPlaybackCoordinator, AdsViewportAutoplayCandidateTag)

            return videoPlaybackCoordinator
        end, { viewportVideoAutoplayController, var15, var19 })

        useTagAsAdsViewportAutoplayCandidate(var2, if var13 then viewportVideoAutoplayController else nil)

        local bool6 = var13 ~= nil
        var14 = React.useCallback(function()
            local current = var2.current
            if not (bool6 and viewportVideoAutoplayController and current) then
                return
            end

            viewportVideoAutoplayController:completeAdsPlayback(current, var16)
            var18(var16)
        end, { bool6, viewportVideoAutoplayController, var16 })
    end

    local var15 = if FFlagLuaAppOneByTwoHoverIdleAutoplay and isSponsored then `{hoverKey}|{tbl1.adId}` else hoverKey
    local var16 = useTagAsViewportAutoplayCandidate
    local videoPlaybackContext = if FFlagLuaAppVideoAutoplayOneByTwoConcurrentPlayback and var13 then nil else tbl1.videoPlaybackContext
    var16(
        var2,
        videoPlaybackContext,
        true,
        nil,
        2,
        var12,
        tbl1.alignmentType,
        FFlagLuaAppOneByTwoHoverIdleAutoplay and {
            videoKey = var15,
            isUserIntentModeAutoplayCandidate = true
        } or nil
    )

    local var17 = React.useRef(nil)

    local var18 = isSponsored
        and {
            encryptedAdTrackingData = tbl1.adId,
            tileType = GameCollectionItemTypes.GameCollectionItemType.OneByTwoTile,
            mediaType = "video",
            videoPlaybackStateRef = var17,
            videoSource = `rbxassetid://{tbl1.primaryVideoAssetId}`
        }
        or nil

    useTagAsSponsoredAdViewabilityCandidate(var2, var18)

    if not (FFlagLuaAppVideoAutoplayOneByTwoConcurrentPlayback and var13) then
        if tbl1.videoPlaybackContext then
            var13 = tbl1.videoPlaybackContext.videoPlaybackCoordinator
        else
            var13 = VideoPlaybackCoordinator.default
        end
    end

    if not FFlagLuaAppVideoAutoplayOneByTwoConcurrentPlayback then
        if FFlagLuaAppOneByTwoHoverIdleAutoplay and tbl1.videoPlaybackContext then
            viewportVideoAutoplayController = tbl1.videoPlaybackContext.viewportVideoAutoplayController
        else
            viewportVideoAutoplayController = nil
        end
    end

    local var19 = FFlagLuaAppOneByTwoHoverIdleAutoplay

    if var19 then
        if bool2 then
            if viewportVideoAutoplayController == nil then
                var19 = false
            else
                var19 = viewportVideoAutoplayController:isUserIntentWithSelectiveAutoplay()
            end
        else
            var19 = bool2
        end
    end

    local useMemo = React.useMemo
    local function func1()
        return getAvailableGameTileOverflowMenuItems({
            isSponsored = isSponsored,
            enableSponsoredFeedback = tbl1.enableSponsoredFeedback,
            enableReportAd = tbl1.enableReportAd,
            enableReportExperience = if FFlagLuaAppEnableReportExperience and not bool4 then tbl1.enableReportExperience else nil,
            enableExplicitFeedback = if bool4 then nil else tbl1.enableExplicitFeedback
        })
    end

    local enableSponsoredFeedback = tbl1.enableSponsoredFeedback
    local enableReportAd = tbl1.enableReportAd
    local enableReportExperience = if FFlagLuaAppEnableReportExperience then tbl1.enableReportExperience else nil
    local availableMenuItems = useMemo(
        func1,
        {
            isSponsored,
            bool4,
            enableSponsoredFeedback,
            enableReportAd,
            enableReportExperience,
            tbl1.enableExplicitFeedback
        }
    )

    local var21 = React.useCallback(function()
        var11.current = false
    end, {})

    local onSelectionGained = tbl1.onSelectionGained
    local var22 = React.useCallback(function()
        var8(true)
        if onSelectionGained then
            onSelectionGained()
        end
    end, { onSelectionGained })

    local onSelectionLost = tbl1.onSelectionLost
    local var23 = React.useCallback(function()
        var8(false)
        if onSelectionLost then
            onSelectionLost()
        end
    end, { onSelectionLost })

    local useCallback = React.useCallback
    local function func2()
        local current = var11.current
        var11.current = true
        if FFlagLuaAppSduiSponsoredOneByTwoTile and current == false and tbl1.onTouchLongPress then
            tbl1.onTouchLongPress()
            return
        end

        if current ~= false or next(availableMenuItems) == nil then
            return
        end

        if var10 and not var9 then
            local tbl2 = {
                universeId = tostring(tbl1.universeId or ""),
                sortId = tbl1.topicId
            }
            var10(str1, "Press", tbl1.appPage or "Unknown", tbl2)
        end
        getOverflowMenuSignalStore().openMenu(hoverKey)
    end

    local appPage = tbl1.appPage
    local topicId = tbl1.topicId
    local universeId = tbl1.universeId
    local onTouchLongPress = if FFlagLuaAppSduiSponsoredOneByTwoTile then tbl1.onTouchLongPress else nil
    local var24 = useCallback(func2, { hoverKey, appPage, topicId, universeId, var10, var9, availableMenuItems, onTouchLongPress })

    local var25 = React.useRef(0)

    local var26, var27 = React.useState(nil)

    local var28, var29 = React.useState(VideoLoadingState.Idle)
    local function onLoadingStateChanged(idle)
        if idle ~= VideoLoadingState.Idle then
            var29(idle)
        end
    end
    local onVideoLoaded = React.useCallback(function(duration: number, loadTime: number)
        var25.current = 0
        OneByTwoTileTelemetry.logOneByTwoTileVideoLoaded(duration, loadTime, tbl1.adId)
        var27({ duration = duration, loadTime = loadTime })
    end, { var27, tbl1.adId })

    local useCallback2 = React.useCallback
    local function func4()
        var25.current = 0
        if tbl1.videoAnalytics then
            tbl1.videoAnalytics.reportVideoLoop(tbl1.index, var13.currentPlaybackSessionId)
        end
        if FFlagLuaAppVideoAutoplayOneByTwoConcurrentPlayback and var14 then
            var14()
        end
    end

    local videoAnalytics = tbl1.videoAnalytics

    local index = tbl1.index
    local var31 = if FFlagLuaAppVideoAutoplayOneByTwoConcurrentPlayback then var14 else nil
    local onVideoLooped = useCallback2(func4, { videoAnalytics, var13, index, var31 })

    local var33 = if FFlagLuaAppOneByTwoHoverIdleAutoplay then React.useCallback(function()
        local current = var2.current
        if current == nil then
            DiscoveryEventErrorLogger.reportError(
                "SponsoredTiles",
                "OneByTwoTile: tile ref missing when reporting video completion"
            )
            return
        end

        if viewportVideoAutoplayController then
            viewportVideoAutoplayController:onVideoCompleted(current)
        end
    end, { viewportVideoAutoplayController, var2 }) else nil

    local onVideoProgressChanged = React.useCallback(function(current: number)
        var25.current = current
    end, {})

    local shouldStartPlayback, onPlaybackChange = React.useState(false)
    React.useEffect(function()
        local var37 = var26
        if not shouldStartPlayback or var37 == nil then
            return
        end
        local currentPlaybackSessionId = var13.currentPlaybackSessionId
        if currentPlaybackSessionId == nil then
            return
        end
        if tbl1.videoAnalytics then
            tbl1.videoAnalytics.reportVideoLoad(tbl1.index, currentPlaybackSessionId, var37.duration, var37.loadTime)
            var27(nil)
        end
    end, {
        shouldStartPlayback,
        var26,
        var13,
        tbl1.videoAnalytics,
        tbl1.index,
        var27
    })

    local bool6 = not (tbl1.videoPlaybackContext == nil) and tbl1.videoPlaybackContext.disablePlayback == true
    local bool7 = FFlagLuaAppSuppressVideoDetectorDuringScroll and FFlagLuaAppSuppressOneByTwoVideoDetectorDuringScroll

    if bool7 then
        if tbl1.videoPlaybackContext == nil then
            bool7 = false
        else
            bool7 = tbl1.videoPlaybackContext.disableDetectors == true
        end
    end

    React.useEffect(function()
        if bool6 then
            onPlaybackChange(false)
        end
    end, { bool6 })

    local isVideoEligible, var38 = React.useState(false)

    local var39 = useCanDevicePlayVideoPreview(TileVideoBlockingConfig, tbl1.universeId or "", tbl1.pageContext or "")

    local onPlaybackCandidate = React.useCallback(function()
        var38(var39())
    end, { var39 })
    React.useEffect(onPlaybackCandidate, { onPlaybackCandidate })

    local var41 = useRoactService(RoactNetworking)
    local var42 = useRoactService(AppSessionService)
    local var43 = useNavigation()
    local var44 = useLocalization({ joinButtonText = "Common.VisitGame.Label.Play" })
    local playableText = if bool4 then tbl1.ctaText elseif tbl1.ctaText ~= "" then tbl1.ctaText else var44.joinButtonText
    local bool8 = bool4 and not (tbl1.clickoutUrl == nil or tbl1.clickoutUrl == "") and playableText ~= ""
    local var46 = tbl1.launchExperienceEventContext or DiscoveryAnalytics.Constants.Context.ExperienceTile

    local var47 = React.useCallback(function()
        if tbl1.adId then
            sponsoredGamesRecordClick(var41, tbl1.adId)
        end
    end, { var41, tbl1.adId })

    local var3 = React.useCallback(function(str2: string?)
        if var42 then
            SetGamePlaySession(var42, SessionType.StructuralIdentifier.GamePlayFromHoverTile, true)
        end

        if isHovered then
            HoverTileCoordinator.default:reset()
        end

        if not tbl1.reportExperienceLaunched then
            return
        end

        local tbl2 = {
            placeId = tbl1.placeId,
            universeId = tbl1.universeId,
            adId = tbl1.adId,
            tileType = GameCollectionItemTypes.GameCollectionItemType.OneByTwoTile,
            placeIdOverride = tbl1.placeIdOverride,
            launchDataOverride = tbl1.launchDataOverride
        }
        local reportExperienceLaunched = tbl1.reportExperienceLaunched

        local referralSource = tbl1.referralSource
        local str3 = "OneByTwoTile"
        local var48 = var46
        local index2 = tbl1.index
        if not FFlagLuaAppDemoModePlayButtonTelemetry then
            str2 = nil
        end

        reportExperienceLaunched(tbl2, referralSource, str3, var48, index2, str2)
    end, {
        var42,
        tbl1.reportExperienceLaunched,
        tbl1.placeId,
        tbl1.universeId,
        tbl1.adId,
        tbl1.placeIdOverride,
        tbl1.launchDataOverride,
        tbl1.referralSource,
        var46,
        tbl1.index,
        isHovered
    })

    local useCallback3 = React.useCallback
    local function func5()
        if var11.current then
            var11.current = false
            return
        end

        if isHovered then
            HoverTileCoordinator.default:reset()
        end

        if not isVideoEligible or var28 ~= VideoLoadingState.Loaded then
            return
        end

        OneByTwoTileTelemetry.logOneByTwoTileActivated()
        local current = var25.current
        var13:reset(VideoEndReason.TileClicked, nil, tbl1.universeId, nil)
        var43.navigate(AppPage.FeatureTileAdPlayer, {
            extraProps = {
                videoAssetId = tbl1.primaryVideoAssetId,
                imageAssetId = tbl1.primaryImageAssetId,
                startPlaybackProgress = current,
                attributionThumbnailAssetId = tbl1.attributionThumbnailAssetId,
                videoPlaybackContext = tbl1.videoPlaybackContext,
                title = headline,
                subtitle = subtitle,
                contentType = tbl1.contentType,
                payerName = tbl1.payerName,
                sponsoredUserCohort = tbl1.sponsoredUserCohort,
                adId = tbl1.adId,
                enableReportAd = tbl1.enableReportAd,
                clickoutUrl = tbl1.clickoutUrl,
                ctaText = tbl1.ctaText,
                universeId = tbl1.universeId,
                index = tbl1.index,
                placeId = tbl1.placeId,
                placeIdOverride = tbl1.placeIdOverride,
                launchDataOverride = tbl1.launchDataOverride,
                referralSource = tbl1.referralSource,
                source = GameCollectionItemTypes.GameCollectionItemType.OneByTwoTile,
                launchExperienceEventContext = var46,
                reportGameDetailOpened = tbl1.reportGameDetailOpened,
                reportExperienceLaunched = tbl1.reportExperienceLaunched,
                onOpenGameDetails = if FFlagLuaAppSduiSponsoredOneByTwoTile then tbl1.onOpenGameDetails else nil,
                disableGameLaunchSponsoredClickRecording = if FFlagLuaAppSduiSponsoredOneByTwoTile then tbl1.disableGameLaunchSponsoredClickRecording else nil
            }
        })
    end

    local tableValue1 = isHovered
    local tableValue2 = var43
    local tableValue3 = var13
    local tableValue4 = tbl1.universeId
    local tableValue5 = tbl1.primaryVideoAssetId
    local tableValue6 = tbl1.primaryImageAssetId
    local tableValue7 = tbl1.attributionThumbnailAssetId
    local tableValue8 = tbl1.videoPlaybackContext
    local tableValue9 = headline
    local tableValue10 = subtitle
    local tableValue11 = tbl1.contentType
    local tableValue12 = tbl1.payerName
    local tableValue13 = tbl1.sponsoredUserCohort
    local tableValue14 = tbl1.adId
    local tableValue15 = tbl1.enableReportAd
    local tableValue16 = tbl1.clickoutUrl
    local ctaText = tbl1.ctaText
    local placeId = tbl1.placeId
    local placeIdOverride = tbl1.placeIdOverride
    local launchDataOverride = tbl1.launchDataOverride
    local referralSource = tbl1.referralSource

    local index2 = tbl1.index
    local reportGameDetailOpened = tbl1.reportGameDetailOpened
    local reportExperienceLaunched = tbl1.reportExperienceLaunched
    local onOpenGameDetails = if FFlagLuaAppSduiSponsoredOneByTwoTile then tbl1.onOpenGameDetails else nil
    local disableGameLaunchSponsoredClickRecording = if FFlagLuaAppSduiSponsoredOneByTwoTile then tbl1.disableGameLaunchSponsoredClickRecording else nil
    local var49 = useCallback3(func5, {
        tableValue1,
        tableValue2,
        tableValue3,
        tableValue4,
        tableValue5,
        tableValue6,
        tableValue7,
        tableValue8,
        tableValue9,
        tableValue10,
        tableValue11,
        tableValue12,
        tableValue13,
        tableValue14,
        tableValue15,
        tableValue16,
        ctaText,
        placeId,
        placeIdOverride,
        launchDataOverride,
        referralSource,
        var46,
        index2,
        reportGameDetailOpened,
        reportExperienceLaunched,
        onOpenGameDetails,
        disableGameLaunchSponsoredClickRecording,
        isVideoEligible,
        var28
    })

    local useCallback4 = React.useCallback
    local function func6()
        OneByTwoTileTelemetry.logOneByTwoTileGameJoinInitiated()
        OneByTwoTileTelemetry.logOneByTwoTileCtaActivated(OneByTwoTileTelemetry.CtaType.GameJoin)
        if not (FFlagLuaAppSduiSponsoredOneByTwoTile and tbl1.disableGameLaunchSponsoredClickRecording) then
            var47()
        end
    end

    local disableGameLaunchSponsoredClickRecording2 = if FFlagLuaAppSduiSponsoredOneByTwoTile then tbl1.disableGameLaunchSponsoredClickRecording else nil
    local onActivated = useCallback4(func6, { var47, disableGameLaunchSponsoredClickRecording2 })

    local useCallback5 = React.useCallback
    local function func7()
        if not bool8 then
            return
        end

        OneByTwoTileTelemetry.logOneByTwoTileCtaActivated(OneByTwoTileTelemetry.CtaType.Clickout)
        var47()
        if FFlagLuaAppAdClickoutEvent then
            local adId = tbl1.adId
            if adId ~= nil and adId ~= "" then
                SponsoredTilesTelemetry.Events.adClickout(
                    adId,
                    GameCollectionItemTypes.GameCollectionItemType.OneByTwoTile,
                    tbl1.clickoutUrl
                )
            end
        end
        if FFlagLuaAppAdClickoutDeeplink then
            openAdClickoutUrl(var43, tbl1.clickoutUrl)
            return
        end
        var43.navigate(AppPage.GenericWebPage, { detail = tbl1.clickoutUrl, extraProps = { showDomainAsTitle = true } })
    end

    local clickoutUrl = tbl1.clickoutUrl
    local adId = if FFlagLuaAppAdClickoutEvent then tbl1.adId else nil
    local var51 = useCallback5(func7, { bool8, var43, clickoutUrl, var47, adId })

    React.useEffect(function()
        ImpressionsTagUtility.AddTag(ref, tbl1.impressionsTag, tbl1.index)
        return function()
            ImpressionsTagUtility.RemoveTag(ref, tbl1.impressionsTag, tbl1.index)
        end
    end, { tbl1.impressionsTag, tbl1.index })

    local tileBadgesByPosition = useValidTileBadges(tbl1.universeId or "", tbl1.topicId, tbl1.badgeOverride)

    local var53 = tonumber(tbl1.logoAspectRatio)
    local aspectRatio = if var53 then if var53 > 0 then var53 else 1 else 1
    local xScale2 = if aspectRatio == 3 then xScale else num6
    local var55, var56, var57, var58, size500, offset, var59, yOffset, var60

    if bool1 then
        var55 = var1.Padding.Medium
        var56 = var1.Typography.TitleLarge
        var57 = var1.Typography.BodySmall
        var58 = var1.Size.Size_600
        size500 = var1.Size.Size_500
        offset = var1.Gap.XXSmall
        var59 = ButtonSize.Small
        yOffset = var1.Size.Size_800
        var60 = var1.Typography.TitleSmall
    else
        var55 = var1.Padding.Large
        var56 = var1.Typography.HeadingMedium
        var57 = var1.Typography.BodyMedium
        var58 = var1.Size.Size_800
        size500 = var1.Size.Size_500
        offset = var1.Gap.XSmall
        var59 = ButtonSize.Medium
        yOffset = var1.Size.Size_1000
        var60 = var1.Typography.TitleMedium
    end

    local createElement = React.createElement
    local str2 = "Frame"
    local tbl2 = {
        Size = if FFlagLuaAppSduiSponsoredOneByTwoTile then tbl1.rootSize else nil,
        LayoutOrder = tbl1.index,
        ZIndex = tbl1.zIndex,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ref = ref
    }
    local tbl3 = { Container = 0 }
    local createElement2 = React.createElement
    local str3 = "TextButton"
    local tbl4 = {
        ref = var2,
        Size = tbl1.size or UDim2.fromScale(1, 1),
        BackgroundColor3 = var1.Color.Surface.Surface_100.Color3,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Text = "",
        AutoButtonColor = false,
        SelectionOrder = tbl1.SelectionOrder,
        [React.Event.Activated] = var49,
        [React.Event.TouchLongPress] = var24,
        [React.Event.SelectionGained] = var22,
        [React.Event.SelectionLost] = var23,
        [React.Change.GuiState] = var21
    }
    local tbl5 = {
        UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, var1.Radius.Medium) }),
        Video = 0,
        GradientOverlayBottom = 0,
        TileBadge = 0,
        Logo = 0,
        OverflowMenu = 0,
        BottomStack = 0
    }
    local createElement3 = React.createElement
    local var61 = VideoDisplay
    local tbl6 = {
        video = `rbxassetid://{tbl1.primaryVideoAssetId}`,
        thumbnail = `rbxassetid://{tbl1.primaryImageAssetId}`,
        shouldStartPlayback = shouldStartPlayback,
        loadImmediately = isVideoEligible and var28 ~= VideoLoadingState.Failed,
        muted = true,
        looped = not FFlagLuaAppOneByTwoHoverIdleAutoplay or not var19 or isHovered,
        Size = UDim2.fromScale(1, 1),
        ScaleType = Enum.ScaleType.Crop,
        cornerRadius = var1.Radius.Medium,
        ZIndex = 0,
        onVideoLoaded = onVideoLoaded,
        onLoadingStateChanged = onLoadingStateChanged,
        onVideoEnded = 0,
        onVideoLooped = 0,
        onVideoProgressChanged = 0,
        videoPlaybackStateRef = 0
    }

    if not (FFlagLuaAppOneByTwoHoverIdleAutoplay and var19) then
        var33 = nil
    end

    tbl6.onVideoEnded = var33

    tbl6.onVideoLooped = onVideoLooped
    tbl6.onVideoProgressChanged = onVideoProgressChanged
    if not isSponsored then
        var17 = nil
    end

    tbl6.videoPlaybackStateRef = var17
    tbl5.Video = createElement3(var61, tbl6)

    tbl5.GradientOverlayBottom = React.createElement("Frame", {
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.new(0, 0, 1, 0),
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = var1.Color.Extended.Black.Black_100.Color3,
        BackgroundTransparency = 0,
        BorderSizePixel = 0,
        ZIndex = 1
    }, {
        UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, var1.Radius.Medium) }),
        UIGradientBottom = React.createElement("UIGradient", {
            Rotation = 90,
            Transparency = NumberSequence.new(
                { NumberSequenceKeypoint.new(0, num8), NumberSequenceKeypoint.new(1 - num9, num8), NumberSequenceKeypoint.new(1, num7) }
            )
        })
    })
    local var62

    if tileBadgesByPosition then
        local createElement4 = React.createElement
        local str4 = "Frame"
        local tbl7 = {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            ZIndex = 2
        }

        local tbl8 = {
            Badge = React.createElement(GameTileThumbnailBadges, {
                tileBadgesByPosition = tileBadgesByPosition,
                padding = if FFlagLuaAppSponsoredTileBadgeContentPadding then var55 else nil
            })
        }
        var62 = createElement4(str4, tbl7, tbl8)
    else
        var62 = nil
    end

    tbl5.TileBadge = var62
    local element

    if tbl1.logoImageAssetId then
        element = React.createElement(Image, {
            Image = `rbxassetid://{tbl1.logoImageAssetId}`,
            Position = UDim2.new(1, -var1.Padding.Medium, 0, var1.Padding.Medium),
            tag = "anchor-top-right",
            Size = UDim2.new(xScale2, 0, 1, 0),
            aspectRatio = aspectRatio,
            ZIndex = 2
        })
    else
        element = nil
    end

    tbl5.Logo = element
    local var63

    if FFlagLuaAppSduiSponsoredOneByTwoTile and tbl1.renderOverflowMenu then
        var63 = tbl1.renderOverflowMenu({ isHovered = isHovered, isSelected = isSelected, menuKey = hoverKey, parentRef = var2 })
    else
        local createElement4 = React.createElement
        local var64 = SpanTileOverflowMenu
        local tbl7 = {
            hoverKey = hoverKey,
            parentRef = var2,
            zIndex = 4,
            universeId = tbl1.universeId,
            placeId = tbl1.placeId,
            adId = tbl1.adId,
            payerName = tbl1.payerName,
            sponsoredUserCohort = tbl1.sponsoredUserCohort,
            appPage = tbl1.appPage,
            topicId = tbl1.topicId,
            isSponsored = isSponsored,
            contentType = tbl1.contentType,
            setGameHidden = if FFlagLuaAppSduiSponsoredOneByTwoTile then tbl1.setGameHidden or function() end else tbl1.setGameHidden,
            isHovered = isHovered,
            isSelected = isSelected,
            availableMenuItems = availableMenuItems
        }
        var63 = createElement4(var64, tbl7)
    end

    tbl5.OverflowMenu = var63

    local createElement4 = React.createElement
    local str4 = "Frame"
    local tbl7 = {
        Size = UDim2.new(1, -2 * var55, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        Position = UDim2.new(0, var55, 1, -var55),
        AnchorPoint = Vector2.new(0, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 2
    }

    local tbl8 = {
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            Padding = UDim.new(0, var55)
        }),
        TextStack = 0,
        CtaButton = 0
    }
    local createElement5 = React.createElement
    local str5 = "Frame"
    local tbl9 = {
        LayoutOrder = 1,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        BorderSizePixel = 0
    }

    local tbl10 = {
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            Padding = UDim.new(0, offset)
        }),
        Headline = 0,
        Subtitle = 0
    }
    local element2

    if headline then
        element2 = React.createElement("TextLabel", {
            LayoutOrder = 1,
            Size = UDim2.new(1, 0, 0, 2 * var58),
            BackgroundTransparency = 1,
            Text = headline,
            FontFace = normalizeFontFace(var56.Font),
            LineHeight = var56.LineHeight,
            TextSize = var56.FontSize,
            TextColor3 = var1.LightMode.ActionOverMedia.Foreground.Color3,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Bottom,
            TextWrapped = true,
            TextTruncate = Enum.TextTruncate.AtEnd
        })
    else
        element2 = nil
    end

    tbl10.Headline = element2
    local element3

    if subtitle then
        element3 = React.createElement("TextLabel", {
            LayoutOrder = 2,
            Size = UDim2.new(1, 0, 0, size500),
            BackgroundTransparency = 1,
            Text = subtitle,
            FontFace = normalizeFontFace(var57.Font),
            LineHeight = var57.LineHeight,
            TextSize = var57.FontSize,
            TextColor3 = var1.LightMode.ActionOverMedia.Foreground.Color3,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            TextWrapped = false,
            TextTruncate = Enum.TextTruncate.AtEnd
        })
    else
        element3 = nil
    end

    tbl10.Subtitle = element3
    tbl8.TextStack = createElement5(str5, tbl9, tbl10)
    local element4

    if bool4 then
        if bool8 then
            element4 = React.createElement("TextButton", {
                LayoutOrder = 2,
                Size = UDim2.fromOffset(0, yOffset),
                AutomaticSize = Enum.AutomaticSize.X,
                BackgroundColor3 = var1.Color.Extended.White.White_20.Color3,
                BackgroundTransparency = var1.Color.Extended.White.White_20.Transparency,
                BorderSizePixel = 0,
                Text = playableText,
                TextColor3 = var1.LightMode.ActionOverMedia.Foreground.Color3,
                FontFace = normalizeFontFace(var60.Font),
                TextSize = var60.FontSize,
                [React.Event.Activated] = var51
            }, {
                UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, var1.Radius.Medium) }),
                UIPadding = React.createElement(
                    "UIPadding",
                    {
                        PaddingLeft = UDim.new(0, var1.Padding.Large),
                        PaddingRight = UDim.new(0, var1.Padding.Large)
                    }
                )
            })
        else
            element4 = nil
        end
    elseif tbl1.universeId then
        element4 = React.createElement(PlayButton, {
            LayoutOrder = 2,
            universeId = tbl1.universeId,
            placeId = if tbl1.placeIdOverride then tbl1.placeIdOverride else tbl1.placeId,
            referralSource = tbl1.referralSource,
            eventContext = var46,
            launchSource = "OneByTwoTile",
            playableText = playableText,
            hidePlayableIcon = true,
            buttonSize = var59,
            preferSecondaryPlayButton = true,
            onActivated = onActivated,
            reportExperienceLaunched = var3,
            experienceJoinData = {
                launchData = tbl1.launchDataOverride,
                tileType = GameCollectionItemTypes.GameCollectionItemType.OneByTwoTile,
                nativeAdData = tbl1.adId
            }
        })
    else
        element4 = nil
    end

    tbl8.CtaButton = element4
    tbl5.BottomStack = createElement4(str4, tbl7, tbl8)
    tbl3.Container = createElement2(str3, tbl4, tbl5)
    local tile = createElement(str2, tbl2, tbl3)
    local playbackDetectionMethod = if FFlagLuaAppOneByTwoHoverIdleAutoplay or FFlagLuaAppGameTileSelectionVideoPlayback then getPlaybackDetectionMethod(var5, bool2) else nil
    local createElement6 = React.createElement
    local fragment = React.Fragment
    local var64 = nil
    local tbl11 = { Tile = tile, VideoPlaybackDetector = 0 }
    local var65

    if bool6 or FFlagLuaAppSuppressVideoDetectorDuringScroll and bool7 then
        var65 = nil
    else
        local createElement7 = React.createElement
        local var66 = VideoPlaybackDetector
        local tbl12 = {
            videoKey = 0,
            itemIndex = 0,
            itemFrameRef = 0,
            playbackDetectionMethod = 0,
            isHoverSupported = 0,
            autoplay = 0,
            isHovered = 0,
            hasVideoPlaybackUserIntent = 0,
            onPlaybackChange = 0,
            videoAnalytics = 0,
            videoDwellTimeInSec = 0,
            videoVisiblePercent = 0,
            videoPlaybackCoordinator = 0,
            viewportVideoAutoplayController = 0,
            isVideoEligible = 0,
            onPlaybackCandidate = 0
        }

        if not FFlagLuaAppOneByTwoHoverIdleAutoplay then
            var15 = hoverKey
        end

        tbl12.videoKey = var15
        tbl12.itemIndex = tbl1.index
        tbl12.itemFrameRef = var2
        tbl12.playbackDetectionMethod = if FFlagLuaAppGameTileSelectionVideoPlayback then playbackDetectionMethod elseif FFlagLuaAppOneByTwoHoverIdleAutoplay then playbackDetectionMethod else nil

        if FFlagLuaAppGameTileSelectionVideoPlayback then
            bool2 = nil
        end

        tbl12.isHoverSupported = bool2
        tbl12.autoplay = not FFlagLuaAppGameTileSelectionVideoPlayback or nil
        tbl12.isHovered = isHovered
        tbl12.hasVideoPlaybackUserIntent = if FFlagLuaAppOneByTwoHoverIdleAutoplay then if playbackDetectionMethod == VideoPlaybackDetectionMethod.Hover then isHovered else nil else nil

        tbl12.onPlaybackChange = onPlaybackChange
        tbl12.videoAnalytics = tbl1.videoAnalytics
        tbl12.videoDwellTimeInSec = FIntLuaAppGameTileVideoDwellTimeInSec
        tbl12.videoVisiblePercent = FIntLuaAppGameTileVideoVisiblePercent
        tbl12.videoPlaybackCoordinator = var13
        tbl12.viewportVideoAutoplayController = if FFlagLuaAppVideoAutoplayOneByTwoConcurrentPlayback then viewportVideoAutoplayController elseif tbl1.videoPlaybackContext then tbl1.videoPlaybackContext.viewportVideoAutoplayController else nil

        tbl12.isVideoEligible = isVideoEligible
        tbl12.onPlaybackCandidate = onPlaybackCandidate
        var65 = createElement7(var66, tbl12)
    end

    tbl11.VideoPlaybackDetector = var65
    return createElement6(fragment, var64, tbl11)
end)
