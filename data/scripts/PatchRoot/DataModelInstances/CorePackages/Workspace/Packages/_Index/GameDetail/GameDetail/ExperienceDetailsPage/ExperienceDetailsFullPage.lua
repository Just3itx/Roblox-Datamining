-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:51:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetail = script:FindFirstAncestor("GameDetail")
local GameDetailParent = GameDetail.Parent

local isTenFootInterface = require(GameDetailParent.AppCommonLib).isTenFootInterface

local FFlagSduiEdpRenderStarted = require(GameDetail.Flags.FFlagSduiEdpRenderStarted)
local ExperienceDetailsPageUtils = require(script.Parent.ExperienceDetailsPageUtils)
local ExperienceDetailsPageConstants = require(script.Parent.ExperienceDetailsPageConstants)
local ExperienceDetailsPageScopeFields = require(script.Parent.ExperienceDetailsPageScopeFields)
local fetchExperienceDetailsPage = require(script.Parent.fetchExperienceDetailsPage)
local getExperienceDetailsPageKey = require(script.Parent.getExperienceDetailsPageKey)
local removeGameDetailSessionIfDeparted = require(script.Parent.removeGameDetailSessionIfDeparted)
local useEdpFunctionallyReadyLogger = require(script.Parent.useEdpFunctionallyReadyLogger)
local createExperienceDetailsPageTimer = require(script.Parent.createExperienceDetailsPageTimer)
local ExperienceDetailsFallbackBannerImage = require(script.Parent.Fallback.ExperienceDetailsFallbackBannerImage)
local ExperienceDetailsFallbackFeed = require(script.Parent.Fallback.ExperienceDetailsFallbackFeed)
local ExperienceDetailsPersistentActionBar = require(script.Parent.ExperienceDetailsPersistentActionBar)

local _Navigation = require(GameDetailParent.Navigation)
local Foundation = require(GameDetailParent.Foundation)
local React = require(GameDetailParent.React)
local useTokens = Foundation.Hooks.useTokens
local AppSessionService = require(GameDetailParent.RoactServiceTags).AppSessionService
local useNavigation = require(GameDetailParent.Navigation).useNavigation
local useRoactService = require(GameDetailParent.RobloxAppHooks).useRoactService
local DetailsPageLayout = require(GameDetailParent.AppBlox).DetailsPageLayout
local AppPage = require(GameDetailParent.RobloxAppEnums).AppPage
local DataHydration = require(GameDetailParent.DataHydration)
local Responsive = require(GameDetailParent.Responsive)
local useGetCurrentLegacyRoute = require(GameDetailParent.DiscoveryRouting).useGetCurrentLegacyRoute

local EDPTTIConstants = require(GameDetailParent.GameDetailTelemetry).EDPTTIConstants

local SduiSharedUtilities = require(GameDetailParent.SduiSharedUtilities)
local getSduiClientPageScope = SduiSharedUtilities.getSduiClientPageScope
local SduiSurfaceLoadTimeTracker = SduiSharedUtilities.SduiSurfaceLoadTimeTracker
local usePageScopeRef = SduiSharedUtilities.usePageScopeRef
local SduiPageEntryPoint = SduiSharedUtilities.SduiPageEntryPoint
local SduiFeatureEntryPoint = SduiSharedUtilities.SduiFeatureEntryPoint
local UiStatus = SduiSharedUtilities.UiStatus
local usePublishContainerWidth = SduiSharedUtilities.usePublishContainerWidth
local useUiStatus = SduiSharedUtilities.useUiStatus
local FilterPlayWithReward = ExperienceDetailsPageScopeFields.FilterPlayWithReward
local IsTenFoot = ExperienceDetailsPageScopeFields.IsTenFoot

local CompositionTags = require(GameDetailParent.AppComposition).CompositionTags

local SharedFlags = require(GameDetailParent.SharedFlags)
local FFlagEDPTTIParityDefinitions = SharedFlags.FFlagEDPTTIParityDefinitions
local FFlagSduiPageEntryUseSharedHooks = SharedFlags.FFlagSduiPageEntryUseSharedHooks
local FFlagSduiContainerQueries = SharedFlags.FFlagSduiContainerQueries
local bool1 = game:DefineFastFlag("SduiEdpPageScopeIsTenFoot", false)
local FFlagLuaAppMediaGalleryGamepadSupport = SharedFlags.FFlagLuaAppMediaGalleryGamepadSupport
local FFlagLuaAppEdpDirectionalGradientMidTransparency = SharedFlags.FFlagLuaAppEdpDirectionalGradientMidTransparency
local FFlagEnableSplitPaneEDPFix = SharedFlags.FFlagEnableSplitPaneEDPFix
local num1 = game:DefineFastInt("EdpBannerAspectRatioTenths", 0)
local num2 = game:DefineFastInt("EdpFullBleedOverlapOffset", 180)
local num3 = game:DefineFastInt("EdpGradientTopBleedOffset", 120)
local num4 = game:DefineFastInt("EdpBannerBottomVisiblePercent", 20)
local num5 = game:DefineFastInt("EdpDirectionalFullBleedOverlapOffset", 195)
local num6 = game:DefineFastInt("EdpDirectionalBannerBottomVisiblePercent", 50)

local num7 = game:DefineFastInt("EdpDirectionalGradientMidTransparencyHundredths", 12)

local selectionGroup = {
    SelectionBehaviorUp = Enum.SelectionBehavior.Stop,
    SelectionBehaviorDown = Enum.SelectionBehavior.Stop,
    SelectionBehaviorRight = Enum.SelectionBehavior.Stop
}

return React.memo(function(arg1) -- name: ExperienceDetailsFullPage
    local useExperienceDetailsFocusNavigation = require(GameDetail.FocusNavigation.useExperienceDetailsFocusNavigation)

    local universeId = ExperienceDetailsPageUtils.getUniverseId(arg1)
    local configKey = getExperienceDetailsPageKey(universeId)

    local scrollingFrameRef = React.useRef(nil)
    usePageScopeRef(configKey)
    local var2 = React.useMemo(function()
        local fromPropsOrNavigationParams = ExperienceDetailsPageUtils.getFromPropsOrNavigationParams(arg1, "pageTimer")
        local var2 = if FFlagEDPTTIParityDefinitions then fromPropsOrNavigationParams
            or createExperienceDetailsPageTimer(
                configKey,
                {
                    page = "Untracked",
                    category = EDPTTIConstants.EDP_IMPLEMENTATION.SDUI_FULL_PAGE
                }
            ) else fromPropsOrNavigationParams
            or SduiSurfaceLoadTimeTracker.createLoadTimerWithSurfaceLoadTime(configKey, {
                eventName = EDPTTIConstants.EDP_TTI_EVENT_NAME,
                metadata = {
                    page = "Untracked",
                    category = EDPTTIConstants.EDP_IMPLEMENTATION.SDUI_FULL_PAGE
                },
                manualSurfaceReady = true
            })
        getSduiClientPageScope(configKey).set(SduiSurfaceLoadTimeTracker.SURFACE_LOAD_TIME_PAGE_SCOPE_KEY, var2)
        return var2
    end, {})

    if FFlagSduiEdpRenderStarted then
        var2.logRenderStarted()
    end
    useEdpFunctionallyReadyLogger(var2, universeId)

    local var3 = useNavigation()
    local var4 = useRoactService(AppSessionService)
    local var5 = useTokens()

    local var6 = useGetCurrentLegacyRoute()

    local referralSource = ExperienceDetailsPageUtils.getFromPropsOrNavigationParams(arg1, "referralSource")
    local experienceJoinData = ExperienceDetailsPageUtils.getFromPropsOrNavigationParams(arg1, "experienceJoinData")
    local placeIdOverride = ExperienceDetailsPageUtils.getFromPropsOrNavigationParams(arg1, "placeIdOverride")
    React.useEffect(function()
        local sduiClientPageScope = getSduiClientPageScope(configKey)
        sduiClientPageScope.set("referralSource", referralSource)
        sduiClientPageScope.set("experienceJoinData", experienceJoinData)
        sduiClientPageScope.set("placeId", placeIdOverride)
        sduiClientPageScope.set("launchSource", "ExperienceDetailsPage")
        sduiClientPageScope.set(FilterPlayWithReward, nil)
        if bool1 then
            sduiClientPageScope.set(IsTenFoot, isTenFootInterface())
        end
    end, {
        configKey,
        referralSource,
        experienceJoinData,
        placeIdOverride
    })
    local var7 = React.useCallback(function()
        local var7 = var6()
        var3.goBack()
        removeGameDetailSessionIfDeparted(var4, var7)
    end, { var3, var4, var6 })

    React.useEffect(function()
        if universeId and var2 then
            fetchExperienceDetailsPage(universeId, var2)
        end
    end, { universeId, var2 })

    local var8 = useUiStatus(configKey)
    React.useEffect(function()
        if var8 == UiStatus.Error and universeId then
            DataHydration.Game.getGameInfoStore(false).getAndFetchGameInfo(universeId, function(arg2): boolean
                return arg2 == nil or arg2.creator == nil
            end)
            DataHydration.Game.getAgeRecommendationStore(false).getAndFetchAgeRecommendation(universeId)
        end
    end, { var8, universeId })

    local refresh = React.useCallback(function()
        if universeId and var2 then
            fetchExperienceDetailsPage(universeId, var2, true)
        end
    end, { universeId, var2 })

    local var10 = useExperienceDetailsFocusNavigation(var7)

    if FFlagSduiContainerQueries then
        var10 = usePublishContainerWidth(configKey, var10)
    end

    local bool2 = if FFlagLuaAppMediaGalleryGamepadSupport then Responsive.useLastInput() == Responsive.Input.Directional else Responsive.usePreferredInput() == Responsive.Input.Directional
    local bool3 = if FFlagEnableSplitPaneEDPFix then arg1.hideCloseButtonOnHeader == true else nil

    if FFlagEnableSplitPaneEDPFix then
        React.useEffect(function()
            getSduiClientPageScope(configKey).set(ExperienceDetailsPageScopeFields.HideCloseButtonOnHeader, bool3)
        end, { configKey, bool3 })
    end

    local bool4, bool5

    if FFlagEnableSplitPaneEDPFix then
        bool4 = arg1.showBottomActionBar == true
        bool5 = bool2 or bool4
    else
        bool5 = bool2
        bool4 = nil
    end

    if universeId == nil then
        return nil
    end

    local createElement = React.createElement
    local root = DetailsPageLayout.Root
    local tbl2 = {
        ref = var10,
        onClose = 0,
        selectionGroup = 0,
        fullBleedAspectRatio = 0,
        fullBleedOverlapOffset = 0,
        gradientTopBleedOffset = 0,
        gradientMidTransparency = 0,
        bannerBottomVisiblePercent = 0,
        reserveHeaderBarSpace = 0,
        disableFocusNavEngineScroll = 0,
        fullBleedContent = 0
    }

    if bool5 or bool3 then
        var7 = nil
    end

    tbl2.onClose = var7
    tbl2.selectionGroup = selectionGroup
    tbl2.fullBleedAspectRatio = if FFlagLuaAppMediaGalleryGamepadSupport and bool2 and num1 > 0 then num1 / 10 else nil

    tbl2.fullBleedOverlapOffset = if FFlagLuaAppMediaGalleryGamepadSupport and bool2 then num5 else num2

    tbl2.gradientTopBleedOffset = if FFlagLuaAppMediaGalleryGamepadSupport and bool2 then num3 else nil

    tbl2.gradientMidTransparency = if FFlagLuaAppEdpDirectionalGradientMidTransparency and FFlagLuaAppMediaGalleryGamepadSupport and bool2 then num7 / 100 else nil

    tbl2.bannerBottomVisiblePercent = if FFlagLuaAppMediaGalleryGamepadSupport and bool2 then num6 / 100 else num4 / 100

    tbl2.reserveHeaderBarSpace = if FFlagLuaAppMediaGalleryGamepadSupport then not bool2 and nil else nil
    tbl2.disableFocusNavEngineScroll = if FFlagLuaAppMediaGalleryGamepadSupport then if bool2 then true else nil else nil

    tbl2.fullBleedContent = React.createElement(SduiFeatureEntryPoint, {
        appPage = AppPage.ExperienceDetail,
        configKey = configKey,
        identifier = ExperienceDetailsPageConstants.EDP_BANNER_IMAGE_IDENTIFIER,
        loadTimer = var2,
        Size = UDim2.fromScale(1, 1),
        loadingSlot = React.createElement(ExperienceDetailsFallbackBannerImage.Skeleton),
        errorSlot = React.createElement(ExperienceDetailsFallbackBannerImage.Error, { universeId = universeId })
    })

    local tbl3 = { Header = 0, Content = 0, Actions = 0 }
    local element

    if bool5 then
        element = nil
    else
        element = React.createElement(DetailsPageLayout.Header, {
            closeIconName = Foundation.Enums.IconName.X,
            backgroundColor = var5.Color.Surface.Surface_300,
            fullWidthContent = true
        }, {
            StickyHeaderContent = React.createElement(SduiFeatureEntryPoint, {
                appPage = AppPage.ExperienceDetail,
                configKey = configKey,
                identifier = ExperienceDetailsPageConstants.EDP_STICKY_HEADER_IDENTIFIER,
                loadTimer = var2,
                shouldDisplayLoading = false,
                shouldDisplayError = false,
                Size = UDim2.fromScale(1, 1),
                AutomaticSize = Enum.AutomaticSize.None
            })
        })
    end

    tbl3.Header = element

    local createElement2 = React.createElement
    local content = DetailsPageLayout.Content
    local tbl4 = { scrollingFrameRef = scrollingFrameRef }
    local tbl5 = {
        Feed = React.createElement(SduiPageEntryPoint, {
            appPage = AppPage.ExperienceDetail,
            configKey = configKey,
            identifier = if FFlagSduiPageEntryUseSharedHooks then ExperienceDetailsPageConstants.EDP_FEED_IDENTIFIER else ExperienceDetailsPageUtils.getResolvedIdentifier(configKey, ExperienceDetailsPageConstants.EDP_FEED_IDENTIFIER_SUFFIX),
            pageTimer = var2,
            includeNavigationHeaderBar = false,
            scrollingFrameRef = scrollingFrameRef,
            scrollToSelectionRevealOnly = if FFlagLuaAppMediaGalleryGamepadSupport then if bool2 then true else nil else nil,
            backgroundStyle = var5.Color.None,
            disableRootPadding = true,
            clipsDescendantsOverride = false,
            contentTag = CompositionTags.ContentRegion.Body,
            loadingSlot = React.createElement(ExperienceDetailsFallbackFeed.Skeleton, {
                universeId = universeId,
                launchSource = "ExperienceDetailsPage",
                isSmallScreen = false,
                referralSource = referralSource,
                experienceJoinData = experienceJoinData,
                placeIdOverride = placeIdOverride
            }),
            errorSlot = React.createElement(ExperienceDetailsFallbackFeed.Error, {
                universeId = universeId,
                refresh = refresh,
                launchSource = "ExperienceDetailsPage",
                isSmallScreen = false,
                referralSource = referralSource,
                experienceJoinData = experienceJoinData,
                placeIdOverride = placeIdOverride
            }),
            snackbarPortalLayoutOrder = 2147483647
        })
    }
    tbl3.Content = createElement2(content, tbl4, tbl5)

    tbl3.Actions = if FFlagEnableSplitPaneEDPFix and bool4 then React.createElement(DetailsPageLayout.Actions, {}, {
        ActionBar = React.createElement(ExperienceDetailsPersistentActionBar, {
            universeId = universeId,
            configKey = configKey,
            loadTimer = var2,
            launchSource = "ExperienceDetailsPage",
            referralSource = referralSource,
            experienceJoinData = experienceJoinData,
            placeIdOverride = placeIdOverride,
            showOutline = false
        })
    }) else nil
    return createElement(root, tbl2, tbl3)
end)
