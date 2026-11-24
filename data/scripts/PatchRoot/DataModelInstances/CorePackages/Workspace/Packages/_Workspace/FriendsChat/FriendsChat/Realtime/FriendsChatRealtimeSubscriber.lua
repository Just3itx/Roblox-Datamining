-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:21:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent
local Players = game:GetService("Players")

local React = require(FriendsChatParent.React)
local RealtimeDelivery = require(FriendsChatParent.RealtimeDelivery)
local ExpChatShared = require(FriendsChatParent.ExpChatShared)

local ConversationChannels = require(FriendsChatParent.AppChat.ConversationChannels)
local fetchNewerMessages = require(FriendsChatParent.AppChat.fetchNewerMessages)
local GetConversationMessageListStore = require(FriendsChatParent.AppChat.GetConversationMessageListStore)

local classifyCommunicationChannelsEvent = require(script.Parent.classifyCommunicationChannelsEvent)
local ExpChatConversationListAdapter = require(script.Parent.Parent.ConversationList.ExpChatConversationListAdapter)
local GetFriendsChatNavigationStore = require(script.Parent.Parent.Stores.GetFriendsChatNavigationStore)
local GetFriendsChatRealtimeStore = require(script.Parent.Parent.Stores.GetFriendsChatRealtimeStore)
local FStringDebugFriendsChatConversationId = require(script.Parent.Parent.Flags.FStringDebugFriendsChatConversationId)

local var1 = ExpChatShared.Logger:new(script.Name)

local FriendshipNotifications = require(script.Parent.FriendshipNotifications)

local function fetchNewerMessagesSafe(str1: string, callback: ((...any) -> (...any))?)
    local var2 = ExpChatConversationListAdapter.getConversationStore().getConversation(str1, false)
    local lastUpdated = var2 and var2.lastUpdated

    local tbl1 = ({})
    for _, value in GetConversationMessageListStore(false).getOrderedIds(str1, false) do
        tbl1[value] = true
    end

    fetchNewerMessages(str1):andThen(function(arg1)
        local response = arg1 and arg1.response
        local responseBody = response and response.responseBody
        local var3 = not responseBody and {} or responseBody.messages or {}
        local ingestedIds = arg1 and arg1.ingestedIds
        local friendsChatRealtimeStore = GetFriendsChatRealtimeStore(false)
        local activeConversationId = friendsChatRealtimeStore.getActiveConversationId(false)
        local localPlayer = Players.LocalPlayer
        local hasUnreadMessages = activeConversationId ~= str1

        local _, var4 = ExpChatConversationListAdapter.updateConversationPreviewFromMessages(str1, var3, {
            hasUnreadMessages = hasUnreadMessages,
            localUserId = if localPlayer then localPlayer.UserId else 0,
            refreshListOnMissingConversation = true,
            unreadFreshnessLastUpdated = lastUpdated
        })

        if var4 then
            friendsChatRealtimeStore.addLocalUnread(str1)
        end
        if activeConversationId ~= str1 then
            return
        end

        ExpChatConversationListAdapter.markConversationRead(str1, true)
        if callback == nil then
            return
        end

        local bool2 = false
        if ingestedIds ~= nil then
            for _, ingestedId in ingestedIds do
                if not tbl1[ingestedId] then
                    bool2 = true
                    break
                end
            end
        end

        if bool2 then
            callback()
        end
    end):catch(function(arg1)
        var1:warning(`Failed to fetch newer messages for {str1}: {tostring(arg1)}`)
    end)
end

local function getFirstConversationResponse(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local var2 = if arg1 == nil then nil else arg1.responseBody or arg1
    local conversations = var2 and var2.conversations
    return if conversations == nil then nil else conversations[1]
end

local function updateSelectedFriendPlaceholder(channelId: string, arg1)
    local firstConversationResponse = getFirstConversationResponse(arg1)

    if firstConversationResponse == nil
        or firstConversationResponse.source ~= ConversationChannels.Source.Channels
        or firstConversationResponse.type ~= ConversationChannels.Type.OneToOne
        or firstConversationResponse.participant_user_ids == nil
    then
        return
    end

    local friendConversationId = ConversationChannels.getFriendConversationId(firstConversationResponse.participant_user_ids)
    local friendsChatNavigationStore = GetFriendsChatNavigationStore(false)
    if friendsChatNavigationStore.getSelectedConversationId(false) == friendConversationId then
        friendsChatNavigationStore.setSelectedConversationId(firstConversationResponse.id or channelId)
    end
end

local function fetchConversationDetailsSafe(channelId: string, bool1: boolean, callback: (...any) -> (...any))
    ExpChatConversationListAdapter.fetchConversationDetailsToSignals(channelId):andThen(function(arg1)
        if bool1 and getFirstConversationResponse(arg1) == nil then
            callback(`new conversation {channelId}`)
            return
        end
        updateSelectedFriendPlaceholder(channelId, arg1)
    end):catch(function(arg1)
        var1:warning(`Failed to fetch conversation details for {channelId}: {tostring(arg1)}`)
    end)
end

local function handleRemove(channelId: string) -- Luacid: Inlined by compiler; 1 call site recovered
    ExpChatConversationListAdapter.removeConversation(channelId)
    local friendsChatNavigationStore = GetFriendsChatNavigationStore(false)
    if friendsChatNavigationStore.getSelectedConversationId(false) == channelId then
        friendsChatNavigationStore.setSelectedConversationId(nil)
    end
end

local function FriendsChatRealtimeSubscriber(tbl1)
    local onActiveConversationMessageReceived = tbl1.onActiveConversationMessageReceived

    local var2 = React.useRef(false)
    local var3 = React.useRef(0)

    local function requestConversationListRefresh(str1: string)
        var2.current = true
        local var4 = var3
        var4.current += 1
        local current = var3.current

        local function attempt(num1: number)
            if var3.current ~= current then
                return
            end

            if ExpChatConversationListAdapter.getConversationStore().getListStatus(false).isFetchingConversations == true then
                if num1 <= 0 then
                    var2.current = false
                    var1:warning(`Gave up refreshing conversation list after {str1}: fetch still in flight`)
                    return
                end
                task.delay(1, function()
                    attempt(num1 - 1)
                end)
            elseif var2.current then
                var2.current = false

                ExpChatConversationListAdapter.fetchConversationListPageToSignals():catch(function(arg1)
                    var1:warning(`Failed to refresh conversation list after {str1}: {tostring(arg1)}`)
                end)
            end
        end
        attempt(3)
    end

    RealtimeDelivery.useRealtimeNamespace("CommunicationChannels", function(arg1)
        local var4 = classifyCommunicationChannelsEvent(arg1)
        local channelId = var4.channelId
        if channelId == nil then
            return
        end

        if var4.kind == "fetchMessage" then
            fetchNewerMessagesSafe(channelId, onActiveConversationMessageReceived)
        elseif var4.kind == "removeConversation" then
            handleRemove(channelId)
        elseif var4.kind == "fetchConversationDetails" then
            fetchConversationDetailsSafe(
                channelId,
                arg1.Type == "AddedToChannel" or arg1.Type == "ChannelCreated",
                requestConversationListRefresh
            )
        end
    end, {})

    RealtimeDelivery.useRealtimeConnectionStateChanged("CommunicationChannels", function(connectionState, bool1: boolean)
        if connectionState ~= Enum.ConnectionState.Connected or not bool1 then
            return
        end
        local var4 = GetFriendsChatRealtimeStore(false).getActiveConversationId(false) or FStringDebugFriendsChatConversationId
        if var4 ~= "" then
            fetchNewerMessagesSafe(var4, onActiveConversationMessageReceived)
        end
    end, {})

    RealtimeDelivery.useRealtimeNamespace(FriendshipNotifications.Namespace, function(arg1)
        if arg1 == nil or arg1.Type ~= FriendshipNotifications.EventType.Created then
            return
        end
        var1:info(`Received friendship notification: {arg1.Type}`)
        var2.current = true
        local var4 = var3
        var4.current += 1
        local current = var3.current

        local str1 = "friendship update"

        local function attempt(num1: number)
            if var3.current ~= current then
                return
            end

            if ExpChatConversationListAdapter.getConversationStore().getListStatus(false).isFetchingConversations == true then
                if num1 <= 0 then
                    var2.current = false
                    var1:warning(`Gave up refreshing conversation list after {str1}: fetch still in flight`)
                    return
                end
                task.delay(1, function()
                    attempt(num1 - 1)
                end)
            elseif var2.current then
                var2.current = false

                ExpChatConversationListAdapter.fetchConversationListPageToSignals():catch(function(arg2)
                    var1:warning(`Failed to refresh conversation list after {str1}: {tostring(arg2)}`)
                end)
            end
        end
        attempt(3)
    end, {})

    React.useEffect(function()
        return function()
            local var4 = var3
            var4.current += 1
        end
    end, {})

    return nil
end

return FriendsChatRealtimeSubscriber
