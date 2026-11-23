-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:51:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local AppChatNetworking = require(AppChatParent.AppChatNetworking)

local Rodux = require(AppChatParent.Rodux)
local LuauPolyfill = require(AppChatParent.LuauPolyfill)

local Conversations = require(AppChat.Conversations)

local ChangedParticipants = require(AppChat.Conversations.Actions.ChangedParticipants)
local MessageFailedToSend = Conversations.Actions.MessageFailedToSend
local MessageModerated = Conversations.Actions.MessageModerated
local ReceivedConversation = require(AppChat.Conversations.Actions.ReceivedConversation)
local ReceivedMessages = Conversations.Actions.ReceivedMessages
local RemovedConversation = require(AppChat.Conversations.Actions.RemovedConversation)
local ReceivedChannelsMigrationConflict = require(AppChat.Conversations.Actions.ReceivedChannelsMigrationConflict)
local RenamedGroupConversation = require(AppChat.Conversations.Actions.RenamedGroupConversation)
local SendingMessage = Conversations.Actions.SendingMessage
local SentMessage = Conversations.Actions.SentMessage
local SetUserTyping = require(AppChat.Conversations.Actions.SetUserTyping)
local FriendConversationCreated = require(AppChat.Conversations.Actions.FriendConversationCreated)
local FriendshipDestroyed = require(AppChat.Actions.FriendshipDestroyed)
local ReloadedMessagesForConversations = require(AppChat.Conversations.Actions.ReloadedMessagesForConversations)
local ConversationModerationTypeChanged = require(AppChat.Conversations.Actions.ConversationModerationTypeChanged)

local NetworkingChat = require(AppChat.Http.NetworkingChat)
local NetworkingBlocking = require(AppChat.Http.NetworkingBlocking)

local Conversation = require(AppChat.Models.Conversation)
local ConversationChannels = require(AppChat.Models.ConversationChannels)
local Immutable = require(AppChatParent.AppCommonLib).Immutable
local OrderedMap = require(AppChatParent.AppCommonLib).OrderedMap
local MessageModel = require(AppChat.Models.MessageModel)
local Cryo = require(AppChatParent.Cryo)

local addConversation = require(AppChat.Utils.addConversation)

local getFFlagAppChatPCMFixBlocking = require(AppChatParent.SharedFlags).getFFlagAppChatPCMFixBlocking

local updateConversationReducer = require(script.Parent.updateConversationReducer)
local getOneToOneConversationIdFromFriendId = require(AppChat.Utils.getOneToOneConversationIdFromFriendId)

local getFFlagAppChatEnableManualTranslation = require(AppChat.Flags.getFFlagAppChatEnableManualTranslation)
local FFlagAppChatEnableU13ChatOptIn = require(AppChatParent.SharedFlags).FFlagAppChatEnableU13ChatOptIn

local Constants = require(AppChat.Constants)

local tbl1 = {
    [Constants.OptInVariant.OsaContextCard] = {
        field = "osaAcknowledgementStatus",
        value = ConversationChannels.OsaAcknowledgementStatus.Acknowledged
    },
    [Constants.OptInVariant.ChatOptInInfoCard] = FFlagAppChatEnableU13ChatOptIn
        and {
            field = "userOptedIntoChatMessages",
            value = ConversationChannels.UserOptedIntoChatMessagesStatus.OptedIn
        }
        or nil
}

local function markConversationAndMessagesAsRead(tbl2, conversationId: string)
    local var1 = tbl2[conversationId]

    if not var1 then
        warn("Conversation " .. conversationId .. " not found when marking conversation as read")
        return tbl2
    end
    assert(var1, "FFlagLuauTinyControlFlowAnalysis")

    local var2 = var1.messages:Map(function(arg1)
        if arg1.read then
            return arg1
        end
        return Immutable.Set(arg1, "read", true)
    end)

    local var3 = Immutable.Set(var1, "messages", var2)
    local var4 = Immutable.Set(var3, "hasUnreadMessages", false)

    return (Immutable.Set(tbl2, var4.id, var4))
end

local function addMessagesToConversation(tbl2, str1: string, tbl3)
    local var1 = tbl2[str1]

    if not var1 then
        return tbl2
    end

    local var2 = nil
    local previewMessageId = var1.previewMessageId
    local num1 = 0
    if previewMessageId and var1.messages then
        local var3 = var1.messages:Get(previewMessageId)
        if var3 then
            num1 = var3.sent:GetUnixTimestamp()
        end
    end
    for i = 1, #tbl3.messages do
        local var3 = tbl3.messages[i]
        local var4 = var1.messages:Get(var3.id)
        if var4 then
            if var2 then
                var2.previousMessageId = var4.id
            end
            if var3.previousMessageId == nil and var4.previousMessageId ~= nil then
                var3.previousMessageId = var4.previousMessageId
            end
            var3.read = var3.read or var4.read
        elseif var3.isPreviewable and num1 < var3.sent:GetUnixTimestamp() then
            previewMessageId = var3.id
            num1 = var3.sent:GetUnixTimestamp()
        end

        var2 = var3
    end

    local var3 = Immutable.JoinDictionaries(var1, { previewMessageId = previewMessageId })

    local var4 = OrderedMap.Insert(var3.messages, unpack(tbl3.messages))

    if tbl3.exclusiveStartMessageId and #tbl3.messages > 0 and var4:Get(tbl3.exclusiveStartMessageId) then
        local var5 = tbl3.messages[1]
        local var6 = var4:Get(tbl3.exclusiveStartMessageId)
        var4 = var4:Insert((Immutable.Set(var6, "previousMessageId", var5.id)))
    end

    local var5 = previewMessageId and var4 and var4:Get(previewMessageId)
    local lastUpdated = var3.lastUpdated
    if var5 then
        lastUpdated = (lastUpdated and lastUpdated:GetUnixTimestamp() or 0) < var5.sent:GetUnixTimestamp() and var5.sent or var3.lastUpdated
    end

    local hasUnreadMessages = tbl3.shouldMarkConversationUnread or var3.hasUnreadMessages
    local var7 = Immutable.JoinDictionaries(var3, {
        messages = var4,
        lastUpdated = lastUpdated,
        hasUnreadMessages = hasUnreadMessages,
        nextCursor = tbl3.nextCursor,
        previousCursor = tbl3.previousCursor
    })

    local var8 = Immutable.Set(var7, "usersTyping", {})
    return Immutable.Set(tbl2, var8.id, var8)
end

local function updateMessageContentToDisplay(tbl2, conversationId: string, messageId: string, contentToDisplay: string)
    local var1 = tbl2[conversationId]
    if var1 then
        local var2 = var1.messages:Get(messageId)
        if var2 then
            local var3 = Immutable.Set(var2, "contentToDisplay", contentToDisplay)
            local var4 = var1.messages:Insert(var3)
            local var5 = Immutable.Set(var1, "messages", var4)
            return Immutable.Set(tbl2, var5.id, var5)
        end
    end
    return tbl2
end

local function messagesFromResponseOfChannelsApi(conversationId: string, messages)
    if not messages then
        return {}
    end
    local id = nil

    local result = {}

    for i = #messages, 1, -1 do
        local var1 = messages[i]
        local channelsApi = MessageModel.fromChannelsApi(var1, conversationId, id)
        if channelsApi then
            table.insert(result, channelsApi)
            id = channelsApi.id
        end
    end

    return result
end

local function getMessagesFromConversationResponse(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    return arg1.messages or {}
end

local function getShouldMarkConversationUnread(arg1, tbl2)
    if not (arg1 and arg1.messages and tbl2) then
        return false
    end

    local key = arg1.messages.keys[#arg1.messages.keys]
    local var1 = arg1.messages.values[key]
    local unixTimestamp = var1 and var1.sent and var1.sent:GetUnixTimestamp() or 0

    for i = #tbl2, 1, -1 do
        local var2 = tbl2[i]
        if not var2 then
            continue
        end

        if var2.sent:GetUnixTimestamp() <= unixTimestamp then
            return false
        end

        local senderTargetId = var2.senderTargetId

        if senderTargetId ~= tostring(Players.LocalPlayer.UserId) and var2.isBadgeable then
            return true
        end
    end

    return false
end

local createReducer = Rodux.createReducer

local tbl2 = {}
tbl2[ReceivedConversation.name] = function(arg1, arg2)
    return updateConversationReducer(arg1, arg2.conversation)
end

tbl2[AppChatNetworking.rodux.CreateConversation.Succeeded.name] = function(arg1, arg2)
    local responseBody = arg2.responseBody
    if responseBody
        and responseBody.conversations
        and responseBody.conversations[1]
        and responseBody.conversations[1].status == "success"
    then
        local channelsApi = ConversationChannels.fromChannelsApi(responseBody.conversations[1])
        arg1 = updateConversationReducer(arg1, channelsApi)
    end

    return arg1
end

tbl2[AppChatNetworking.rodux.DuplicateConversation.Succeeded.name] = function(arg1, arg2)
    local responseBody = arg2.responseBody
    if responseBody and responseBody.conversations and responseBody.conversations[1] then
        local channelsApi = ConversationChannels.fromChannelsApi(responseBody.conversations[1])
        arg1 = addConversation(arg1, channelsApi)
    end

    return arg1
end

tbl2[ReceivedMessages.name] = function(arg1, arg2)
    return addMessagesToConversation(arg1, arg2.conversationId, arg2)
end

tbl2[SendingMessage.name] = function(arg1, arg2)
    local var1 = arg1[arg2.conversationId]

    if var1 then
        local var2 = OrderedMap.Insert(var1.sendingMessages, arg2.message)
        local var3 = Immutable.Set(var1, "sendingMessages", var2)
        arg1 = Immutable.Set(arg1, var3.id, var3)
    end
    return arg1
end

tbl2[SentMessage.name] = function(arg1, arg2)
    local var1 = arg1[arg2.conversationId]

    if var1 then
        local var2 = OrderedMap.Delete(var1.sendingMessages, arg2.messageId)
        local var3 = Immutable.Set(var1, "sendingMessages", var2)
        arg1 = Immutable.Set(arg1, var3.id, var3)
    end
    return arg1
end

tbl2[RenamedGroupConversation.name] = function(arg1, arg2)
    local conversationId = arg2.conversationId

    local var1 = arg1[conversationId]

    if var1 then
        local var2 = Immutable.JoinDictionaries(
            var1,
            {
                lastUpdated = arg2.lastUpdated,
                title = arg2.title,
                isDefaultTitle = arg2.isDefaultTitle
            }
        )
        arg1 = Immutable.Set(arg1, conversationId, var2)
    end
    return arg1
end

tbl2[ChangedParticipants.name] = function(arg1, arg2)
    local conversationId = arg2.conversationId
    local participants = arg2.participants

    local var1 = arg1[conversationId]

    if var1 then
        local var2 = Immutable.JoinDictionaries(var1, { participants = participants, lastUpdated = arg2.lastUpdated, title = arg2.title })

        arg1 = Immutable.Set(arg1, conversationId, var2)
    end
    return arg1
end

tbl2[RemovedConversation.name] = function(arg1, arg2)
    local conversationId = arg2.conversationId
    return Immutable.Set(arg1, conversationId, nil)
end

tbl2[SetUserTyping.name] = function(arg1, arg2)
    local var1 = arg1[arg2.conversationId]

    if var1 then
        local usersTyping = var1.usersTyping
        local var2 = Immutable.Set(usersTyping, arg2.userId, arg2.value)
        local var3 = Immutable.Set(var1, "usersTyping", var2)
        arg1 = Immutable.Set(arg1, var3.id, var3)
    end
    return arg1
end

tbl2[MessageModerated.name] = function(arg1, arg2)
    local var1 = arg1[arg2.conversationId]
    if var1 then
        local var2 = var1.sendingMessages:Get(arg2.messageId)

        if var2 then
            local var3 = Immutable.Set(var2, "moderated", true)
            local var4 = var1.sendingMessages:Insert(var3)
            local var5 = Immutable.Set(var1, "sendingMessages", var4)
            arg1 = Immutable.Set(arg1, var5.id, var5)
        end
    end
    return arg1
end

tbl2[MessageFailedToSend.name] = function(arg1, arg2)
    local var1 = arg1[arg2.conversationId]
    if var1 then
        local var2 = var1.sendingMessages:Get(arg2.messageId)

        if var2 then
            local var3 = Immutable.Set(var2, "failed", true)
            local var4 = var1.sendingMessages:Insert(var3)
            local var5 = Immutable.Set(var1, "sendingMessages", var4)
            arg1 = Immutable.Set(arg1, var5.id, var5)
        end
    end
    return arg1
end

tbl2[NetworkingChat.GetUserConversations.Succeeded.name] = function(arg1, arg2)
    local responseBody = arg2.responseBody

    for _, value in ipairs(responseBody) do
        local web = Conversation.fromWeb(value)
        arg1 = updateConversationReducer(arg1, web)
    end
    return arg1
end

tbl2[AppChatNetworking.rodux.GetUserConversations.Succeeded.name] = function(arg1, arg2)
    local responseBody = arg2.responseBody

    if responseBody and responseBody.conversations then
        for _, conversation in responseBody.conversations do
            local channelsApi = ConversationChannels.fromChannelsApi(conversation)
            arg1 = updateConversationReducer(arg1, channelsApi)
            local messagesFromConversationResponse = getMessagesFromConversationResponse(conversation)

            if not (messagesFromConversationResponse and #messagesFromConversationResponse > 0) then
                continue
            end

            local tbl3 = {
                messages = LuauPolyfill.Array.map(messagesFromConversationResponse, function(arg3)
                    return MessageModel.fromChannelsApi(arg3, channelsApi.id)
                end)
            }
            arg1 = addMessagesToConversation(arg1, channelsApi.id, tbl3)
        end
    end

    return arg1
end

tbl2[AppChatNetworking.rodux.GetOlderMessages.Succeeded.name] = function(arg1, arg2)
    local conversationId = arg2.queryArgs.conversation_id
    local responseBody = arg2.responseBody

    local var1 = arg1[conversationId]
    if not var1 then
        return arg1
    end
    assert(var1, "FFlagLuauTinyControlFlowAnalysis")

    local previousCursor = var1.previousCursor or nil
    local nextCursor = var1.nextCursor or nil

    if not responseBody then
        return arg1
    end

    local messages = messagesFromResponseOfChannelsApi(conversationId, responseBody.messages)
    local nextCursor2 = if responseBody.next_cursor == "" then nil else responseBody.next_cursor
    local var2 = nextCursor2 or nextCursor

    if previousCursor == nil then
        if responseBody.previous_cursor == "" then
            previousCursor = nil
        else
            previousCursor = responseBody.previous_cursor
        end
    end
    arg1 = addMessagesToConversation(
        arg1,
        conversationId,
        { messages = messages, nextCursor = var2, previousCursor = previousCursor }
    )
    if not nextCursor2 then
        local var3 = arg1[conversationId]
        if var3 then
            local var4 = Immutable.Set(var3, "fetchedOldestMessage", true)
            arg1 = Immutable.Set(arg1, var4.id, var4)
        end
    end

    return arg1
end

tbl2[AppChatNetworking.rodux.GetNewerMessages.Succeeded.name] = function(arg1, arg2)
    local conversationId = arg2.queryArgs.conversation_id
    local responseBody = arg2.responseBody

    local var1 = arg1[conversationId]
    if not var1 then
        return arg1
    end
    assert(var1, "FFlagLuauTinyControlFlowAnalysis")

    local previousCursor = var1.previousCursor or nil
    local nextCursor = var1.nextCursor or nil

    if not responseBody then
        return arg1
    end

    local messages = messagesFromResponseOfChannelsApi(conversationId, responseBody.messages)

    if nextCursor == nil then
        if responseBody.next_cursor == "" then
            nextCursor = nil
        else
            nextCursor = responseBody.next_cursor
        end
    end

    local tbl4 = {
        messages = messages,
        nextCursor = nextCursor,
        previousCursor = (if responseBody.previous_cursor == "" then nil else responseBody.previous_cursor) or previousCursor,
        shouldMarkConversationUnread = getShouldMarkConversationUnread(var1, messages)
    }

    return (addMessagesToConversation(arg1, conversationId, tbl4))
end

tbl2[AppChatNetworking.rodux.GetConversationDetails.Succeeded.name] = function(arg1, arg2)
    local conversation = arg2.responseBody.conversations[1]
    if not conversation then
        return arg1
    end

    local channelsApi = ConversationChannels.fromChannelsApi(conversation)
    arg1 = updateConversationReducer(arg1, channelsApi)
    local messagesFromConversationResponse = getMessagesFromConversationResponse(conversation)

    if messagesFromConversationResponse and #messagesFromConversationResponse > 0 then
        local tbl3 = {
            messages = LuauPolyfill.Array.map(messagesFromConversationResponse, function(arg3)
                return MessageModel.fromChannelsApi(arg3, channelsApi.id)
            end)
        }
        arg1 = addMessagesToConversation(arg1, channelsApi.id, tbl3)
    end

    return arg1
end

tbl2[AppChatNetworking.rodux.MultiGetConversationDetails.Succeeded.name] = function(arg1, arg2)
    local responseBody = arg2.responseBody
    if not (responseBody and responseBody.conversations) then
        return arg1
    end

    for _, conversation in responseBody.conversations do
        local channelsApi = ConversationChannels.fromChannelsApi(conversation)
        arg1 = updateConversationReducer(arg1, channelsApi)
        local messagesFromConversationResponse = getMessagesFromConversationResponse(conversation)

        if not (messagesFromConversationResponse and #messagesFromConversationResponse > 0) then
            continue
        end

        local tbl3 = {
            messages = LuauPolyfill.Array.map(messagesFromConversationResponse, function(arg3)
                return MessageModel.fromChannelsApi(arg3, channelsApi.id)
            end)
        }
        arg1 = addMessagesToConversation(arg1, channelsApi.id, tbl3)
    end

    return arg1
end

tbl2[AppChatNetworking.rodux.MarkConversation.Succeeded.name] = function(arg1, arg2)
    local conversationId = arg2.postBody.conversation_ids[1]
    return (markConversationAndMessagesAsRead(arg1, conversationId))
end
tbl2[AppChatNetworking.rodux.TranslateUserMessage.Succeeded.name] = getFFlagAppChatEnableManualTranslation() and function(arg1, arg2)
    local contentToDisplay = arg2.responseBody.content_to_display
    if arg2.postBody.conversation_id and arg2.postBody.message_id then
        return updateMessageContentToDisplay(arg1, arg2.postBody.conversation_id, arg2.postBody.message_id, contentToDisplay)
    end

    return arg1
end or nil

tbl2[ReceivedChannelsMigrationConflict.name] = function(_, _)
    return {}
end

tbl2[FriendConversationCreated.name] = function(arg1, arg2)
    if arg1[arg2.oldFriendConversationId] then
        return Immutable.Set(arg1, arg2.oldFriendConversationId, nil)
    end
    return arg1
end

tbl2[FriendshipDestroyed.name] = function(arg1, arg2)
    local var1 = if arg2.userId1 ~= "localUserId" then arg2.userId1 elseif arg2.userId2 == "localUserId" then nil else arg2.userId2

    if not var1 then
        return arg1
    end
    assert(var1, "FFlagLuauTinyControlFlowAnalysis")

    local friendConversationId = ConversationChannels.getFriendConversationId({ var1 })
    if arg1[friendConversationId] then
        return Immutable.Set(arg1, friendConversationId, nil)
    end
    return arg1
end

tbl2[NetworkingBlocking.BlockUserById.Succeeded.name] = getFFlagAppChatPCMFixBlocking() and function(arg1, arg2)
    local str1 = tostring(arg2.namedIds.users)
    if not str1 then
        return arg1
    end

    local oneToOneConversationIdFromFriendId = getOneToOneConversationIdFromFriendId(arg1, str1)
    local var1 = if oneToOneConversationIdFromFriendId and arg1[oneToOneConversationIdFromFriendId] then Immutable.Set(arg1, oneToOneConversationIdFromFriendId, nil) else arg1
    local friendConversationId = ConversationChannels.getFriendConversationId({ str1 })

    if friendConversationId and arg1[friendConversationId] then
        var1 = Immutable.Set(arg1, friendConversationId, nil)
    end

    return var1
end or nil

tbl2[ReloadedMessagesForConversations.name] = function(tbl3, arg1)
    for _, conversationId in arg1.conversationIds do
        local var1 = tbl3[conversationId]
        local join = Cryo.Dictionary.join
        local tbl4 = {}
        local join2 = Cryo.Dictionary.join
        local tbl5 = {
            messages = ConversationChannels.getEmptyMessages(),
            sendingMessages = ConversationChannels.getEmptySendingMessages(),
            previousCursor = Cryo.None,
            nextCursor = Cryo.None,
            fetchedOldestMessage = false
        }
        tbl4[conversationId] = join2(var1, tbl5)
        tbl3 = join(tbl3, tbl4)
    end

    return tbl3
end

tbl2[ConversationModerationTypeChanged.name] = function(arg1, arg2)
    local conversationId = arg2.conversationId
    local moderationType = arg2.moderationType
    local var1 = arg1[conversationId]
    if not var1 then
        return arg1
    end

    local var2 = Immutable.Set(var1, "moderationType", moderationType)
    return Immutable.Set(arg1, conversationId, var2)
end

tbl2[AppChatNetworking.rodux.RecordModalSequenceResponse.Succeeded.name] = function(arg1, arg2)
    local postBody = arg2.postBody
    if postBody.action_type ~= Constants.ModalAction.Accept then
        return arg1
    end

    local var1 = tbl1[postBody.modal_variant]
    if not var1 then
        return arg1
    end

    local var2 = postBody.conversation_id or ConversationChannels.getFriendConversationId({ postBody.friend_id })

    local var3 = var2 and arg1[var2]
    if not var3 then
        return arg1
    end

    return Immutable.Set(arg1, var2, Immutable.Set(var3, var1.field, var1.value))
end

return createReducer({}, tbl2)
