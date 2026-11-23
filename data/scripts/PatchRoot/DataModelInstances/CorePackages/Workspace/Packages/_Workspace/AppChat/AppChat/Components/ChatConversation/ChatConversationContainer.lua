-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:11:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local HttpService = game:GetService("HttpService")
local IXPService = game:GetService("IXPService")

local Logger = require(script.Parent.Logger)
local React = require(AppChatParent.React)
local Cryo = require(AppChatParent.Cryo)
local RoactNavigation = require(AppChatParent.RoactNavigation)
local UniversalAppPolicy = require(AppChatParent.UniversalAppPolicy).UniversalAppPolicy
local ChatConversation = require(script.Parent.ChatConversation)
local PendingStateConversationPage = require(script.Parent.PendingState.PendingStateConversationPage)

local RoactChatAnalytics = require(AppChat.LegacyAnalytics.RoactChatAnalytics)
local useAnalytics = require(AppChat.LegacyAnalytics.useAnalytics)

local selectMessagesPure = require(AppChat.Components.ChatConversation.Messages.Selectors.selectMessagesPure)
local ConversationChannels = require(AppChat.Models.ConversationChannels)
local Conversation = require(AppChat.Models.Conversation)
local GenericDialogType = require(AppChat.Components.ChatDetails.Dialogs.GenericDialogType)

local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local mapDispatchToProps = require(script.Parent.mapDispatchToProps)
local useGetConversationFromId = require(AppChat.Hooks.useGetConversationFromId)
local useLocalization = require(AppChatParent.Localization).Hooks.useLocalization
local useEffect = React.useEffect
local useLocalUserId = require(AppChatParent.RobloxAppHooks).useLocalUserId
local useDispatch = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useMapDispatch = require(AppChat.Hooks.useMapDispatch)
local useGetUsers = require(AppChat.Hooks.useGetUsers)
local useGetUsersTyping = require(AppChat.Hooks.useGetUsersTyping)
local useSignalState = require(AppChatParent.SignalsReact).useSignalState
local GetReplyingToStore = require(AppChat.Stores.GetReplyingToStore)
local GetConversationMessageViewModelStore = require(AppChat.Stores.GetConversationMessageViewModelStore)
local useReplyingToMessage = require(script.Parent.MessageInteraction.ReplyingContext.useReplyingToMessage)

local useReplyingToMessageDispatch = require(script.Parent.MessageInteraction.ReplyingContext.useReplyingToMessageDispatch)
local FFlagAppChatSignalsReplyStore = require(AppChat.Flags.FFlagAppChatSignalsReplyStore)
local FFlagAppChatUseUserProfileHydration = require(AppChat.Flags.FFlagAppChatUseUserProfileHydration)
local UserProfiles = require(AppChatParent.UserProfiles)
local DataStatus = require(AppChatParent.DataHydration).DataStatus
local useProfileNames = require(AppChat.Hooks.useProfileNames)
local getCombinedNameFromProfileNames = require(AppChat.Users.getCombinedNameFromProfileNames)

local getConversationTitle = require(AppChat.Conversations.getConversationTitle)
local getOtherParticipants = require(AppChat.Conversations.getOtherParticipants)
local useRecipientIds = require(AppChat.Hooks.useRecipientIds)
local useIsUserPending = require(AppChat.Hooks.useIsUserPending)
local useChatIsVisible = require(AppChat.Hooks.useChatIsVisible)
local useSelector = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useSelector
local useIsExternalNavigationAvailable = require(AppChat.Hooks.useIsExternalNavigationAvailable)
local useIsInExperience = require(AppChat.Hooks.useIsInExperience)
local useIsChatUserMessagesEnabled = require(AppChat.Hooks.useIsChatUserMessagesEnabled)
local chatInputBoxDisabledPressedSignal = require(AppChatParent.InterventionShared).Signals.chatInputBoxDisabledPressedSignal
local RoduxNetworking = require(AppChat.Http.RoduxNetworking)
local useChatTimeoutDetails = require(AppChat.Hooks.useChatTimeoutDetails)
local useChatTimeoutDetailsFromHydration = require(AppChat.Hooks.useChatTimeoutDetailsFromHydration)
local ChatConversationTelemetryLayer = require(AppChat.Telemetry.Layers.ChatConversationTelemetryLayer)
local ChatConversationTelemetryState = require(AppChat.Contexts.TelemetryState.ChatConversationTelemetryState)
local useTelemetry = require(AppChat.Telemetry.useTelemetry)
local ChatConversationTelemetryEvents = require(script.Parent.ChatConversationTelemetryEvents)
local useIsChatEnabled = require(AppChat.Hooks.useIsChatEnabled)
local interventionTreatmentShownSignal = require(AppChatParent.InterventionShared).Signals.interventionTreatmentShownSignal
local useSignal = require(AppChatParent.RoactUtils).Hooks.useSignal
local Constants = require(AppChatParent.InterventionShared).Utils.Constants
local getAllRemainingOlderMessages = require(script.Parent.Messages.Thunks.getAllRemainingOlderMessages)
local getOlderMessages = require(script.Parent.Messages.NetworkRequests.getOlderMessages)
local useCallbackWithDynamicConversationId = require(AppChat.Hooks.useCallbackWithDynamicConversationId)
local useShouldShowConversationOverlay = require(AppChat.Hooks.useShouldShowConversationOverlay)
local useKeybind = require(AppChat.App.Hooks.useKeybind)
local EnumScreens = require(AppChat.EnumScreens)
local EnumMessageTypes = require(script.Parent.EnumMessageTypes)
local EnumCustomEntryTypes = require(script.Parent.EnumCustomEntryTypes)
local FFlagAppChatPerfTracking = require(AppChat.Flags.FFlagAppChatPerfTracking)
local FFlagAppChatMessageTTIMilestones = require(AppChat.Flags.FFlagAppChatMessageTTIMilestones)
local AppChatPerfTracker = require(AppChat.Telemetry.AppChatPerfTracker)

local GetFFlagEnableAppChatInExperience = require(AppChatParent.SharedFlags).GetFFlagEnableAppChatInExperience
local FFlagTCUpsellModalEnabled_DEV = require(AppChatParent.SharedFlags).FFlagTCUpsellModalEnabled_DEV
local FFlagDebugEnableTCDoubleOptIn_DEV = require(AppChatParent.SharedFlags).FFlagDebugEnableTCDoubleOptIn_DEV
local FFlagAppChatShowOSAOnPageEntry = require(AppChatParent.SharedFlags).FFlagAppChatShowOSAOnPageEntry
local FFlagAppChatReactiveFeatureRestrictions = require(AppChatParent.SharedFlags).FFlagAppChatReactiveFeatureRestrictions
local FFlagAppChatUniversalFeatureRestriction = require(AppChatParent.SharedFlags).FFlagAppChatUniversalFeatureRestriction

local FIntAppChatGetAllMessagesDepth = require(AppChat.Flags.FIntAppChatGetAllMessagesDepth)

local FFlagAppChatNavigateBackIfOSAUnacknowledged = require(AppChatParent.SharedFlags).FFlagAppChatNavigateBackIfOSAUnacknowledged
local shouldShowOSAForConversation = require(AppChat.Utils.shouldShowOSAForConversation)
local SignalsMigrationConfig = require(AppChat.Flags.SignalsMigrationConfig)
local useMessageItemList = require(AppChat.Hooks.useMessageItemList).useMessageItemList
local shouldShowU13ChatOptInForConversation = require(AppChat.Utils.shouldShowU13ChatOptInForConversation)
local navigateWithOsaGate = require(AppChat.Utils).navigateWithOsaGate
local FFlagAppChatConversationLoadingSkeleton = require(AppChat.Flags.FFlagAppChatConversationLoadingSkeleton)
local FFlagAppChatBlueSentBubblesIxpEnabled = require(AppChat.Flags.FFlagAppChatBlueSentBubblesIxpEnabled)
local FFlagAppChatUseDataHydrationForChatTimeouts = require(AppChat.Flags.FFlagAppChatUseDataHydrationForChatTimeouts)
local FStringAppChatBlueSentBubblesIxpLayer = require(AppChat.Flags.FStringAppChatBlueSentBubblesIxpLayer)

local isSyntheticSystemMessageId = require(script.Parent.Utils.isSyntheticSystemMessageId)

local FFlagAppChatConversationTrustedFriendUpsellBanner = require(AppChatParent.SharedFlags).FFlagAppChatConversationTrustedFriendUpsellBanner
local seedConversationTopModalFromRequest = if FFlagAppChatConversationTrustedFriendUpsellBanner then require(AppChat.Sdui.seedConversationTopModalFromRequest) else nil
local bool1 = game:DefineFastFlag("AppChatConversationPageSyntheticSystemMessageIxpEnabled", false)

local layerName = game:DefineFastString("AppChatConversationPageSyntheticSystemMessageIxpLayer", "Party.ConversationPage")

local function isOverlayNavigation(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1 and arg1.action and arg1.action.params and arg1.action.params.isOverlay or false
end

local tbl1 = {
    topBarHeight = 0,
    wideMode = false,
    chatInputPlaceholderKey = "Feature.Chat.Label.ChatInputPlaceholder",
    replyChatInputPlaceholderKey = "Feature.Chat.Label.ReplyChatInputPlaceholder",
    replyToYourselfChatInputPlaceholderKey = "Feature.Chat.Label.ReplyToYourselfChatInputPlaceholder",
    messageDefaultNoticeKey = "Feature.Chat.Message.Default",
    messageModeratedNoticeKey = "Feature.Chat.Message.MessageContentModerated",
    newTextKey = "Feature.Chat.Label.New",
    schedulePartyTextKey = "Feature.Squads.Action.ScheduleParty",
    messageHiddenNoticeKey = "Feature.Chat.Label.MessageNotAvailable",
    networkErrorTextKey = "Feature.Toast.NetworkingError.SomethingIsWrong",
    notImplementedMessageTypeKey = "Feature.Chat.Label.NotImplementedMessageType",
    viewProfileOnAvatarPressed = true,
    unknownUserTextKey = "Feature.Chat.Label.UnknownUser",
    oneUserTyping = { "Feature.Chat.Message.OneUserTyping", DISPLAY_NAME = "" },
    twoUsersTyping = {
        "Feature.Chat.Message.TwoUsersTyping",
        DISPLAY_NAME_1 = "",
        DISPLAY_NAME_2 = ""
    },
    severalUsersTyping = "Feature.Chat.Message.SeveralUsersTyping",
    pendingStateBodyKey = "Feature.Chat.Message.ChatIsUnfiltered",
    connectUnavailableWithUserKey = "Feature.Chat.RobloxConnectUnavailableWithUser",
    chatUnavailableWithUserKey = "Feature.Chat.Message.ChatUnavailableWithUser",
    getReadingMessagesIsEnabled = function() end,
    updateConversationTitle = function(_) end,
    navigateToScreen = function() end,
    inputBarDisabledKey = "Feature.Chat.Label.ChatDisabled",
    navigateToChatLanding = function() end,
    releaseInputBarFocus = function() end,
    navigateToSquadLobby = function() end,
    navigateToConversationOverlay = function() end,
    getCanAccessParty = true
}

local function isNameSettled(arg1, arg2): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return not (arg1 == nil) and (arg1.status ~= DataStatus.NotReady or getCombinedNameFromProfileNames(arg1, arg2) ~= nil)
end

local function getOsaState(arg1, arg2, arg3, arg4)
    local fetchedOldestMessage = arg1 and arg1.fetchedOldestMessage

    local bool2 = not arg1 or arg1.conversationType ~= Conversation.Type.MULTI_USER_CONVERSATION

    local shouldShowOsaCardInConversation = arg1
        and bool2
        and (arg1.source == "friends"
            or arg1.osaAcknowledgementStatus == Conversation.OsaAcknowledgementStatus.Unacknowledged
            or arg1.osaAcknowledgementStatus == Conversation.OsaAcknowledgementStatus.Acknowledged)

    local var2 = arg1 and arg1.osaAcknowledgementStatus == Conversation.OsaAcknowledgementStatus.Unacknowledged
    local isFriendsConversation = arg1 and arg1.source == "friends"

    local shouldShowOsaCardOnInitialLoad = shouldShowOsaCardInConversation and var2 and not isFriendsConversation

    local shouldShowOsaCardNow = shouldShowOsaCardInConversation and (fetchedOldestMessage or isFriendsConversation)
    local var6, bool3

    if FFlagAppChatConversationLoadingSkeleton then
        var6 = shouldShowOsaCardOnInitialLoad or shouldShowOsaCardNow
        local var7 = if var6 then getOtherParticipants(arg1, arg2)[1] else nil

        if var7 == nil then
            bool3 = true
        else
            bool3 = FFlagAppChatUseUserProfileHydration and isNameSettled(arg4, var7)

            if not bool3 then
                if arg3 ~= nil and arg3.error ~= nil then
                    bool3 = true
                elseif arg3 == nil or arg3.data == nil then
                    bool3 = false
                else
                    bool3 = UserProfiles.Selectors.getCombinedNameFromId(arg3.data, var7) ~= nil
                end
            end
        end
    else
        var6 = nil
        bool3 = nil
    end

    return {
        shouldShowOsaCardInConversation = shouldShowOsaCardInConversation,
        fetchedOldestMessage = fetchedOldestMessage,
        shouldShowOsaCardOnInitialLoad = shouldShowOsaCardOnInitialLoad,
        shouldShowOsaCardNow = shouldShowOsaCardNow,
        isFriendsConversation = isFriendsConversation,
        willShowOsaCard = var6,
        isOsaCardReady = bool3
    }
end

function ChatConversationContainer(arg1)
    local var1 = Cryo.Dictionary.join(tbl1, arg1)
    local var2 = useAnalytics()
    local var3 = React.useCallback(function(arg2)
        var2:navigate(RoactChatAnalytics.NavigationEvents.ChatConversationProfile)
        var1.openViewProfile(arg2)
    end, { var1.openViewProfile, var2 })
    local var4 = useMapDispatch(mapDispatchToProps)
    local var5 = useGetConversationFromId(var1.conversationId)

    local input = useRecipientIds(var5)
    local success, result = pcall(function(): string
        return HttpService:JSONEncode(input)
    end)
    local recipientIdsSerialized = if success then result else "[]"

    local var7 = nil
    local var8 = nil
    local localUserId = useLocalUserId()
    local chatIsVisible = useChatIsVisible()
    local var11 = useIsChatUserMessagesEnabled()
    local var12 = useIsChatEnabled()
    local dispatch = useDispatch()

    if FFlagAppChatPerfTracking and FFlagAppChatMessageTTIMilestones and AppChatPerfTracker.Hooks then
        local eventName = AppChatPerfTracker.getEventName(AppChatPerfTracker.Events.ChatConversationTTI) or ""

        AppChatPerfTracker.Hooks.useTTIRenderAndMountedTracking(eventName)
    end

    useEffect(function()
        if not var12 then
            var1.navigateToChatLanding()
        end
    end, { var12, var1.navigateToChatLanding })

    if FFlagAppChatNavigateBackIfOSAUnacknowledged then
        local param = if var1.navigation and var1.navigation.getParam then var1.navigation.getParam("isNavigatedFromGroupOSAJoin", false) else false

        if FFlagAppChatShowOSAOnPageEntry then
            useEffect(function()
                if not var1.navigation or not var1.navigation.addListener then
                    return
                end

                local var14 = var1.navigation.addListener(RoactNavigation.Events.WillFocus, function()
                    navigateWithOsaGate({
                        conversationId = var1.conversationId,
                        dispatch = dispatch,
                        onAccepted = function() end,
                        onDeclined = function()
                            var1.navigateToChatLanding()
                        end
                    })
                end)
                return function()
                    if var14 then
                        var14:remove()
                    end
                end
            end, { var1.navigation, var1.conversationId, dispatch })
        else
            useEffect(function()
                if not param and shouldShowOSAForConversation(var5) then
                    var1.navigateToChatLanding()
                end
            end, { var5, var1.navigateToChatLanding, param })
        end
    end

    if FFlagAppChatShowOSAOnPageEntry then
        useEffect(function()
            if not var5 then
                return
            end
            local var14 = shouldShowOSAForConversation(var5)
            local var15 = shouldShowU13ChatOptInForConversation(var5)
            if not var14 and not var15 then
                return
            end

            navigateWithOsaGate({
                conversationId = var1.conversationId,
                dispatch = dispatch,
                onAccepted = function() end,
                onDeclined = function()
                    var1.navigateToChatLanding()
                end
            })
        end, { var5, var1.conversationId, dispatch })
    end

    useSignal(interventionTreatmentShownSignal, React.useCallback(function(arg2)
        if arg2 == Constants.TreatmentType.PartyChatNudgeDialog or arg2 == Constants.TreatmentType.PartyChatTimeoutDialog then
            var1.releaseInputBarFocus()
        end
    end, { var1.releaseInputBarFocus }))

    if FFlagAppChatUseUserProfileHydration then
        var8 = useProfileNames(getOtherParticipants(var5, localUserId))
    else
        var7 = UserProfiles.Hooks.useUserProfilesFetch({
            userIds = getOtherParticipants(var5, localUserId),
            query = UserProfiles.Queries.userProfilesCombinedNameAndUsernameByUserIds
        })
    end

    local conversationTitle = getConversationTitle(var5)

    local users = useGetUsers()
    local usersTyping = useGetUsersTyping(var1.conversationId)

    local var16 = React.useRef(
        {
            itemList = {},
            previousMessagesState = {},
            previousSendingMessagesState = {},
            previousMessagesResult = {}
        }
    )
    local var17 = if SignalsMigrationConfig.shouldReadMessageListFromSignalsStore then useMessageItemList(var1.conversationId, users, localUserId, var5) else nil

    local var18 = React.useMemo(function()
        if SignalsMigrationConfig.shouldReadMessageListFromSignalsStore then
            return var17
        end

        local var18 = FFlagAppChatPerfTracking
            and FFlagAppChatMessageTTIMilestones
            and AppChatPerfTracker.isActive(AppChatPerfTracker.Events.ChatConversationTTI, { conversationId = var1.conversationId })

        if var18 then
            local tbl2 = {
                conversationId = var1.conversationId
            }
            AppChatPerfTracker.trackMilestone(
                AppChatPerfTracker.Events.ChatConversationTTI,
                AppChatPerfTracker.Milestone.DataProcessingStarted.Name,
                tbl2
            )

            AppChatPerfTracker.trackSubphase(
                AppChatPerfTracker.Events.ChatConversationTTI,
                AppChatPerfTracker.Milestone.DataProcessingStarted.Name,
                AppChatPerfTracker.Milestone.DataProcessingStarted.Subphase.DataUpdate,
                tbl2
            )
        end

        var16.current = selectMessagesPure(
            {
                conversation = var5,
                conversationId = var1.conversationId,
                Users = users,
                localUserId = localUserId
            },
            var16.current
        )
        if var18 then
            local tbl2 = {
                conversationId = var1.conversationId
            }
            AppChatPerfTracker.trackMilestone(
                AppChatPerfTracker.Events.ChatConversationTTI,
                AppChatPerfTracker.Milestone.DataProcessingCompleted.Name,
                tbl2
            )

            AppChatPerfTracker.trackSubphase(
                AppChatPerfTracker.Events.ChatConversationTTI,
                AppChatPerfTracker.Milestone.DataProcessingCompleted.Name,
                AppChatPerfTracker.Milestone.DataProcessingCompleted.Subphase.DataUpdate,
                tbl2
            )
        end

        return var16.current.itemList
    end, {
        var5,
        var1.conversationId,
        users,
        localUserId,
        var17
    })
    local osaState = getOsaState(var5, localUserId, var7, if FFlagAppChatUseUserProfileHydration then var8 else nil)

    local itemList = React.useMemo(function()
        local tbl2 = {}

        if osaState.shouldShowOsaCardOnInitialLoad and not osaState.fetchedOldestMessage then
            return tbl2
        end

        local var19 = table.clone(var18)

        if osaState.shouldShowOsaCardNow then
            table.insert(var19, {
                messageType = EnumMessageTypes.Custom,
                customEntryType = EnumCustomEntryTypes.OsaContextCardOneToOne,
                stable_key = EnumCustomEntryTypes.OsaContextCardOneToOne
            })
        end

        return var19
    end, {
        var18,
        var5,
        osaState.shouldShowOsaCardOnInitialLoad,
        osaState.shouldShowOsaCardInConversation,
        osaState.shouldShowOsaCardNow,
        osaState.fetchedOldestMessage
    })

    local var20

    if FFlagAppChatConversationLoadingSkeleton then
        local var21 = useSelector(function(arg2)
            return AppChatNetworking.rodux.GetOlderMessages.getStatus(arg2, var1.conversationId)
        end)

        local isOsaCardReady, willShowOsaCard

        if osaState.isFriendsConversation then
            isOsaCardReady = osaState.isOsaCardReady
            willShowOsaCard = osaState.willShowOsaCard
        elseif osaState.shouldShowOsaCardOnInitialLoad then
            if osaState.fetchedOldestMessage == true then
                isOsaCardReady = osaState.isOsaCardReady
            else
                isOsaCardReady = false
            end

            willShowOsaCard = true
        else
            isOsaCardReady = var21 == RoduxNetworking.Enum.NetworkStatus.Done or osaState.fetchedOldestMessage == true
            willShowOsaCard = var21 == RoduxNetworking.Enum.NetworkStatus.NotStarted or var21 == RoduxNetworking.Enum.NetworkStatus.Fetching
        end

        local var22 = React.useRef({ conversationId = nil, hasLoadedFirstPage = false })
        if var22.current.conversationId ~= var1.conversationId then
            var22.current = {
                conversationId = var1.conversationId,
                hasLoadedFirstPage = false
            }
        end

        var22.current.hasLoadedFirstPage = var22.current.hasLoadedFirstPage or isOsaCardReady

        var20 = var5 and not var22.current.hasLoadedFirstPage and willShowOsaCard
    else
        var20 = false
    end

    local var21 = if FFlagAppChatUseUserProfileHydration then getCombinedNameFromProfileNames(var8, usersTyping[1] and usersTyping[1].id) elseif usersTyping[1] and var7.data then UserProfiles.Selectors.getCombinedNameFromId(var7.data, usersTyping[1].id) else nil
    local displayName2 = if FFlagAppChatUseUserProfileHydration then getCombinedNameFromProfileNames(var8, usersTyping[2] and usersTyping[2].id) elseif usersTyping[2] and var7.data then UserProfiles.Selectors.getCombinedNameFromId(var7.data, usersTyping[2].id) else nil
    local bool2 = true
    if #usersTyping == 1 and not var21 or #usersTyping == 2 and not (var21 and displayName2) then
        bool2 = false
    end

    local isInExperience = GetFFlagEnableAppChatInExperience() and useIsInExperience()
    local replyingToStore = if FFlagAppChatSignalsReplyStore then GetReplyingToStore(false) else nil
    local conversationMessageStore = if FFlagAppChatSignalsReplyStore then GetConversationMessageViewModelStore(false).conversationMessageStore else nil
    local var24 = nil
    local var25 = nil
    local var26 = nil
    local var27 = nil
    local var28 = nil
    if FFlagAppChatSignalsReplyStore then
        var26 = useSignalState(replyingToStore.getMessageId)
        if var26 then
            local var29 = conversationMessageStore.messages(false)[var26]
            local var30 = if var29 and var29.sender_user_id then tostring(var29.sender_user_id) else nil
            var28 = var30 == localUserId
            if FFlagAppChatUseUserProfileHydration then
                if var28 then
                    var27 = nil
                else
                    var27 = getCombinedNameFromProfileNames(var8, var30)
                end
            elseif var28 or not (var30 and var7.data) then
                var27 = nil
            else
                var27 = UserProfiles.Selectors.getCombinedNameFromId(var7.data, var30)
            end
        end
    else
        var24 = useReplyingToMessage()
        var25 = useReplyingToMessageDispatch()
        if var24 then
            var28 = var24.senderTargetId == localUserId
            if FFlagAppChatUseUserProfileHydration then
                if var28 then
                    var27 = nil
                else
                    var27 = getCombinedNameFromProfileNames(var8, var24.senderTargetId)
                end
            elseif var28 or not var7.data then
                var27 = nil
            else
                var27 = UserProfiles.Selectors.getCombinedNameFromId(var7.data, var24.senderTargetId)
            end
        end
    end

    local var29 = useLocalization({
        chatInputPlaceholder = var1.chatInputPlaceholderKey,
        replyChatInputPlaceholder = {
            var1.replyChatInputPlaceholderKey,
            DISPLAY_NAME = var27
        },
        replyToYourselfChatInputPlaceholder = var1.replyToYourselfChatInputPlaceholderKey,
        invalidMessageTypeText = var1.notImplementedMessageTypeKey,
        messageDefaultNoticeText = var1.messageDefaultNoticeKey,
        messageModeratedNoticeText = var1.messageModeratedNoticeKey,
        messageHiddenNoticeText = var1.messageHiddenNoticeKey,
        networkErrorText = var1.networkErrorTextKey,
        newText = var1.newTextKey,
        schedulePartyText = var1.schedulePartyTextKey,
        unknownUserText = var1.unknownUserTextKey,
        oneUserTyping = { "Feature.Chat.Message.OneUserTyping", DISPLAY_NAME = var21 },
        twoUsersTyping = {
            "Feature.Chat.Message.TwoUsersTyping",
            DISPLAY_NAME_1 = var21,
            DISPLAY_NAME_2 = displayName2
        },
        severalUsersTyping = var1.severalUsersTyping,
        bottomModalText = var1.chatUnavailableWithUserKey,
        inputBarDisabledText = var1.inputBarDisabledKey
    })
    local var30 = useTelemetry(ChatConversationTelemetryLayer.Context)
    local var31 = ChatConversationTelemetryState.useMergeState()
    local var32 = ChatConversationTelemetryState.useClearState()

    local var33 = var5 and var5.moderationType or Cryo.None
    local userPendingStatus = var5 and var5.userPendingStatus or Cryo.None
    useEffect(function()
        var31({ conversationId = var1.conversationId, moderationType = var33, userPendingStatus = userPendingStatus })
    end, {
        var31,
        var1.conversationId,
        var33,
        userPendingStatus
    })
    local var35 = useIsUserPending(var5 or {})
    local source = var5 and var5.source

    local var36, var37 = useCallbackWithDynamicConversationId(AppChatNetworking.rodux.GetModalSequence.API, var1.conversationId)

    useEffect(function()
        if not var37 then
            return
        end
        if var35 and source == "channels" then
            dispatch(AppChatNetworking.rodux.GetPendingStateModal.API(var1.conversationId, isInExperience)):catch(function(arg2)
                Logger:warning(`GetPendingStateModal error in ChatConversationContainer {tostring(arg2)}`)
            end)
        end

        if var35 then
            return
        end

        local var38 = dispatch(
            var36(
                {
                    modalSequence = AppChatNetworking.Constants.ModalSequence.ConversationTopModal,
                    isInExperience = isInExperience
                }
            )
        )

        if FFlagAppChatConversationTrustedFriendUpsellBanner then
            var38 = seedConversationTopModalFromRequest(var38, var1.conversationId)
        end

        var38:catch(function(arg2)
            Logger:warning(
                `GetModalSequence for ConversationTopModal error in ChatConversationContainer {tostring(arg2)}`
            )
        end)
    end, {
        var1.conversationId,
        var37,
        isInExperience,
        var35,
        source
    })

    local var38, var39 = useCallbackWithDynamicConversationId(AppChatNetworking.rodux.GetModalSequence.API, var1.conversationId)

    useEffect(function()
        if var35 or not var39 then
            return
        end

        dispatch(
            var38(
                {
                    modalSequence = AppChatNetworking.Constants.ModalSequence.ConversationOverlay,
                    isInExperience = isInExperience
                }
            )
        ):catch(
            function(arg2)
                Logger:warning(`GetModalSequence error in ChatConversationContainer {tostring(arg2)}`)
            end
        )
    end, {
        var39,
        var1.conversationId,
        var35,
        isInExperience,
        var33
    })
    if FFlagDebugEnableTCDoubleOptIn_DEV then
        useKeybind({
            keyCode = Enum.KeyCode.O,
            modifierKey = Enum.ModifierKey.Ctrl
        }, function()
            Logger:debug("Ctrl + O pressed, showing new TC double opt in banner")
            dispatch({
                type = "DEBUG_ShowNewTopModal",
                conversationId = var1.conversationId,
                modalVariant = AppChatNetworking.Constants.ConversationTopModal.AddTrustedConnection
            })
        end, { dispatch, var1.conversationId })

        useKeybind({
            keyCode = Enum.KeyCode.P,
            modifierKey = Enum.ModifierKey.Ctrl
        }, function()
            Logger:debug("Ctrl + P pressed, showing new TC double opt in request banner")
            dispatch({
                type = "DEBUG_ShowNewTopModal",
                conversationId = var1.conversationId,
                modalVariant = AppChatNetworking.Constants.ConversationTopModal.TrustedConnectionRequest
            })
        end, { dispatch, var1.conversationId })
    end

    if FFlagTCUpsellModalEnabled_DEV then
        useKeybind({
            keyCode = Enum.KeyCode.L,
            modifierKey = Enum.ModifierKey.Ctrl
        }, function()
            Logger:debug("Ctrl + L pressed, showing new TC created overlay")
            dispatch({
                type = "DEBUG_ShowNewTCOverlay",
                conversationId = var1.conversationId,
                modalVariant = AppChatNetworking.Constants.ConversationOverlay.TrustedConnectionCreated
            })
        end, { dispatch, var1.conversationId })
    end
    local var40, var41 = useCallbackWithDynamicConversationId(AppChatNetworking.rodux.GetModalSequence.API, var1.conversationId)

    useEffect(function()
        if not var41 then
            return
        end

        dispatch(
            var40(
                {
                    modalSequence = AppChatNetworking.Constants.ModalSequence.ConversationBottomModal,
                    isInExperience = isInExperience
                }
            )
        ):catch(
            function(arg2)
                Logger:warning(
                    `GetModalSequence for ConversationBottomModal error in ChatConversationContainer {tostring(arg2)}`
                )
            end
        )
    end, {
        var1.conversationId,
        var41,
        isInExperience,
        dispatch,
        var40
    })
    local var42 = useShouldShowConversationOverlay(var1.conversationId)
    useEffect(function()
        if var42 then
            var1.navigateToConversationOverlay()
        end
    end, { var42, var1.conversationId })

    local bool3 = source ~= "channels"
    local var43 = useSelector(function(arg2): boolean
        return (if bool3 then AppChatNetworking.rodux.GetChatModerationStatuses.getStatus(arg2) else AppChatNetworking.rodux.GetChatModerationStatuses.getStatus(arg2, var1.conversationId)) == RoduxNetworking.Enum.NetworkStatus.NotStarted
    end)
    useEffect(function()
        if not var43 or FFlagAppChatUseDataHydrationForChatTimeouts then
            return
        end

        dispatch(AppChatNetworking.rodux.GetChatModerationStatuses.API(not bool3 and { var1.conversationId } or nil)):catch(
            function(arg2)
                warn("GetChatModerationStatuses error in ChatConversationContainer " .. tostring(arg2))
            end
        )
    end, {
        var1.conversationId,
        bool3,
        dispatch,
        var43
    })

    local var44 = if FFlagAppChatUseDataHydrationForChatTimeouts then useSignalState(
        useChatTimeoutDetailsFromHydration({ conversationId = var1.conversationId, conversationModerationType = var33 })
    ) else useChatTimeoutDetails({ conversationId = var1.conversationId, conversationModerationType = var33 })
    local isTimedOut = var44.isTimedOut
    local timeoutEndTimestamp = var44.timeoutEndTimestamp
    local decisionEventId = var44.decisionEventId
    local duration = var44.duration

    useEffect(function()
        var30.emit(ChatConversationTelemetryEvents.ScreenRendered, { loadedMessageCount = #var18 })
    end, { var1.conversationId })

    if bool1 then
        local var45 = var18[1]
        local id = if var45 then var45.id else nil

        useEffect(function()
            if isSyntheticSystemMessageId(id) then
                IXPService:LogFlagLinkedUserLayerExposure(layerName)
            end
        end, { var1.conversationId, id })
    end

    if FFlagAppChatBlueSentBubblesIxpEnabled then
        local var45 = React.useMemo(function()
            for _, value in var18 do
                if not value.isIncoming and value.messageType == EnumMessageTypes.PlainText then
                    return true
                end
            end
            return false
        end, { var18 })
        useEffect(function()
            if var45 then
                IXPService:LogFlagLinkedUserLayerExposure(FStringAppChatBlueSentBubblesIxpLayer)
            end
        end, { var1.conversationId, var45 })
    end

    local onConversationUnmount = React.useCallback(function(conversationExitType: string)
        var30.emit(ChatConversationTelemetryEvents.ScreenExit, { conversationExitType = conversationExitType })

        var32()
    end, { var30, var32 })

    var5 = var5 or {}
    local shouldShowChatInputBar = not (var5.participantPendingStatus == ConversationChannels.UserPendingStatus.Pending) and var11
    local shouldShowLegacyBottomModal = not shouldShowChatInputBar and var11

    local var48 = useIsExternalNavigationAvailable({ EnumScreens.ViewUserProfile })

    local bool4 = var5.conversationType == Conversation.Type.MULTI_USER_CONVERSATION
    local var49 = useSelector(function(arg2): boolean
        return bool4 and var5.initiator == arg2.LocalUserId
    end)

    local function openViewProfile(participantId)
        if var48[EnumScreens.ViewUserProfile] then
            var3(participantId)
            return
        end
        var1.navigateToScreen(GenericDialogType.ParticipantDialog, {
            conversationId = var1.conversationId,
            participantId = participantId,
            showRemoveUserButton = not var35 and bool4 and var49
        }, true)
    end

    local chatInputPlaceholder = if if FFlagAppChatSignalsReplyStore then var26 else var24 then if var28 then var29.replyToYourselfChatInputPlaceholder else var29.replyChatInputPlaceholder else var29.chatInputPlaceholder

    useEffect(function()
        var1.updateConversationTitle(conversationTitle)
    end, { conversationTitle, var1.updateConversationTitle })

    local onDisabledInputBarActivated = React.useCallback(function()
        if not FFlagAppChatUniversalFeatureRestriction then
            chatInputBoxDisabledPressedSignal:fire(
                {
                    endTimestamp = timeoutEndTimestamp,
                    decisionEventId = decisionEventId,
                    duration = duration
                }
            )
            return
        end

        local abuseVector = require(AppChatParent.UniversalFeatureRestrictions.AbuseVector)
        local showFeatureRestriction = require(AppChatParent.UniversalFeatureRestrictions.showFeatureRestriction)
        local tbl2 = {
            onShown = var1.releaseInputBarFocus,
            onAppeal = function() end
        }
        if FFlagAppChatReactiveFeatureRestrictions then
            local partyChatTimeoutReceivedSignal = require(AppChatParent.InterventionShared).Signals.partyChatTimeoutReceivedSignal
            function tbl2.onAcknowledgementSuccess()
                partyChatTimeoutReceivedSignal:fire(nil)
            end
        end
        showFeatureRestriction(abuseVector.PartyChat, tbl2)
    end, {
        var1.releaseInputBarFocus,
        timeoutEndTimestamp,
        decisionEventId,
        duration
    })

    local var52, var53 = React.useState(var1.navigation and var1.navigation.isFocused and var1.navigation.isFocused())

    local var54 = nil
    local var55 = nil
    if FFlagAppChatPerfTracking then
        if not var1.isFocused or var1.isFocused() then
            var54 = var52
        else
            var54 = false
        end

        var55 = var54 and not var35
    end

    local var56

    if FFlagAppChatPerfTracking then
        local var57 = React.useRef(false)

        React.useEffect(function()
            var57.current = not shouldShowChatInputBar
        end, { var1.conversationId, shouldShowChatInputBar })

        local var58 = React.useCallback(function(str1: string)
            if not (AppChatPerfTracker.isActive(AppChatPerfTracker.Events.ChatConversationTTI, { conversationId = var1.conversationId })
                and var55) then
                return
            end

            if not var57.current then
                Logger:debug("TTI: Messages ready but waiting for input bar (chatInputBarReady={}, reason={})", var57.current, str1)
            else
                AppChatPerfTracker.finish(
                    AppChatPerfTracker.Events.ChatConversationTTI,
                    {
                        conversationId = var1.conversationId,
                        numElementsRendered = #var18
                    }
                )
            end
        end, {
            var1.conversationId,
            var52,
            var35,
            #var18
        })
        React.useEffect(function()
            var58("messages_ready")
        end, { var58, #var18, var1.conversationId })

        var56 = React.useCallback(function()
            var57.current = true
            var58("input_bar_ready")
        end, { var58 })
    else
        var56 = nil
    end

    if FFlagAppChatPerfTracking then
        local var57 = React.useRef(nil)

        React.useEffect(function()
            Logger:debug("Perf: Resetting message perf tracking for conversation {}", var1.conversationId)

            var57.current = nil

            local tbl2 = {
                conversationId = var1.conversationId
            }

            if FFlagAppChatMessageTTIMilestones then
                AppChatPerfTracker.cancel(AppChatPerfTracker.Events.MessageSendTTI, tbl2)
                AppChatPerfTracker.cancel(AppChatPerfTracker.Events.MessageReceiveTTI, tbl2)
                return
            end
            AppChatPerfTracker.cancel(AppChatPerfTracker.Events.MessageSendToPendingRender, tbl2)
            AppChatPerfTracker.cancel(AppChatPerfTracker.Events.MessageSendResponseToFinalRender, tbl2)
            AppChatPerfTracker.cancel(AppChatPerfTracker.Events.MessageSendToFinalRender, tbl2)
            AppChatPerfTracker.cancel(AppChatPerfTracker.Events.MessageReceiveToRender, tbl2)
        end, { var1.conversationId })

        React.useEffect(function()
            local var58 = var18[1]
            if not (var58 and var58.id) then
                return
            end

            local tbl2 = {
                conversationId = var1.conversationId
            }
            local bool5 = var58.senderTargetId == localUserId

            if not var58.isSending and (var58.senderType == "system" or not bool5) then
                if var58.id ~= var57.current then
                    var57.current = var58.id
                    if FFlagAppChatMessageTTIMilestones then
                        AppChatPerfTracker.finish(AppChatPerfTracker.Events.MessageReceiveTTI, tbl2)
                    else
                        AppChatPerfTracker.finish(AppChatPerfTracker.Events.MessageReceiveToRender, tbl2)
                    end
                end
            elseif FFlagAppChatMessageTTIMilestones then
                if AppChatPerfTracker.isActive(AppChatPerfTracker.Events.MessageReceiveTTI, tbl2) then
                    AppChatPerfTracker.cancel(AppChatPerfTracker.Events.MessageReceiveTTI, tbl2)
                end
            elseif AppChatPerfTracker.isActive(AppChatPerfTracker.Events.MessageReceiveToRender, tbl2) then
                AppChatPerfTracker.cancel(AppChatPerfTracker.Events.MessageReceiveToRender, tbl2)
            end

            if not bool5 then
                return
            end

            if FFlagAppChatMessageTTIMilestones then
                if var58.isSending then
                    AppChatPerfTracker.trackMilestone(
                        AppChatPerfTracker.Events.MessageSendTTI,
                        AppChatPerfTracker.Milestone.FunctionallyReady,
                        tbl2
                    )

                    return
                end
                AppChatPerfTracker.finish(AppChatPerfTracker.Events.MessageSendTTI, tbl2)
            elseif var58.isSending then
                AppChatPerfTracker.finish(AppChatPerfTracker.Events.MessageSendToPendingRender, tbl2)
            else
                AppChatPerfTracker.finish(AppChatPerfTracker.Events.MessageSendResponseToFinalRender, tbl2)
                AppChatPerfTracker.finish(AppChatPerfTracker.Events.MessageSendToFinalRender, tbl2)
            end
        end, { var18, localUserId, var1.conversationId })
    end

    useEffect(function()
        local var57 = var1.navigation and var1.navigation.addListener and var1.navigation.addListener(RoactNavigation.Events.WillBlur, function(arg2)
            if not FFlagAppChatPerfTracking then
                if arg2 and arg2.action and arg2.action.params and arg2.action.params.isOverlay then
                    var53(true)
                    return
                end
                var53(false)
                return
            end

            local isOverlay = isOverlayNavigation(arg2)

            var53(isOverlay)
            if isOverlay then
                return
            end

            if AppChatPerfTracker.isActive(AppChatPerfTracker.Events.ChatConversationTTI, { conversationId = var1.conversationId }) then
                AppChatPerfTracker.cancel(AppChatPerfTracker.Events.ChatConversationTTI, { conversationId = var1.conversationId })
            end
        end)

        local var58 = var1.navigation and var1.navigation.addListener and var1.navigation.addListener(RoactNavigation.Events.WillFocus, function(_)
            var53(true)
        end)

        return function()
            if var57 then
                var57.remove()
            end
            if var58 then
                var58.remove()
            end
        end
    end, { var1.navigation, var1.conversationId })

    useEffect(function()
        if not osaState.shouldShowOsaCardOnInitialLoad then
            return
        end

        dispatch(getAllRemainingOlderMessages(getOlderMessages, var1.conversationId, FIntAppChatGetAllMessagesDepth)):catch(
            function()
                var1.navigateToToast({ toastProps = { toastContent = { toastTitle = var29.networkErrorText } } })
            end
        )
    end, { osaState.shouldShowOsaCardOnInitialLoad })

    local getCanAccessParty = var1.getCanAccessParty
    if FFlagAppChatPerfTracking then
        if not var54 then
            return nil
        end

        if var35 then
            return React.createElement(PendingStateConversationPage, {
                conversationId = var1.conversationId,
                topBarHeight = var1.topBarHeight,
                networkErrorText = var29.networkErrorText,
                navigateToToast = var1.navigateToToast,
                wideMode = var1.wideMode,
                onConversationUnmount = onConversationUnmount,
                navigateBack = var1.navigateBack
            })
        end
        local createElement = React.createElement
        local var57 = ChatConversation
        local join = Cryo.Dictionary.join
        local tbl2 = {
            moreMenuEnabled = getCanAccessParty,
            conversation = var5,
            conversationTitle = conversationTitle,
            itemList = itemList,
            localUserId = localUserId,
            openGameDetailsPage = var1.openGameDetailsPage,
            openViewProfile = openViewProfile,
            readingMessagesIsEnabled = var1.getReadingMessagesIsEnabled(),
            Users = users,
            usersTyping = usersTyping,
            displayNamesAvailable = bool2,
            onConversationUnmount = onConversationUnmount,
            recipientIdsSerialized = recipientIdsSerialized,
            chatIsVisible = chatIsVisible,
            chatInputPlaceholder = chatInputPlaceholder,
            replyingToMessageId = 0,
            replyingToMessage = 0,
            replyingToMessageDispatch = 0,
            shouldShowChatInputBar = 0,
            shouldShowLegacyBottomModal = 0,
            shouldDisableChatInputBar = 0,
            onChatInputBarReady = 0,
            inputBarDisabledEndTimestampDisplay = 0,
            onDisabledInputBarActivated = 0,
            scrollToTopOnInitialOsaLoad = 0,
            openMessageListAtStart = 0,
            navigateToSquadLobby = 0,
            shouldHideMoreMenuButton = 0,
            isInitialMessageLoading = 0
        }

        if not FFlagAppChatSignalsReplyStore then
            var26 = nil
        end

        tbl2.replyingToMessageId = var26
        if FFlagAppChatSignalsReplyStore then
            var24 = nil
        end

        tbl2.replyingToMessage = var24
        if FFlagAppChatSignalsReplyStore then
            var25 = nil
        end

        tbl2.replyingToMessageDispatch = var25

        tbl2.shouldShowChatInputBar = shouldShowChatInputBar
        tbl2.shouldShowLegacyBottomModal = shouldShowLegacyBottomModal
        tbl2.shouldDisableChatInputBar = isTimedOut
        if not FFlagAppChatPerfTracking then
            var56 = nil
        end

        tbl2.onChatInputBarReady = var56
        tbl2.inputBarDisabledEndTimestampDisplay = timeoutEndTimestamp
        tbl2.onDisabledInputBarActivated = onDisabledInputBarActivated
        tbl2.scrollToTopOnInitialOsaLoad = osaState.shouldShowOsaCardOnInitialLoad and osaState.fetchedOldestMessage
        tbl2.openMessageListAtStart = osaState.shouldShowOsaCardOnInitialLoad
        tbl2.navigateToSquadLobby = if getCanAccessParty then var1.navigateToSquadLobby else nil
        tbl2.shouldHideMoreMenuButton = if getCanAccessParty then not shouldShowChatInputBar else nil
        if not FFlagAppChatConversationLoadingSkeleton then
            var20 = nil
        end

        tbl2.isInitialMessageLoading = var20
        return createElement(var57, join(var1, var4, var29, tbl2))
    end

    if not var52 then
        return nil
    end

    if var1.isFocused and not var1.isFocused() then
        return nil
    end

    if var35 then
        return React.createElement(PendingStateConversationPage, {
            conversationId = var1.conversationId,
            topBarHeight = var1.topBarHeight,
            networkErrorText = var29.networkErrorText,
            navigateToToast = var1.navigateToToast,
            wideMode = var1.wideMode,
            onConversationUnmount = onConversationUnmount,
            navigateBack = var1.navigateBack,
            style = var1.style
        })
    end
    local createElement = React.createElement
    local var57 = ChatConversation
    local join = Cryo.Dictionary.join
    local tbl2 = {
        moreMenuEnabled = getCanAccessParty,
        conversation = var5,
        conversationTitle = conversationTitle,
        itemList = itemList,
        localUserId = localUserId,
        openGameDetailsPage = var1.openGameDetailsPage,
        openViewProfile = openViewProfile,
        readingMessagesIsEnabled = var1.getReadingMessagesIsEnabled(),
        Users = users,
        usersTyping = usersTyping,
        displayNamesAvailable = bool2,
        onConversationUnmount = onConversationUnmount,
        recipientIdsSerialized = recipientIdsSerialized,
        chatIsVisible = chatIsVisible,
        chatInputPlaceholder = chatInputPlaceholder,
        replyingToMessageId = 0,
        replyingToMessage = 0,
        replyingToMessageDispatch = 0,
        shouldShowChatInputBar = 0,
        shouldShowLegacyBottomModal = 0,
        shouldDisableChatInputBar = 0,
        onChatInputBarReady = 0,
        inputBarDisabledEndTimestampDisplay = 0,
        onDisabledInputBarActivated = 0,
        scrollToTopOnInitialOsaLoad = 0,
        openMessageListAtStart = 0,
        navigateToSquadLobby = 0,
        shouldHideMoreMenuButton = 0,
        isInitialMessageLoading = 0
    }

    if not FFlagAppChatSignalsReplyStore then
        var26 = nil
    end

    tbl2.replyingToMessageId = var26
    if FFlagAppChatSignalsReplyStore then
        var24 = nil
    end

    tbl2.replyingToMessage = var24
    if FFlagAppChatSignalsReplyStore then
        var25 = nil
    end

    tbl2.replyingToMessageDispatch = var25

    tbl2.shouldShowChatInputBar = shouldShowChatInputBar
    tbl2.shouldShowLegacyBottomModal = shouldShowLegacyBottomModal
    tbl2.shouldDisableChatInputBar = isTimedOut
    if not FFlagAppChatPerfTracking then
        var56 = nil
    end

    tbl2.onChatInputBarReady = var56
    tbl2.inputBarDisabledEndTimestampDisplay = timeoutEndTimestamp
    tbl2.onDisabledInputBarActivated = onDisabledInputBarActivated
    tbl2.scrollToTopOnInitialOsaLoad = osaState.shouldShowOsaCardOnInitialLoad and osaState.fetchedOldestMessage
    tbl2.openMessageListAtStart = osaState.shouldShowOsaCardOnInitialLoad
    tbl2.navigateToSquadLobby = if getCanAccessParty then var1.navigateToSquadLobby else nil
    tbl2.shouldHideMoreMenuButton = if getCanAccessParty then not shouldShowChatInputBar else nil
    if not FFlagAppChatConversationLoadingSkeleton then
        var20 = nil
    end

    tbl2.isInitialMessageLoading = var20
    return createElement(var57, join(var1, var4, var29, tbl2))
end

return UniversalAppPolicy.connect(function(arg1)
    return {
        viewProfileOnAvatarPressed = arg1.getChatTapConversationThumbnail(),
        getCanAccessParty = arg1.getCanAccessParty()
    }
end)(ChatConversationContainer)
