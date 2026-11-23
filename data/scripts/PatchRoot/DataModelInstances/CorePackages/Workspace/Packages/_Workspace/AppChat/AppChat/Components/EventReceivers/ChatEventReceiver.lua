-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:21:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

if require(AppChatParent.SharedFlags).FFlagAppChatMigrateChatEventReceiver then
    return (require(script.Parent.ChatEventReceiver2))
end

local Localization = require(AppChatParent.Localization)
local React = require(AppChatParent.React)
local RoactNavigation = require(AppChatParent.RoactNavigation)
local RoactUtils = require(AppChatParent.RoactUtils)
local Cryo = require(AppChatParent.Cryo)
local AppChatNetworking = require(AppChatParent.AppChatNetworking)

local useCallback = React.useCallback
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useEffect = React.useEffect
local useLocalization = Localization.Hooks.useLocalization
local useMemo = React.useMemo
local useRef = React.useRef
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector

local FormFactor = require(AppChatParent.FormFactor).Enums.FormFactor
local var1 = require(AppChat.Logger):new("AppChat.Realtime")

local Conversation = require(AppChat.Models.Conversation)
local ConversationChannels = require(AppChat.Models.ConversationChannels)
local ChangedParticipants = require(AppChat.Conversations.Actions.ChangedParticipants)
local RoduxAliases = require(AppChat.Http.RoduxAliases)
local ReceivedUserTyping = require(AppChat.Conversations.Actions.ReceivedUserTyping)
local RemovedConversation = require(AppChat.Conversations.Actions.RemovedConversation)
local RenamedGroupConversation = require(AppChat.Conversations.Actions.RenamedGroupConversation)
local SetConnectionState = require(AppChat.Actions.SetConnectionState)
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
local _ChatMigrationTypes = require(script.Parent.ChatMigrationTypes)

local useChatTrustedConnectionsEvents = require(AppChat.Components.EventReceivers.useChatTrustedConnectionsEvents)
local getFFlagDebugUnfilteredThreads = require(AppChatParent.SharedFlags).getFFlagDebugUnfilteredThreads

local FFlagRemoveUnusedConnectionStateRoduxSlice = require(AppChatParent.SharedFlags).FFlagRemoveUnusedConnectionStateRoduxSlice
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

function ChatEventReceiver(tbl2)
    useEffect(function()
        var1:info("ChatEventReceiver mounted")
        return function()
            var1:info("ChatEventReceiver unmounted")
        end
    end, {})

    local var2 = if FFlagAppChatUseSignalsForAppLoaded then useSignalState(GetAppLoadedStore(false).getAppLoaded) else useSelector(useCallback(function(arg1)
        return arg1.ChatAppReducer.AppLoaded
    end, {}))

    local var3 = useSelector(useCallback(function(arg1)
        return arg1.ChatAppReducer.Conversations
    end, {}))
    local var4 = useSelector(useCallback(function(arg1)
        return arg1.FormFactor
    end, {}))
    local var5 = useSelector(useCallback(function(arg1)
        return arg1.Users
    end, {}))

    local var6 = Cryo.isEmpty(var3)
    local var7 = useLocalUserId()
    local var8 = useIsChatEnabled()
    local var9 = useIsGroupChatEnabled()
    local var10 = useIsInExperience()

    local var11 = useDispatch()
    local function func1(arg1, arg2, arg3, arg4) -- Luacid: Inlined by compiler; 2 call sites recovered
        var11(ChangedParticipants(arg1, arg2, arg3, arg4))
    end
    local function func2() -- Luacid: Inlined by compiler; 1 call site recovered
        return var11(fetchChatMetadata())
    end

    local function func3(arg1) -- Luacid: Inlined by compiler; 5 call sites recovered
        return var11(fetchLatestConversationDetails(arg1))
    end
    local function func4() -- Luacid: Inlined by compiler; 1 call site recovered
        var11(getAllFriendsAsync())
    end
    local var12 = not FFlagAppChatPresenceStoreMigration and function()
        spawn(function()
            var11(getAllUserPresences())
        end)
    end or nil

    local function func5(arg1, arg2, arg3) -- Luacid: Inlined by compiler; 4 call sites recovered
        return var11(getNewMessages(arg1, arg2, arg3))
    end

    local function restartMessageReceiveTracking(str1: string)
        if not FFlagAppChatPerfTracking then
            return
        end
        local tbl3 = {
            conversationId = tostring(str1)
        }

        if FFlagAppChatMessageTTIMilestones then
            AppChatPerfTracker.cancel(AppChatPerfTracker.Events.MessageReceiveTTI, tbl3)
            AppChatPerfTracker.start(AppChatPerfTracker.Events.MessageReceiveTTI, tbl3)
            return
        end
        AppChatPerfTracker.cancel(AppChatPerfTracker.Events.MessageReceiveToRender, tbl3)
        AppChatPerfTracker.start(AppChatPerfTracker.Events.MessageReceiveToRender, tbl3)
    end

    local function func6(str1: string, newAlias) -- Luacid: Inlined by compiler; 1 call site recovered
        var11(RoduxAliases.Actions.AliasUpdated(str1, newAlias))
    end
    local function func7(arg1, arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
        var11(ReceivedUserTyping(arg1, arg2))
    end

    local function func8() -- Luacid: Inlined by compiler; 2 call sites recovered
        var11(paginateAndRefreshConversations())
    end

    local function func9(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
        var11(RemovedConversation(arg1))
    end
    local function func10(arg1, arg2, arg3, arg4) -- Luacid: Inlined by compiler; 2 call sites recovered
        var11(RenamedGroupConversation(arg1, arg2, arg3, arg4))
    end
    local function func11(connectionState) -- Luacid: Inlined by compiler; 1 call site recovered
        var11(SetConnectionState(connectionState))
    end

    local var13 = Cryo.Dictionary.join(tbl1, tbl2)
    local robloxEventReceiver = var13.robloxEventReceiver

    local var14 = useRef({})
    local var15 = useRef(Enum.ConnectionState.Connected)

    local var16 = useLocalization({
        networkErrorText = "Feature.Toast.NetworkingError.SomethingIsWrong",
        removedFromConversationToastTitle = "Feature.Chat.Message.RemovedFromConversation"
    })

    local networkErrorText = var16.networkErrorText
    local removedFromConversationToastTitle = var16.removedFromConversationToastTitle

    local var17 = useCallback(function(str1: string, arg1)
        assert(var14.current, "table")
        var14.current[str1] = arg1
    end, { var14.current })

    local var18 = useCallback(function()
        if not var13.rnBypassActionSignal then
            return
        end

        var13.rnBypassActionSignal:fire(
            RoactNavigation.Actions.navigate({
                routeName = EnumScreens.RoactChatToast,
                params = {
                    toastProps = {
                        toastContent = { toastTitle = networkErrorText }
                    }
                }
            })
        )
    end, { var13.rnBypassActionSignal, networkErrorText })

    useEffect(function()
        local var19 = robloxEventReceiver:observeEvent("ChatNotifications", function(arg1, arg2, _)
            var17("ChatNotifications", arg1.SequenceNumber)
            local var19 = arg1.Type or arg2
            var1:info("Received chat notification: {}", var19)
            local var20 = if arg1.ConversationId then tostring(arg1.ConversationId) or "" else ""

            if var19 == "RemovedFromConversation" or var19 == "ConversationRemoved" then
                func9(var20)
                local activeConversationId = var13.activeConversationId
                if activeConversationId ~= nil and tostring(activeConversationId) == var20 and var13.rnBypassActionSignal then
                    var13.rnBypassActionSignal:fire(
                        RoactNavigation.Actions.navigate(
                            {
                                routeName = var4 == FormFactor.WIDE and EnumScreens.EmptyConversation or EnumScreens.ChatLanding
                            }
                        )
                    )
                end

                if var19 == "RemovedFromConversation" then
                    var13.rnBypassActionSignal:fire(
                        RoactNavigation.Actions.navigate({
                            routeName = EnumScreens.RoactChatToast,
                            params = {
                                toastProps = {
                                    toastContent = {
                                        toastTitle = removedFromConversationToastTitle
                                    }
                                }
                            }
                        })
                    )
                end

                return
            end

            if var19 == "ConversationTitleChanged" or var19 == "ParticipantAdded" or var19 == "ParticipantLeft" then
                task.spawn(function()
                    func3(var20):andThen(function(arg3)
                        local title = arg3.title
                        local lastUpdated = arg3.lastUpdated

                        if var19 == "ConversationTitleChanged" then
                            func10(var20, title, arg3.isDefaultTitle, lastUpdated)
                            return
                        end

                        func1(var20, arg3.participants, title, lastUpdated)
                    end):catch(function(arg3)
                        var1:warning(`NetworkingChat failure in RobloxEventReceiver->{var19}, Status: {tostring(arg3)}`)
                    end)
                end)

                return
            end

            if var19 == "AddedToConversation" or var19 == "NewConversation" then
                if var6 then
                    var1:debug(`Received {var19} event while loading conversation data`)
                    return
                end

                task.spawn(function()
                    func3(var20):catch(function(arg3)
                        var1:warning(`NetworkingChat failure in RobloxEventReceiver->{var19}, Status: {tostring(arg3)}`)
                    end)
                end)

                return
            end

            if var19 == "NewMessage" then
                if FFlagAppChatPerfTracking and var13.activeConversationId and tostring(var13.activeConversationId) == var20 then
                    restartMessageReceiveTracking(var20)
                end

                func5(var20, false, (tick()))
                return
            elseif var19 == "NewMessageBySelf" then
                func5(var20, true, (tick()))
                return
            end
            if var19 == "ParticipantTyping" then
                local userId = arg1.UserId
                func7(var20, tostring(userId))
            end
        end)

        return function()
            if var19 and var19.disconnect then
                var19:disconnect()
            end
        end
    end, {
        var11,
        var17,
        var13.activeConversationId,
        var13.rnBypassActionSignal,
        var6,
        var4,
        var5
    })

    useEffect(function()
        if not var8 and var13.activeConversationId and var13.rnBypassActionSignal then
            var1:debug("Chat is disabled for our user, navigating away from active conversation")
            var13.rnBypassActionSignal:fire(
                RoactNavigation.Actions.navigate(
                    {
                        routeName = var4 == FormFactor.WIDE and EnumScreens.EmptyConversation or EnumScreens.ChatLanding
                    }
                )
            )
        end
    end, { var8 })

    local var19 = if var13.activeConversationId then var3[var13.activeConversationId] else nil

    useEffect(function()
        if not var9 and var19 and var13.rnBypassActionSignal and var19.type == "group" then
            var1:debug("Group chats are disabled and we are navigated to a group chat. Navigating to ChatLanding")

            var13.rnBypassActionSignal:fire(
                RoactNavigation.Actions.navigate(
                    {
                        routeName = var4 == FormFactor.WIDE and EnumScreens.EmptyConversation or EnumScreens.ChatLanding
                    }
                )
            )
        end
    end, { var9, var19 })

    useEffect(function()
        local var20 = robloxEventReceiver:observeEvent("UserTagChangeNotification", function(arg1, _)
            if arg1.Type == "UserTagUpdate" then
                local userId = arg1.UserId
                func6(tostring(userId), arg1.NewAlias)
            end
        end)

        return function()
            if var20 and var20.disconnect then
                var20:disconnect()
            end
        end
    end, { var11 })

    useEffect(function()
        local var20 = robloxEventReceiver:observeEvent("FriendshipNotifications", function(arg1, _)
            local type = arg1.Type
            var1:info("Received friendship notification: {}", type)

            if type == "FriendshipCreated" then
                func8()
                return
            end

            if type ~= "FriendshipDestroyed" then
                return
            end

            local var20 = nil
            if arg1.EventArgs then
                local str1 = tostring(arg1.EventArgs.UserId1)
                local str2 = tostring(arg1.EventArgs.UserId2)
                if str1 == var7 then
                    str1 = "localUserId"
                    var20 = str2
                end
                if str2 == var7 then
                    str2 = "localUserId"
                    var20 = str1
                end

                var11(FriendshipDestroyed({ userId1 = str1, userId2 = str2 }))
            end

            if var19
                and var19.source == "friends"
                and var19.conversationType == Conversation.Type.ONE_TO_ONE_CONVERSATION
                and Cryo.List.findWhere(var19.participants, function(arg2): boolean
                    return arg2 == var20
                end)
            then
                local routeName = if var4 == FormFactor.WIDE then EnumScreens.EmptyConversation else EnumScreens.ChatLanding
                var13.rnBypassActionSignal:fire(RoactNavigation.Actions.navigate({ routeName = routeName }))
            end
        end)

        return function()
            if var20 and var20.disconnect then
                var20:disconnect()
            end
        end
    end, {
        var11,
        func8,
        var7,
        var4,
        var19,
        var13.rnBypassActionSignal
    })

    useEffect(function()
        local var20 = robloxEventReceiver:observeEvent("ChatMigration", function(arg1, _)
            local type = arg1.Type
            var1:info("Received chat migration notification: {}", type)
            local var20, var21

            if type == "ConversationBackfilled" then
                var20 = arg1.ConversationId
                var21 = arg1.ChannelId
            else
                if type ~= "ConversationReset" then
                    var1:warning(`ChatEventReceiver: unknown notification {type}`)
                    return
                end

                var20 = arg1.ChannelId
                var21 = arg1.ConversationId
            end

            var11(RemovedConversation(var20))

            func3(var21):catch(function(arg2)
                var1:warning(`NetworkingChat failure in RobloxEventReceiver->{type}, Status: {tostring(arg2)}`)
            end)

            if not var13.activeConversationId
                or not var20
                or tostring(var13.activeConversationId) ~= var20
                or not var13.rnBypassActionSignal
            then
                return
            end
            var13.rnBypassActionSignal:fire(
                RoactNavigation.Actions.navigate({ routeName = EnumScreens.ChatConversation, params = { conversationId = var21 } })
            )
        end)

        return function()
            if var20 and var20.disconnect then
                var20:disconnect()
            end
        end
    end, {
        var11,
        var13.activeConversationId,
        var13.rnBypassActionSignal,
        func3
    })

    local var20 = useCallback(function()
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
                var12()
            end
        end)
    end, {
        var2,
        func8,
        func4,
        var12,
        func2
    })
    useEffect(function()
        local var21 = robloxEventReceiver:observeEvent("signalR", function(connectionState, _, arg1)
            var1:info("SignalR connection state transitioned to {}", tostring(connectionState))

            if not FFlagRemoveUnusedConnectionStateRoduxSlice then
                func11(connectionState)
            end

            var15.current = connectionState

            if connectionState == Enum.ConnectionState.Connected
                and arg1
                and (var14.current == nil
                    or var14.current.ChatNotifications ~= arg1.ChatNotifications
                    or var14.current.CommunicationChannels ~= arg1.CommunicationChannels)
            then
                var1:trace(
                    "We missed some messages while we were disconnected. The chat app was previously {}",
                    if var2 then "loaded" else "unloaded"
                )
                var20()
            end
        end)

        return function()
            if var21 and var21.disconnect then
                var21:disconnect()
            end
        end
    end, {
        var11,
        var15,
        var14,
        var18,
        var2
    })
    useEffect(function()
        local var21 = robloxEventReceiver:observeEvent("CommunicationChannels", function(arg1, _)
            if arg1.ChannelVertical ~= "PlatformChat"
                or not table.find(CommunicationChannelsTypes.ChannelTypeAllowlist, arg1.ChannelType)
            then
                return
            end

            var1:info("Received channels notification: {}", arg1.Type)

            var17("CommunicationChannels", arg1.SequenceNumber)

            local channelId = arg1.ChannelId

            if arg1.Type == "ChannelDeleted" or arg1.Type == "RemovedFromChannel" or arg1.Type == "ChannelArchived" then
                func9(channelId)
                local activeConversationId = var13.activeConversationId
                if activeConversationId ~= nil and tostring(activeConversationId) == arg1.ChannelId and var13.rnBypassActionSignal then
                    local routeName = if var4 == FormFactor.WIDE then EnumScreens.EmptyConversation else EnumScreens.ChatLanding
                    var13.rnBypassActionSignal:fire(RoactNavigation.Actions.navigate({ routeName = routeName }))
                end

                if arg1.Actor.Id ~= tostring(var7) then
                    var13.rnBypassActionSignal:fire(
                        RoactNavigation.Actions.navigate({
                            routeName = EnumScreens.RoactChatToast,
                            params = {
                                toastProps = {
                                    toastContent = {
                                        toastTitle = removedFromConversationToastTitle
                                    }
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
                    func5(channelId, arg1.Actor.Id == tostring(var7), (tick()))
                    return
                end

                local bool1 = arg1.Actor.Id == tostring(var7)
                if not bool1 and var13.activeConversationId and tostring(var13.activeConversationId) == channelId then
                    restartMessageReceiveTracking(channelId)
                end

                func5(channelId, bool1, (tick()))
                return
            end

            if var6 then
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

                    var11(FriendConversationCreated({ newConversationId = arg2.id, oldFriendConversationId = oldFriendConversationId }))

                    if var13.activeConversationId ~= oldFriendConversationId then
                        return
                    end

                    var13.rnBypassActionSignal:fire(
                        RoactNavigation.Actions.navigate({ routeName = EnumScreens.ChatConversation, params = { conversationId = arg2.id } })
                    )
                end):catch(function(arg2)
                    var1:warning("Failure in RobloxEventReceiver->{}, Status: {}", arg1.Type, tostring(arg2))
                end)
            end)
        end)

        return function()
            if var21 and var21.disconnect then
                var21:disconnect()
            end
        end
    end, {
        var7,
        robloxEventReceiver,
        var17,
        func9,
        var13.activeConversationId,
        var13.rnBypassActionSignal,
        removedFromConversationToastTitle,
        func3,
        func10,
        func1,
        var6,
        func5,
        func7,
        var20
    })

    local var21 = useMemo(function()
        if not var3 then
            return {}
        end

        return (Cryo.List.filterMap(Cryo.Dictionary.values(var3), function(arg1)
            return if arg1 and arg1.id and arg1.source ~= "friends" then arg1.id else nil
        end))
    end, { var3 })
    useEffect(function()
        local var22 = robloxEventReceiver:observeEvent("ChatModerationTypeEligibility", function(arg1, _)
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

            local var22 = Cryo.List.filter(channelsInspected, function(arg2): number?
                return table.find(var21, arg2)
            end)
            if #var22 == 0 then
                var1:debug("No filtered existing conversation IDs found in ChatModerationTypeEligibility notification")

                return
            end
            if getFFlagDebugUnfilteredThreads() then
                local str1 = ""
                for _, value in var22 do
                    str1 = `{str1}, {value}`
                end
                chunkAndLogString(`RTN FILTERED CONVERSATIONS{str1}`)
            end
            var11(multiGetConversationDetails(var22)):catch(function(arg2)
                var1:warning(
                    "NetworkingChat failure in " .. "ChatEventReceiver->ChatModerationTypeEligibility->MultiGetConversationDetails, Status: " .. tostring(arg2)
                )
            end)

            if not var13.activeConversationId then
                return
            end
            if not table.find(channelsInspected, var13.activeConversationId) then
                return
            end

            var11(AppChatNetworking.rodux.GetConversationsParticipantsMetadata.API({ var13.activeConversationId })):catch(function(arg2)
                var1:warning(
                    "NetworkingChat failure in " .. "ChatEventReceiver->ChatModerationTypeEligibility->GetConversationsParticipantsMetadata, Status: " .. tostring(arg2)
                )
            end)
            var11(refreshConversationUnfilteredThreadsDetails(var13.activeConversationId, var10))
        end)

        return function()
            if var22 and var22.disconnect then
                var22:disconnect()
            end
        end
    end, { var11, var13.activeConversationId, var21 })

    useEffect(function()
        local var22 = robloxEventReceiver:observeEvent("EligibilityStatusChanged", function(_, _)
            var1:info("Received EligibilityStatusChanged notification")

            var11(AppChatNetworking.rodux.GetChatLandingModal.API(var10)):catch(function(arg1)
                var1:warning("Error in GetChatLandingModal request. Error: {}", tostring(arg1))
            end)
        end)

        return function()
            if var22 and var22.disconnect then
                var22:disconnect()
            end
        end
    end, { var11 })

    useChatTrustedConnectionsEvents({ activeConversationId = var13.activeConversationId })

    return {}
end

return ChatEventReceiver
