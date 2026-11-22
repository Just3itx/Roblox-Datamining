-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:51:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialServerDrivenUi = script:FindFirstAncestor("SocialServerDrivenUi")
local SocialServerDrivenUiParent = SocialServerDrivenUi.Parent

local React = require(SocialServerDrivenUiParent.React)
local SharedFlags = require(SocialServerDrivenUiParent.SharedFlags)
local Signals = require(SocialServerDrivenUiParent.Signals)
local SignalsReact = require(SocialServerDrivenUiParent.SignalsReact)
local SduiCoreSystem = require(SocialServerDrivenUiParent.SduiCoreSystem)
local PYMKCarousel = require(SocialServerDrivenUiParent.PYMKCarousel)
local FriendRecommendations = require(SocialServerDrivenUiParent.DataHydration.FriendsRecommendations).FriendRecommendations

local AppPage = require(SocialServerDrivenUiParent.RobloxAppEnums).AppPage
local SetCurrentToastMessage = require(SocialServerDrivenUiParent.ToastRodux).Actions.SetCurrentToastMessage
local PymkNavigationBridge = require(SocialServerDrivenUi.System.PymkNavigationBridge)
local normalizeDirectRecommendations = require(SocialServerDrivenUi.Common.normalizeDirectRecommendations)

local FFlagCreateConnectionsHub = SharedFlags.FFlagCreateConnectionsHub
local FFlagLuaAppEnableSduiHomePage = SharedFlags.FFlagLuaAppEnableSduiHomePage
local FFlagPymkCarouselExtendProps = SharedFlags.FFlagPymkCarouselExtendProps

local tbl1 = {}

local function readRecommendationHydration(tbl2, store, arg1)
    local result = {}

    for _, value in tbl2 do
        local var1 = store.getFriendRecommendation(value.id).data(arg1)
        if var1 then
            result[value.id] = var1
        end
    end

    return result
end

local function SduiPymkCarousel(tbl2)
    local var1 = tbl2.items or tbl1
    local analyticsData = tbl2.analyticsContext.analyticsData or {}
    local dependencies = tbl2.sduiContext.dependencies
    local sortIndex = tonumber(SduiCoreSystem.findAnalyticsField("collectionPosition", analyticsData, -1)) or -1
    local startRow = tbl2.startRow or -1
    local store = if FFlagPymkCarouselExtendProps then FriendRecommendations.getStore(tbl2.sduiContext.configKey) else FriendRecommendations.getStore()

    local var2 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            return normalizeDirectRecommendations(var1, (readRecommendationHydration(var1, store, arg1)))
        end)
    end, { var1, store })
    local var3 = SignalsReact.useSignalState(var2)

    local sortAnalyticsData = React.useMemo(function()
        return {
            sortIndex = sortIndex,
            appPage = tbl2.sduiContext.appPage,
            sortId = tbl2.sortId,
            startRow = startRow
        }
    end, {
        sortIndex,
        tbl2.sduiContext.appPage,
        tbl2.sortId,
        startRow
    })
    local openProfilePeekView = React.useCallback(function(str1: string, arg1)
        PymkNavigationBridge.requestOpenProfile(str1, arg1)
    end, {})

    local showToast = React.useCallback(function(toastMessage: string)
        dependencies.dispatch(SetCurrentToastMessage({ toastMessage = toastMessage }))
    end, { dependencies.dispatch })

    local goToAddFriendsPage = React.useCallback(function(_: boolean?)
        if FFlagCreateConnectionsHub then
            dependencies.getNavigation().navigate(AppPage.CoHubAddConnections)
            return
        end
        PymkNavigationBridge.requestOpenAddFriends()
    end, { dependencies.getNavigation })

    local createElement = React.createElement
    local pymkCarouselEntryPoint = PYMKCarousel.PYMKCarouselEntryPoint
    local tbl3 = {
        key = tbl2.recommendationRequestId,
        carouselTitle = tbl2.title or "",
        recommendations = 0,
        recommendationSessionId = 0,
        openProfilePeekView = 0,
        showToast = 0,
        goToAddFriendsPage = 0,
        pageContext = 0,
        scrollViewPositionChangedSignal = 0,
        sortAnalyticsData = 0,
        diagService = 0,
        eventIngestService = 0,
        appCompositionEnabled = 0,
        onRecommendationsShown = 0,
        analyticsSurface = 0
    }
    if FFlagPymkCarouselExtendProps and not FFlagLuaAppEnableSduiHomePage and tbl2.sduiContext.appPage == AppPage.Home then
        var3 = nil
    end

    tbl3.recommendations = var3

    tbl3.recommendationSessionId = tbl2.recommendationRequestId
    tbl3.openProfilePeekView = openProfilePeekView
    tbl3.showToast = showToast
    tbl3.goToAddFriendsPage = goToAddFriendsPage
    tbl3.pageContext = tbl2.sduiContext.appPage
    tbl3.scrollViewPositionChangedSignal = tbl2.scrollViewPositionChangedSignal
    tbl3.sortAnalyticsData = sortAnalyticsData
    tbl3.diagService = dependencies.appAnalytics.Diag
    tbl3.eventIngestService = dependencies.eventIngest
    tbl3.appCompositionEnabled = tbl2.sduiContext.appCompositionEnabled
    tbl3.onRecommendationsShown = if FFlagPymkCarouselExtendProps then tbl2.onRecommendationsShown else nil
    tbl3.analyticsSurface = if FFlagPymkCarouselExtendProps then tbl2.analyticsSurface else nil
    return createElement(pymkCarouselEntryPoint, tbl3)
end

return SduiPymkCarousel
