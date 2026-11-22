-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:31:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Foundation = require(MomentsParent.Foundation)
local React = require(MomentsParent.React)
local Navigation = require(MomentsParent.Navigation)
local RoactNavigation = require(MomentsParent.RoactNavigation)
local SharedFlags = require(MomentsParent.SharedFlags)
local SignalsReact = require(MomentsParent.SignalsReact)

local MomentsCommon = require(MomentsParent.MomentsCommon)
local isStudio = require(MomentsParent.MomentsCommon.isStudio)
local Constants = require(Moments.Constants)
local ImmersiveFeedKind = Constants.ImmersiveFeedKind

local MomentsHostShell = require(Moments.Components.MomentsHostShell)
local _MomentsHostContext = require(Moments.MomentsHostContext)
local MomentsFeedSurface = require(Moments.Components.MomentsFeedSurface)
local MomentsBackHeader = require(Moments.Components.MomentsBackHeader)
local CreationFlowScreen = require(MomentsParent.MomentsCreation).CreationFlowScreen
local FTUXEducationScreen = require(Moments.Components.FTUXEducationScreen)
local Feed = require(Moments.Components.Feed)
local MomentPushedFeedSafeAreaContext = require(Moments.Components.Feed.Items.Moment.MomentPushedFeedSafeAreaContext)
local createMomentsStore = require(Moments.Stores.GetMomentsStore.createMomentsStore)
local createMomentsFeedSource = require(Moments.Stores.GetMomentsStore.createMomentsFeedSource)
local GetDeepLinkStore = require(Moments.Stores.GetDeepLinkStore)
local createUserMomentsFeedSource = require(Moments.Stores.GetMomentsStore.createUserMomentsFeedSource)
local GetMomentsPreferencesStore = require(Moments.Stores.GetMomentsPreferencesStore)
local useCreationEntry = require(Moments.Hooks.useCreationEntry)
local useUploadHost = require(Moments.Hooks.useUploadHost)
local logCreateIntent = require(Moments.Analytics.logCreateIntent)
local logMomentsLayerExposure = MomentsCommon.Utils.logMomentsLayerExposure
local FFlagMomentsCreateAvatarPosts = SharedFlags.FFlagMomentsCreateAvatarPosts
local FFlagMomentsFlushDwellBeforeNavigation = require(Moments.Flags.FFlagMomentsFlushDwellBeforeNavigation)
local NavigationDestinationType = require(Moments.Enums.NavigationDestinationType)
local MomentsFeedType = require(Moments.Enums.MomentsFeedType)
local FFlagMomentsNavigationEvent = require(Moments.Flags.FFlagMomentsNavigationEvent)

local FFlagMomentsPersonalizedRecommendationsEntryPoint = require(Moments.Flags.FFlagMomentsPersonalizedRecommendationsEntryPoint)
local bool1 = game:DefineFastFlag("MomentsImmersiveNavigationMenu", false)
local FFlagMomentsRenderAvatarPostsInFeed = SharedFlags.FFlagMomentsRenderAvatarPostsInFeed

local FStringMomentsExperienceJoinActionTextIxpLayer = require(Moments.Flags.FStringMomentsExperienceJoinActionTextIxpLayer)
local GetFFlagArgusStudioMockFeed = require(Moments.Flags.GetFFlagArgusStudioMockFeed)
local createSignalTracker = require(Moments.SignalTracker).createSignalTracker

local View = Foundation.View

local useNavigationFocus = Navigation.useNavigationFocus
local useNavigation = Navigation.useNavigation
local useSignalState = SignalsReact.useSignalState
local FFlagEnableArgus = SharedFlags.FFlagEnableArgus
local FFlagMomentsCreationFeatureGate = SharedFlags.FFlagMomentsCreationFeatureGate
local FFlagMomentsOptimisticProfilePending = SharedFlags.FFlagMomentsOptimisticProfilePending
local FFlagMomentsAvatarLookTryOn = SharedFlags.FFlagMomentsAvatarLookTryOn

local Analytics = MomentsCommon.Analytics
local EventNames = Analytics.EventNames
local FunnelEventNames = Analytics.FunnelEventNames
local fireAnalyticsEvent = Analytics.fireAnalyticsEvent
local feedPlaybackSuspension = MomentsCommon.Media.feedPlaybackSuspension
local reportModalCovering = MomentsCommon.Media.reportModalCovering
local accountSettingsCovering = require(Moments.Components.Feed.accountSettingsCovering)
local useDeviceInsets = MomentsCommon.Hooks.useDeviceInsets
local useMomentsGating = MomentsCommon.Hooks.useMomentsGating

local createRecommendationTelemetry = Feed.createRecommendationTelemetry
local createMockFeedSource = Feed.createMockFeedSource

local function PushedFeedSafeAreaProvider(tbl1)
    local value = useDeviceInsets()

    return React.createElement(MomentPushedFeedSafeAreaContext.Context.Provider, { value = value }, { Content = tbl1.children })
end

return React.memo(function(tbl1) -- name: MomentsImmersivePresentation
    local controllerRef = React.useRef(nil)
    local var2 = React.useRef(nil)
    if var2.current == nil then
        var2.current = createMomentsStore()
    end
    local current = var2.current

    local var3 = React.useRef(nil)
    if var3.current == nil and FFlagEnableArgus then
        var3.current = createSignalTracker()
    end
    local current2 = var3.current

    local feedKind = tbl1.feedKind
    local targetUserId = tbl1.targetUserId
    local initialIndex = tbl1.initialIndex
    local initialMomentId = if FFlagMomentsOptimisticProfilePending then tbl1.initialMomentId else nil
    local var4 = useCreationEntry({ manageTabBarVisibility = false })

    local host = useUploadHost({ onExit = var4.onExitCreation, captureSource = var4.captureSource })
    local onCreatePressed = if var4 == nil then nil else var4.onCreatePressed

    local var6 = React.useCallback(function()
        if onCreatePressed ~= nil then
            logCreateIntent(FunnelEventNames.CreationIntentSource.TopBar)
            onCreatePressed()
        end
    end, { onCreatePressed })

    local isCreationEnabled = if FFlagMomentsCreationFeatureGate then useMomentsGating().isCreationEnabled else nil
    local var7 = feedKind == ImmersiveFeedKind.Trending and (not FFlagMomentsCreationFeatureGate or isCreationEnabled)
    local isCreating = var7 and not (var4 == nil) and var4.isCreating
    local showFtux = var7 and not (var4 == nil) and var4.showFtux
    local deepLinkedMomentId = tbl1.deepLinkedMomentId
    local deepLinkedMomentTargetIdType = tbl1.deepLinkedMomentTargetIdType
    local var8 = React.useRef(nil)
    if deepLinkedMomentId ~= nil then
        local str1 = `{deepLinkedMomentId}:{tostring(deepLinkedMomentTargetIdType)}`
        if var8.current ~= str1 then
            GetDeepLinkStore().setDeepLinkedMoment(deepLinkedMomentId, deepLinkedMomentTargetIdType)
            var8.current = str1
        end
    end

    local source = React.useMemo(function()
        if feedKind == ImmersiveFeedKind.User then
            return createUserMomentsFeedSource(targetUserId or 0, { initialIndex = initialIndex, initialMomentId = initialMomentId })
        elseif isStudio() and GetFFlagArgusStudioMockFeed() then
            return createMockFeedSource()
        end
        return createMomentsFeedSource(current.getMomentsSessionId, { signalTracker = current2 })
    end, {
        feedKind,
        targetUserId,
        initialIndex,
        initialMomentId,
        current,
        current2
    })
    local telemetry = React.useMemo(function()
        if feedKind ~= ImmersiveFeedKind.Trending or not FFlagEnableArgus then
            return nil
        end
        return createRecommendationTelemetry(
            {
                getMomentsSessionId = current.getMomentsSessionId,
                signalTracker = current2,
                feedType = MomentsFeedType.Trending
            }
        )
    end, { feedKind, current, current2 })

    local sessionSource = tbl1.sessionSource
    React.useEffect(function()
        current.setSessionSource(sessionSource)
        logMomentsLayerExposure(FStringMomentsExperienceJoinActionTextIxpLayer)
        if require(Moments.Flags.FFlagMomentsCreatorAttributionIxpEnabled) then
            logMomentsLayerExposure(require(Moments.Flags.FStringMomentsCreatorAttributionIxpLayer))
        end

        if require(Moments.Flags.FFlagMomentsFeedIxpEnabled) then
            logMomentsLayerExposure(require(Moments.Flags.FStringMomentsFeedIxpLayer))
        end
        fireAnalyticsEvent(
            EventNames.TapMomentsTab,
            {
                moments_session_id = current.getMomentsSessionId(false),
                source = sessionSource
            }
        )
        Analytics.reportMomentsSessionStarted(sessionSource)
        local momentsSessionHeartbeat = Analytics.createMomentsSessionHeartbeat()
        if momentsSessionHeartbeat ~= nil then
            momentsSessionHeartbeat.start(sessionSource)
        end

        return function()
            if momentsSessionHeartbeat ~= nil then
                momentsSessionHeartbeat.stop()
            end
            local var11 = os.clock() - current.getSessionStartTime(false)

            fireAnalyticsEvent(EventNames.MomentsSessionEnded, {
                moments_session_id = current.getMomentsSessionId(false),
                source = sessionSource,
                duration_seconds = tostring(math.floor(var11))
            })
            Analytics.reportMomentsSessionEnded(sessionSource)
        end
    end, { sessionSource, current })

    local var11 = useNavigationFocus()

    local var12 = useSignalState(feedPlaybackSuspension.getSuspended)
    local var13 = useSignalState(GetMomentsPreferencesStore(false).getIsTeleporting)

    local var14 = useSignalState(reportModalCovering.getCovering)
    local var15 = if FFlagMomentsPersonalizedRecommendationsEntryPoint then useSignalState(accountSettingsCovering.getCovering) else false
    local playbackActive = var11 and not var12 and not (var13 or var14) and not (isCreating or var15)

    local var17 = React.useCallback(function(arg1)
        local current3 = controllerRef.current
        if current3 ~= nil then
            current3.flushView(arg1)
        end
    end, {})

    local var18 = if FFlagMomentsCreateAvatarPosts then React.useCallback(function()
        logCreateIntent(FunnelEventNames.CreationIntentSource.TopBar)
        if FFlagMomentsNavigationEvent then
            var17(NavigationDestinationType.Create)
        end
        if tbl1.openAvatarMomentsCreation ~= nil then
            tbl1.openAvatarMomentsCreation()
        end
    end, { var17, tbl1.openAvatarMomentsCreation }) else nil

    if not FFlagMomentsCreateAvatarPosts or tbl1.openAvatarMomentsCreation == nil then
        var18 = nil
    end

    local var19 = React.useCallback(function(arg1)
        local current3 = controllerRef.current
        if current3 ~= nil then
            current3.refresh(arg1)
        end
    end, {})

    local var20 = if FFlagMomentsFlushDwellBeforeNavigation then useNavigation() else nil

    React.useEffect(function()
        if not FFlagMomentsFlushDwellBeforeNavigation or var20 == nil or var20.addListener == nil then
            return nil
        end

        local var21 = var20.addListener(RoactNavigation.Events.WillBlur, function()
            var17()
        end)
        return function()
            var21.remove()
        end
    end, { var20, var17 })

    local onBack = tbl1.onBack
    local var1 = React.useCallback(function()
        if FFlagMomentsFlushDwellBeforeNavigation then
            var17(if FFlagMomentsNavigationEvent then NavigationDestinationType.Exit else nil)
        end
        onBack()
    end, { onBack, var17 })
    local var22 = React.useCallback(function()
        fireAnalyticsEvent(EventNames.FeedHomeButtonPressed)
        var19(if FFlagMomentsNavigationEvent then NavigationDestinationType.Trending else nil)
    end, { var19 })
    local openOwnMoments = tbl1.openOwnMoments
    local var23 = React.useCallback(function()
        fireAnalyticsEvent(EventNames.MyCreationButtonPressed)
        if openOwnMoments == nil then
            return
        end

        if FFlagMomentsFlushDwellBeforeNavigation then
            var17(if FFlagMomentsNavigationEvent then NavigationDestinationType.MyMoments else nil)
        end
        openOwnMoments()
    end, { openOwnMoments, var17 })
    local bool2 = bool1 and feedKind == ImmersiveFeedKind.Trending
    local useMemo = React.useMemo
    local function func1()
        return React.createElement(MomentsBackHeader, {
            onBack = var1,
            onCreatePressed = if var7 then var6 else nil,
            onCreateAvatarMomentPressed = if FFlagMomentsCreateAvatarPosts then var18 else nil,
            onNavigateToTrending = if bool2 then var22 else nil,
            onNavigateToMyMoments = if bool2 then var23 else nil
        })
    end

    local var24 = if FFlagMomentsCreateAvatarPosts then var18 else nil
    local header = useMemo(func1, { var1, var7, var6, var24, bool2, var22, var23 })
    local inactiveDestination = if FFlagMomentsNavigationEvent then if isCreating then NavigationDestinationType.Create elseif var14 then NavigationDestinationType.Report else nil else nil
    local element = React.createElement(MomentsFeedSurface, {
        source = source,
        telemetry = telemetry,
        inactiveDestination = inactiveDestination,
        active = var11 and not var14 and not (isCreating or var15),
        playbackActive = playbackActive,
        initialIndex = initialIndex,
        header = header,
        controllerRef = controllerRef
    })
    local element2 = React.createElement(PushedFeedSafeAreaProvider, nil, element)

    if var7 then
        element2 = React.createElement(View, {
            backgroundStyle = FFlagMomentsRenderAvatarPostsInFeed and { Transparency = 1 } or nil,
            tag = {
                ["size-full"] = FFlagMomentsRenderAvatarPostsInFeed,
                ["size-full bg-surface-0"] = not FFlagMomentsRenderAvatarPostsInFeed
            }
        }, {
            Feed = element2,
            CreationFlowOverlay = if isCreating then React.createElement(
                View,
                {
                    tag = "size-full",
                    ZIndex = Constants.DisplayOrder.Modals
                },
                {
                    Screen = React.createElement(CreationFlowScreen, { host = host })
                }
            ) else nil,
            FtuxOverlay = if showFtux then React.createElement(
                View,
                {
                    tag = "size-full",
                    ZIndex = Constants.DisplayOrder.Modals
                },
                {
                    Screen = React.createElement(FTUXEducationScreen, { onClose = var4.onExitFtux })
                }
            ) else nil
        })
    end

    return React.createElement(MomentsHostShell, {
        sessionStore = current,
        openProfile = tbl1.openProfile,
        openOwnMoments = tbl1.openOwnMoments,
        openMomentsFeedReport = tbl1.openMomentsFeedReport,
        openAvatarLookTryOn = if FFlagMomentsAvatarLookTryOn then tbl1.openAvatarLookTryOn else nil,
        openMomentCommentReport = tbl1.openMomentCommentReport,
        openBlockUser = tbl1.openBlockUser
    }, element2)
end)
