-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCarousel = script:FindFirstAncestor("SocialCarousel")
local SocialCarouselParent = SocialCarousel.Parent
local React = require(SocialCarouselParent.React)
local RoactUtils = require(SocialCarouselParent.RoactUtils)

local AppEventIngestService = require(SocialCarouselParent.RoactServiceTags).AppEventIngestService
local RoactAnalytics = require(SocialCarouselParent.RoactServiceTags).RoactAnalytics
local useRoactService = require(SocialCarouselParent.RobloxAppHooks).useRoactService
local useThrottledCallback = RoactUtils.Hooks.useThrottledCallback

local _Enums = require(SocialCarousel.Common.Enums)

local SocialCarouselContext = require(SocialCarousel.Contexts.SocialCarouselContext)
local useSocialCarouselList = require(SocialCarousel.Hooks.useSocialCarouselList)
local useSocialCarouselUnifiedLogging = require(SocialCarousel.Analytics.useSocialCarouselUnifiedLogging)
local useSocialCarouselAnalytics = require(SocialCarousel.Analytics.useSocialCarouselAnalytics)
local useSocialCarouselLoadTimer = require(SocialCarousel.Analytics.useSocialCarouselLoadTimer)

local _AnalyticsTypes = require(SocialCarousel.Analytics.AnalyticsTypes)

local num1 = game:DefineFastInt("FriendCarouselRefreshThrottleInterval", 3)
local FFlagSocialCarouselShareQREnabled = require(SocialCarouselParent.SharedFlags).FFlagSocialCarouselShareQREnabled
local FFlagMobileGameJoinCardVideo = require(SocialCarouselParent.SharedFlags).FFlagMobileGameJoinCardVideo
local FFlagSocialCarouselBuildPresence = require(SocialCarouselParent.SharedFlags).FFlagSocialCarouselBuildPresence
local FFlagSocialCarouselInGameTitleMarquee = require(SocialCarouselParent.SharedFlags).FFlagSocialCarouselInGameTitleMarquee

local Carousel = require(SocialCarousel.Components.Carousel)

return function(tbl1)
    local appAnalytics = useRoactService(RoactAnalytics)
    local eventIngest = useRoactService(AppEventIngestService)
    local var3 = useSocialCarouselAnalytics()
    local var4 = useSocialCarouselLoadTimer(var3.reportLoadingEvent)
    local var5 = React.useRef(os.clock())
    local var6 = useSocialCarouselList(tbl1.roduxKey, tbl1.customTileList)

    local openGameJoinCardUserId, var8 = React.useState(nil)
    local var9 = var8
    local var10, var11

    if FFlagSocialCarouselBuildPresence then
        var10, var11 = React.useState(nil)
    else
        var10 = nil
        var11 = nil
    end

    local var12 = React.useRef(nil)
    local var13 = if FFlagSocialCarouselInGameTitleMarquee then React.useRef(nil) else nil

    local var14 = React.useCallback(function(current)
        if typeof(current) == "function" then
            current = current(var12.current)
        end

        var12.current = current
        var9(current)
    end, { var9 })
    local unifiedLogging = useSocialCarouselUnifiedLogging(appAnalytics, eventIngest, tbl1.unifiedLogging, var6, var5)

    local var16 = useThrottledCallback(function()
        var6.refreshFriendsList()
    end, num1)

    React.useEffect(function()
        if not tbl1.refreshSignal then
            return
        end

        tbl1.refreshSignal:connect(var16)
    end, { tbl1.refreshSignal })

    local createElement = React.createElement
    local provider = SocialCarouselContext.Provider
    local tbl2 = { value = 0 }
    local value = {
        eventIngest = eventIngest,
        appAnalytics = appAnalytics,
        hideCarouselHeader = tbl1.hideCarouselHeader,
        openGameJoinCardUserId = openGameJoinCardUserId,
        joinPopoverUserIdRef = if FFlagSocialCarouselInGameTitleMarquee then var12 else nil,
        joinSheetUserIdRef = 0,
        setOpenGameJoinCardUserId = 0,
        openBuildCardUserId = 0,
        setOpenBuildCardUserId = 0,
        unifiedLogging = 0,
        sortAnalyticsData = 0,
        friendRequestCount = 0,
        recommendationCount = 0,
        friendCount = 0,
        tiles = 0,
        isLoading = 0,
        onSuccessfulRender = 0,
        selectionOrderBase = 0,
        source = 0,
        navigateToQRCodePage = 0,
        isJoinCardVideoEnabled = 0,
        videoPlaybackContext = 0
    }

    if not FFlagSocialCarouselInGameTitleMarquee then
        var13 = nil
    end

    value.joinSheetUserIdRef = var13
    if not FFlagSocialCarouselInGameTitleMarquee then
        var14 = var9
    end

    value.setOpenGameJoinCardUserId = var14

    if not FFlagSocialCarouselBuildPresence then
        var10 = nil
    end

    value.openBuildCardUserId = var10
    if not FFlagSocialCarouselBuildPresence then
        var11 = nil
    end

    value.setOpenBuildCardUserId = var11
    value.unifiedLogging = unifiedLogging
    value.sortAnalyticsData = tbl1.sortAnalyticsData
    value.friendRequestCount = var6.friendRequestCount
    value.recommendationCount = var6.recommendationCount
    value.friendCount = var6.friendCount
    value.tiles = var6.tiles
    value.isLoading = var6.isLoading
    value.onSuccessfulRender = var4.onSuccessfulRender
    value.selectionOrderBase = tbl1.selectionOrderBase
    value.source = tbl1.source
    value.navigateToQRCodePage = if FFlagSocialCarouselShareQREnabled then tbl1.navigateToQRCodePage else nil
    value.isJoinCardVideoEnabled = if FFlagMobileGameJoinCardVideo then tbl1.isJoinCardVideoEnabled else nil
    value.videoPlaybackContext = if FFlagMobileGameJoinCardVideo then tbl1.videoPlaybackContext else nil
    tbl2.value = value
    return createElement(
        provider,
        tbl2,
        {
            Carousel = React.createElement(Carousel, { appCompositionEnabled = tbl1.appCompositionEnabled })
        }
    )
end
