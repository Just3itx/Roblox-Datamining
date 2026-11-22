-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:30:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PYMKCarousel = script:FindFirstAncestor("PYMKCarousel")
local PYMKCarouselParent = PYMKCarousel.Parent

local dependencies = require(PYMKCarousel.dependencies)

local React = dependencies.React
local RobloxAppHooks = require(PYMKCarouselParent.RobloxAppHooks)
local SharedFlags = require(PYMKCarouselParent.SharedFlags)

local useSelector = dependencies.Hooks.useSelector
local useLocalUserId = RobloxAppHooks.useLocalUserId

local setupFireEvent = require(PYMKCarousel.Analytics).setupFireEvent
local getSessionIdByKey = dependencies.RoduxAnalytics.Selectors.getSessionIdByKey
local RECOMMENDATION_SESSION_ID_KEY = require(PYMKCarousel.Common.Constants).RECOMMENDATION_SESSION_ID_KEY
local HomepagePYMKCarouselSourceName = require(PYMKCarousel.Common.Constants).HomepagePYMKCarouselSourceName

local PYMKCollectionCarousel = require(PYMKCarousel.Components.PYMKCollectionCarousel)

local _AnalyticsTypes = require(PYMKCarousel.Analytics.AnalyticsTypes)
local _DirectRecommendationTypes = require(PYMKCarousel.Common.DirectRecommendationTypes)

local FFlagLuaAppUserSeenCollectionUnifiedFields = SharedFlags.FFlagLuaAppUserSeenCollectionUnifiedFields
local FFlagLuaAppEnableSduiHomePage = SharedFlags.FFlagLuaAppEnableSduiHomePage
local FFlagPymkCarouselExtendProps = SharedFlags.FFlagPymkCarouselExtendProps

local function PYMKCarouselEntryPoint(tbl1)
    local uid = useLocalUserId()
    local var2

    if FFlagLuaAppEnableSduiHomePage then
        var2 = tbl1.recommendationSessionId
    elseif FFlagPymkCarouselExtendProps then
        var2 = useSelector(function(arg1)
            return getSessionIdByKey(arg1)(RECOMMENDATION_SESSION_ID_KEY)
        end)
        if tbl1.recommendations then
            var2 = tbl1.recommendationSessionId
        end
    else
        var2 = useSelector(function(arg1)
            return getSessionIdByKey(arg1)(RECOMMENDATION_SESSION_ID_KEY)
        end)
    end

    local useMemo = React.useMemo
    local function func1()
        return setupFireEvent({
            infoForAllEvents = {
                uid = uid,
                recommendationSessionId = var2,
                sortIndex = tbl1.sortAnalyticsData.sortIndex,
                sortId = tbl1.sortAnalyticsData.sortId,
                appPage = tbl1.sortAnalyticsData.appPage,
                rowNumber = 1,
                feedRowNumber = tbl1.sortAnalyticsData.startRow,
                source = if FFlagPymkCarouselExtendProps then if tbl1.analyticsSurface then tbl1.analyticsSurface.source else HomepagePYMKCarouselSourceName else nil
            },
            analytics = {
                Diag = tbl1.diagService,
                EventStream = tbl1.eventIngestService
            },
            context = if FFlagPymkCarouselExtendProps and tbl1.analyticsSurface then tbl1.analyticsSurface.context else nil
        })
    end

    local var3 = var2
    local sortAnalyticsData = tbl1.sortAnalyticsData
    local analyticsSurface = if FFlagPymkCarouselExtendProps then tbl1.analyticsSurface else nil
    local fireAnalyticsEvent = useMemo(func1, { uid, var3, sortAnalyticsData, analyticsSurface })

    if not uid then
        return nil
    end

    if not (var2 or tbl1.findFriendsTileEnabled) then
        return nil
    end

    return React.createElement(PYMKCollectionCarousel, {
        findFriendsTileEnabled = tbl1.findFriendsTileEnabled,
        seeAllTileEnabled = tbl1.seeAllTileEnabled,
        recommendationSessionId = var2,
        carouselTitle = tbl1.carouselTitle,
        sideMargin = tbl1.sideMargin,
        openProfilePeekView = tbl1.openProfilePeekView,
        showToast = tbl1.showToast,
        goToAddFriendsPage = tbl1.goToAddFriendsPage,
        shouldShowContactImporterBadge = tbl1.shouldShowContactImporterBadge,
        pageContext = tbl1.pageContext,
        scrollViewPositionChangedSignal = tbl1.scrollViewPositionChangedSignal,
        fireAnalyticsEvent = fireAnalyticsEvent,
        appCompositionEnabled = tbl1.appCompositionEnabled,
        sortAnalyticsData = if FFlagLuaAppUserSeenCollectionUnifiedFields then tbl1.sortAnalyticsData else nil,
        recommendations = if FFlagPymkCarouselExtendProps or FFlagLuaAppEnableSduiHomePage then tbl1.recommendations else nil,
        onRecommendationsShown = if FFlagPymkCarouselExtendProps then tbl1.onRecommendationsShown else nil,
        analyticsSurface = if FFlagPymkCarouselExtendProps then tbl1.analyticsSurface else nil
    })
end
return PYMKCarouselEntryPoint
