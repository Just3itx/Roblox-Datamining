-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:01:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local AppCommonLib = require(AppChatParent.AppCommonLib)
local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local AppNavBar = require(AppChatParent.AppNavBar)
local VisibilityControl = AppNavBar.VisibilityControl
local Cryo = require(AppChatParent.Cryo)
local Foundation = require(AppChatParent.Foundation)
local Components = require(AppChatParent.FriendsLanding.Components)
local React = require(AppChatParent.React)
local RoactRodux = require(AppChatParent.RoactRodux)
local SharedFlags = require(AppChatParent.SharedFlags)
local useThemeBackground = require(AppChatParent.ThemeBackground).useThemeBackground
local FFlagAppThemeHalloween2026ChatBackground = require(AppChat.Flags.FFlagAppThemeHalloween2026ChatBackground)
local UIBlox = require(AppChatParent.UIBlox)
local useDispatch = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useEffectOnMount = require(AppChatParent.RoactUtils).Hooks.useEffectOnMount
local useLocalization = require(AppChatParent.Localization).Hooks.useLocalization
local useLocalUserId = require(AppChatParent.RobloxAppHooks).useLocalUserId
local useNavigation = require(AppChatParent.Navigation).useNavigation
local usePrevious = require(AppChatParent.RoactUtils).Hooks.usePrevious
local useSelector = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useSelector
local AppPage = require(AppChatParent.RobloxAppEnums).AppPage

local ChatLoadingContainer = require(script.Parent.ChatLoading.ChatLoadingContainer)
local ChatLandingTelemetryEvents = require(script.Parent.ChatLandingTelemetryEvents)
local ConversationGroupsEntryContainer = require(script.Parent.ConversationGroupsEntryContainer)
local ConversationListWithTopBar = require(script.Parent.ConversationListWithTopBar)
local var1 = require(script.Parent.Logger):new(script.Name)
local NoConversationsLanding = require(script.Parent.NoConversationsLanding)
local mapDispatchToProps = require(script.Parent.mapDispatchToProps)

local ChatLandingTelemetryLayer = require(AppChat.Telemetry.Layers.ChatLandingTelemetryLayer)
local ChatLandingTelemetryState = require(AppChat.Contexts.TelemetryState.ChatLandingTelemetryState)
local compose = require(AppChat.SocialLibraries).RoduxTools.compose
local ConversationChannels = require(AppChat.Models.ConversationChannels)
local createConversation = require(AppChat.Conversations.Thunks.createConversation)
local CreateConversationError = require(AppChat.Analytics.Enums.CreateConversationError)
local EmptyStateType = require(AppChat.Analytics.Enums.EmptyStateType)
local EnumScreens = require(AppChat.EnumScreens)
local EventNames = require(AppChat.Analytics.EventNames)
local fetchConversationsByPage = require(AppChat.Conversations.Thunks.fetchConversationsByPage)
local getConversationTitle = require(AppChat.Conversations.getConversationTitle)
local getOtherParticipants = require(AppChat.Conversations.getOtherParticipants)
local parseCreateConversationErrors = require(AppChat.Conversations.Thunks.parseCreateConversationErrors)
local RoactPaginator = require(AppChat.SocialLibraries).RoactPaginator
local useAnalytics = require(AppChat.Analytics.useAnalytics)
local useChatPlacementContext = require(AppChat.Contexts.ChatPlacementContext).useChatPlacementContext
local useGetConversations = require(AppChat.Hooks.useGetConversations)
local useAreConversationsFetching = require(AppChat.Hooks.useAreConversationsFetching)
local useChatIsVisible = require(AppChat.Hooks.useChatIsVisible)
local useHasConversations = require(AppChat.Hooks.useHasConversations)
local useAppChatIsWideMode = require(AppChat.Hooks.useAppChatIsWideMode)
local useIsAppLoaded = require(AppChat.Hooks.useIsAppLoaded)
local useIsChatEnabled = require(AppChat.Hooks.useIsChatEnabled)
local useChatSettingsRetrievalStatus = require(AppChat.Hooks.useChatSettingsRetrievalStatus)
local useIsExternalNavigationAvailable = require(AppChat.Hooks.useIsExternalNavigationAvailable)
local useIsGroupChatEnabled = require(AppChat.Hooks.useIsGroupChatEnabled)
local useIsInExperience = require(AppChat.Hooks.useIsInExperience)
local useIsOldestConversationFetched = require(AppChat.Hooks.useIsOldestConversationFetched)
local useIsUserPending = require(AppChat.Hooks.useIsUserPending)
local useIsChatEnabledFromReason = require(AppChat.Hooks.useIsChatEnabledFromReason)
local useAnalytics2 = require(AppChat.Analytics.useAnalytics)
local useTelemetry = require(AppChat.Telemetry.useTelemetry)
local getConversationIds = require(AppChat.Utils.getConversationIds)

local FFlagAppChatPerfTracking = require(AppChat.Flags.FFlagAppChatPerfTracking)
local FFlagAppChatMessageTTIMilestones = require(AppChat.Flags.FFlagAppChatMessageTTIMilestones)
local SignalsMigrationConfig = require(AppChat.Flags.SignalsMigrationConfig)
local AppChatPerfTracker = require(AppChat.Telemetry.AppChatPerfTracker)
local FFlagAppChatConsoleFocusFixes = require(AppChat.Flags.FFlagAppChatConsoleFocusFixes)
local FFlagAppChatServerSideConversationSearch = require(AppChat.Flags.FFlagAppChatServerSideConversationSearch)
local FFlagAppChatSearchSendPlacement = require(AppChat.Flags.FFlagAppChatSearchSendPlacement)
local FFlagAppChatSkipSearchWhenChatDisabled = require(AppChat.Flags.FFlagAppChatSkipSearchWhenChatDisabled)

local useCallback = React.useCallback
local useEffect = React.useEffect

local IsVRAppBuild = AppCommonLib.IsVRAppBuild

local useTokens = Foundation.Hooks.useTokens
local useStyle = UIBlox.Core.Style.useStyle
local useTextSizeOffset = UIBlox.Core.Style.useTextSizeOffset

local NoFriendsView = Components.NoFriendsView

local FFlagAppIaScrollAway = SharedFlags.FFlagAppIaScrollAway
local FFlagEnableScrollAwayContentScrollableFix = SharedFlags.FFlagEnableScrollAwayContentScrollableFix
local FFlagSignalsNavP3hMisc = SharedFlags.FFlagSignalsNavP3hMisc
local FFlagSignalsNavDeferProjection = SharedFlags.FFlagSignalsNavDeferProjection
local useSignalsEffect = if FFlagSignalsNavDeferProjection then require(AppChatParent.RobloxAppHooks).useSignalsEffect else nil
local isChatVisible = if FFlagSignalsNavDeferProjection then require(AppChat.Utils.getIsChatVisibleNow).isChatVisible else nil
local getFFlagChatTabHideGroupsLinkOnVR = require(AppChat.Flags.getFFlagChatTabHideGroupsLinkOnVR)
local GetTopBarStore = require(AppChat.Stores.GetTopBarStore)
local PartyPageCarouselExperimentation = require(AppChatParent.SocialExperiments).PartyPageCarouselExperimentation
local FFlagCreateConnectionsHub = require(AppChatParent.SharedFlags).FFlagCreateConnectionsHub
local SquadQuickStartExperimentation = require(AppChatParent.SocialExperiments).SquadQuickStartExperimentation
local useCanAccessParty = require(AppChatParent.Squads.useCanAccessParty)
local useConversationList = require(AppChat.Hooks.useConversationList)
local useConversationSearchListProps = require(AppChat.Hooks.useConversationSearchListProps)
local useChatSearchSession = require(AppChat.Hooks.useChatSearchSession)
local FFlagAppChatSearchSessionTelemetry = require(AppChat.Flags.FFlagAppChatSearchSessionTelemetry)
local FFlagAppChatVisibleIsInConversation = require(AppChat.Flags.FFlagAppChatVisibleIsInConversation)
local getIsInConversationForTelemetry = require(script.Parent.Utils.getIsInConversationForTelemetry)
local FFlagAppChatConversationLoadRetry = require(AppChat.Flags.FFlagAppChatConversationLoadRetry)
local RoduxNetworking = require(AppChat.Http.RoduxNetworking)

local shouldReadConversationListFromSignalsStore = SignalsMigrationConfig.shouldReadConversationListFromSignalsStore
local var2 = if game.PlaceId > 0 then tostring(game.PlaceId) else nil
local var3 = if game.GameId > 0 then tostring(game.GameId) else nil
local tbl1 = {
    topBarHeight = 0,
    isShowingFilterBox = false,
    navigateToSquadLobby = function() end
}

local function areConversationIdsEqual(tbl2, tbl3) -- Luacid: Inlined by compiler; 1 call site recovered
    if #tbl2 ~= #tbl3 then
        return false
    end

    for value, value2 in tbl2 do
        if value2 ~= tbl3[value] then
            return false
        end
    end

    return true
end

local function finishChatLandingTTIIfReady(isInteractive: boolean, numElementsRendered: number) -- Luacid: Inlined by compiler; 1 call site recovered
    if isInteractive and AppChatPerfTracker.isActive(AppChatPerfTracker.Events.ChatLandingTTI) then
        AppChatPerfTracker.finish(AppChatPerfTracker.Events.ChatLandingTTI, { numElementsRendered = numElementsRendered })
    end
end

local function encodeConversationIds(input) -- Luacid: Inlined by compiler; 2 call sites recovered
    local success, result = pcall(function(): string
        return HttpService:JSONEncode(input)
    end)
    return if success then result else "[]"
end

function ChatLandingContainer(tbl2)
    local var4 = Cryo.Dictionary.join(tbl1, tbl2)

    local var5 = useAnalytics()
    local var6 = useChatPlacementContext()
    local var7 = useDispatch()
    local var8 = useIsChatEnabled()
    local var9 = useIsGroupChatEnabled()
    local privacySettingsEnabled = useIsChatEnabledFromReason("privacySettingsEnabled")
    local globalRulesEnabled = useIsChatEnabledFromReason("globalRulesEnabled")
    local thirdPartyPrivacySettingsEnabled = useIsChatEnabledFromReason("thirdPartyPrivacySettingsEnabled")
    local isInExperience = useIsInExperience()
    local var14 = useAppChatIsWideMode(isInExperience)

    if FFlagAppChatPerfTracking and FFlagAppChatMessageTTIMilestones and AppChatPerfTracker.Hooks then
        local eventName = AppChatPerfTracker.getEventName(AppChatPerfTracker.Events.ChatLandingTTI) or ""

        AppChatPerfTracker.Hooks.useTTIRenderAndMountedTracking(eventName)
    end

    local appLoaded = useIsAppLoaded()
    local bool1 = useAreConversationsFetching()
    local bool2 = useHasConversations()
    local bool3 = useIsOldestConversationFetched()
    local localUserId = useLocalUserId()
    local var17 = useNavigation()
    local bool4 = if FFlagAppThemeHalloween2026ChatBackground then useThemeBackground() ~= nil else false
    local var18 = useStyle()
    local var19 = useTextSizeOffset()
    local var20 = useAnalytics2()
    local var21 = if FFlagAppChatConsoleFocusFixes then useTokens() else nil
    local yOffset = if FFlagAppChatConsoleFocusFixes then var21.Size.Size_1600 + 2 * var19 else 64 + 2 * var19
    local screenProps = if FFlagCreateConnectionsHub then var17.getScreenProps("navigateToLuaAppPages", {}) else nil
    local var22 = useGetConversations()
    local tbl3 = {}
    local listStatus

    if shouldReadConversationListFromSignalsStore then
        local var23 = useConversationList(true)
        tbl3 = var23.items
        listStatus = var23.listStatus
    else
        listStatus = {}
    end

    local var23 = if shouldReadConversationListFromSignalsStore then tbl3 else var22

    if shouldReadConversationListFromSignalsStore then
        bool1 = listStatus.isFetchingConversations == true
    end
    if shouldReadConversationListFromSignalsStore then
        bool2 = #tbl3 > 0
    end

    if shouldReadConversationListFromSignalsStore then
        bool3 = listStatus.oldestConversationIsFetched == true
    end

    local bool5, bool6

    if FFlagAppChatConversationLoadRetry then
        if shouldReadConversationListFromSignalsStore then
            local bool7 = listStatus.isFetchingNextPage == true
            if listStatus.isFetchingConversations == true then
                bool5 = not bool7
            else
                bool5 = false
            end

            if listStatus.error == nil or listStatus.hasFetchedInitialPage == true then
                bool6 = false
            else
                bool6 = not bool5
            end
        else
            local var24 = useSelector(function(arg1)
                return AppChatNetworking.rodux.GetUserConversations.getStatus(arg1)
            end)
            bool5 = var24 == RoduxNetworking.Enum.NetworkStatus.Fetching
            if var24 == RoduxNetworking.Enum.NetworkStatus.Failed then
                bool6 = true
            else
                bool6 = false
            end
        end
    else
        bool6 = false
        bool5 = false
    end

    local var24, var25

    if FFlagAppChatServerSideConversationSearch then
        local bool7 = var4.isShowingFilterBox == true
        if FFlagAppChatSkipSearchWhenChatDisabled then
            bool7 = bool7 and var8
        end

        local var26 = useConversationSearchListProps
        local filterText = var4.filterText

        local navigateToConversation = var4.navigateToConversation
        local chatPlacement = if FFlagAppChatSearchSendPlacement then var6.chatPlacement else nil
        var24, var25 = var26(filterText, bool7, localUserId, var9, navigateToConversation, chatPlacement)
    else
        var24 = false
        var25 = {}
    end

    if FFlagAppChatSearchSessionTelemetry then
        local bool7 = var4.isShowingFilterBox == true and var4.filterText ~= nil and var4.filterText:match("%S") ~= nil

        if FFlagAppChatServerSideConversationSearch and FFlagAppChatSkipSearchWhenChatDisabled then
            bool7 = bool7 and var8
        end

        useChatSearchSession(bool7, FFlagAppChatServerSideConversationSearch)
    end

    if shouldReadConversationListFromSignalsStore then
        useEffect(function()
            if #var22 == 0 and #tbl3 == 0 then
                return
            end

            local conversationIds = getConversationIds(var22)
            local conversationIds2 = getConversationIds(tbl3)

            if not areConversationIdsEqual(conversationIds, conversationIds2) then
                var1:warning(
                    "Conversation list parity mismatch. Rodux ids: {}, Signals ids: {}",
                    encodeConversationIds(conversationIds),
                    (encodeConversationIds(conversationIds2))
                )
            end
        end, { var22, tbl3 })
    end

    local var26 = usePrevious(var8)
    useEffect(function()
        var1:debug("Comparing previousIsChatEnabled ({}) --> isChatEnabled ({})", var26, var8)

        if var26 ~= nil and var26 ~= var8 and var8 then
            var1:info("Chat has become enabled, fetching conversations")
            var7(fetchConversationsByPage())
        end
    end, { var7, var8, var26 })

    local useMemo = React.useMemo

    local function func1()
        local num1 = 0
        local num2 = 0
        local tbl4 = {}
        for _, value in var23 do
            if shouldReadConversationListFromSignalsStore and value.otherParticipants == nil then
                local join = Cryo.Dictionary.join
                local tbl5 = {
                    otherParticipants = getOtherParticipants(value, localUserId)
                }
                value = join(value, tbl5)
            end

            if useIsUserPending(value) then
                num1 += 1
            end
            if value.moderationType == ConversationChannels.ModerationType.TrustedComms then
                num2 += 1
            end
            local title = getConversationTitle(value)

            if var9 or value.conversationType ~= "MultiUserConversation" then
                table.insert(tbl4, Cryo.Dictionary.join(value, { title = title }))
            end
        end

        return tbl4, num1, num2
    end

    local var27 = if shouldReadConversationListFromSignalsStore then localUserId else nil
    local itemList, pendingConversationCount, unfilteredConversationCount = useMemo(func1, { var23, var9, var27 })

    local var31 = useTelemetry(ChatLandingTelemetryLayer.Context)
    local emit = var31.emit
    if shouldReadConversationListFromSignalsStore then
        local var32 = React.useRef(var31.emit)
        var32.current = var31.emit
        emit = function(...)
            var32.current(...)
        end
    end
    local var32 = ChatLandingTelemetryState.useSetState()

    useEffect(function()
        var32(function(arg1)
            return Cryo.Dictionary.join(arg1, {
                chatLandingListCount = #itemList,
                pendingConversationCount = pendingConversationCount,
                unfilteredConversationCount = unfilteredConversationCount
            })
        end)
    end, {
        #itemList,
        pendingConversationCount,
        unfilteredConversationCount,
        var32
    })
    useEffectOnMount(function()
        var31.emit(ChatLandingTelemetryEvents.ScreenRendered, { isChatEnabled = var8 })
    end)

    local var33 = useLocalization({
        chatUnavailableWithUser = "Feature.Chat.Message.ChatUnavailableWithUser",
        networkErrorText = "Feature.Toast.NetworkingError.SomethingIsWrong",
        conversationLoadError = if FFlagAppChatConversationLoadRetry then "CommonUI.Messages.Response.PageError" else nil,
        refresh = if FFlagAppChatConversationLoadRetry then "CommonUI.Controls.Action.Refresh" else nil
    })

    local var34 = useCallback(function()
        if not PartyPageCarouselExperimentation.getPartyPageCarouselEnabled() then
            return
        end

        local str1 = HttpService:GenerateGUID(false)

        var5.fireAnalyticsEvent(
            EventNames.ChatLandingPartyQuickStartButtonClicked,
            {
                clickLocation = var6.chatPlacement,
                partyAttemptId = str1,
                placeId = var2,
                universeId = var3
            }
        )
        var17.navigate(EnumScreens.QuickStartSquadInviteFriends, { uuid = str1 })
    end, {
        var5,
        var6,
        var17,
        var2,
        var3
    })
    local var35 = useCallback(function(arg1)
        if not PartyPageCarouselExperimentation.getPartyPageCarouselEnabled() then
            return
        end

        var7(createConversation("one_to_one", { arg1 }, var20, "navigateToConversationFromSocialCarousel")):andThen(function(arg2)
            if FFlagAppChatPerfTracking then
                AppChatPerfTracker.start(AppChatPerfTracker.Events.ChatConversationTTI, { conversationId = arg2.id })
            end

            var17.navigate(EnumScreens.ChatConversation, { conversationId = arg2.id })
        end):catch(
            function(arg2)
                local toastTitle = if parseCreateConversationErrors(arg2) == "participant_chat_disabled" then var33.chatUnavailableWithUser else var33.networkErrorText
                var17.navigate(EnumScreens.RoactChatToast, { toastProps = { toastContent = { toastTitle = toastTitle } } })

                if var20 then
                    var20.fireAnalyticsEvent(
                        EventNames.NewConversationCreated,
                        {
                            createConversationResult = CreateConversationError.FetchConversationError
                        }
                    )
                end
            end
        )
    end, {
        var7,
        var33,
        parseCreateConversationErrors,
        var17,
        var20
    })
    local var36 = Cryo.isEmpty(itemList)
    local bool7 = useChatSettingsRetrievalStatus() ~= "Done"

    if not bool7 then
        if var36 then
            bool7 = bool1 or var36 and bool2
        else
            bool7 = var36 and bool2
        end
    end

    local bool8 = false
    local bool9 = false
    local bool10 = false
    local var37 = useIsExternalNavigationAvailable({ EnumScreens.AddFriends, EnumScreens.PrivacySettings, EnumScreens.Groups })

    local scrollAwayEnabled = FFlagAppIaScrollAway and not isInExperience and AppNavBar.getScrollAwayEnabled()

    local canAccessParty = useCanAccessParty()
    local isPartyQuickStartEnabled = SquadQuickStartExperimentation.getPartyQuickStartChangesEnabled() and canAccessParty

    local var40 = bool7
    if FFlagAppChatConversationLoadRetry and var8 and not var24 and var36 then
        var40 = var40 or bool5
    end

    local element

    if var40 then
        element = React.createElement(ChatLoadingContainer, {
            topBarHeight = var4.topBarHeight,
            pageHeaderText = var4.pageHeaderText,
            cellHeight = yOffset,
            cellWidth = 375,
            topPadding = if FFlagAppIaScrollAway and scrollAwayEnabled then var4.topBarHeight else nil,
            pageBackgroundTransparency = if bool4 then 1 else nil
        })
        bool8 = true
    elseif FFlagAppChatConversationLoadRetry and var8 and not var24 and var36 and appLoaded and not bool1 and bool6 then
        element = React.createElement(
            Foundation.Empty,
            {
                text = var33.conversationLoadError,
                button = {
                    text = var33.refresh,
                    onActivated = var4.onRetryConversations
                }
            }
        )
        bool8 = true
    elseif var8 and (var24 or not var36 or not appLoaded or bool1) then
        local key = `conversationListWithTopBar{var4.filterText}`

        bool8 = true
        bool9 = true
        bool10 = true

        local createElement = React.createElement
        local var41 = ConversationListWithTopBar
        local join = Cryo.Dictionary.join
        local tbl4 = {
            filterText = if var4.isShowingFilterBox then var4.filterText or nil else nil,
            key = key,
            itemList = itemList,
            appLoaded = appLoaded,
            localUserId = localUserId,
            conversationsIsFetching = bool1,
            oldestConversationIsFetched = bool3,
            entryHeight = yOffset,
            isInExperience = isInExperience,
            isWideMode = 0,
            navigateToConversationFromUserId = 0,
            navigateToQuickStartSquadInviteFriends = 0,
            showGroupsLink = 0,
            canvasTopPadding = 0,
            pageBackgroundTransparency = 0,
            canAccessParty = 0,
            isPartyQuickStartEnabled = 0
        }

        if not (PartyPageCarouselExperimentation.getPartyPageCarouselEnabled()
            or SignalsMigrationConfig.shouldUseFoundationConversationRow) then
            var14 = nil
        end

        tbl4.isWideMode = var14

        if not PartyPageCarouselExperimentation.getPartyPageCarouselEnabled() then
            var35 = nil
        end

        tbl4.navigateToConversationFromUserId = var35

        if not PartyPageCarouselExperimentation.getPartyPageCarouselEnabled() then
            var34 = nil
        end

        tbl4.navigateToQuickStartSquadInviteFriends = var34

        tbl4.showGroupsLink = var37[EnumScreens.Groups]
        tbl4.canvasTopPadding = if FFlagAppIaScrollAway and scrollAwayEnabled then var4.topBarHeight else nil
        tbl4.pageBackgroundTransparency = if bool4 then 1 else nil
        tbl4.canAccessParty = canAccessParty
        tbl4.isPartyQuickStartEnabled = isPartyQuickStartEnabled
        element = createElement(var41, join(var4, tbl4, var25))
    elseif var8 then
        element = React.createElement("Frame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundColor3 = var18.Theme.BackgroundDefault.Color,
            BackgroundTransparency = if bool4 then 1 else var18.Tokens.Color.None.Transparency,
            BorderSizePixel = 0
        }, {
            NoFriendsView = React.createElement(NoFriendsView, {
                pageRenderReport = function()
                    var31.emit(ChatLandingTelemetryEvents.ChatEmptyStateScreenRendered, { emptyStateType = EmptyStateType.NoFriendsView })
                end,
                openAddFriendsPage = function()
                    var31.emit(ChatLandingTelemetryEvents.ChatAddFriendsBtnClicked, {})
                    if FFlagCreateConnectionsHub then
                        screenProps[AppPage.CoHubAddConnections]()
                        return
                    end
                    var4.navigateToAddFriends()
                end,
                noFriendsHeaderKey = "Feature.Chat.Label.AddFriends",
                noFriendsTextLabelKey = "Feature.Chat.Text.NoFriends",
                addFriendsBtnLabelKey = "Feature.Chat.Label.AddFriends",
                addFriendsBtnEnabled = var37[EnumScreens.AddFriends]
            })
        })

        bool8 = true
    else
        element = React.createElement(NoConversationsLanding, {
            chatEnabled = var8,
            privacySettingsEnabled = privacySettingsEnabled,
            globalRulesEnabled = globalRulesEnabled,
            thirdPartyPrivacySettingsEnabled = thirdPartyPrivacySettingsEnabled,
            canNavigateToPrivacySettings = var37[EnumScreens.PrivacySettings],
            canNavigateToAddFriends = var37[EnumScreens.AddFriends],
            onCallToAction = function(arg1)
                if arg1 == "privacy" then
                    var4.navigateToPrivacy()
                    return
                end

                if arg1 ~= "friends" then
                    return
                end

                var31.emit(ChatLandingTelemetryEvents.ChatAddFriendsBtnClicked, {})
                if FFlagCreateConnectionsHub then
                    screenProps[AppPage.CoHubAddConnections]()
                    return
                end
                var4.navigateToAddFriends()
            end,
            fireRenderEvent = function(arg1)
                local emptyStateType = if arg1 == "friends" then EmptyStateType.NoFriendsView elseif arg1 == "privacy" then EmptyStateType.ChatSettingsDisabledView elseif arg1 == "regional" then EmptyStateType.ChatUnavailableRegionView else EmptyStateType.EmptyConversationList
                var31.emit(ChatLandingTelemetryEvents.ChatEmptyStateScreenRendered, { emptyStateType = emptyStateType })
            end
        })
    end

    if FFlagAppIaScrollAway and FFlagEnableScrollAwayContentScrollableFix then
        useEffect(function()
            if not scrollAwayEnabled then
                return
            end
            VisibilityControl.setContentScrollable(bool10)
        end, { bool10, scrollAwayEnabled })
    end

    if getFFlagChatTabHideGroupsLinkOnVR() and IsVRAppBuild() then
        bool8 = true
    end

    useEffect(function()
        if isInExperience then
            GetTopBarStore(false).setScreenTopBar(EnumScreens.ChatLanding, { rightHidden = not bool9 })
        end
    end, { bool9, isInExperience })

    if not bool8 and var37[EnumScreens.Groups] then
        element = React.createElement(React.Fragment, nil, {
            UIPadding = if FFlagAppIaScrollAway and scrollAwayEnabled then React.createElement("UIPadding", { PaddingTop = UDim.new(0, var4.topBarHeight) }) else nil,
            groupsLink = React.createElement(ConversationGroupsEntryContainer, { entryHeight = yOffset }),
            chatFrame = React.createElement("Frame", {
                Size = UDim2.new(1, 0, 1, -yOffset),
                Position = UDim2.new(0, 0, 0, yOffset),
                BackgroundTransparency = 1,
                BorderSizePixel = 0
            }, { chatContainer = element })
        })
    end

    local var41 = useChatIsVisible()

    React.useEffect(function()
        if not var41 then
            return
        end

        emit(ChatLandingTelemetryEvents.AppChatVisible, {
            isChatEnabled = var8,
            isChatLoading = bool7,
            isInConversation = if FFlagAppChatVisibleIsInConversation then getIsInConversationForTelemetry(var17) else nil
        })
    end, { var41, var8, bool7 })

    if FFlagAppChatPerfTracking then
        React.useEffect(function()
            if not var41 then
                return
            end

            local var42 = not var40 and var8
            var1:debug(
                "TTI Ready Check (ChatLanding): isLoading={}, isChatEnabled={}, itemCount={}, ready={}",
                var40,
                var8,
                #itemList,
                var42
            )

            if var42 and AppChatPerfTracker.isActive(AppChatPerfTracker.Events.ChatLandingTTI) then
                AppChatPerfTracker.finish(AppChatPerfTracker.Events.ChatLandingTTI, { numElementsRendered = #itemList })
            end
        end, {
            var41,
            var40,
            var8,
            #itemList
        })
        if FFlagSignalsNavDeferProjection then
            local current = {
                isInteractive = not var40 and var8,
                numElementsRendered = #itemList
            }
            local var42 = React.useRef(current)

            if var41 then
                var42.current = current
            end
            useSignalsEffect(isChatVisible, function(bool11: boolean)
                if bool11 then
                    local current = var42.current
                    finishChatLandingTTIIfReady(current.isInteractive, current.numElementsRendered)
                end
            end)
        end
    end
    local var42 = React.useRef({ isChatEnabled = var8, isChatLoading = bool7 })

    React.useEffect(function()
        var42.current = { isChatEnabled = var8, isChatLoading = bool7 }
    end, { var8, bool7 })

    useEffect(function()
        return function()
            if var41 then
                emit(ChatLandingTelemetryEvents.AppChatClosed, var42.current)
            end
        end
    end, { var41 })

    if not FFlagSignalsNavP3hMisc then
        return element
    end

    local var43 = React.useRef(nil)
    if var41 or var43.current == nil then
        var43.current = element
    end
    return var43.current
end

local function paginatorParameters()
    return { pageSize = 30 }
end

local var4 = compose(RoactRodux.connect(nil, mapDispatchToProps), RoactPaginator.connect(paginatorParameters))(ChatLandingContainer)

local var5 = compose(RoactRodux.connect(nil, mapDispatchToProps), RoactPaginator.connect(paginatorParameters))(function(arg1) -- name: PaginatorPropsBridge
    local var5 = arg1[RoactPaginator.loadNext]
    local var6 = arg1[RoactPaginator.loadPrevious]
    local onPaginatorReady = arg1.onPaginatorReady
    React.useLayoutEffect(function()
        onPaginatorReady({ [RoactPaginator.loadNext] = var5, [RoactPaginator.loadPrevious] = var6 })
    end, { var5, var6, onPaginatorReady })
    return nil
end)
local var6 = RoactRodux.connect(nil, mapDispatchToProps)(ChatLandingContainer)

return if FFlagAppChatConversationLoadRetry then function(tbl2) -- name: ChatLandingContainerWithRetry
    local key, var8 = React.useState(0)
    local var9 = React.useRef({})
    local onRetryConversations = useCallback(function()
        var8(function(arg1): number
            return arg1 + 1
        end)
    end, {})
    local onPaginatorReady = useCallback(function(current)
        var9.current = current
    end, {})
    local var12 = useCallback(function(...)
        local var12 = var9.current[RoactPaginator.loadNext]
        if var12 then
            return var12(...)
        end
        return nil
    end, {})
    local var13 = useCallback(function(...)
        local var13 = var9.current[RoactPaginator.loadPrevious]
        if var13 then
            return var13(...)
        end
        return nil
    end, {})

    local createElement = React.createElement
    local fragment = React.Fragment
    local tbl3 = {
        Paginator = React.createElement(var5, { key = key, onPaginatorReady = onPaginatorReady }),
        Landing = React.createElement(
            var6,
            Cryo.Dictionary.join(tbl2, {
                [RoactPaginator.loadNext] = var12,
                [RoactPaginator.loadPrevious] = var13,
                onRetryConversations = onRetryConversations
            })
        )
    }
    return createElement(fragment, nil, tbl3)
end else var4
