-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local Cryo = require(AppChatParent.Cryo)

local OrderedMap = require(AppChatParent.AppCommonLib).OrderedMap
local Constants = require(AppChat.Constants)
local Conversation = require(script.Parent.Conversation)
local DateTime = require(AppChatParent.Time).DateTime

local function getMessageId(arg1)
    return arg1.id
end

local function messageSortPredicate(arg1, arg2): boolean
    local sent = arg1 and arg1.sent
    local sent2 = arg2 and arg2.sent
    if not (sent or sent2) then
        return (arg1 and arg1.id or "") > (arg2 and arg2.id or "")
    end

    if not sent then
        return false
    end

    if not sent2 then
        return true
    end
    local unixTimestamp = arg1.sent:GetUnixTimestamp()
    local unixTimestamp2 = arg2.sent:GetUnixTimestamp()

    if unixTimestamp == unixTimestamp2 then
        return arg1.id > arg2.id
    end

    return unixTimestamp < unixTimestamp2
end

local function sendingMessageSortPredicate(tbl1, arg1): boolean
    return tbl1.order < arg1.order
end

local function convertToLegacyConversationType(str1: string, str2: string) -- Luacid: Inlined by compiler; 3 call sites recovered
    if str2 == "friends" then
        return Conversation.Type.ONE_TO_ONE_CONVERSATION
    end

    if str1 == "group" then
        return Conversation.Type.MULTI_USER_CONVERSATION
    end

    if str1 == "one_to_one" then
    end

    return Conversation.Type.ONE_TO_ONE_CONVERSATION
end

local function getFriendId(arg1)
    local localPlayer = Players.LocalPlayer
    if localPlayer then
        for _, participantUserId in arg1.participant_user_ids do
            if tostring(participantUserId) ~= tostring(localPlayer.UserId) then
                return "friends:" .. tostring(participantUserId)
            end
        end
    end

    return "friends:unknown-id"
end

local function getConversationId(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    if arg1.source == "friends" then
        return (getFriendId(arg1))
    end

    return tostring(arg1.id)
end

local module = {
    ModerationType = {
        TrustedComms = "trusted_comms",
        Moderated = "moderated",
        Invalid = "invalid",
        UnknownType = "unknown_type"
    },
    UserPendingStatus = { Invalid = "invalid", Pending = "pending", NotPending = "not_pending" },
    OsaAcknowledgementStatus = AppChatNetworking.Constants.OsaAcknowledgementStatusResponse,
    UserOptedIntoChatMessagesStatus = AppChatNetworking.Constants.UserOptedIntoChatMessagesStatusResponse,
    CallButtonEligibility = { Eligible = "eligible", Ineligible = "ineligible" },
    Source = { Friends = "friends", Channels = "channels", Chat = "chat" },
    Type = { Group = "group", OneToOne = "one_to_one" }
}

function module.getEmptyMessages()
    return OrderedMap.new(getMessageId, messageSortPredicate)
end

function module.getEmptySendingMessages()
    return OrderedMap.new(getMessageId, sendingMessageSortPredicate)
end

function module.mockBase()
    return {
        source = "channels",
        type = "one_to_one",
        createdAt = nil,
        messages = module.getEmptyMessages(),
        sendingMessages = module.getEmptySendingMessages(),
        id = "1-2-3",
        clientId = "1-2-3",
        initiator = "1",
        hasUnreadMessages = false,
        conversationType = Conversation.Type.ONE_TO_ONE_CONVERSATION,
        hasGroupUp = false,
        usersTyping = {},
        isUserLeaving = false,
        fetchingOlderMessages = false,
        serverState = Constants.ServerState.CREATED,
        pinnedGame = {},
        moderationType = module.ModerationType.TrustedComms,
        userPendingStatus = module.UserPendingStatus.NotPending,
        participantPendingStatus = module.UserPendingStatus.NotPending,
        callButtonEligibility = nil,
        previewMessageId = nil,
        previewContent = nil,
        lastUpdated = DateTime.now(),
        title = "test",
        titleForViewer = "test",
        isDefaultTitle = false,
        participants = { "1" },
        osaAcknowledgementStatus = module.OsaAcknowledgementStatus.NotApplicable,
        userOptedIntoChatMessages = module.UserOptedIntoChatMessagesStatus.NotApplicable,
        previousCursor = nil,
        nextCursor = nil,
        fetchedOldestMessage = nil
    }
end

function module.mock(arg1)
    return Cryo.Dictionary.join(module.mockBase(), arg1 or {})
end

function module.response(tbl1)
    return {
        source = if tbl1.source then tbl1.source else "channels",
        type = if tbl1.type then tbl1.type else "one_to_one",
        created_at = if tbl1.created_at then tbl1.created_at else "2021-01-01T00:00:00Z",
        created_by = if tbl1.created_by then tbl1.created_by else 1,
        id = if tbl1.id then tbl1.id else "1-2-3",
        name = if tbl1.name then tbl1.name else "test",
        participant_user_ids = not tbl1.participant_user_ids and { 1 } or tbl1.participant_user_ids,
        unread_message_count = if tbl1.unread_message_count then tbl1.unread_message_count else 0,
        updated_at = if tbl1.updated_at then tbl1.updated_at else "2021-01-01T00:00:00Z",
        messages = not tbl1.messages and {} or tbl1.messages,
        moderation_type = if tbl1.moderation_type then tbl1.moderation_type else "trusted_comms",
        user_pending_status = if tbl1.user_pending_status then tbl1.user_pending_status else "not_pending",
        participant_pending_status = if tbl1.participant_pending_status then tbl1.participant_pending_status else "not_pending",
        success = if tbl1.success then tbl1.success else nil,
        preview_message = if tbl1.preview_message then tbl1.preview_message else nil,
        hasGroupUp = if tbl1.hasGroupUp then tbl1.hasGroupUp else false,
        osa_acknowledgement_status = if tbl1.osa_acknowledgement_status then tbl1.osa_acknowledgement_status else nil,
        user_opted_into_chat_messages = if tbl1.user_opted_into_chat_messages then tbl1.user_opted_into_chat_messages else nil,
        call_button_eligibility = tbl1.call_button_eligibility
    }
end

function module.fromChannelsApi(arg1)
    local channelsApi = ({})

    channelsApi.source = arg1.source
    channelsApi.type = arg1.type
    channelsApi.createdAt = arg1.created_at

    channelsApi.messages = module.getEmptyMessages()
    channelsApi.sendingMessages = module.getEmptySendingMessages()
    channelsApi.id = getConversationId(arg1)

    channelsApi.clientId = ""
    channelsApi.initiator = tostring(arg1.created_by)
    channelsApi.hasUnreadMessages = arg1.unread_message_count > 0
    local type = arg1.type
    channelsApi.conversationType = if arg1.source == "friends" then convertToLegacyConversationType(nil, "friends") elseif type == "group" then Conversation.Type.MULTI_USER_CONVERSATION elseif type == "one_to_one" then convertToLegacyConversationType(nil, "friends") else convertToLegacyConversationType(nil, "friends")
    channelsApi.usersTyping = {}
    channelsApi.isUserLeaving = false
    channelsApi.fetchingOlderMessages = false
    channelsApi.serverState = if arg1.source == "friends" then Constants.ServerState.NONE else Constants.ServerState.CREATED

    channelsApi.pinnedGame = {}
    channelsApi.moderationType = arg1.moderation_type
    channelsApi.userPendingStatus = arg1.user_pending_status
    channelsApi.participantPendingStatus = arg1.participant_pending_status
    channelsApi.callButtonEligibility = arg1.call_button_eligibility
    local previewMessage = arg1.preview_message
    if previewMessage then
        if previewMessage.is_previewable then
            channelsApi.previewMessageId = previewMessage.id
        end
        channelsApi.previewContent = previewMessage.content or previewMessage.preview_content
    end
    channelsApi.hasGroupUp = if arg1.has_group_up then arg1.has_group_up else false
    channelsApi.lastUpdated = DateTime.fromIsoDate(arg1.updated_at)

    channelsApi.title = arg1.name
    channelsApi.titleForViewer = ""
    channelsApi.isDefaultTitle = arg1.name == nil

    channelsApi.participants = {}
    if arg1.participant_user_ids then
        for _, participantUserId in arg1.participant_user_ids do
            table.insert(channelsApi.participants, tostring(participantUserId))
        end
    end

    if arg1.osa_acknowledgement_status then
        channelsApi.osaAcknowledgementStatus = arg1.osa_acknowledgement_status
    end

    if arg1.user_opted_into_chat_messages then
        channelsApi.userOptedIntoChatMessages = arg1.user_opted_into_chat_messages
    end

    return channelsApi
end

function module.getFriendConversationId(participantUserIds): string
    return (getFriendId({ participant_user_ids = participantUserIds }))
end

function module.getConversationId(arg1): string
    return getConversationId(arg1)
end

return module
