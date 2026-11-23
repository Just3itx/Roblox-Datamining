-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:21:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Localization = require(AppChatParent.Localization)
local React = require(AppChatParent.React)
local RealtimeDelivery = require(AppChatParent.RealtimeDelivery)
local RoactNavigation = require(AppChatParent.RoactNavigation)
local RoactUtils = require(AppChatParent.RoactUtils)
local Cryo = require(AppChatParent.Cryo)
local AppChatNetworking = require(AppChatParent.AppChatNetworking)

local dependencyArray = RoactUtils.Hooks.dependencyArray
local useCallback = React.useCallback
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useEffect = React.useEffect
local useLocalization = Localization.Hooks.useLocalization
local useMemo = React.useMemo
local useRef = React.useRef
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector

local FormFactor = require(AppChatParent.FormFactor).Enums.FormFactor
local var1 = require(AppChat.Logger):new("AppChat.Realtime.ChatEventReceiver2")

local Conversation = require(AppChat.Models.Conversation)
local ConversationChannels = require(AppChat.Models.ConversationChannels)
local ChangedParticipants = require(AppChat.Conversations.Actions.ChangedParticipants)
local RoduxAliases = require(AppChat.Http.RoduxAliases)
local ReceivedUserTyping = require(AppChat.Conversations.Actions.ReceivedUserTyping)
local RemovedConversation = require(AppChat.Conversations.Actions.RemovedConversation)
local RenamedGroupConversation = require(AppChat.Conversations.Actions.RenamedGroupConversation)
local FriendConversationCreated = require(AppChat.Conversations.Actions.FriendConversationCreated)
local FriendshipDestroyed = require(AppChat.Actions.FriendshipDestroyed)
local useIsChatEnabled = require(AppChat.Hooks.useIsChatEnabled)
local useIsGroupChatEnabled = require(AppChat.Hooks.useIsGroupChatEnabled)
local useIsInExperience = require(AppChat.Hooks.useIsInExperience)

local Messages = require(AppChat.Components.ChatConversation.Messages)
local EnumScreens = require(AppChat.EnumScreens)
local getNewMessages = Messages.Thunks.getNewMessages
local FFlagAppChatPerfTracking = require(AppChat.Flags.FFlagAppChatPerfTracking)
local FFlagAppChatMessageTTIMilestones = require(AppChat.Flags.FFlagAppChatMessageTTIMilestones)
local AppChatPerfTracker = require(AppChat.Telemetry.AppChatPerfTracker)
local paginateAndRefreshConversations = require(AppChat.Conversations.Thunks.paginateAndRefreshConversations)
local fetchChatMetadata = require(AppChat.Conversations.Thunks.fetchChatMetadata)
local getAllUserPresences = require(AppChat.Conversations.Thunks.getAllUserPresences)
local fetchLatestConversationDetails = require(AppChat.Conversations.Thunks.fetchLatestConversationDetails)
local getAllFriendsAsync = require(AppChat.Conversations.Thunks.getAllFriendsAsync)
local useLocalUserId = require(AppChatParent.RobloxAppHooks).useLocalUserId
local multiGetConversationDetails = require(AppChat.Conversations.Thunks.multiGetConversationDetails)

local refreshConversationUnfilteredThreadsDetails = require(AppChat.Conversations.Thunks.refreshConversationUnfilteredThreadsDetails)

local CommunicationChannelsTypes = require(script.Parent.CommunicationChannelsTypes)
local _UnfilteredThreadsTypes = require(script.Parent.UnfilteredThreadsTypes)
local useChatTrustedConnectionsEvents = require(AppChat.Components.EventReceivers.useChatTrustedConnectionsEvents)
local getFFlagDebugUnfilteredThreads = require(AppChatParent.SharedFlags).getFFlagDebugUnfilteredThreads
local FFlagAppChatPresenceStoreMigration = require(AppChat.Flags.FFlagAppChatPresenceStoreMigration)
local FFlagAppChatUseSignalsForAppLoaded = require(AppChat.Flags.FFlagAppChatUseSignalsForAppLoaded)
local GetAppLoadedStore = require(AppChat.Stores.GetAppLoadedStore)
local useSignalState = require(AppChatParent.SignalsReact).useSignalState

local function chunkAndLogString(str1: string)
    local tbl1 = {}
    for i = 1, #str1, 800 do
        local num1 = i + 800 - 1
        table.insert(tbl1, str1:sub(i, num1))
    end
    for _, value in tbl1 do
        var1:debug(value)
    end
end

local tbl1 = { handlesAppShellNotifications = true }

function ChatEventReceiver2(tbl2)
    useEffect(function()
        var1:info("ChatEventReceiver2 mounted")
        return function()
            var1:info("ChatEventReceiver2 unmounted")
        end
    end, {})

    local var2 = if FFlagAppChatUseSignalsForAppLoaded then useSignalState(GetAppLoadedStore(false).getAppLoaded) else useSelector(function(arg1)
        return arg1.ChatAppReducer.AppLoaded
    end)
    local var3 = useSelector(function(arg1)
        return arg1.ChatAppReducer.Conversations
    end)
    local var4 = useSelector(function(arg1)
        return arg1.FormFactor
    end)

    local var5 = Cryo.isEmpty(var3)
    local var6 = useLocalUserId()
    local var7 = useIsChatEnabled()
    local var8 = useIsGroupChatEnabled()
    local var9 = useIsInExperience()

    local var10 = useDispatch()
    local function func1(arg1, arg2, arg3, arg4) -- Luacid: Inlined by compiler; 1 call site recovered
        var10(ChangedParticipants(arg1, arg2, arg3, arg4))
    end
    local function func2() -- Luacid: Inlined by compiler; 1 call site recovered
        return var10(fetchChatMetadata())
    end

    local function func3(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
        return var10(fetchLatestConversationDetails(arg1))
    end
    local function func4() -- Luacid: Inlined by compiler; 1 call site recovered
        var10(getAllFriendsAsync())
    end
    local var11 = not FFlagAppChatPresenceStoreMigration and function()
        spawn(function()
            var10(getAllUserPresences())
        end)
    end or nil

    local function func5(arg1, arg2, arg3) -- Luacid: Inlined by compiler; 2 call sites recovered
        return var10(getNewMessages(arg1, arg2, arg3))
    end

    local function restartMessageReceiveTracking(channelId: string)
        if not FFlagAppChatPerfTracking then
            return
        end
        local tbl3 = {
            conversationId = tostring(channelId)
        }

        if FFlagAppChatMessageTTIMilestones then
            AppChatPerfTracker.cancel(AppChatPerfTracker.Events.MessageReceiveTTI, tbl3)
            AppChatPerfTracker.start(AppChatPerfTracker.Events.MessageReceiveTTI, tbl3)
            return
        end
        AppChatPerfTracker.cancel(AppChatPerfTracker.Events.MessageReceiveToRender, tbl3)
        AppChatPerfTracker.start(AppChatPerfTracker.Events.MessageReceiveToRender, tbl3)
    end

    local function func6(arg1, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
        var10(RoduxAliases.Actions.AliasUpdated(arg1, arg2))
    end
    local function func7(arg1, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
        var10(ReceivedUserTyping(arg1, arg2))
    end

    local function func8() -- Luacid: Inlined by compiler; 2 call sites recovered
        var10(paginateAndRefreshConversations())
    end

    local function func9(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
        var10(RemovedConversation(arg1))
    end
    local function func10(arg1, arg2, arg3, arg4) -- Luacid: Inlined by compiler; 1 call site recovered
        var10(RenamedGroupConversation(arg1, arg2, arg3, arg4))
    end

    local var12 = Cryo.Dictionary.join(tbl1, tbl2)
    local var13 = useRef({})

    local var14 = useLocalization({
        networkErrorText = "Feature.Toast.NetworkingError.SomethingIsWrong",
        removedFromConversationToastTitle = "Feature.Chat.Message.RemovedFromConversation"
    })

    local networkErrorText = var14.networkErrorText
    local removedFromConversationToastTitle = var14.removedFromConversationToastTitle

    local var15 = useCallback(function(str1: string, arg1)
        assert(var13.current, "table")
        var13.current[str1] = arg1
    end, { var13.current })

    local var16 = useCallback(function()
        if not var12.rnBypassActionSignal then
            return
        end

        var12.rnBypassActionSignal:fire(
            RoactNavigation.Actions.navigate({
                routeName = EnumScreens.RoactChatToast,
                params = {
                    toastProps = {
                        toastContent = { toastTitle = networkErrorText }
                    }
                }
            })
        )
    end, { var12.rnBypassActionSignal, networkErrorText })

    useEffect(function()
        if not var7 and var12.activeConversationId and var12.rnBypassActionSignal then
            var1:debug("Chat is disabled for our user, navigating away from active conversation")
            var12.rnBypassActionSignal:fire(
                RoactNavigation.Actions.navigate(
                    {
                        routeName = var4 == FormFactor.WIDE and EnumScreens.EmptyConversation or EnumScreens.ChatLanding
                    }
                )
            )
        end
    end, {
        var7,
        var4,
        var12.activeConversationId,
        var12.rnBypassActionSignal
    })

    local var17 = if var12.activeConversationId then var3[var12.activeConversationId] else nil

    useEffect(function()
        if not var8 and var17 and var12.rnBypassActionSignal and var17.type == "group" then
            var1:debug("Group chats are disabled and we are navigated to a group chat. Navigating to ChatLanding")

            var12.rnBypassActionSignal:fire(
                RoactNavigation.Actions.navigate(
                    {
                        routeName = var4 == FormFactor.WIDE and EnumScreens.EmptyConversation or EnumScreens.ChatLanding
                    }
                )
            )
        end
    end, {
        var8,
        var17,
        var4,
        var12.rnBypassActionSignal
    })
    RealtimeDelivery.useRealtimeNamespace("UserTagChangeNotification", function(arg1)
        var1:info("Received UserTagChangeNotification: {}", arg1.Type)
        if arg1.Type == "UserTagUpdate" then
            local userId = arg1.UserId
            func6(tostring(userId), arg1.NewAlias)
        end
    end, dependencyArray(func6))

    RealtimeDelivery.useRealtimeNamespace("FriendshipNotifications", function(arg1)
        local type = arg1.Type
        var1:info("Received FriendshipNotifications notification: {}", type)

        if type == "FriendshipCreated" then
            func8()
            return
        end

        if type ~= "FriendshipDestroyed" then
            return
        end

        local var18 = nil
        if arg1.EventArgs then
            local str1 = tostring(arg1.EventArgs.UserId1)
            local str2 = tostring(arg1.EventArgs.UserId2)
            if str1 == var6 then
                str1 = "localUserId"
                var18 = str2
            end
            if str2 == var6 then
                str2 = "localUserId"
                var18 = str1
            end

            var10(FriendshipDestroyed({ userId1 = str1, userId2 = str2 }))
        end

        if var17
            and var17.source == "friends"
            and var17.conversationType == Conversation.Type.ONE_TO_ONE_CONVERSATION
            and Cryo.List.findWhere(var17.participants, function(arg2): boolean
                return arg2 == var18
            end)
        then
            local routeName = if var4 == FormFactor.WIDE then EnumScreens.EmptyConversation else EnumScreens.ChatLanding
            var12.rnBypassActionSignal:fire(RoactNavigation.Actions.navigate({ routeName = routeName }))
        end
    end, dependencyArray(var10, func8, var6, var4, var17, var12.rnBypassActionSignal))

    local var18 = useCallback(function()
        if not var2 then
            return
        end

        func2():andThen(function(bool1: boolean)
            if not bool1 then
                var1:trace("Chat is disabled for our user, no need to refresh conversations")
                return
            end

            var1:trace("Chat is enabled for our user, refreshing conversations")
            func8()

            task.spawn(function()
                func4()
            end)

            if not FFlagAppChatPresenceStoreMigration then
                var11()
            end
        end)
    end, {
        var2,
        func8,
        func4,
        var11,
        func2
    })
    RealtimeDelivery.useRealtimeConnectionStateChanged("CommunicationChannels", function(connectionState, arg1)
        var1:info("CommunicationChannels connection state transitioned to {}", tostring(connectionState))

        if connectionState == Enum.ConnectionState.Disconnected then
            var1:info("CommunicationChannels disconnected, show network error toast.")
            var16()
        elseif connectionState == Enum.ConnectionState.Connected and arg1 then
            var1:trace(
                "We missed some messages while we were disconnected. The chat app was previously {}",
                if var2 then "loaded" else "unloaded"
            )
            var18()
        end
    end, dependencyArray(var18, var2, var16))

    RealtimeDelivery.useRealtimeNamespace("CommunicationChannels", function(arg1)
        if arg1.ChannelVertical ~= "PlatformChat"
            or not table.find(CommunicationChannelsTypes.ChannelTypeAllowlist, arg1.ChannelType)
        then
            return
        end

        var1:info("Received CommunicationChannels notification: {}", arg1.Type)

        var15("CommunicationChannels", arg1.SequenceNumber)

        local channelId = arg1.ChannelId

        if arg1.Type == "ChannelDeleted" or arg1.Type == "RemovedFromChannel" or arg1.Type == "ChannelArchived" then
            func9(channelId)
            local activeConversationId = var12.activeConversationId
            if activeConversationId ~= nil and tostring(activeConversationId) == arg1.ChannelId and var12.rnBypassActionSignal then
                local routeName = if var4 == FormFactor.WIDE then EnumScreens.EmptyConversation else EnumScreens.ChatLanding
                var12.rnBypassActionSignal:fire(RoactNavigation.Actions.navigate({ routeName = routeName }))
            end

            if arg1.Actor.Id ~= tostring(var6) then
                var12.rnBypassActionSignal:fire(
                    RoactNavigation.Actions.navigate({
                        routeName = EnumScreens.RoactChatToast,
                        params = {
                            toastProps = {
                                toastContent = { toastTitle = removedFromConversationToastTitle }
                            }
                        }
                    })
                )
            end

            return
        end

        if arg1.Type == "ChannelUpdated" or arg1.Type == "ParticipantsAdded" or arg1.Type == "ParticipantsRemoved" then
            task.spawn(function()
                func3(channelId):andThen(function(arg2)
                    local title = arg2.title
                    local lastUpdated = arg2.lastUpdated

                    if arg1.Type == "ChannelUpdated" then
                        func10(channelId, title, arg2.isDefaultTitle, lastUpdated)
                        return
                    end

                    func1(channelId, arg2.participants, title, lastUpdated)
                end):catch(function(arg2)
                    var1:warning(`Failure in RobloxEventReceiver->{arg1.Type}, Status: {tostring(arg2)}`)
                end)
            end)

            return
        end

        if arg1.Type ~= "AddedToChannel"
            and arg1.Type ~= "ChannelCreated"
            and arg1.Type ~= "ChannelMarkedRead"
            and (arg1.Type ~= "ChannelMetadataUpdated" or channelId == nil)
            and arg1.Type ~= "ChannelUnarchived"
        then
            if arg1.Type ~= "MessageCreated" and arg1.Type ~= "SystemMessageCreated" then
                if arg1.Type == "ParticipantTyping" and arg1.IsTyping then
                    func7(channelId, arg1.Actor.Id)
                end

                return
            end

            if not FFlagAppChatPerfTracking then
                func5(channelId, arg1.Actor.Id == tostring(var6), (tick()))
                return
            end

            local bool1 = arg1.Actor.Id == tostring(var6)
            if not bool1 and var12.activeConversationId and tostring(var12.activeConversationId) == channelId then
                restartMessageReceiveTracking(channelId)
            end

            func5(channelId, bool1, (tick()))
            return
        end

        if var5 then
            var1:debug("Received {} event while loading conversation data", arg1.Type)
            return
        end

        task.spawn(function()
            func3(channelId):andThen(function(arg2)
                if arg1.Type ~= "ChannelCreated" and arg1.Type ~= "ChannelUnarchived" or arg2.type ~= "one_to_one" then
                    return
                end

                local oldFriendConversationId = ConversationChannels.getFriendConversationId(arg2.participants)
                if not oldFriendConversationId then
                    return
                end

                var10(FriendConversationCreated({ newConversationId = arg2.id, oldFriendConversationId = oldFriendConversationId }))

                if var12.activeConversationId ~= oldFriendConversationId then
                    return
                end

                var12.rnBypassActionSignal:fire(
                    RoactNavigation.Actions.navigate({ routeName = EnumScreens.ChatConversation, params = { conversationId = arg2.id } })
                )
            end):catch(function(arg2)
                var1:warning("Failure in RobloxEventReceiver->{}, Status: {}", arg1.Type, tostring(arg2))
            end)
        end)
    end, dependencyArray(
        var6,
        var15,
        func9,
        var12.activeConversationId,
        var12.rnBypassActionSignal,
        removedFromConversationToastTitle,
        func3,
        func10,
        func1,
        var5,
        func5,
        func7
    ))

    local var19 = useMemo(function()
        if not var3 then
            return {}
        end

        return (Cryo.List.filterMap(Cryo.Dictionary.values(var3), function(arg1)
            return if arg1 and arg1.id and arg1.source ~= "friends" then arg1.id else nil
        end))
    end, { var3 })
    RealtimeDelivery.useRealtimeNamespace("ChatModerationTypeEligibility", function(arg1)
        var1:debug("Received ChatModerationTypeEligibility notification")
        local channelsInspected = arg1.channels_inspected
        if not channelsInspected or #channelsInspected == 0 then
            return
        end
        if getFFlagDebugUnfilteredThreads() then
            local str1 = ""
            for _, value in channelsInspected do
                str1 = `{str1}, {value}`
            end
            chunkAndLogString(`RTN CONVERSATIONS INSPECTED{str1}`)
        end

        local var20 = Cryo.List.filter(channelsInspected, function(arg2): number?
            return table.find(var19, arg2)
        end)
        if #var20 == 0 then
            var1:debug("No filtered existing conversation IDs found in ChatModerationTypeEligibility notification")

            return
        end
        if getFFlagDebugUnfilteredThreads() then
            local str1 = ""
            for _, value in var20 do
                str1 = `{str1}, {value}`
            end
            chunkAndLogString(`RTN FILTERED CONVERSATIONS{str1}`)
        end
        var10(multiGetConversationDetails(var20)):catch(function(arg2)
            var1:warning(
                "NetworkingChat failure in " .. "ChatEventReceiver->ChatModerationTypeEligibility->MultiGetConversationDetails, Status: " .. tostring(arg2)
            )
        end)

        if not var12.activeConversationId then
            return
        end
        if not table.find(channelsInspected, var12.activeConversationId) then
            return
        end

        var10(AppChatNetworking.rodux.GetConversationsParticipantsMetadata.API({ var12.activeConversationId })):catch(function(arg2)
            var1:warning(
                "NetworkingChat failure in " .. "ChatEventReceiver->ChatModerationTypeEligibility->GetConversationsParticipantsMetadata, Status: " .. tostring(arg2)
            )
        end)
        var10(refreshConversationUnfilteredThreadsDetails(var12.activeConversationId, var9))
    end, dependencyArray(var10, var12.activeConversationId, var19))

    RealtimeDelivery.useRealtimeNamespace("EligibilityStatusChanged", function(_)
        var1:info("Received EligibilityStatusChanged notification")

        var10(AppChatNetworking.rodux.GetChatLandingModal.API(var9)):catch(function(arg1)
            var1:warning(
                "NetworkingChat failure in ChatEventReceiver->EligibilityStatusChanged->GetChatLandingModal request. Status: {}",
                tostring(arg1)
            )
        end)
    end, dependencyArray(var10, var9))

    useChatTrustedConnectionsEvents({ activeConversationId = var12.activeConversationId })

    return {}
end

return ChatEventReceiver2
