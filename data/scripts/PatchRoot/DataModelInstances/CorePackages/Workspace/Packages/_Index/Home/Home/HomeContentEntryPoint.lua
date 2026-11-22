-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:30:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppLifecycleObserverService = game:GetService("AppLifecycleObserverService")
local ExperienceService = game:GetService("ExperienceService")

local Home = script:FindFirstAncestor("Home")
local HomeParent = Home.Parent

local React = require(HomeParent.React)
local SignalsReact = require(HomeParent.SignalsReact)
local useSponsoredAdViewabilityDetector = require(HomeParent.SponsoredAdViewability).useSponsoredAdViewabilityDetector
local _Navigation = require(HomeParent.Navigation)
local AppPage = require(HomeParent.RobloxAppEnums).AppPage
local Responsive = require(HomeParent.Responsive)
local SduiSharedUtilities = require(HomeParent.SduiSharedUtilities)
local SduiPageWrapperEntryPoint = SduiSharedUtilities.SduiPageWrapperEntryPoint
local usePageScopeRef = SduiSharedUtilities.usePageScopeRef
local useEntrySurfacing = SduiSharedUtilities.useEntrySurfacing
local VideoUtils = require(HomeParent.VideoUtils)

local refreshHomePage = require(Home.refreshHomePage)
local fetchHomePage = require(Home.fetchHomePage)
local useHomeCollectionLayoutSync = require(Home.useHomeCollectionLayoutSync)
local useHomeStartupSnapshot = require(Home.useHomeStartupSnapshot)
local HomeConstants = require(Home.HomeConstants)
local HomePageSession = require(Home.HomePageSession)
local FFlagLuaAppAddHomeExtraTopPadding = require(HomeParent.SharedFlags).FFlagLuaAppAddHomeExtraTopPadding
local FFlagLuaAppSduiVideoThumbnail = require(HomeParent.SharedFlags).FFlagLuaAppSduiVideoThumbnail
local FFlagLuaAppOneByTwoHoverIdleAutoplay = require(HomeParent.SharedFlags).FFlagLuaAppOneByTwoHoverIdleAutoplay

local FFlagLuaAppSduiSuppressVideoDetectorDuringScroll = require(HomeParent.SharedFlags).FFlagLuaAppSduiSuppressVideoDetectorDuringScroll
local FFlagSduiDismissPromptPageScope = require(HomeParent.SharedFlags).FFlagSduiDismissPromptPageScope
local FFlagAppPageShellScrollToTopFocus = require(HomeParent.SharedFlags).FFlagAppPageShellScrollToTopFocus
local FFlagAppPageShellScrollTelemetry = require(HomeParent.SharedFlags).FFlagAppPageShellScrollTelemetry

local FFlagHomePageRefetchOnDataHydrationAccountReset = require(HomeParent.SharedFlags).FFlagHomePageRefetchOnDataHydrationAccountReset
local FFlagLuaAppSduiHomeSponsoredAdViewability = require(Home.Flags.FFlagLuaAppSduiHomeSponsoredAdViewability)
local FFlagAppThemeHalloween2026HomeBackground = require(HomeParent.SharedFlags).FFlagAppThemeHalloween2026HomeBackground
local FFlagSduiHomeStartupSnapshot = require(HomeParent.SharedFlags).FFlagSduiHomeStartupSnapshot

local function getFromPropsOrNavigationParams(tbl1, str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return tbl1[str1] or tbl1.navigation and tbl1.navigation.getParam(str1)
end

local function getCommittedHomeSessionId(arg1)
    local var1 = HomePageSession:GetCommittedSignal()(arg1)
    return if var1 then var1.sessionId else nil
end

return React.memo(function(tbl1) -- name: HomeContentEntryPoint
    local configKey = HomeConstants.ConfigKey
    local feedTopMargin

    if FFlagLuaAppAddHomeExtraTopPadding then
        local var1 = useEntrySurfacing(configKey, HomeConstants.ContentIdentifier, "fullPage")
        local contentTopPadding = var1 and var1.contentTopPadding or 0
        feedTopMargin = (tbl1.feedTopMargin or 0) + contentTopPadding
    else
        feedTopMargin = nil
    end

    if FFlagSduiDismissPromptPageScope then
        usePageScopeRef(configKey)
    end

    local fromPropsOrNavigationParams = getFromPropsOrNavigationParams(tbl1, "pageTimer")

    local pageTimer = React.useMemo(function()
        return fromPropsOrNavigationParams or SduiSharedUtilities.SduiLoadTimer.createLoadTimer(AppPage.Home)
    end, { configKey, fromPropsOrNavigationParams })

    local var2 = if FFlagHomePageRefetchOnDataHydrationAccountReset then SduiSharedUtilities.useDataHydrationAccountGeneration() else nil
    local useEffect = React.useEffect
    local function func1()
        fetchHomePage(pageTimer)
    end

    if not FFlagHomePageRefetchOnDataHydrationAccountReset then
        var2 = nil
    end

    useEffect(func1, { configKey, pageTimer, var2 })

    React.useEffect(function()
        return require(Home.getHomePageAutoRefreshStore)(false).start()
    end, {})

    useHomeCollectionLayoutSync()

    local var3 = nil
    if FFlagLuaAppOneByTwoHoverIdleAutoplay then
        local var4 = Responsive.usePreferredInput()
        local bool1 = var4 == Responsive.Input.Pointer

        local playbackDetectionMethod = VideoUtils.getPlaybackDetectionMethod(var4, bool1)

        var3 = VideoUtils.useFeedVideoPlaybackContext(nil, nil, nil, nil, playbackDetectionMethod)
    elseif FFlagLuaAppSduiVideoThumbnail then
        local bool1 = Responsive.usePreferredInput() == Responsive.Input.Touch

        var3 = React.useMemo(function()
            return VideoUtils.FeedVideoPlaybackContext.new(bool1)
        end, { bool1 })
    end

    local var4 = nil
    if FFlagLuaAppSduiHomeSponsoredAdViewability then
        local var5, var6 = React.useState(nil)
        var4 = var6
        local var7 = SignalsReact.useSignalState(getCommittedHomeSessionId)
        useSponsoredAdViewabilityDetector(var5, var7, AppLifecycleObserverService)
    end

    local var5

    if FFlagSduiHomeStartupSnapshot then
        local var6, var7 = React.useState(nil)

        useHomeStartupSnapshot(var6, tbl1.navigation)
        var5 = React.useCallback(function(arg1)
            var7(arg1)
            if var4 then
                var4(arg1)
            end
        end, { var4 })
    else
        var5 = nil
    end

    if FFlagLuaAppSduiSuppressVideoDetectorDuringScroll then
        local bool1 = Responsive.usePreferredInput() == Responsive.Input.Touch
        local viewportVideoAutoplayController = if var3 then var3.viewportVideoAutoplayController else nil

        React.useEffect(function()
            if not viewportVideoAutoplayController then
                return nil
            end
            viewportVideoAutoplayController:setSuppressDetectorsDuringScroll(bool1)
            if not bool1 then
                return nil
            end

            local connection = AppLifecycleObserverService.OnHide:Connect(function()
                viewportVideoAutoplayController:reset(VideoUtils.AnalyticsEnums.VideoEndReason.AppBackgrounded)
            end)
            local connection2 = ExperienceService:RegisterForExperienceJoin(function()
                viewportVideoAutoplayController:reset(VideoUtils.AnalyticsEnums.VideoEndReason.ExperienceLaunched)
            end)

            return function()
                connection:Disconnect()
                connection2:Disconnect()
            end
        end, { viewportVideoAutoplayController, bool1 })
    end

    local createElement = React.createElement
    local var6 = SduiPageWrapperEntryPoint
    local tbl2 = {
        ref = 0,
        appPage = 0,
        configKey = 0,
        contentIdentifier = 0,
        pageTimer = 0,
        refresh = 0,
        scrollPerformanceIntervalName = 0,
        pageTopPadding = 0,
        feedTopMargin = 0,
        stickyTopPadding = 0,
        scrollAway = 0,
        videoPlaybackContext = 0,
        handleBackButton = 0,
        defaultFocusRef = 0,
        backgroundStyle = 0,
        stickyBackgroundStyle = 0
    }

    if not FFlagSduiHomeStartupSnapshot then
        if FFlagLuaAppSduiHomeSponsoredAdViewability then
            var5 = var4
        else
            var5 = nil
        end
    end

    tbl2.ref = var5

    tbl2.appPage = AppPage.Home
    tbl2.configKey = configKey
    tbl2.contentIdentifier = HomeConstants.ContentIdentifier
    tbl2.pageTimer = pageTimer
    tbl2.refresh = refreshHomePage
    tbl2.scrollPerformanceIntervalName = if FFlagAppPageShellScrollTelemetry then "LuaApp_Home_Scroll" else nil
    tbl2.pageTopPadding = tbl1.pageTopPadding
    if not FFlagLuaAppAddHomeExtraTopPadding then
        feedTopMargin = tbl1.feedTopMargin
    end

    tbl2.feedTopMargin = feedTopMargin
    tbl2.stickyTopPadding = tbl1.feedTopMargin
    tbl2.scrollAway = tbl1.scrollAway
    if not (FFlagLuaAppSduiVideoThumbnail or FFlagLuaAppOneByTwoHoverIdleAutoplay) then
        var3 = nil
    end

    tbl2.videoPlaybackContext = var3

    tbl2.handleBackButton = not FFlagAppPageShellScrollToTopFocus and nil
    tbl2.defaultFocusRef = if FFlagAppPageShellScrollToTopFocus then tbl1.defaultFocusRef else nil
    tbl2.backgroundStyle = if FFlagAppThemeHalloween2026HomeBackground then tbl1.backgroundStyle else nil
    tbl2.stickyBackgroundStyle = if FFlagAppThemeHalloween2026HomeBackground then tbl1.stickyBackgroundStyle else nil
    return createElement(var6, tbl2)
end)
