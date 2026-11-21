-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:51:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetail = script:FindFirstAncestor("GameDetail")
local GameDetailParent = GameDetail.Parent

local FFlagSduiEdpRenderStarted = require(GameDetail.Flags.FFlagSduiEdpRenderStarted)
local ExperienceDetailsPageUtils = require(script.Parent.ExperienceDetailsPageUtils)
local ExperienceDetailsPageConstants = require(script.Parent.ExperienceDetailsPageConstants)
local ExperienceDetailsPageScopeFields = require(script.Parent.ExperienceDetailsPageScopeFields)
local ExperienceDetailsBottomSheetTopBar = require(script.Parent.ExperienceDetailsBottomSheetTopBar)
local fetchExperienceDetailsPage = require(script.Parent.fetchExperienceDetailsPage)
local getExperienceDetailsPageKey = require(script.Parent.getExperienceDetailsPageKey)
local removeGameDetailSessionIfDeparted = require(script.Parent.removeGameDetailSessionIfDeparted)
local useEdpFunctionallyReadyLogger = require(script.Parent.useEdpFunctionallyReadyLogger)
local createExperienceDetailsPageTimer = require(script.Parent.createExperienceDetailsPageTimer)
local useMotionJitterMetric = require(script.Parent.useMotionJitterMetric)
local ExperienceDetailsFallbackActionBar = require(script.Parent.Fallback.ExperienceDetailsFallbackActionBar)
local ExperienceDetailsFallbackFeed = require(script.Parent.Fallback.ExperienceDetailsFallbackFeed)

local SetTabBarVisible = require(GameDetailParent.AppTabBarRodux).Actions.SetTabBarVisible
local DiscoveryTypes = require(GameDetailParent.DiscoveryTypes)
local gameDetailsPeekViewEvents = require(GameDetailParent.DiscoveryAnalytics).Events.gameDetailsPeekViewEvents

local Navigation = require(GameDetailParent.Navigation)
local Foundation = require(GameDetailParent.Foundation)
local React = require(GameDetailParent.React)
local Sheet = Foundation.Sheet
local OverlayProvider = Foundation.OverlayProvider
local useTokens = Foundation.Hooks.useTokens
local useNavigation = Navigation.useNavigation
local getSafeAreaSize = require(GameDetailParent.InputUi).getSafeAreaSize
local useDeviceInsets = require(GameDetailParent.Responsive).useDeviceInsets
local DataHydration = require(GameDetailParent.DataHydration)

local useTopBarHeight = require(GameDetailParent.RobloxAppHooks).useTopBarHeight
local shouldUseDeviceSafeInsets = require(GameDetailParent.Display).shouldUseDeviceSafeInsets
local useScreenSize = require(GameDetailParent.RobloxAppHooks).useScreenSize
local useRoactService = require(GameDetailParent.RobloxAppHooks).useRoactService
local RoactServiceTags = require(GameDetailParent.RoactServiceTags)
local AppEventIngestService = RoactServiceTags.AppEventIngestService
local AppSessionService = RoactServiceTags.AppSessionService
local SessionType = require(GameDetailParent.RobloxAppSessionization).SessionType
local AppPage = require(GameDetailParent.RobloxAppEnums).AppPage

local RoactUtils = require(GameDetailParent.RoactUtils)
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useStore = RoactUtils.Hooks.RoactRodux.useStore
local useGetCurrentLegacyRoute = require(GameDetailParent.DiscoveryRouting).useGetCurrentLegacyRoute
local hasPageInCurrentRoute = require(GameDetailParent.DiscoveryRouting).hasPageInCurrentRoute
local PeekViewState = require(GameDetailParent.PeekView).PeekViewState
local SetGameDetailsPeekViewState = require(GameDetail.PeekView.SetGameDetailsPeekViewState)
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
local FFlagEnableExperienceDetailsBottomSheetTopBar = SharedFlags.FFlagEnableExperienceDetailsBottomSheetTopBar
local FFlagEnableMotionJitterMetric = SharedFlags.FFlagEnableMotionJitterMetric
local FFlagSduiEdpPersistentActionBarPlayButton = SharedFlags.FFlagSduiEdpPersistentActionBarPlayButton
local FFlagLuaAppEdpBottomSheetPeekViewEvents = SharedFlags.FFlagLuaAppEdpBottomSheetPeekViewEvents
local FFlagSduiPlayWithRewardRefactor = SharedFlags.FFlagSduiPlayWithRewardRefactor
local FFlagFixOverlayTopInsetForDeviceSafeInsets = SharedFlags.FFlagFixOverlayTopInsetForDeviceSafeInsets

local function snapPointIndexFor(bool1: boolean): number -- Luacid: Inlined by compiler; 2 call sites recovered
    return if bool1 then 2 else 1
end

return React.memo(function(arg1) -- name: ExperienceDetailsBottomSheet
    local universeId = ExperienceDetailsPageUtils.getUniverseId(arg1)
    local fromPropsOrNavigationParams = ExperienceDetailsPageUtils.getFromPropsOrNavigationParams(arg1, "onPeekViewClosed")
    local configKey = getExperienceDetailsPageKey(universeId)

    usePageScopeRef(configKey)
    local var1 = React.useMemo(function()
        local fromPropsOrNavigationParams2 = ExperienceDetailsPageUtils.getFromPropsOrNavigationParams(arg1, "pageTimer")
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

    local tokens = useTokens()
    local navigation = useNavigation()
    local var4 = useRoactService(AppSessionService)
    local var5 = useDispatch()
    local var6 = if FFlagLuaAppEdpBottomSheetPeekViewEvents then useRoactService(AppEventIngestService) else nil

    local var7 = useGetCurrentLegacyRoute()

    React.useEffect(function()
        var5(SetTabBarVisible(false))
    end, { var5 })

    local referralSource = ExperienceDetailsPageUtils.getFromPropsOrNavigationParams(arg1, "referralSource")
    local experienceJoinData = ExperienceDetailsPageUtils.getFromPropsOrNavigationParams(arg1, "experienceJoinData")
    local placeIdOverride = ExperienceDetailsPageUtils.getFromPropsOrNavigationParams(arg1, "placeIdOverride")

    React.useEffect(function()
        local sduiClientPageScope = getSduiClientPageScope(configKey)
        sduiClientPageScope.set("referralSource", referralSource)
        sduiClientPageScope.set("experienceJoinData", experienceJoinData)
        sduiClientPageScope.set("placeId", placeIdOverride)
        sduiClientPageScope.set("launchSource", "LuaGameCard")
        if FFlagSduiPlayWithRewardRefactor then
            sduiClientPageScope.set(FilterPlayWithReward, nil)
        end
    end, {
        configKey,
        referralSource,
        experienceJoinData,
        placeIdOverride
    })
    local var8 = if FFlagEnableExperienceDetailsBottomSheetTopBar then useTopBarHeight() else nil

    local var9 = useScreenSize()
    local deviceInsets = useDeviceInsets()

    if FFlagEnableExperienceDetailsBottomSheetTopBar
        and FFlagFixOverlayTopInsetForDeviceSafeInsets
        and shouldUseDeviceSafeInsets
    then
        local top = deviceInsets.top
        var8 += top
    end
    local safeAreaSize = getSafeAreaSize(var9, deviceInsets)
    local num1 = math.min(safeAreaSize.X.Offset, 640)
    local var11 = if FFlagSduiContainerQueries then usePublishContainerWidth(configKey) else nil
    local var12 = if FFlagEnableExperienceDetailsBottomSheetTopBar then React.useRef(nil) else nil
    local scrollingFrameRef = React.useRef(nil)
    local var14, ref = React.useState(nil)
    local var16, var17 = React.useState(DiscoveryTypes.Constants.GAME_DETAILS_ACTION_BAR_HEIGHT)

    local onAbsoluteSizeChange = React.useCallback(function(arg2)
        local absoluteSizeY = arg2.AbsoluteSize.Y
        if absoluteSizeY > 0 then
            var17(absoluteSizeY)
        end
    end, {})

    local var19 = useEntrySurfacing(configKey, ExperienceDetailsPageConstants.EDP_FEED_IDENTIFIER, "peekView")
    local heightOffset = var19 and var19.heightOffset or 0

    local snapPoints = React.useMemo(function()
        local var20 = num1 + var16 + heightOffset + 25
        local offset = if FFlagEnableExperienceDetailsBottomSheetTopBar then math.ceil(var9.Y) - deviceInsets.bottom - var8 else safeAreaSize.Y.Offset
        return { var20, offset }
    end, FFlagEnableExperienceDetailsBottomSheetTopBar and {
        num1,
        var16,
        heightOffset,
        var9.Y,
        deviceInsets.bottom,
        var8
    }
        or {
            num1,
            var16,
            heightOffset,
            safeAreaSize.Y.Offset
        })

    local fromPropsOrNavigationParams5 = ExperienceDetailsPageUtils.getFromPropsOrNavigationParams(arg1, "mountAsFullView")
    local bool1 = fromPropsOrNavigationParams5 == true
    local var21

    if FFlagLuaAppEdpBottomSheetPeekViewEvents then
        local var22 = useStore()
        local analyticsSource = ExperienceDetailsPageUtils.getAnalyticsSource(arg1)
        local tilePositionIndex = ExperienceDetailsPageUtils.getTilePositionIndex(arg1)

        local var23 = React.useMemo(function()
            return var22:getState().GameDetailsPeekView.viewState
        end, {})
        if fromPropsOrNavigationParams5 ~= nil then
            bool1 = fromPropsOrNavigationParams5 == true
        else
            bool1 = var23 == PeekViewState.Full or var23 == PeekViewState.Extended
        end

        React.useEffect(function()
            if universeId and not bool1 then
                local var24 = if var23 == PeekViewState.Brief then "SwitchGame" elseif var23 == PeekViewState.Closed then "OpenPeekView" else nil

                if var24 then
                    gameDetailsPeekViewEvents(
                        var6,
                        var24,
                        universeId,
                        analyticsSource,
                        tilePositionIndex,
                        ExperienceDetailsPageConstants.EDP_BOTTOM_SHEET_SURFACE
                    )
                end
            end

            var5(SetGameDetailsPeekViewState(if bool1 then PeekViewState.Full else PeekViewState.Brief))

            return function()
                if not hasPageInCurrentRoute(var7(), AppPage.GameDetail) then
                    var5(SetGameDetailsPeekViewState(PeekViewState.Closed))
                end
            end
        end, {})

        local var24 = React.useRef((snapPointIndexFor(bool1)))
        var21 = React.useCallback(function(_: number, current: number)
            local current2 = var24.current
            var24.current = current

            if navigation.isFocused() then
                var5(SetGameDetailsPeekViewState(if current == 2 then PeekViewState.Full else PeekViewState.Brief))
            end

            if universeId and current2 == 1 and current == 2 then
                gameDetailsPeekViewEvents(
                    var6,
                    "GoToFullView",
                    universeId,
                    analyticsSource,
                    tilePositionIndex,
                    ExperienceDetailsPageConstants.EDP_BOTTOM_SHEET_SURFACE
                )
            end
        end, {
            var6,
            universeId,
            analyticsSource,
            tilePositionIndex,
            var5,
            navigation
        })
    else
        var21 = nil
    end
    local defaultSnapPointIndex = snapPointIndexFor(bool1)

    if FFlagEnableMotionJitterMetric then
        useMotionJitterMetric(
            scrollingFrameRef,
            ExperienceDetailsPageConstants.EDP_BOTTOM_SHEET_SURFACE,
            false,
            "AbsolutePosition"
        )
    end

    local onBack = React.useCallback(function()
        if not navigation.isFocused() then
            return
        end

        local var22 = var7()
        if fromPropsOrNavigationParams and typeof(fromPropsOrNavigationParams) == "function" then
            fromPropsOrNavigationParams()
        end
        navigation.goBack()
        removeGameDetailSessionIfDeparted(var4, var22)
    end, {
        navigation,
        var4,
        fromPropsOrNavigationParams,
        var7
    })

    local onClose = React.useCallback(function()
        if not navigation.isFocused() then
            return
        end

        if fromPropsOrNavigationParams and typeof(fromPropsOrNavigationParams) == "function" then
            fromPropsOrNavigationParams()
        end
        navigation.clearAppScreens({ AppPage.GameDetail })
        if var4 then
            var4:RemoveSession(SessionType.StructuralIdentifier.GameDetailSource)
        end
    end, { navigation, var4, fromPropsOrNavigationParams })

    local var2 = if FFlagLuaAppEdpBottomSheetPeekViewEvents then onClose elseif bool1 then onBack else onClose

    React.useEffect(function()
        if universeId and var1 then
            fetchExperienceDetailsPage(universeId, var1)
        end
    end, { universeId, var1 })

    local var25 = useUiStatus(configKey)
    React.useEffect(function()
        if var25 == UiStatus.Error and universeId then
            DataHydration.Game.getGameInfoStore(false).getAndFetchGameInfo(universeId, function(arg2): boolean
                return arg2 == nil or arg2.creator == nil
            end)
            DataHydration.Game.getAgeRecommendationStore(false).getAndFetchAgeRecommendation(universeId)
        end
    end, { var25, universeId })

    local refresh = React.useCallback(function()
        if universeId and var1 then
            fetchExperienceDetailsPage(universeId, var1, true)
        end
    end, { universeId, var1 })

    if universeId == nil then
        return nil
    end

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl1 = {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        ref = ref
    }
    local tbl2 = { SheetProvider = 0 }
    local var27

    if var14 then
        local createElement2 = React.createElement
        local var28 = OverlayProvider
        local tbl3 = { gui = var14 }
        local tbl4 = {
            TopBar = if FFlagEnableExperienceDetailsBottomSheetTopBar then React.createElement(
                ExperienceDetailsBottomSheetTopBar,
                {
                    tokens = tokens,
                    navigation = navigation,
                    deviceInsets = deviceInsets,
                    topBarHeight = var8,
                    briefH = snapPoints[1],
                    fullH = snapPoints[2],
                    overlayFrame = var14,
                    sheetContentRef = var12,
                    shouldMountAsFullView = bool1,
                    onBack = onBack,
                    onClose = onClose
                }
            ) else nil,
            SheetRoot = 0
        }

        local createElement3 = React.createElement
        local root = Sheet.Root
        local tbl5 = {
            isOpen = true,
            onClose = var2,
            snapPoints = snapPoints,
            defaultSnapPointIndex = defaultSnapPointIndex,
            onSnapPointChanged = 0,
            testId = "--experience-details-bottom-sheet"
        }

        if not FFlagLuaAppEdpBottomSheetPeekViewEvents then
            var21 = nil
        end

        tbl5.onSnapPointChanged = var21

        local tbl6 = { Content = 0, Actions = 0 }
        local createElement4 = React.createElement
        local content = Sheet.Content
        local tbl7 = { isContentFullBleed = true, scrollingFrameRef = scrollingFrameRef, ref = 0 }
        if not FFlagEnableExperienceDetailsBottomSheetTopBar then
            var12 = nil
        end

        tbl7.ref = var12
        local tbl8 = { ContentWrapper = 0 }
        local createElement5 = React.createElement
        local view = Foundation.View
        local tbl9 = { ref = 0, tag = "col size-full-0 auto-y" }
        if not FFlagSduiContainerQueries then
            var11 = nil
        end

        tbl9.ref = var11

        local tbl10 = {
            Content = React.createElement(SduiPageEntryPoint, {
                appPage = AppPage.GameDetail,
                configKey = configKey,
                identifier = if FFlagSduiPageEntryUseSharedHooks then ExperienceDetailsPageConstants.EDP_FEED_IDENTIFIER else ExperienceDetailsPageUtils.getResolvedIdentifier(configKey, ExperienceDetailsPageConstants.EDP_FEED_IDENTIFIER_SUFFIX),
                pageTimer = var1,
                backgroundStyle = tokens.Color.Surface.Surface_100,
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
        tbl8.ContentWrapper = createElement5(view, tbl9, tbl10)
        tbl6.Content = createElement4(content, tbl7, tbl8)

        local createElement6 = React.createElement
        local actions = Sheet.Actions
        local tbl11 = {}
        local tbl12 = { ActionBarWrapper = 0 }
        local createElement7 = React.createElement
        local view2 = Foundation.View
        local tbl13 = {
            tag = "col size-full-0 auto-y",
            padding = UDim.new(0, -tokens.Margin.Small)
        }
        local tbl14 = { ActionBar = 0 }
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

        tbl14.ActionBar = element
        tbl12.ActionBarWrapper = createElement7(view2, tbl13, tbl14)
        tbl6.Actions = createElement6(actions, tbl11, tbl12)
        tbl4.SheetRoot = createElement3(root, tbl5, tbl6)
        var27 = createElement2(var28, tbl3, tbl4) or nil
    else
        var27 = nil
    end

    tbl2.SheetProvider = var27
    return createElement(str1, tbl1, tbl2)
end)
