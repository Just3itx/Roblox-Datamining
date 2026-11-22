-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:50:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Foundation = require(MomentsParent.Foundation)
local React = require(MomentsParent.React)
local AppPage = require(MomentsParent.RobloxAppEnums).AppPage
local RobloxAppEvents = require(MomentsParent.RobloxAppEvents)
local RoactNavigation = require(MomentsParent.RoactNavigation)

local View = Foundation.View

local TopBar = require(Moments.Components.TopBar)
local MomentsFeedSurface = require(Moments.Components.MomentsFeedSurface)
local Feed = require(Moments.Components.Feed)

local CreationFlowScreen = require(MomentsParent.MomentsCreation).CreationFlowScreen
local FTUXEducationScreen = require(Moments.Components.FTUXEducationScreen)
local useMomentsHost = require(Moments.MomentsHostContext).useMomentsHost
local Constants = require(Moments.Constants)
local useScreenBottomInset = require(Moments.Hooks.useScreenBottomInset)
local useFeedPlaybackActive = require(Moments.Hooks.useFeedPlaybackActive)
local useMomentsTabIsVisible = require(Moments.Hooks.useMomentsTabIsVisible)
local GetMomentsPreferencesStore = require(Moments.Stores.GetMomentsPreferencesStore)
local NavigationDestinationType = require(Moments.Enums.NavigationDestinationType)
local FFlagMomentsNavigationEvent = require(Moments.Flags.FFlagMomentsNavigationEvent)

local FFlagMomentsFixRecommendationImpressionLifecycle = require(Moments.Flags.FFlagMomentsFixRecommendationImpressionLifecycle)
local FFlagMomentsFlushDwellBeforeNavigation = require(Moments.Flags.FFlagMomentsFlushDwellBeforeNavigation)

local FFlagMomentsPersonalizedRecommendationsEntryPoint = require(Moments.Flags.FFlagMomentsPersonalizedRecommendationsEntryPoint)
local useCreationEntry = require(Moments.Hooks.useCreationEntry)
local useUploadHost = require(Moments.Hooks.useUploadHost)
local logCreateIntent = require(Moments.Analytics.logCreateIntent)
local GetUploadStore = require(Moments.Stores.GetUploadStore)
local SignalsReact = require(MomentsParent.SignalsReact)
local MomentOverlayInsetContext = require(Moments.Components.Feed.Items.Moment.MomentOverlayInsetContext)
local FFlagMomentsFeedAboveNavBar = require(Moments.Flags.FFlagMomentsFeedAboveNavBar)
local FFlagMomentsFixFeedForDeviceSafeInsets = require(Moments.Flags.FFlagMomentsFixFeedForDeviceSafeInsets)
local shouldUseDeviceSafeInsets = require(MomentsParent.Display).shouldUseDeviceSafeInsets
local var1 = FFlagMomentsFixFeedForDeviceSafeInsets and shouldUseDeviceSafeInsets
local GetImmersiveChromeStore = require(Moments.Stores.GetImmersiveChromeStore)
local MomentsLocalStorage = require(MomentsParent.MomentsCommon.MomentsLocalStorage)
local MomentsLocalStorageKeys = require(MomentsParent.MomentsCommon.MomentsLocalStorageKeys)
local useMomentsSession = require(Moments.Stores.GetMomentsStore.MomentsSessionContext).useMomentsSession
local createMomentsFeedSource = require(Moments.Stores.GetMomentsStore.createMomentsFeedSource)
local MomentsFeedType = require(Moments.Enums.MomentsFeedType)
local FFlagMomentsFollowingFeed = require(Moments.Flags.FFlagMomentsFollowingFeed)
local FFlagMomentsRecommendationFeedType = require(Moments.Flags.FFlagMomentsRecommendationFeedType)
local useFeedSelection = if FFlagMomentsFollowingFeed then require(Moments.Hooks.useFeedSelection) else nil
local FeedSwitchFade = if FFlagMomentsFollowingFeed then require(Moments.Components.FeedSwitchFade) else nil
local createSignalTracker = require(Moments.SignalTracker).createSignalTracker

local SharedFlags = require(MomentsParent.SharedFlags)
local FFlagMomentsCreateAvatarPosts = SharedFlags.FFlagMomentsCreateAvatarPosts
local FFlagEnableArgus = SharedFlags.FFlagEnableArgus
local FFlagMomentsCreationFeatureGate = SharedFlags.FFlagMomentsCreationFeatureGate
local FFlagMomentsRenderAvatarPostsInFeed = SharedFlags.FFlagMomentsRenderAvatarPostsInFeed
local FFlagMomentsPostFeedback = SharedFlags.FFlagMomentsPostFeedback
local FFlagMomentsPostFeedbackIxpEnabled = require(Moments.Flags.FFlagMomentsPostFeedbackIxpEnabled)
local isStudio = require(MomentsParent.MomentsCommon.isStudio)
local reportModalCovering = require(MomentsParent.MomentsCommon).Media.reportModalCovering
local accountSettingsCovering = require(Moments.Components.Feed.accountSettingsCovering)
local GetFFlagArgusStudioMockFeed = require(Moments.Flags.GetFFlagArgusStudioMockFeed)
local createMockFeedSource = Feed.createMockFeedSource
local signalTracker = if FFlagEnableArgus then createSignalTracker() else nil
local MomentUnavailableDialog = require(Moments.Components.MomentUnavailableDialog)

local createRecommendationTelemetry = Feed.createRecommendationTelemetry

local MomentsCommon = require(MomentsParent.MomentsCommon)
local Analytics = MomentsCommon.Analytics
local EventNames = Analytics.EventNames
local SessionManager = Analytics.SessionManager
local FunnelEventNames = Analytics.FunnelEventNames
local fireAnalyticsEvent = Analytics.fireAnalyticsEvent
local fireFunnelAnalyticsEvent = Analytics.fireFunnelAnalyticsEvent
local useMomentsGating = MomentsCommon.Hooks.useMomentsGating

local var2 = nil
local function getUploadLogger() -- Luacid: Inlined by compiler; 3 call sites recovered
    if var2 == nil then
        var2 = require(MomentsParent.Loggers).Logger:new("Moments.Upload")
    end
    return var2
end

local function TrendingScreen(tbl1)
    local var3, var4 = React.useState(function(): boolean
        return not MomentsLocalStorage.getField(MomentsLocalStorageKeys.CreateTooltipSeen)
    end)
    local var5, var6 = React.useState(false)
    local controllerRef = React.useRef(nil)
    local var8 = React.useRef(nil)
    local value = useScreenBottomInset()

    local var9 = useFeedPlaybackActive()
    local var10, var11

    if FFlagMomentsNavigationEvent then
        var10 = useMomentsTabIsVisible()

        var11 = SignalsReact.useSignalState(GetMomentsPreferencesStore(false).getIsTeleporting)
    else
        var11 = false
        var10 = true
    end

    local var12 = useMomentsSession()

    local var13 = useMomentsHost()
    local openOwnMoments = var13.openOwnMoments
    local openAvatarMomentsCreation = if FFlagMomentsCreateAvatarPosts then var13.openAvatarMomentsCreation else nil
    local var14 = useMomentsGating()
    local platformIntegrationEnabled = var14.isFlyoutEntryEnabled and var14.platformIntegrationEnabled
    local isCreationEnabled = if FFlagMomentsCreationFeatureGate then not (var14 == nil) and var14.isCreationEnabled else nil
    local var15 = useCreationEntry()

    local host = useUploadHost({
        onExit = var15.onExitCreation,
        captureSource = var15.captureSource,
        postFeedback = if FFlagMomentsPostFeedback then true else nil,
        logsPostFeedbackExposure = if FFlagMomentsPostFeedbackIxpEnabled then true else nil
    })

    React.useEffect(function()
        local var17 = SessionManager.getSessionId(FunnelEventNames.FunnelTypes.AppNavigation)
            or SessionManager.startSession(FunnelEventNames.FunnelTypes.AppNavigation)
        fireFunnelAnalyticsEvent(
            FunnelEventNames.FunnelTypes.AppNavigation,
            FunnelEventNames.AppNavigationSteps.TrendingScreenView,
            var17
        )
    end, {})

    local onDeepLinkedMomentUnavailable = React.useCallback(function()
        var6(true)
    end, {})

    local var18 = React.useMemo(function()
        if isStudio() and GetFFlagArgusStudioMockFeed() then
            return createMockFeedSource()
        end
        return createMomentsFeedSource(
            var12.getMomentsSessionId,
            {
                signalTracker = signalTracker,
                onDeepLinkedMomentUnavailable = onDeepLinkedMomentUnavailable
            }
        )
    end, { var12, onDeepLinkedMomentUnavailable })

    local var19 = React.useMemo(function()
        if not FFlagEnableArgus then
            return nil
        end
        return createRecommendationTelemetry({
            getMomentsSessionId = var12.getMomentsSessionId,
            signalTracker = signalTracker,
            feedType = if FFlagMomentsRecommendationFeedType then MomentsFeedType.Trending else nil
        })
    end, { var12 })

    local var20 = if FFlagMomentsRecommendationFeedType and FFlagMomentsFollowingFeed then React.useMemo(function()
        if not FFlagEnableArgus then
            return nil
        end
        return createRecommendationTelemetry(
            {
                getMomentsSessionId = var12.getMomentsSessionId,
                signalTracker = signalTracker,
                feedType = MomentsFeedType.Following
            }
        )
    end, { var12 }) else nil

    local var21 = SignalsReact.useSignalState(GetImmersiveChromeStore(false).getOverlayCovering)

    local var22 = SignalsReact.useSignalState(reportModalCovering.getCovering)
    local var23 = if FFlagMomentsPersonalizedRecommendationsEntryPoint then SignalsReact.useSignalState(accountSettingsCovering.getCovering) else false
    local bool1 = not (var15.isCreating or var21 or var5 or var22 or var23)

    if FFlagMomentsFixRecommendationImpressionLifecycle then
        bool1 = bool1 and var9
    end

    local playbackActive = var9 and not (var15.isCreating or var5 or var22 or var23)
    local var25

    if FFlagMomentsNavigationEvent then
        if var11 then
            var25 = NavigationDestinationType.ExperienceJoin
        elseif var15.isCreating then
            var25 = NavigationDestinationType.Create
        elseif var22 then
            var25 = NavigationDestinationType.Report
        elseif var10 then
            var25 = nil
        else
            var25 = NavigationDestinationType.Exit
        end
    else
        var25 = nil
    end

    local refreshFeed = React.useCallback(function(arg1)
        local current = controllerRef.current
        if current ~= nil then
            current.refresh(arg1)
        end
    end, {})

    local flushView = React.useCallback(function(arg1)
        local current = controllerRef.current
        if current ~= nil then
            current.flushView(arg1)
        end
    end, {})

    local var28 = if FFlagMomentsCreateAvatarPosts then React.useCallback(function()
        logCreateIntent(FunnelEventNames.CreationIntentSource.TopBar)
        if FFlagMomentsNavigationEvent then
            flushView(NavigationDestinationType.Create)
        end
        if openAvatarMomentsCreation ~= nil then
            openAvatarMomentsCreation()
        end
    end, { flushView, openAvatarMomentsCreation }) else nil

    if not FFlagMomentsCreateAvatarPosts or openAvatarMomentsCreation == nil then
        var28 = nil
    end

    local var29

    if useFeedSelection == nil then
        var29 = nil
    else
        local var30 = useFeedSelection
        local tbl2 = {
            trendingSource = var18,
            trendingTelemetry = var19,
            followingTelemetry = 0,
            refreshFeed = 0,
            flushView = 0
        }

        if not FFlagMomentsRecommendationFeedType then
            var20 = nil
        end

        tbl2.followingTelemetry = var20
        tbl2.refreshFeed = refreshFeed
        tbl2.flushView = flushView
        var29 = var30(tbl2)
    end

    if var29 ~= nil then
        var18 = var29.source
    end

    if var29 ~= nil then
        var19 = var29.telemetry
    end
    React.useEffect(function()
        if not FFlagMomentsFlushDwellBeforeNavigation or tbl1.navigation.addListener == nil then
            return nil
        end

        local var30 = tbl1.navigation.addListener(RoactNavigation.Events.WillBlur, function()
            flushView()
        end)
        return function()
            var30.remove()
        end
    end, { tbl1.navigation, flushView })

    React.useEffect(function()
        local connection = RobloxAppEvents.ReloadPage:connect(function(moments)
            if moments ~= AppPage.Moments then
                return
            end
            if var29 ~= nil and var29.getSelected() == MomentsFeedType.Following then
                var29.select(MomentsFeedType.Trending)
                return
            end
            refreshFeed()
        end)

        return function()
            connection:disconnect()
        end
    end, { refreshFeed, var29 })

    local uploadStore = GetUploadStore(false)
    local current = SignalsReact.useSignalState(uploadStore.getState)
    local var31 = SignalsReact.useSignalState(uploadStore.getUploadedMoment)
    React.useEffect(function()
        if current ~= "Success" then
            var8.current = current
            return
        end
        if var8.current == "Success" then
            return
        end

        var8.current = current

        if var29 ~= nil and var29.getSelected() == MomentsFeedType.Following then
            getUploadLogger():debug("event=feed_upload_skipped_on_following")
            return
        end
        local current = controllerRef.current
        if type(var31) ~= "table" or var31.momentId == nil or current == nil then
            getUploadLogger():debug(
                "event=feed_refresh_after_upload uploadedMoment={} hasController={}",
                tostring(var31),
                tostring(current ~= nil)
            )
            refreshFeed()
            return
        end

        local uploadLogger = getUploadLogger()
        local momentId = var31.momentId
        local assetId = var31.assetId
        uploadLogger:debug("event=feed_prepend_uploaded momentId={} assetId={}", momentId, tostring(assetId))

        current.prependMoment(var31)
    end, {
        current,
        var31,
        refreshFeed,
        var29
    })
    local onFtuxTooltipDismissed = React.useCallback(function()
        var4(false)
        MomentsLocalStorage.setField(MomentsLocalStorageKeys.CreateTooltipSeen, true)
    end, {})

    local var33 = React.useCallback(function()
        logCreateIntent(FunnelEventNames.CreationIntentSource.TopBar)
        var15.onCreatePressed()
    end, { var15.onCreatePressed })

    local onNavigateToTrending = React.useCallback(function()
        fireAnalyticsEvent(EventNames.FeedHomeButtonPressed)
        if var29 ~= nil then
            var29.select(MomentsFeedType.Trending)
            return
        end
        refreshFeed(if FFlagMomentsNavigationEvent then NavigationDestinationType.Trending else nil)
    end, { refreshFeed, var29 })

    local onNavigateToMyMoments = React.useCallback(function()
        fireAnalyticsEvent(EventNames.MyCreationButtonPressed)
        if openOwnMoments == nil then
            return
        end

        if FFlagMomentsFlushDwellBeforeNavigation then
            flushView(if FFlagMomentsNavigationEvent then NavigationDestinationType.MyMoments else nil)
        end
        openOwnMoments()
    end, { openOwnMoments, flushView })

    local var36 = React.useCallback(function(trending)
        if trending == MomentsFeedType.Trending then
            onNavigateToTrending()
        elseif var29 ~= nil then
            var29.select(trending)
        end
    end, { onNavigateToTrending, var29 })

    local useMemo = React.useMemo
    local function func1()
        return React.createElement(TopBar, {
            isBaseScreen = true,
            showTopScrim = true,
            showFtuxTooltip = var3 and var9 and (not FFlagMomentsCreationFeatureGate or isCreationEnabled),
            showHamburger = platformIntegrationEnabled,
            onFtuxTooltipDismissed = onFtuxTooltipDismissed,
            onCreatePressed = if FFlagMomentsCreationFeatureGate and not isCreationEnabled then nil else var33,
            onCreateAvatarMomentPressed = if FFlagMomentsCreateAvatarPosts then var28 else nil,
            onNavigateToTrending = onNavigateToTrending,
            onNavigateToMyMoments = onNavigateToMyMoments,
            selectedFeedType = if var29 == nil then nil else var29.selected,
            onFeedTypeSelected = if var29 == nil then nil else var36
        })
    end

    local var37 = if FFlagMomentsCreationFeatureGate then isCreationEnabled else false
    local var38 = if FFlagMomentsCreateAvatarPosts then var28 else nil
    local header = useMemo(func1, {
        var3,
        var9,
        var37,
        platformIntegrationEnabled,
        onFtuxTooltipDismissed,
        var33,
        var38,
        onNavigateToTrending,
        onNavigateToMyMoments,
        var36,
        var29
    })

    local yOffset = 0
    if FFlagMomentsFixFeedForDeviceSafeInsets then
        local var40 = MomentsCommon.Hooks.useDeviceInsets()
        yOffset = if shouldUseDeviceSafeInsets then var40.top else 0
    end

    local renderFeedContainer = React.useCallback(function(feed)
        local element = React.createElement(MomentOverlayInsetContext.Context.Provider, { value = value }, { Feed = feed })

        local padding = FFlagMomentsFeedAboveNavBar and {
            bottom = UDim.new(0, value)
        } or nil

        return React.createElement(View, {
            backgroundStyle = FFlagMomentsRenderAvatarPostsInFeed and { Transparency = 1 } or nil,
            tag = {
                ["size-full"] = not var1
            },
            Position = if var1 then UDim2.fromOffset(0, -yOffset) else nil,
            Size = if var1 then UDim2.new(1, 0, 1, yOffset) else nil,
            testId = "--moments-feed-container-full-bleed",
            padding = padding,
            ZIndex = Constants.DisplayOrder.Feed
        }, {
            Feed = element,
            SwitchFade = if FeedSwitchFade == nil or var29 == nil then nil else React.createElement(FeedSwitchFade, { feedKey = var29.selected, ZIndex = 2 })
        })
    end, { value, yOffset, var29 })

    local createElement = React.createElement
    local var41 = View
    local tbl2 = {
        backgroundStyle = FFlagMomentsRenderAvatarPostsInFeed and { Transparency = 1 } or nil,
        tag = {
            ["size-full"] = FFlagMomentsRenderAvatarPostsInFeed,
            ["size-full bg-surface-0"] = not FFlagMomentsRenderAvatarPostsInFeed
        }
    }

    local tbl3 = {
        Surface = React.createElement(MomentsFeedSurface, {
            source = var18,
            active = bool1,
            playbackActive = playbackActive,
            telemetry = var19,
            inactiveDestination = var25,
            controllerRef = controllerRef,
            trackSurfaceLoad = true,
            header = header,
            renderFeedContainer = renderFeedContainer,
            emptyState = if var29 == nil then nil else var29.emptyState,
            caughtUpState = if var29 == nil then nil else var29.caughtUpState
        }),
        MomentUnavailableDialog = if var9 and var5 then React.createElement(MomentUnavailableDialog, {
            onDismiss = function()
                var6(false)
            end
        }) else nil,
        CreationFlowOverlay = if var15.isCreating then React.createElement(
            View,
            {
                tag = "size-full",
                ZIndex = Constants.DisplayOrder.Modals
            },
            {
                Screen = React.createElement(CreationFlowScreen, { host = host })
            }
        ) else nil,
        FtuxOverlay = if var15.showFtux then React.createElement(
            View,
            {
                tag = "size-full",
                ZIndex = Constants.DisplayOrder.Modals
            },
            {
                Screen = React.createElement(FTUXEducationScreen, { onClose = var15.onExitFtux })
            }
        ) else nil
    }

    return createElement(var41, tbl2, tbl3)
end

return TrendingScreen
