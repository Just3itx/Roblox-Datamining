-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:51:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetail = script:FindFirstAncestor("GameDetail")
local GameDetailParent = GameDetail.Parent

local FFlagSduiEdpRenderStarted = require(GameDetail.Flags.FFlagSduiEdpRenderStarted)
local ExperienceDetailsPageUtils = require(script.Parent.ExperienceDetailsPageUtils)
local ExperienceDetailsPageConstants = require(script.Parent.ExperienceDetailsPageConstants)
local ExperienceDetailsPageScopeFields = require(script.Parent.ExperienceDetailsPageScopeFields)
local fetchExperienceDetailsPage = require(script.Parent.fetchExperienceDetailsPage)
local getExperienceDetailsPageKey = require(script.Parent.getExperienceDetailsPageKey)
local PeekViewTopBar = require(script.Parent.PeekViewTopBar)
local useEdpFunctionallyReadyLogger = require(script.Parent.useEdpFunctionallyReadyLogger)
local createExperienceDetailsPageTimer = require(script.Parent.createExperienceDetailsPageTimer)
local useMotionJitterMetric = require(script.Parent.useMotionJitterMetric)
local ExperienceDetailsFallbackActionBar = require(script.Parent.Fallback.ExperienceDetailsFallbackActionBar)
local ExperienceDetailsFallbackFeed = require(script.Parent.Fallback.ExperienceDetailsFallbackFeed)

local SetTabBarVisible = require(GameDetailParent.AppTabBarRodux).Actions.SetTabBarVisible
local gameDetailsPeekViewEvents = require(GameDetailParent.DiscoveryAnalytics).Events.gameDetailsPeekViewEvents

local _Navigation = require(GameDetailParent.Navigation)
local Foundation = require(GameDetailParent.Foundation)
local React = require(GameDetailParent.React)
local PeekView = require(GameDetailParent.PeekView)
local useTokens = Foundation.Hooks.useTokens
local useNavigation = require(GameDetailParent.Navigation).useNavigation
local PeekViewWithTopBar = PeekView.PeekViewWithTopBar
local PeekViewState = PeekView.PeekViewState
local getSafeAreaSize = require(GameDetailParent.InputUi).getSafeAreaSize
local useDeviceInsets = require(GameDetailParent.Responsive).useDeviceInsets
local DataHydration = require(GameDetailParent.DataHydration)

local useTopBarHeight = require(GameDetailParent.RobloxAppHooks).useTopBarHeight
local useScreenSize = require(GameDetailParent.RobloxAppHooks).useScreenSize
local useRoactService = require(GameDetailParent.RobloxAppHooks).useRoactService
local RoactServiceTags = require(GameDetailParent.RoactServiceTags)
local AppEventIngestService = RoactServiceTags.AppEventIngestService
local AppSessionService = RoactServiceTags.AppSessionService
local SessionType = require(GameDetailParent.RobloxAppSessionization).SessionType
local AppPage = require(GameDetailParent.RobloxAppEnums).AppPage

local RoactUtils = require(GameDetailParent.RoactUtils)
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local EDPTTIConstants = require(GameDetailParent.GameDetailTelemetry).EDPTTIConstants

local SduiSharedUtilities = require(GameDetailParent.SduiSharedUtilities)
local getSduiClientPageScope = SduiSharedUtilities.getSduiClientPageScope
local SduiSurfaceLoadTimeTracker = SduiSharedUtilities.SduiSurfaceLoadTimeTracker
local usePageScopeRef = SduiSharedUtilities.usePageScopeRef
local SduiFeatureEntryPoint = SduiSharedUtilities.SduiFeatureEntryPoint
local SduiPageEntryPoint = SduiSharedUtilities.SduiPageEntryPoint
local UiStatus = SduiSharedUtilities.UiStatus
local usePublishContainerWidth = SduiSharedUtilities.usePublishContainerWidth
local useUiStatus = SduiSharedUtilities.useUiStatus
local useEntrySurfacing = SduiSharedUtilities.useEntrySurfacing
local FilterPlayWithReward = ExperienceDetailsPageScopeFields.FilterPlayWithReward

local CompositionTags = require(GameDetailParent.AppComposition).CompositionTags

local ExperienceDetailsPersistentActionBar = require(script.Parent.ExperienceDetailsPersistentActionBar)

local SharedFlags = require(GameDetailParent.SharedFlags)
local FFlagSduiContainerQueries = SharedFlags.FFlagSduiContainerQueries
local FFlagEDPTTIParityDefinitions = SharedFlags.FFlagEDPTTIParityDefinitions
local FFlagSduiPageEntryUseSharedHooks = SharedFlags.FFlagSduiPageEntryUseSharedHooks
local FFlagEnableMotionJitterMetric = SharedFlags.FFlagEnableMotionJitterMetric
local FFlagSduiEdpPersistentActionBarPlayButton = SharedFlags.FFlagSduiEdpPersistentActionBarPlayButton
local FFlagLuaAppEdpBottomSheetPeekViewEvents = SharedFlags.FFlagLuaAppEdpBottomSheetPeekViewEvents

return React.memo(function(pageProps) -- name: ExperienceDetailsPeekView
    local universeId = ExperienceDetailsPageUtils.getUniverseId(pageProps)
    local source = ExperienceDetailsPageUtils.getAnalyticsSource(pageProps)
    local index = ExperienceDetailsPageUtils.getTilePositionIndex(pageProps)
    local fromPropsOrNavigationParams = ExperienceDetailsPageUtils.getFromPropsOrNavigationParams(pageProps, "onPeekViewClosed")
    local configKey = getExperienceDetailsPageKey(universeId)
    usePageScopeRef(configKey)
    local var1 = React.useMemo(function()
        local fromPropsOrNavigationParams2 = ExperienceDetailsPageUtils.getFromPropsOrNavigationParams(pageProps, "pageTimer")
        local var1 = if FFlagEDPTTIParityDefinitions then fromPropsOrNavigationParams2
            or createExperienceDetailsPageTimer(
                configKey,
                {
                    page = "Untracked",
                    category = EDPTTIConstants.EDP_IMPLEMENTATION.SDUI_PEEK_VIEW
                }
            ) else fromPropsOrNavigationParams2
            or SduiSurfaceLoadTimeTracker.createLoadTimerWithSurfaceLoadTime(configKey, {
                eventName = EDPTTIConstants.EDP_TTI_EVENT_NAME,
                metadata = {
                    page = "Untracked",
                    category = EDPTTIConstants.EDP_IMPLEMENTATION.SDUI_PEEK_VIEW
                },
                manualSurfaceReady = true
            })
        getSduiClientPageScope(configKey).set(SduiSurfaceLoadTimeTracker.SURFACE_LOAD_TIME_PAGE_SCOPE_KEY, var1)
        return var1
    end, {})

    if FFlagSduiEdpRenderStarted then
        var1.logRenderStarted()
    end
    useEdpFunctionallyReadyLogger(var1, universeId)

    local var2 = useTokens()
    local var3 = useNavigation()
    local var4 = useRoactService(AppEventIngestService)
    local var5 = useRoactService(AppSessionService)
    local var6 = useDispatch()
    React.useEffect(function()
        var6(SetTabBarVisible(false))
    end, { var6 })

    local referralSource = ExperienceDetailsPageUtils.getFromPropsOrNavigationParams(pageProps, "referralSource")
    local experienceJoinData = ExperienceDetailsPageUtils.getFromPropsOrNavigationParams(pageProps, "experienceJoinData")
    local placeIdOverride = ExperienceDetailsPageUtils.getFromPropsOrNavigationParams(pageProps, "placeIdOverride")
    React.useEffect(function()
        local sduiClientPageScope = getSduiClientPageScope(configKey)
        sduiClientPageScope.set("referralSource", referralSource)
        sduiClientPageScope.set("experienceJoinData", experienceJoinData)
        sduiClientPageScope.set("placeId", placeIdOverride)
        sduiClientPageScope.set("launchSource", "LuaGameCard")
        sduiClientPageScope.set(FilterPlayWithReward, nil)
    end, {
        configKey,
        referralSource,
        experienceJoinData,
        placeIdOverride
    })
    local topBarHeight = useTopBarHeight()
    local var8 = useScreenSize()
    local var9 = useDeviceInsets()
    local num1 = math.min(getSafeAreaSize(var8, var9).X.Offset, 640)
    local var10 = if FFlagSduiContainerQueries then usePublishContainerWidth(configKey) else nil
    local scrollingFrameRef = React.useRef(nil)
    local bottomDockedContainerHeight, var13 = React.useState(function()
        return var2.Padding.Medium + var2.Size.Size_1200
    end)

    local onAbsoluteSizeChange = React.useCallback(function(arg1)
        local absoluteSizeY = arg1.AbsoluteSize.Y
        if not (absoluteSizeY > 0) then
            return
        end

        local var14 = var2.Padding.Medium + var2.Size.Size_1200
        if not (absoluteSizeY <= var14 + var2.Padding.Medium) then
            var14 = absoluteSizeY
        end

        var13(var14)
    end, { var2 })

    local var15 = useEntrySurfacing(configKey, ExperienceDetailsPageConstants.EDP_FEED_IDENTIFIER, "peekView")
    local heightOffset = var15 and var15.heightOffset or 0
    local uDim = UDim.new(0, num1 + bottomDockedContainerHeight + heightOffset)

    local var16 = useSelector(function(arg1)
        return arg1.GameDetailsPeekView.viewState
    end)
    local fromPropsOrNavigationParams5 = ExperienceDetailsPageUtils.getFromPropsOrNavigationParams(pageProps, "mountAsFullView")
    if fromPropsOrNavigationParams5 == nil then
        fromPropsOrNavigationParams5 = var16 == PeekViewState.Full or var16 == PeekViewState.Extended
    end

    local mountAnimation = var16 == PeekViewState.Closed

    if FFlagEnableMotionJitterMetric then
        useMotionJitterMetric(scrollingFrameRef, ExperienceDetailsPageConstants.EDP_PEEK_VIEW_SURFACE, true, "CanvasPosition")
    end

    local onClose = React.useCallback(function()
        if fromPropsOrNavigationParams and typeof(fromPropsOrNavigationParams) == "function" then
            fromPropsOrNavigationParams()
        end
        var3.clearAppScreens({ AppPage.GameDetail })
        if var5 then
            var5:RemoveSession(SessionType.StructuralIdentifier.GameDetailSource)
        end
    end, {
        var3,
        var5,
        fromPropsOrNavigationParams,
        universeId,
        source,
        index
    })
    React.useEffect(function()
        if universeId and var1 then
            fetchExperienceDetailsPage(universeId, var1)
        end
    end, { universeId, var1 })

    local var18 = useUiStatus(configKey)
    React.useEffect(function()
        if var18 == UiStatus.Error and universeId then
            DataHydration.Game.getGameInfoStore(false).getAndFetchGameInfo(universeId, function(arg1): boolean
                return arg1 == nil or arg1.creator == nil
            end)
            DataHydration.Game.getAgeRecommendationStore(false).getAndFetchAgeRecommendation(universeId)
        end
    end, { var18, universeId })

    local refresh = React.useCallback(function()
        if universeId and var1 then
            fetchExperienceDetailsPage(universeId, var1, true)
        end
    end, { universeId, var1 })

    local onViewStateChanged = React.useCallback(function(viewState, arg1)
        local var20 = universeId or ""
        if universeId and viewState == PeekViewState.Brief then
            if var16 == PeekViewState.Brief then
                gameDetailsPeekViewEvents(
                    var4,
                    "SwitchGame",
                    var20,
                    source,
                    index,
                    if FFlagLuaAppEdpBottomSheetPeekViewEvents then ExperienceDetailsPageConstants.EDP_PEEK_VIEW_SURFACE else nil
                )
            elseif arg1 == PeekViewState.Closed then
                gameDetailsPeekViewEvents(
                    var4,
                    "OpenPeekView",
                    var20,
                    source,
                    index,
                    if FFlagLuaAppEdpBottomSheetPeekViewEvents then ExperienceDetailsPageConstants.EDP_PEEK_VIEW_SURFACE else nil
                )
            end
        end

        var6({ type = "SetGameDetailsPeekViewState", viewState = viewState })
        if universeId and viewState == PeekViewState.Full and arg1 == PeekViewState.Brief then
            gameDetailsPeekViewEvents(
                var4,
                "GoToFullView",
                var20,
                source,
                index,
                if FFlagLuaAppEdpBottomSheetPeekViewEvents then ExperienceDetailsPageConstants.EDP_PEEK_VIEW_SURFACE else nil
            )
        end

        if viewState == PeekViewState.Closed then
            onClose()
        end
    end, {
        var6,
        var4,
        universeId,
        source,
        index,
        var16,
        onClose
    })

    if universeId == nil then
        return nil
    end

    local createElement = React.createElement
    local var21 = PeekViewWithTopBar
    local tbl1 = {
        topBarHeight = topBarHeight,
        bottomDockedContainerHeight = bottomDockedContainerHeight,
        fullViewContentHeight = UDim.new(1, -topBarHeight),
        briefViewContentHeight = uDim,
        onViewStateChanged = onViewStateChanged,
        viewChangedEventMeta = { universeId = universeId, source = source, index = index },
        mountAsFullView = fromPropsOrNavigationParams5,
        mountAnimation = mountAnimation,
        scrollingFrameRef = scrollingFrameRef,
        topBarSlot = React.createElement(PeekViewTopBar, { pageProps = pageProps, onClose = onClose }),
        contentSlot = 0,
        bottomBarSlot = 0
    }

    local createElement2 = React.createElement
    local str1 = "Frame"
    local tbl2 = { ref = 0, Size = 0, AutomaticSize = 0, BackgroundTransparency = 1 }
    if not FFlagSduiContainerQueries then
        var10 = nil
    end

    tbl2.ref = var10
    tbl2.Size = UDim2.new(1, 0, 1, 0)
    tbl2.AutomaticSize = Enum.AutomaticSize.Y

    local tbl3 = {
        Content = React.createElement(SduiPageEntryPoint, {
            appPage = AppPage.GameDetail,
            configKey = configKey,
            identifier = if FFlagSduiPageEntryUseSharedHooks then ExperienceDetailsPageConstants.EDP_FEED_IDENTIFIER else ExperienceDetailsPageUtils.getResolvedIdentifier(configKey, ExperienceDetailsPageConstants.EDP_FEED_IDENTIFIER_SUFFIX),
            pageTimer = var1,
            backgroundStyle = var2.Color.Surface.Surface_100,
            includeNavigationHeaderBar = false,
            scrollingFrameRef = scrollingFrameRef,
            contentTag = CompositionTags.ContentRegion.Body,
            loadingSlot = React.createElement(
                ExperienceDetailsFallbackFeed.Skeleton,
                { universeId = universeId, isSmallScreen = true, launchSource = "LuaGameCard" }
            ),
            errorSlot = React.createElement(ExperienceDetailsFallbackFeed.Error, {
                universeId = universeId,
                refresh = refresh,
                isSmallScreen = true,
                launchSource = "LuaGameCard",
                referralSource = referralSource,
                experienceJoinData = experienceJoinData,
                placeIdOverride = placeIdOverride
            }),
            snackbarPortalLayoutOrder = 2147483647
        })
    }
    tbl1.contentSlot = createElement2(str1, tbl2, tbl3)
    local element

    if FFlagSduiEdpPersistentActionBarPlayButton then
        element = React.createElement(ExperienceDetailsPersistentActionBar, {
            universeId = universeId,
            configKey = configKey,
            loadTimer = var1,
            launchSource = "LuaGameCard",
            referralSource = referralSource,
            experienceJoinData = experienceJoinData,
            placeIdOverride = placeIdOverride,
            onAbsoluteSizeChange = onAbsoluteSizeChange
        })
    else
        element = React.createElement(SduiFeatureEntryPoint, {
            appPage = AppPage.GameDetail,
            configKey = configKey,
            identifier = ExperienceDetailsPageConstants.EDP_ACTION_BAR_IDENTIFIER,
            loadTimer = var1,
            AutomaticSize = Enum.AutomaticSize.XY,
            onAbsoluteSizeChange = onAbsoluteSizeChange,
            loadingSlot = React.createElement(ExperienceDetailsFallbackActionBar.Skeleton, {
                universeId = universeId,
                launchSource = "LuaGameCard",
                referralSource = referralSource,
                experienceJoinData = experienceJoinData,
                placeIdOverride = placeIdOverride
            }),
            errorSlot = React.createElement(ExperienceDetailsFallbackActionBar.Error, {
                universeId = universeId,
                launchSource = "LuaGameCard",
                referralSource = referralSource,
                experienceJoinData = experienceJoinData,
                placeIdOverride = placeIdOverride
            })
        })
    end

    tbl1.bottomBarSlot = element
    return createElement(var21, tbl1)
end)
