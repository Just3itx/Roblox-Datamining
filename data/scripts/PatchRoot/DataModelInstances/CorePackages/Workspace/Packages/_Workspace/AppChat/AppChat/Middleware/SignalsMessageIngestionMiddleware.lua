-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Cryo = require(AppChatParent.Cryo)
local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local SharedFlags = require(AppChatParent.SharedFlags)

local buildConversationMessageFromApi = require(AppChat.Stores.Ingestion.buildConversationMessageFromApi)
local ingestBatch = require(AppChat.Stores.Ingestion.ingestBatch)
local IngestOperation = require(AppChat.Stores.Ingestion.IngestOperation)

local Conversations = require(AppChat.Conversations)
local ReceivedMessages = Conversations.Actions.ReceivedMessages
local SendingMessage = Conversations.Actions.SendingMessage
local SentMessage = Conversations.Actions.SentMessage
local MessageModerated = Conversations.Actions.MessageModerated
local MessageFailedToSend = Conversations.Actions.MessageFailedToSend
local RemovedConversation = require(AppChat.Conversations.Actions.RemovedConversation)
local ReloadedMessagesForConversations = require(AppChat.Conversations.Actions.ReloadedMessagesForConversations)

local _Types = require(AppChat.MessageData.Types)
local Enums = require(AppChat.MessageData.Enums)
local MessageStatus = Enums.MessageStatus
local MessageType = Enums.MessageType
local MessageVisibility = Enums.MessageVisibility
local GetFFlagEnableSocialCards = SharedFlags.GetFFlagEnableSocialCards

local GetConversationMessageViewModelStore = require(AppChat.Stores.GetConversationMessageViewModelStore)
local GetMessageReactionsStore = require(AppChat.Stores.GetMessageReactionsStore)
local GetMessageReactionsViewModelStore = require(AppChat.Stores.GetMessageReactionsViewModelStore)

local FFlagAppChatIncrementalPaginationProjection = require(AppChat.Flags.FFlagAppChatIncrementalPaginationProjection)
local FFlagAppChatSignalsMessageStore = require(AppChat.Flags.FFlagAppChatSignalsMessageStore)
local FFlagAppChatEnableReactions = SharedFlags.FFlagAppChatEnableReactions

local function determineStatus(bool1: boolean?, bool2: boolean?, bool3: boolean?, hidden: string?) -- Luacid: Inlined by compiler; 2 call sites recovered
    if bool1 then
        return MessageStatus.Pending
    end

    if bool2 then
        return MessageStatus.Failed
    end

    if bool3 then
        return MessageStatus.Moderated
    end

    if hidden == MessageVisibility.Hidden then
        return MessageStatus.Hidden
    end

    return MessageStatus.Default
end

local function extractLegacyTimestamp(sent)
    if sent == nil or typeof(sent) ~= "table" then
        return nil
    end
    if sent.ToIsoDate then
        return sent:ToIsoDate()
    end
    local var1 = nil
    if sent.GetUnixTimestamp then
        var1 = sent:GetUnixTimestamp()
    elseif sent.UnixTimestamp then
        var1 = sent.UnixTimestamp
    end
    if var1 and var1 > 0 then
        local success, result = pcall(DateTime.fromUnixTimestamp, var1)
        if success and result then
            return result:ToIsoDate()
        end
    end
    return nil
end

local function buildFromLegacy(arg1, conversationId: string)
    local tbl1

    if arg1.repliesTo and arg1.repliesTo.id then
        tbl1 = {
            id = arg1.repliesTo.id,
            content = arg1.repliesTo.content,
            sender_user_id = if arg1.repliesTo.senderTargetId then tonumber(arg1.repliesTo.senderTargetId) else nil,
            created_at = extractLegacyTimestamp(arg1.repliesTo.sent),
            type = if arg1.repliesTo.messageType == "System" then MessageType.System else MessageType.User
        }
    else
        tbl1 = nil
    end

    local tbl2 = {
        id = arg1.id or arg1.messageId,
        type = if arg1.messageType == "System" then MessageType.System else MessageType.User,
        content = arg1.content,
        created_at = extractLegacyTimestamp(arg1.sent),
        sender_user_id = if arg1.senderTargetId then tonumber(arg1.senderTargetId) else nil,
        moderation_type = arg1.moderationType,
        visibility = arg1.visibility,
        preview_content = arg1.previewContent,
        content_to_display = arg1.contentToDisplay or arg1.content,
        replies_to = tbl1,
        cards = if GetFFlagEnableSocialCards() then arg1.cards else nil,
        filtered_for_receivers = arg1.filteredForReceivers,
        is_previewable = arg1.isPreviewable,
        conversationId = conversationId,
        status = 0,
        stableKey = 0
    }
    local isSending = arg1.isSending
    local failed = arg1.failed
    local moderated = arg1.moderated
    local visibility = arg1.visibility
    tbl2.status = if isSending then determineStatus(true, nil, nil, nil) else determineStatus(false, failed, moderated, visibility)
    tbl2.stableKey = arg1.stableKey or arg1.stable_key or arg1.id or arg1.messageId
    return tbl2
end

local function clearConversationStores(tbl1, str1: string)
    local orderedIds = tbl1.conversationMessageListStore.getOrderedIds(str1)
    for _, orderedId in orderedIds do
        tbl1.conversationMessageStore.removeMessage(orderedId)
    end
    if FFlagAppChatEnableReactions then
        GetMessageReactionsStore(false).evictMessageReactions(orderedIds)
        GetMessageReactionsViewModelStore(false).evictMessages(orderedIds)
    end
    tbl1.conversationMessageViewModelStore.evictConversation(str1)
    tbl1.conversationMessageListStore.clearConversation(str1)
end

local function ingestConversationsFromResponse(responseBody, _)
    if not (responseBody and responseBody.conversations) then
        return
    end
    for _, conversation in responseBody.conversations do
        local id = conversation.id
        if not (id and conversation.messages) then
            continue
        end

        local var1 = Cryo.List.filterMap(conversation.messages, function(arg1)
            if arg1 and arg1.id then
                return (buildConversationMessageFromApi(arg1, id))
            end

            return nil
        end)
        ingestBatch(id, var1, IngestOperation.Prepend)
    end
end

local tbl1 = {}

tbl1[ReceivedMessages.name] = function(arg1, _) -- name: handleReceivedMessages
    local conversationId = arg1.conversationId
    local messages = arg1.messages
    if not messages or not conversationId then
        return
    end

    local var1 = Cryo.List.filterMap(messages, function(arg2)
        if arg2 and arg2.id then
            return (buildFromLegacy(arg2, conversationId))
        end

        return nil
    end)
    ingestBatch(conversationId, var1, IngestOperation.Prepend)
end

tbl1[SendingMessage.name] = function(arg1, _) -- name: handleSendingMessage
    local conversationId = arg1.conversationId
    local message = arg1.message
    if not message or not message.id or not conversationId then
        return
    end

    local fromLegacy = buildFromLegacy(message, conversationId)
    fromLegacy.status = MessageStatus.Pending
    ingestBatch(conversationId, { fromLegacy }, IngestOperation.Prepend)
end

tbl1[SentMessage.name] = function(arg1, tbl2) -- name: handleSentMessage
    local conversationId = arg1.conversationId
    local messageId = arg1.messageId
    if conversationId and messageId then
        tbl2.conversationMessageListStore.removeMessage(conversationId, messageId)
        tbl2.conversationMessageStore.removeMessage(messageId)
    end
end

tbl1[MessageModerated.name] = function(arg1, tbl2) -- name: handleMessageModerated
    local messageId = arg1.messageId
    if not messageId then
        return
    end

    tbl2.conversationMessageStore.updateMessage(messageId, { status = MessageStatus.Moderated })
    if FFlagAppChatIncrementalPaginationProjection and arg1.conversationId then
        tbl2.conversationMessageListStore.publishMessageUpdates(arg1.conversationId, { messageId })
    end
end

tbl1[MessageFailedToSend.name] = function(arg1, tbl2) -- name: handleMessageFailedToSend
    local messageId = arg1.messageId
    if not messageId then
        return
    end

    tbl2.conversationMessageStore.updateMessage(messageId, { status = MessageStatus.Failed })
    if FFlagAppChatIncrementalPaginationProjection and arg1.conversationId then
        tbl2.conversationMessageListStore.publishMessageUpdates(arg1.conversationId, { messageId })
    end
end

tbl1[AppChatNetworking.rodux.GetOlderMessages.Succeeded.name] = function(arg1, _) -- name: handleGetOlderMessagesSucceeded
    local conversationId = arg1.queryArgs and arg1.queryArgs.conversation_id
    local responseBody = arg1.responseBody
    if not conversationId or not responseBody or not responseBody.messages then
        return
    end

    local var1 = Cryo.List.filterMap(responseBody.messages, function(arg2)
        if arg2 and arg2.id then
            return (buildConversationMessageFromApi(arg2, conversationId))
        end

        return nil
    end)
    local nextCursor = responseBody.next_cursor
    local var2 = ingestBatch
    local appendAndAdvanceCursor = IngestOperation.AppendAndAdvanceCursor

    if nextCursor == "" then
        nextCursor = nil
    end

    var2(conversationId, var1, appendAndAdvanceCursor, nextCursor)
end

tbl1[AppChatNetworking.rodux.GetNewerMessages.Succeeded.name] = function(arg1, _) -- name: handleGetNewerMessagesSucceeded
    local conversationId = arg1.queryArgs and arg1.queryArgs.conversation_id
    local responseBody = arg1.responseBody
    if not conversationId or not responseBody or not responseBody.messages then
        return
    end

    local var1 = Cryo.List.filterMap(responseBody.messages, function(arg2)
        if arg2 and arg2.id then
            return (buildConversationMessageFromApi(arg2, conversationId))
        end

        return nil
    end)
    ingestBatch(conversationId, var1, IngestOperation.Prepend)
end

tbl1[AppChatNetworking.rodux.GetUserConversations.Succeeded.name] = function(arg1, tbl2) -- name: handleGetUserConversationsSucceeded
    ingestConversationsFromResponse(arg1.responseBody, tbl2)
end

tbl1[AppChatNetworking.rodux.GetConversationDetails.Succeeded.name] = function(arg1, tbl2) -- name: handleGetConversationDetailsSucceeded
    ingestConversationsFromResponse(arg1.responseBody, tbl2)
end

tbl1[AppChatNetworking.rodux.MultiGetConversationDetails.Succeeded.name] = function(arg1, tbl2) -- name: handleMultiGetConversationDetailsSucceeded
    ingestConversationsFromResponse(arg1.responseBody, tbl2)
end

tbl1[RemovedConversation.name] = function(arg1, tbl2) -- name: handleRemovedConversation
    local conversationId = arg1.conversationId
    if conversationId then
        clearConversationStores(tbl2, conversationId)
    end
end

tbl1[ReloadedMessagesForConversations.name] = function(arg1, tbl2) -- name: handleReloadedMessagesForConversations
    local conversationIds = arg1.conversationIds
    if not conversationIds then
        return
    end

    for _, conversationId in conversationIds do
        clearConversationStores(tbl2, conversationId)
    end
end

local function SignalsMessageIngestionMiddleware(arg1, _)
    return function(arg2)
        local var1 = arg1(arg2)

        if not FFlagAppChatSignalsMessageStore then
            return var1
        end

        local var2 = tbl1[arg2.type]
        if var2 then
            local conversationMessageViewModelStore = GetConversationMessageViewModelStore(false)
            var2(arg2, {
                conversationMessageStore = conversationMessageViewModelStore.conversationMessageStore,
                conversationMessageListStore = conversationMessageViewModelStore.conversationMessageListStore,
                conversationMessageViewModelStore = conversationMessageViewModelStore
            })
        end

        return var1
    end
end

return SignalsMessageIngestionMiddleware
