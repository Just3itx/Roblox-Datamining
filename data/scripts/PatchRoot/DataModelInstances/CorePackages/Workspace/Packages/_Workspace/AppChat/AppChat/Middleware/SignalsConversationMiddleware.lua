-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local Cryo = require(AppChatParent.Cryo)
local SignalsExperimental = require(AppChatParent.SignalsExperimental)

local Constants = require(AppChat.Constants)
local Conversations = require(AppChat.Conversations)
local ConversationChannels = require(AppChat.Models.ConversationChannels)
local Conversation = require(AppChat.Models.Conversation)
local GetConversationMessageViewModelStore = require(AppChat.Stores.GetConversationMessageViewModelStore)
local GetConversationListStore = require(AppChat.Stores.GetConversationListStore)
local GetConversationStore = require(AppChat.Stores.GetConversationStore)
local GetConversationSearchDataHydration = require(AppChat.Stores.GetConversationSearchDataHydration)
local searchIntroducedConversationIds = require(AppChat.Stores.searchIntroducedConversationIds)
local NetworkingBlocking = require(AppChat.Http.NetworkingBlocking)
local NetworkingChat = require(AppChat.Http.NetworkingChat)
local getMessageSentUnixSeconds = require(AppChat.Utils.getMessageSentUnixSeconds)
local getUnixTimestampMillis = require(AppChat.Utils.getUnixTimestampMillis)
local getUnixTimestampSeconds = require(AppChat.Utils.getUnixTimestampSeconds)
local _Types = require(AppChat.AppChatData.Types)
local findNewestPreviewableMessage = require(AppChat.AppChatData.Conversations.findNewestPreviewableMessage)
local hasPreviewableMessageNewerThan = require(AppChat.AppChatData.Conversations.hasPreviewableMessageNewerThan)
local shouldMarkUnread = require(AppChat.AppChatData.Unread.shouldMarkUnread)

local ChangedParticipants = require(AppChat.Conversations.Actions.ChangedParticipants)
local ConversationModerationTypeChanged = require(AppChat.Conversations.Actions.ConversationModerationTypeChanged)
local FriendConversationCreated = require(AppChat.Conversations.Actions.FriendConversationCreated)
local FriendshipDestroyed = require(AppChat.Actions.FriendshipDestroyed)
local ReceivedChannelsMigrationConflict = require(AppChat.Conversations.Actions.ReceivedChannelsMigrationConflict)
local ReceivedConversation = require(AppChat.Conversations.Actions.ReceivedConversation)
local ReceivedPageConversations = require(AppChat.Conversations.Actions.ReceivedPageConversations)
local RemovedConversation = require(AppChat.Conversations.Actions.RemovedConversation)
local RenamedGroupConversation = require(AppChat.Conversations.Actions.RenamedGroupConversation)
local RequestPageConversations = require(AppChat.Conversations.Actions.RequestPageConversations)
local ReceivedMessages = Conversations.Actions.ReceivedMessages
local SetUserTyping = require(AppChat.Conversations.Actions.SetUserTyping)

local FFlagAppChatConversationStore = require(AppChat.Flags.FFlagAppChatConversationStore)
local FFlagAppChatConversationLoadRetry = require(AppChat.Flags.FFlagAppChatConversationLoadRetry)
local FFlagAppChatAnyServerSideConversationSearch = require(AppChat.Flags.FFlagAppChatAnyServerSideConversationSearch)
local bool1 = game:DefineFastFlag("AppChatBatchConversationPageUpsert", false)

local FFlagAppChatDerivedConversationLatestActivity = require(AppChat.Flags.FFlagAppChatDerivedConversationLatestActivity)

local tbl1 = {
    [Constants.OptInVariant.OsaContextCard] = {
        field = "osaAcknowledgementStatus",
        value = ConversationChannels.OsaAcknowledgementStatus.Acknowledged
    },
    [Constants.OptInVariant.ChatOptInInfoCard] = {
        field = "userOptedIntoChatMessages",
        value = ConversationChannels.UserOptedIntoChatMessagesStatus.OptedIn
    }
}

local function upsertConversationResponse(arg1, arg2)
    if arg2 == nil or arg2.status == "failed" then
        return
    end
    local channelsApi = ConversationChannels.fromChannelsApi(arg2)

    if not FFlagAppChatAnyServerSideConversationSearch then
        arg1.upsertConversation(channelsApi)

        return
    end

    SignalsExperimental.batch(function()
        arg1.upsertConversation(channelsApi)
        searchIntroducedConversationIds.remove(channelsApi.id)
    end)
end

local function upsertConversationResponses(arg1, responseBody)
    if responseBody == nil or responseBody.conversations == nil then
        return
    end

    if bool1 then
        SignalsExperimental.batch(function()
            for _, conversation in responseBody.conversations do
                upsertConversationResponse(arg1, conversation)
            end
        end)
    else
        for _, conversation in responseBody.conversations do
            upsertConversationResponse(arg1, conversation)
        end
    end
end

local function updateConversation(arg1, str1: string?, tbl2) -- Luacid: Inlined by compiler; 8 call sites recovered
    if str1 == nil then
        return
    end
    local conversation = arg1.getConversation(str1, false)
    if conversation == nil then
        return
    end
    arg1.upsertConversation(Cryo.Dictionary.join(conversation, tbl2), false)
end

local function getNewestMessageUnixSeconds(str1: string?)
    if str1 == nil then
        return 0
    end

    local conversationMessageViewModelStore = GetConversationMessageViewModelStore(false)

    local var1 = conversationMessageViewModelStore.conversationMessageListStore.getOrderedIds(str1, false)[1]
    local message = var1 and conversationMessageViewModelStore.conversationMessageStore.getMessage(var1, false)
    return message and getMessageSentUnixSeconds(message) or 0
end

local function shouldMarkConversationUnreadFromMessages(str1: string?, tbl2)
    if tbl2 == nil then
        return false
    end

    return shouldMarkUnread(tbl2, getNewestMessageUnixSeconds(str1), tostring(Players.LocalPlayer.UserId))
end

local function getPreviewMessageUnixSeconds(conversation) -- Luacid: Inlined by compiler; 1 call site recovered
    if conversation.previewMessageId == nil then
        return 0
    end

    local var1 = GetConversationMessageViewModelStore(false).conversationMessageStore.getMessage(conversation.previewMessageId, false)
    return var1 and getMessageSentUnixSeconds(var1) or 0
end

local function updateConversationLastUpdatedFromMessages(arg1, str1: string?, tbl2, bool2: boolean?)
    if str1 == nil or tbl2 == nil then
        return
    end

    local conversation = arg1.getConversation(str1, false)
    if conversation == nil then
        return
    end

    local newestPreviewableMessage = findNewestPreviewableMessage(tbl2, (getPreviewMessageUnixSeconds(conversation)))
    local unixTimestampSeconds = getUnixTimestampSeconds(conversation.lastUpdated) or 0

    if newestPreviewableMessage == nil then
        if bool2 then
            updateConversation(arg1, str1, { hasUnreadMessages = true })
        end

        return
    end

    local tbl3 = {
        previewMessageId = newestPreviewableMessage.messageId
    }
    if unixTimestampSeconds < newestPreviewableMessage.sentUnixSeconds then
        tbl3.lastUpdated = newestPreviewableMessage.sentDateTime

        if FFlagAppChatAnyServerSideConversationSearch then
            searchIntroducedConversationIds.remove(str1)
        end
    end
    if bool2 then
        tbl3.hasUnreadMessages = true
    end

    updateConversation(arg1, str1, tbl3)
end

local function updateConversationFromMessages(arg1, str1: string?, tbl2, bool2: boolean?)
    if str1 == nil or tbl2 == nil then
        return
    end

    local conversation = arg1.getConversation(str1, false)
    if conversation == nil then
        return
    end

    local bool3

    if FFlagAppChatAnyServerSideConversationSearch
        and searchIntroducedConversationIds.has(str1)
        and hasPreviewableMessageNewerThan(tbl2, getUnixTimestampMillis(conversation.lastUpdated) or 0)
    then
        searchIntroducedConversationIds.remove(str1)
        bool3 = true
    else
        bool3 = false
    end

    local tbl3 = {}
    if bool2 then
        tbl3.hasUnreadMessages = true
    end

    if bool3 or bool2 then
        updateConversation(arg1, str1, tbl3)
    end
end

local function handleCreateConversationSucceeded(arg1, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
    local responseBody = arg1.responseBody
    local conversation = responseBody and responseBody.conversations and responseBody.conversations[1]
    upsertConversationResponse(arg2, conversation)

    if FFlagAppChatAnyServerSideConversationSearch then
        GetConversationSearchDataHydration(false).invalidate()
    end
end

local function isInitialConversationPage(arg1): boolean -- Luacid: Inlined by compiler; 5 call sites recovered
    local queryArgs = if arg1 == nil then nil else arg1.queryArgs

    if type(queryArgs) ~= "table" then
        return true
    end
    if queryArgs.pageNumber ~= nil then
        return queryArgs.pageNumber == 1
    end
    local cursor = queryArgs.cursor
    return cursor == nil or cursor == ""
end

local function applyConversationLoadSuccessStatus(arg1, tbl2: {isFetchingConversations: boolean}) -- Luacid: Inlined by compiler; 2 call sites recovered
    if not FFlagAppChatConversationLoadRetry then
        return
    end
    tbl2.error = Cryo.None
    tbl2.isFetchingNextPage = false

    if isInitialConversationPage(arg1) then
        tbl2.hasFetchedInitialPage = true
    end
end

local function applyConversationLoadFailureStatus(arg1, tbl2: {isFetchingConversations: boolean}) -- Luacid: Inlined by compiler; 1 call site recovered
    if not FFlagAppChatConversationLoadRetry then
        return
    end
    tbl2.isFetchingNextPage = false

    if isInitialConversationPage(arg1) then
        tbl2.error = arg1 == nil or arg1.error == nil or arg1.error
    end
end

local function handleGetUserConversationsFailed(arg1, arg2)
    local tbl2 = { isFetchingConversations = false }
    applyConversationLoadFailureStatus(arg1, tbl2)
    arg2.setListStatus(tbl2)
end

local function handleGetConversationDetailsSucceeded(arg1, arg2)
    upsertConversationResponses(arg2, arg1.responseBody)
end

local tbl2 = {
    [AppChatNetworking.rodux.CreateConversation.Succeeded.name] = handleCreateConversationSucceeded
}

tbl2[AppChatNetworking.rodux.DuplicateConversation.Succeeded.name] = function(arg1, arg2) -- name: handleDuplicateConversationSucceeded
    handleCreateConversationSucceeded(arg1, arg2)
end

tbl2[AppChatNetworking.rodux.GetUserConversations.Succeeded.name] = function(arg1, arg2) -- name: handleGetUserConversationsSucceeded
    upsertConversationResponses(arg2, arg1.responseBody)
    local nextCursor = arg1.responseBody and arg1.responseBody.next_cursor
    local tbl3 = { isFetchingConversations = false }

    if nextCursor == nil or nextCursor == "" then
        tbl3.oldestConversationIsFetched = true
    end

    applyConversationLoadSuccessStatus(arg1, tbl3)
    arg2.setListStatus(tbl3)
end

tbl2[AppChatNetworking.rodux.GetUserConversations.Failed.name] = handleGetUserConversationsFailed
tbl2[AppChatNetworking.rodux.GetConversationDetails.Succeeded.name] = handleGetConversationDetailsSucceeded
tbl2[AppChatNetworking.rodux.MultiGetConversationDetails.Succeeded.name] = handleGetConversationDetailsSucceeded

tbl2[AppChatNetworking.rodux.MarkConversation.Succeeded.name] = function(arg1, arg2) -- name: handleMarkConversationSucceeded
    local conversationIds = arg1.postBody and arg1.postBody.conversation_ids
    if conversationIds == nil then
        return
    end
    for _, conversationId in conversationIds do
        updateConversation(arg2, conversationId, { hasUnreadMessages = false })
    end
end

tbl2[AppChatNetworking.rodux.GetConversationsParticipantsMetadata.Succeeded.name] = function(arg1, arg2) -- name: handleParticipantMetadataSucceeded
    local responseBody = arg1.responseBody
    if responseBody == nil or responseBody.conversation_participants_metadata == nil then
        return
    end

    for value, value2 in responseBody.conversation_participants_metadata do
        local tbl3 = ({})
        for value3, value4 in value2.participants_metadata do
            local tbl4 = {
                isPending = value4.is_pending,
                isBlocked = value4.is_blocked,
                isInviter = value4.is_inviter,
                isInvited = value4.is_invited
            }
            tbl3[value3] = tbl4
        end

        arg2.setParticipantMetadata(value, tbl3)
    end
end

tbl2[AppChatNetworking.rodux.RecordModalSequenceResponse.Succeeded.name] = function(arg1, arg2) -- name: handleRecordModalSequenceResponseSucceeded
    local postBody = arg1.postBody
    if postBody == nil or postBody.action_type ~= Constants.ModalAction.Accept then
        return
    end
    local var1 = tbl1[postBody.modal_variant]
    if var1 == nil then
        return
    end

    local var2 = postBody.conversation_id or ConversationChannels.getFriendConversationId({ postBody.friend_id })
    local tbl3 = {
        [var1.field] = var1.value
    }
    updateConversation(arg2, var2, tbl3)
end

tbl2[NetworkingChat.GetUserConversations.Succeeded.name] = function(arg1, arg2) -- name: handleLegacyGetUserConversationsSucceeded
    local responseBody = arg1.responseBody
    if responseBody == nil then
        return
    end
    for _, value in ipairs(responseBody) do
        arg2.upsertConversation(Conversation.fromWeb(value))
    end
    local tbl3 = { isFetchingConversations = false }
    applyConversationLoadSuccessStatus(arg1, tbl3)
    arg2.setListStatus(tbl3)
    local pageSize = arg1.queryArgs and arg1.queryArgs.pageSize
    if pageSize ~= nil and #responseBody < pageSize then
        arg2.setListStatus({ oldestConversationIsFetched = true })
    end
end

tbl2[NetworkingChat.GetUserConversations.Failed.name] = handleGetUserConversationsFailed

tbl2[NetworkingBlocking.BlockUserById.Succeeded.name] = function(arg1, arg2) -- name: handleBlockUserByIdSucceeded
    local users = arg1.namedIds and arg1.namedIds.users
    if users == nil then
        return
    end
    local str1 = tostring(users)

    for _, value in arg2.getConversations(false) do
        local var1 = value.participants or {}
        if value.type == ConversationChannels.Type.OneToOne and table.find(var1, str1) then
            arg2.removeConversation(value.id)
        end
    end
    arg2.removeConversation(ConversationChannels.getFriendConversationId({ str1 }))
end

tbl2[ReceivedConversation.name] = function(arg1, arg2) -- name: handleReceivedConversation
    arg2.upsertConversation(arg1.conversation)
end

tbl2[ReceivedMessages.name] = function(arg1, arg2) -- name: handleReceivedMessages
    if FFlagAppChatDerivedConversationLatestActivity then
        updateConversationFromMessages(arg2, arg1.conversationId, arg1.messages, arg1.shouldMarkConversationUnread)

        return
    end
    updateConversationLastUpdatedFromMessages(arg2, arg1.conversationId, arg1.messages, arg1.shouldMarkConversationUnread)
end

tbl2[RemovedConversation.name] = function(arg1, arg2) -- name: handleRemovedConversation
    if arg1.conversationId then
        arg2.removeConversation(arg1.conversationId)
    end
end

tbl2[RenamedGroupConversation.name] = function(arg1, arg2) -- name: handleRenamedGroupConversation
    updateConversation(
        arg2,
        arg1.conversationId,
        {
            lastUpdated = arg1.lastUpdated,
            title = arg1.title,
            isDefaultTitle = arg1.isDefaultTitle
        }
    )
end

tbl2[ChangedParticipants.name] = function(arg1, arg2) -- name: handleChangedParticipants
    updateConversation(
        arg2,
        arg1.conversationId,
        {
            participants = arg1.participants,
            lastUpdated = arg1.lastUpdated,
            title = arg1.title
        }
    )
end

tbl2[SetUserTyping.name] = function(arg1, arg2) -- name: handleSetUserTyping
    local conversation = arg1.conversationId and arg2.getConversation(arg1.conversationId, false)
    if conversation == nil then
        return
    end
    local var1 = table.clone(conversation.usersTyping or {})
    var1[arg1.userId] = arg1.value
    arg2.setUsersTyping(arg1.conversationId, var1)
end

tbl2[ConversationModerationTypeChanged.name] = function(arg1, arg2) -- name: handleConversationModerationTypeChanged
    updateConversation(arg2, arg1.conversationId, { moderationType = arg1.moderationType })
end

tbl2[FriendConversationCreated.name] = function(arg1, arg2) -- name: handleFriendConversationCreated
    if arg1.oldFriendConversationId then
        arg2.removeConversation(arg1.oldFriendConversationId)
    end

    if FFlagAppChatAnyServerSideConversationSearch then
        GetConversationSearchDataHydration(false).invalidate()
    end
end

tbl2[FriendshipDestroyed.name] = function(arg1, arg2) -- name: handleFriendshipDestroyed
    local var1 = if arg1.userId1 ~= "localUserId" then arg1.userId1 elseif arg1.userId2 == "localUserId" then nil else arg1.userId2

    if var1 == nil then
        return
    end
    arg2.removeConversation(ConversationChannels.getFriendConversationId({ var1 }))
end

tbl2[RequestPageConversations.name] = function(_, arg1) -- name: handleRequestPageConversations
    arg1.setListStatus({ isFetchingConversations = true })
end

tbl2[ReceivedPageConversations.name] = function(_, arg1) -- name: handleReceivedPageConversations
    arg1.setListStatus({ isFetchingConversations = false })
end

tbl2[AppChatNetworking.rodux.GetNewerMessages.Succeeded.name] = function(arg1, arg2) -- name: handleGetNewerMessagesSucceeded
    local conversationId = arg1.queryArgs and arg1.queryArgs.conversation_id
    local responseBody = arg1.responseBody
    local messages = responseBody and responseBody.messages
    if FFlagAppChatDerivedConversationLatestActivity then
        updateConversationFromMessages(
            arg2,
            conversationId,
            messages,
            shouldMarkConversationUnreadFromMessages(conversationId, messages)
        )
        return
    end
    updateConversationLastUpdatedFromMessages(
        arg2,
        conversationId,
        messages,
        shouldMarkConversationUnreadFromMessages(conversationId, messages)
    )
end

tbl2[ReceivedChannelsMigrationConflict.name] = function(_, arg1) -- name: handleReceivedChannelsMigrationConflict
    arg1.clear()
    GetConversationListStore(false).setLatestMessagesFetching(false)
end

local function SignalsConversationMiddleware(arg1, _)
    return function(arg2)
        local var1 = arg1(arg2)

        if not FFlagAppChatConversationStore then
            return var1
        end

        local var2 = tbl2[arg2.type]
        if var2 then
            var2(arg2, GetConversationStore(false))
        end

        return var1
    end
end

return SignalsConversationMiddleware
