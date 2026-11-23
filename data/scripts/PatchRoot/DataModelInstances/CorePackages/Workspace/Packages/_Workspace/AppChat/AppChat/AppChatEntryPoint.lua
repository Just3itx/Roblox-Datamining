-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:10:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local AppChatParent = AppChat.Parent

local Cryo = require(AppChatParent.Cryo)
local _types = require(AppChat.types)
local SharedFlags = require(AppChatParent.SharedFlags)

local Logger = require(AppChatParent.Loggers).Logger
local Logger2 = require(AppChat.Logger)
local getRoactChatStackNavigator = require(AppChat.getRoactChatStackNavigator)

local Foundation = require(AppChatParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local useHeaderBarHeight = Foundation.Hooks.useHeaderBarHeight
local rootNavigator = nil
local rootNavigator2 = nil
local bool1 = not require(AppChat.Flags.getFFlagAppChatRemoveDynamicRequires)()
local usePageSideMargin = require(AppChatParent.CollectionViews).usePageSideMargin

if not bool1 then
    rootNavigator = require(AppChat.Navigators.Compact.rootNavigator)
    rootNavigator2 = require(AppChat.Navigators.Wide.rootNavigator)
end

local AnalyticsProvider = require(AppChat.LegacyAnalytics.AnalyticsProvider)
local ChatPlacementContext = require(AppChat.Contexts.ChatPlacementContext)
local LuaAppNavigationContextProvider = require(AppChat.LuaAppNavigationContextProvider)

local SetTabBarVisible = require(AppChatParent.AppTabBarRodux).Actions.SetTabBarVisible
local RoactChatAnalyticsProvider = require(AppChat.Analytics.RoactChatAnalyticsProvider)
local AppTelemetryLayer = require(AppChat.Telemetry.Layers.AppTelemetryLayer)

local FFlagAppChatPerfTracking = require(AppChat.Flags.FFlagAppChatPerfTracking)
local AppChatPerfTracker = require(AppChat.Telemetry.AppChatPerfTracker)

local React = require(AppChatParent.React)
local RoactNavigation = require(AppChatParent.RoactNavigation)
local UserInputService = game:GetService("UserInputService")
local memo = React.memo
local useCallback = React.useCallback
local useChatIsVisible = require(AppChat.Hooks.useChatIsVisible)
local useCurrentSquadParentChannelId = require(AppChatParent.SquadsCore.Hooks).useCurrentSquadParentChannelId
local useDispatch = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useEffect = React.useEffect
local useIsVoiceConnected = require(AppChatParent.CrossExperienceVoice).Hooks.useIsVoiceConnected
local usePartyChatReactiveFeatureRestriction = require(AppChat.Hooks.usePartyChatReactiveFeatureRestriction)
local useRef = React.useRef
local useSelector = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useSelector
local useStyle = require(AppChatParent.UIBlox).Core.Style.useStyle
local useRobloxLocale = require(AppChat.Hooks.useRobloxLocale)

local ReplyingToMessageProvider = require(AppChat.Components.ChatConversation.MessageInteraction.ReplyingContext.ReplyingToMessageProvider)
local FFlagAppChatSignalsReplyStore = require(AppChat.Flags.FFlagAppChatSignalsReplyStore)
local FFlagAppChatReactivePaneLayoutOnRotation = SharedFlags.FFlagAppChatReactivePaneLayoutOnRotation
local LayerCollectorProvider = require(AppChatParent.UIBlox).Core.Layout.LayerCollector.LayerCollectorProvider
local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local InteractionFeedback = require(AppChatParent.InteractionFeedback)
local HapticFeedbackConfig = require(AppChat.Utils.HapticFeedback).HapticFeedbackConfig

local createConversation = require(AppChat.Conversations.Thunks.createConversation)
local fetchLatestConversationDetails = require(AppChat.Conversations.Thunks.fetchLatestConversationDetails)
local rootedChatDetailsNavigation = require(AppChat.Navigators.rootedChatDetailsNavigation)

local EnumScreens = require(script.Parent.EnumScreens)

local GetFFlagIsSquadEnabled = require(AppChatParent.SharedFlags).GetFFlagIsSquadEnabled
local GetFFlagEnableCrossExpVoice = require(AppChatParent.SharedFlags).GetFFlagEnableCrossExpVoice
local FFlagAppChatReactiveFeatureRestrictions = SharedFlags.FFlagAppChatReactiveFeatureRestrictions

local EnteredChatFromEntryPoint = require(AppChat.Actions.EnteredChatFromEntryPoint)
local NavigateIntoChat = require(AppChat.Actions.NavigateIntoChat)

local getFFlagFixChatsBottomInsetBackgroundColor = require(AppChat.Flags.getFFlagFixChatsBottomInsetBackgroundColor)
local FFlagAppChatFoundationHeaderBar = require(AppChat.Flags.FFlagAppChatFoundationHeaderBar)

local GetOverlayStore = require(AppChat.Stores.GetOverlayStore)
local navigateWithOsaGate = require(AppChat.Utils.navigateWithOsaGate)
local FFlagAppChatShowOSAOnPageEntry = SharedFlags.FFlagAppChatShowOSAOnPageEntry
local FFlagEnableHeaderBarButtonsUpdate = SharedFlags.FFlagEnableHeaderBarButtonsUpdate
local FFlagLuaAppCompositionAppChat = SharedFlags.FFlagLuaAppCompositionAppChat
local FFlagChatPushUpsellPromptsEnabled = SharedFlags.FFlagChatPushUpsellPromptsEnabled

local FFlagAppChatUseSignalsForLastEntryPoint = require(AppChat.Flags.FFlagAppChatUseSignalsForLastEntryPoint)
local useSignalState = require(AppChatParent.SignalsReact).useSignalState
local GetLastEntryPointStore = if FFlagAppChatUseSignalsForLastEntryPoint then require(AppChat.Stores.GetLastEntryPointStore) else nil
local NAV_BAR_WITH_FACEPILE_SIZE = require(AppChat.Constants).NAV_BAR_WITH_FACEPILE_SIZE

local tbl1 = {
    logger = Logger,
    navigateToLuaAppPages = nil,
    parameters = nil,
    rnBypassActionSignal = nil,
    setActiveConversationId = nil,
    setBackButtonEnabled = nil,
    setTabBarVisible = function() end,
    setInitialConversationId = function(_) end,
    wideMode = false,
    notificationCount = 0,
    navigateToRootStack = nil,
    androidBackButtonSignal = nil,
    initialConversationId = "",
    requestedRoute = nil,
    chatPlacement = ChatPlacementContext.Enum.Unknown
}

local function useReactivePaneRestore(arg1)
    local var1 = useRef(if arg1.parameters then arg1.parameters.conversationId else nil)
    local var2 = useCallback(function(current)
        var1.current = current

        local setActiveConversationId = arg1.setActiveConversationId
        if setActiveConversationId then
            setActiveConversationId(current)
        end
    end, { arg1.setActiveConversationId })

    local var3 = useRef(arg1.navigateToRootStack)
    var3.current = arg1.navigateToRootStack
    local var4 = useCallback(function(...)
        local current = var3.current
        if current then
            current(...)
        end
    end, {})

    if not arg1.navigateToRootStack then
        var4 = arg1.navigateToRootStack
    end
    return var1, var2, var4
end

function AppChatEntryPoint(arg1)
    local var1 = Cryo.Dictionary.join(tbl1, arg1)
    local var2 = ChatPlacementContext.isPlacementInExperience(var1.chatPlacement)
    if FFlagAppChatReactiveFeatureRestrictions then
        usePartyChatReactiveFeatureRestriction(var1.isVisible and not var2)
    end
    local var3 = useTokens()
    if bool1 then
        rootNavigator = require(AppChat.Navigators.Compact.rootNavigator)
        rootNavigator2 = require(AppChat.Navigators.Wide.rootNavigator)
    end

    local var4 = useSelector(useCallback(function(arg2)
        return arg2.LocalUserId
    end, {})) or var1.localUserId
    local var5 = useSelector(useCallback(function(arg2)
        return arg2.GlobalGuiInset
    end, {})) or { bottom = 0 }
    local var6 = useCallback(function(arg2)
        return arg2.ChatAppReducer.LastEntryPoint
    end, {})

    local entryPoint = if FFlagAppChatUseSignalsForLastEntryPoint then useSignalState(GetLastEntryPointStore(false).getLastEntryPoint) else useSelector(var6)
    local dispatch = useDispatch()

    useEffect(function()
        dispatch(AppChatNetworking.rodux.GetChatLandingModal.API(var2)):catch(function(arg2)
            Logger2:warning("Error in GetChatLandingModal request. Error: {}", tostring(arg2))
        end)
    end, { dispatch, var4, var2 })

    local chatIsVisible = useChatIsVisible()

    local var10 = nil
    local setActiveConversationId, var11

    if FFlagAppChatReactivePaneLayoutOnRotation then
        local var12, var13
        var12, setActiveConversationId, var13 = useReactivePaneRestore(var1)
        var10 = var12
        var11 = var13
    else
        setActiveConversationId = var1.setActiveConversationId
        var11 = var1.navigateToRootStack
    end

    local var12 = React.useMemo(function()
        return {
            container = RoactNavigation.createAppContainer(
                getRoactChatStackNavigator(
                    var1.wideMode and rootNavigator2 or rootNavigator,
                    var11,
                    var1.androidBackButtonSignal,
                    var1.androidBackButtonConnection
                )
            ),
            restoreParameters = var10 and var10.current and {
                conversationId = var10.current
            } or nil
        }
    end, {
        var1.wideMode,
        rootNavigator2,
        rootNavigator,
        var11,
        var1.androidBackButtonSignal,
        var1.androidBackButtonConnection,
        var10
    })

    local var13 = useRef(nil)

    if not FFlagAppChatReactivePaneLayoutOnRotation and not var2 and var13.current == nil then
        var13.current = RoactNavigation.createAppContainer(
            getRoactChatStackNavigator(
                var1.wideMode and rootNavigator2 or rootNavigator,
                var1.navigateToRootStack,
                var1.androidBackButtonSignal,
                var1.androidBackButtonConnection
            )
        )
    end

    local var14 = if var2 or FFlagAppChatReactivePaneLayoutOnRotation then var12.container else var13.current
    local var15 = useRef(false)
    local var16 = useRef(nil)
    local var17 = useRef(function(...) end)

    useEffect(function()
        if var1.logger then
            Logger2:setParent(var1.logger)
        end
    end, { var1.logger })

    local var18 = useCallback(function(arg2)
        if not var15.current then
            return
        end

        if var17.current then
            var17.current(arg2)
        end
    end, { var15, var17 })

    local navigateToLuaAppPages = var1.navigateToLuaAppPages
    useEffect(function()
        GetOverlayStore(false).setOverlayDefaultProps(
            {
                onViewUserProfile = if navigateToLuaAppPages then navigateToLuaAppPages[EnumScreens.ViewUserProfile] else nil
            }
        )
    end, { navigateToLuaAppPages })

    local var19 = useCallback(function(conversationId)
        return RoactNavigation.Actions.navigate(
            {
                routeName = EnumScreens.ChatConversation,
                params = { conversationId = conversationId }
            }
        )
    end, {})
    local var20 = useCallback(function(conversationId, extraParams)
        local actions = { RoactNavigation.Actions.navigate(
                {
                    routeName = EnumScreens.ChatConversation,
                    params = { conversationId = conversationId }
                }
            ), RoactNavigation.Actions.navigate(
                {
                    routeName = EnumScreens.SquadLobby,
                    params = { conversationId = conversationId, extraParams = extraParams }
                }
            ) }

        if var1.wideMode then
            return RoactNavigation.Actions.navigate({
                routeName = EnumScreens.ChatLanding,
                params = { conversationId = conversationId },
                action = RoactNavigation.StackActions.reset({ index = 2, actions = actions })
            })
        end

        table.insert(actions, 1, RoactNavigation.Actions.navigate({ routeName = EnumScreens.ChatLanding }))

        return RoactNavigation.Actions.navigate({
            routeName = EnumScreens.ChatLandingStack,
            params = { conversationId = conversationId },
            action = RoactNavigation.StackActions.reset({ index = 3, actions = actions })
        })
    end, { var1.wideMode })

    local var21 = useCallback(function(arg2)
        return dispatch(createConversation("one_to_one", { arg2 }))
    end, { dispatch })

    local var7 = useCallback(function(str1: string)
        return dispatch(fetchLatestConversationDetails(str1))
    end, { dispatch })

    local externalDispatchConnector = useCallback(function(callback: (...any) -> (...any))
        var17.current = callback
        if not var1.updateExternalNavigationForScreen then
            return function()
                var17.current = nil
            end
        end
        local updateExternalNavigationForScreen = var1.updateExternalNavigationForScreen

        if GetFFlagIsSquadEnabled() then
            updateExternalNavigationForScreen(function(arg2)
                local conversationId = arg2.conversationId
                local var23 = Cryo.Dictionary.omit(arg2, "conversationId")
                if not FFlagAppChatShowOSAOnPageEntry then
                    callback(var20(conversationId, var23))

                    return
                end

                navigateWithOsaGate({
                    conversationId = conversationId,
                    dispatch = dispatch,
                    onAccepted = function()
                        callback(var20(conversationId, var23))
                    end,
                    requireMultiUserForU13 = true
                })
            end, EnumScreens.SquadLobby)
        end

        updateExternalNavigationForScreen(function(params)
            if params
                and params.conversationId
                and not rootedChatDetailsNavigation.tryNavigateToRootedChatDetails(
                    {
                        callback = callback,
                        dispatch = dispatch,
                        fetchLatestConversationDetails = var7
                    },
                    params
                )
            then
                callback(RoactNavigation.Actions.navigate({ routeName = EnumScreens.ChatDetails, params = params }))
            end
        end, EnumScreens.ChatDetails)

        updateExternalNavigationForScreen(function(arg2)
            local conversationId = arg2 and arg2.conversationId
            if not conversationId then
                local userId = arg2 and arg2.userId
                if not userId then
                    return
                end
                spawn(function()
                    var21(userId):andThen(function(arg3)
                        if FFlagAppChatPerfTracking then
                            AppChatPerfTracker.start(AppChatPerfTracker.Events.ChatConversationTTI, { conversationId = arg3.id })
                        end

                        Logger2:info("Successfully fetched conversation details for userId {} for external navigation", userId)

                        if not FFlagAppChatShowOSAOnPageEntry then
                            callback(var19(arg3.id))

                            return
                        end

                        navigateWithOsaGate({
                            conversationId = arg3.id,
                            dispatch = dispatch,
                            onAccepted = function()
                                callback(var19(arg3.id))
                            end
                        })
                    end):catch(function(arg3)
                        Logger2:warning("Error in CreateConversation request before navigate to conversation. error: {}", tostring(arg3))
                    end)
                end)

                return
            end

            if FFlagAppChatShowOSAOnPageEntry then
                navigateWithOsaGate({
                    conversationId = conversationId,
                    dispatch = dispatch,
                    onAccepted = function()
                        if FFlagAppChatPerfTracking then
                            AppChatPerfTracker.start(AppChatPerfTracker.Events.ChatConversationTTI, { conversationId = conversationId })
                        end

                        callback(var19(conversationId))
                    end
                })
                return
            end
            if FFlagAppChatPerfTracking then
                AppChatPerfTracker.start(AppChatPerfTracker.Events.ChatConversationTTI, { conversationId = conversationId })
            end

            var7(conversationId):andThen(function()
                Logger2:info("Successfully fetched conversation details for conversationId {} for external navigation", conversationId)

                callback(var19(conversationId))
            end):catch(function(arg3)
                Logger2:warning(
                    "Error in fetchLatestConversationDetails request before navigate to conversation. error: {}",
                    tostring(arg3)
                )
                if FFlagAppChatPerfTracking then
                    AppChatPerfTracker.cancel(AppChatPerfTracker.Events.ChatConversationTTI, { conversationId = conversationId })
                end
            end)
        end, EnumScreens.ChatConversation)

        updateExternalNavigationForScreen(function(params)
            callback(RoactNavigation.Actions.navigate({ routeName = EnumScreens.ChatLanding, params = params }))

            if var1.wideMode then
                callback(RoactNavigation.Actions.navigate({ routeName = EnumScreens.EmptyConversation }))
            end
        end, EnumScreens.ChatLanding)

        return function()
            updateExternalNavigationForScreen(nil, EnumScreens.ChatLanding)
            updateExternalNavigationForScreen(nil, EnumScreens.ChatDetails)
            updateExternalNavigationForScreen(nil, EnumScreens.ChatConversation)
            if GetFFlagIsSquadEnabled() then
                updateExternalNavigationForScreen(nil, EnumScreens.SquadLobby)
            end
            var17.current = nil
        end
    end, {
        var17,
        var21,
        dispatch,
        var7,
        var19,
        var20,
        var1.updateExternalNavigationForScreen,
        var1.wideMode
    })

    local var24 = useCallback(function(arg2)
        if var16.current then
            var16.current:disconnect()
            var16.current = nil
        end

        if arg2 then
            var16.current = arg2:connect(var18)
        end
    end, { var16, var18 })

    useEffect(function()
        var15.current = true
        var24(var1.rnBypassActionSignal)

        return function()
            var15.current = false
            var24(nil)

            dispatch(EnteredChatFromEntryPoint())
        end
    end, {})

    useEffect(function()
        if var1.initialConversationId and var1.initialConversationId ~= "" and var2 then
            dispatch(
                NavigateIntoChat(
                    {
                        screen = EnumScreens.ChatConversation,
                        params = {
                            userId = var4,
                            conversationId = var1.initialConversationId
                        }
                    }
                )
            )
            var1.setInitialConversationId("")
        end

        return function() end
    end, {
        dispatch,
        var4,
        var1.initialConversationId,
        var1.setInitialConversationId
    })
    useEffect(function()
        if var1.requestedRoute and var2 then
            dispatch(NavigateIntoChat(var1.requestedRoute))
            if var1.clearRequestedRoute then
                var1.clearRequestedRoute()
            end
        end

        return function() end
    end, {
        dispatch,
        var2,
        var1.requestedRoute,
        var1.clearRequestedRoute
    })

    local var25 = nil
    local var26 = nil
    if GetFFlagIsSquadEnabled() then
        var25 = useCurrentSquadParentChannelId()
        if GetFFlagEnableCrossExpVoice() then
            var26 = useIsVoiceConnected()
        end
    end

    useEffect(function()
        if not GetFFlagIsSquadEnabled() or not var2 or var1.initialConversationId ~= "" or var1.requestedRoute ~= nil or not var25 then
            return
        end
        if GetFFlagEnableCrossExpVoice() and var26 then
            dispatch(NavigateIntoChat({ screen = EnumScreens.SquadLobby, params = { userId = var4, conversationId = var25 } }))
            return
        end

        dispatch(
            NavigateIntoChat({ screen = EnumScreens.ChatConversation, params = { userId = var4, conversationId = var25 } })
        )
    end, {})

    useEffect(function()
        var24(var1.rnBypassActionSignal)
    end, { var1.rnBypassActionSignal, var24 })

    local var27 = usePageSideMargin(var14.current, FFlagLuaAppCompositionAppChat)
    local var28 = React.useMemo(function()
        return {
            outer = if var2 then 12 else var27,
            inner = if var2 then 12 else var27,
            default = 12
        }
    end, { var27, var2 })

    local var29 = if FFlagAppChatFoundationHeaderBar then useHeaderBarHeight() else nil
    local var30 = useStyle()

    local setTabBarVisible = useCallback(function(arg2)
        dispatch(SetTabBarVisible(arg2))
    end, { dispatch })

    if not FFlagAppChatFoundationHeaderBar then
        var29 = math.max(UserInputService.NavBarSize.Y, if var3 then var3.Size.Size_1400 else NAV_BAR_WITH_FACEPILE_SIZE)
    end

    local size100 = if FFlagEnableHeaderBarButtonsUpdate then var3.Size.Size_100 else nil
    local renderChatLandingPrompts = if FFlagChatPushUpsellPromptsEnabled then var1.renderChatLandingPrompts else nil

    local function createScreenProps()
        return {
            navigateToLuaAppPages = var1.navigateToLuaAppPages,
            topBarHeight = var29,
            wideMode = var1.wideMode,
            isInExperience = var2,
            isVisible = var1.isVisible,
            notificationCount = var1.notificationCount,
            appChatOuterPadding = var28.outer,
            appChatInnerPadding = var28.inner,
            appChatDefaultPadding = var28.default,
            topBarUtilityIconSideMargin = size100,
            showSearchRow = var2,
            navigateToRootStack = var1.navigateToRootStack,
            navigateToAddFriends = var1.navigateToAddFriends,
            renderChatLandingPrompts = renderChatLandingPrompts
        }
    end

    local screenProps = if FFlagAppChatFoundationHeaderBar then React.useMemo(createScreenProps, {
        var1.navigateToLuaAppPages,
        var29,
        var1.wideMode,
        var2,
        var1.isVisible,
        var1.notificationCount,
        var28,
        size100,
        var2,
        var1.navigateToRootStack,
        var1.navigateToAddFriends,
        renderChatLandingPrompts
    }) else createScreenProps()
    local navigation = React.createElement(var14, {
        externalDispatchConnector = externalDispatchConnector,
        parameters = if FFlagAppChatReactivePaneLayoutOnRotation then var12.restoreParameters else var1.parameters,
        setActiveConversationId = setActiveConversationId,
        setBackButtonEnabled = var1.setBackButtonEnabled,
        setTabBarVisible = setTabBarVisible,
        chatIsVisible = chatIsVisible,
        screenProps = screenProps
    })

    local element = React.createElement(
        LuaAppNavigationContextProvider,
        {
            navigateToLuaAppPages = var1.navigateToLuaAppPages,
            dispatch = dispatch
        },
        { navigation = navigation }
    )

    local value = React.useMemo(function()
        return {
            chatPlacement = var1.chatPlacement
        }
    end, { var1.chatPlacement })

    local element3 = React.createElement(ChatPlacementContext.Provider, { value = value }, { navigation = element })

    if not FFlagAppChatSignalsReplyStore then
        element3 = React.createElement(ReplyingToMessageProvider, {}, { navigation = element3 })
    end

    local element4 = React.createElement(
        InteractionFeedback.InteractionFeedbackContext.Provider,
        { value = HapticFeedbackConfig },
        { navigation = element3 }
    )

    if not var2 then
        element4 = React.createElement(LayerCollectorProvider, {}, { navigation = element4 })
    end

    local locale = useRobloxLocale()

    local playSessionId = RbxAnalyticsService:GetPlaySessionId()

    local currentSquadId = if GetFFlagIsSquadEnabled() then useSelector(function(arg2)
        local currentSquad = arg2.Squad and arg2.Squad.Squad and arg2.Squad.Squad.currentSquad
        return if currentSquad and currentSquad.squadId then currentSquad.squadId else nil
    end) else nil

    local var8 = React.useMemo(function()
        return {
            context = "platformChat",
            locale = locale,
            entryPoint = entryPoint or "unknown",
            userId = var4,
            playSessionId = playSessionId,
            currentSquadId = currentSquadId,
            placement = var1.chatPlacement
        }
    end, {
        locale,
        entryPoint,
        var4,
        playSessionId,
        currentSquadId,
        var1.chatPlacement
    })
    local createElement = React.createElement
    local var37 = AnalyticsProvider
    local tbl2 = { localUserId = var4, entryPoint = entryPoint }
    local tbl3 = { telemetry = 0 }
    local createElement2 = React.createElement
    local provider = AppTelemetryLayer.Provider
    local tbl4 = { value = var8 }
    local tbl5 = { navigation = element4, BottomInsetBackground = 0 }
    local element5

    if var5.bottom > 0 then
        element5 = React.createElement("Frame", {
            BackgroundColor3 = if getFFlagFixChatsBottomInsetBackgroundColor() then var30.Theme.BackgroundDefault.Color else var30.Theme.NavigationBar.Color,
            BackgroundTransparency = if getFFlagFixChatsBottomInsetBackgroundColor() then var30.Theme.BackgroundDefault.Transparency else var30.Theme.NavigationBar.Transparency,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 1, 0),
            Size = UDim2.new(1, 0, 0, var5.bottom),
            ZIndex = 3
        })
    else
        element5 = nil
    end

    tbl5.BottomInsetBackground = element5
    tbl3.telemetry = createElement2(provider, tbl4, tbl5)
    local element6 = createElement(var37, tbl2, tbl3)

    if FFlagAppChatPerfTracking then
        useEffect(function()
            AppChatPerfTracker.setSharedContext(
                {
                    placement = var1.chatPlacement,
                    entryPoint = entryPoint,
                    hasActiveParty = currentSquadId ~= nil
                }
            )
        end, { var1.chatPlacement, entryPoint, currentSquadId })
    end

    return React.createElement(RoactChatAnalyticsProvider, { entryPoint = entryPoint }, { element6 })
end

return memo(AppChatEntryPoint)
