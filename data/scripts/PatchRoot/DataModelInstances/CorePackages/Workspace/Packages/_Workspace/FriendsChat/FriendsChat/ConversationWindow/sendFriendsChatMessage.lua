-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local FriendsChat = script:FindFirstAncestor("FriendsChat")
local FriendsChatParent = FriendsChat.Parent

local SignalsExperimental = require(FriendsChatParent.SignalsExperimental)
local ExpChatShared = require(FriendsChatParent.ExpChatShared)
local ExpChatPerfTracker = require(FriendsChatParent.ChatUIPrimitives).Telemetry.ExpChatPerfTracker

local AppChatNetworking = require(FriendsChatParent.AppChatNetworking)
local createConversationFromFriendPlaceholder = require(FriendsChatParent.AppChat.createConversationFromFriendPlaceholder)
local GetConversationMessageStore = require(FriendsChatParent.AppChat.GetConversationMessageStore)
local GetConversationMessageListStore = require(FriendsChatParent.AppChat.GetConversationMessageListStore)
local ingestNewerMessages = require(FriendsChatParent.AppChat.ingestNewerMessages)
local ChatConversationTelemetryEvents = require(FriendsChatParent.AppChat.ChatConversationTelemetryEvents)
local SendMessageError = require(FriendsChatParent.AppChat.SendMessageError)

local ExpChatConversationListAdapter = require(script.Parent.Parent.ConversationList.ExpChatConversationListAdapter)

local getConversationMessageSentInfo = require(script.Parent.Parent.Telemetry.ChatConversation.getConversationMessageSentInfo)
local FFlagFriendsChatMessageSendPerfTracking = require(FriendsChat.Flags.FFlagFriendsChatMessageSendPerfTracking)
local FriendsChatTabName = require(FriendsChat.FriendsChatTabName)

local serializeParticipantIdsForTelemetry = require(script.Parent.Parent.Telemetry.App.serializeParticipantIdsForTelemetry)

local var1 = ExpChatShared.Logger:new(script.Name)

local function isSendResponseAccepted(arg1): boolean
    if arg1 == nil or arg1.responseBody == nil then
        return false
    end
    if arg1.responseCode ~= nil and arg1.responseCode ~= 200 then
        return false
    end
    if arg1.StatusCode ~= nil and arg1.StatusCode ~= 200 then
        return false
    end

    local messages = arg1.responseBody.messages
    if messages == nil or #messages == 0 then
        return false
    end

    local status = messages[1].status
    return status == nil or status == "" or status == "success"
end

local function sendFriendsChatMessage(tbl1)
    local text = tbl1.text
    local conversationId = tbl1.conversationId
    local isFriendPlaceholder = tbl1.isFriendPlaceholder
    local hasRealConversation = tbl1.hasRealConversation
    local emit = tbl1.emit

    local str1 = "sending-friends-message-" .. HttpService:GenerateGUID(false)

    local bool1 = if FFlagFriendsChatMessageSendPerfTracking then ExpChatPerfTracker.start(
        ExpChatPerfTracker.Events.MessageSendToWindowRenderInterval,
        { messageId = str1 },
        { tabName = FriendsChatTabName }
    ) else false

    task.spawn(function()
        local var2 = conversationId or ""
        local localPlayer = Players.LocalPlayer
        if isFriendPlaceholder and conversationId ~= nil then
            if bool1 then
                ExpChatPerfTracker.cancel(ExpChatPerfTracker.Events.MessageSendToWindowRenderInterval, { messageId = str1 })
            end

            local var3 = ExpChatConversationListAdapter.getConversationStore().getConversation(conversationId, false)
            if var3 == nil then
                var1:warning(`Unable to find friend placeholder {conversationId}`)
                return
            end

            local conversationFromFriendPlaceholder = createConversationFromFriendPlaceholder(var3, if localPlayer then localPlayer.UserId else 0)

            if conversationFromFriendPlaceholder == nil then
                var1:warning(`Unable to create conversation for friend placeholder {conversationId}`)
                return
            end

            local var4, var5 = conversationFromFriendPlaceholder:await()
            if not var4 or var5 == nil then
                var1:warning(`Failed to create conversation for friend placeholder {conversationId}`)
                return
            end

            var2 = var5.id
            if tbl1.onFriendPlaceholderConversationCreated ~= nil then
                tbl1.onFriendPlaceholderConversationCreated(var2)
            end
        elseif not hasRealConversation then
            if bool1 then
                ExpChatPerfTracker.cancel(ExpChatPerfTracker.Events.MessageSendToWindowRenderInterval, { messageId = str1 })
            end

            return
        end

        local conversationMessageStore = GetConversationMessageStore(false)
        local conversationMessageListStore = GetConversationMessageListStore(false)

        local tbl2 = {
            id = str1,
            type = "user",
            content = text,
            created_at = tostring(os.time()),
            sender_user_id = if localPlayer then localPlayer.UserId else nil,
            status = "Pending",
            conversationId = var2
        }

        conversationMessageStore.upsertMessages({ [str1] = tbl2 })
        conversationMessageListStore.prependMessages(var2, { str1 })

        local content = string.rep("#", utf8.len(text) or #text)

        local var3 = ExpChatConversationListAdapter.getConversationStore().getConversation(var2, false)
        local recipientIds = serializeParticipantIdsForTelemetry(
            if var3 then var3.participants else nil,
            if localPlayer then localPlayer.UserId else 0
        )

        AppChatNetworking.http.SendChatTextMessage(nil, var2, text):andThen(function(arg1)
            emit(ChatConversationTelemetryEvents.ConversationMessageSent, getConversationMessageSentInfo(arg1, recipientIds))

            if not isSendResponseAccepted(arg1) then
                conversationMessageStore.updateMessage(str1, { content = content, status = "Failed" })
                return
            end

            local messages = arg1.responseBody.messages or {}

            SignalsExperimental.batch(function()
                if #ingestNewerMessages(var2, messages) == 0 then
                    conversationMessageStore.updateMessage(str1, { content = content, status = "Failed" })
                    return
                end
                ExpChatConversationListAdapter.updateConversationPreviewFromMessages(
                    var2,
                    messages,
                    {
                        hasUnreadMessages = false,
                        localUserId = if localPlayer then localPlayer.UserId else 0
                    }
                )

                conversationMessageListStore.removeMessage(var2, str1)
                conversationMessageStore.removeMessage(str1)
            end)
        end):catch(function(arg1)
            var1:warning(`Failed to send message to {var2}: {tostring(arg1)}`)

            emit(
                ChatConversationTelemetryEvents.ConversationMessageSent,
                {
                    messageSentResult = SendMessageError.OtherFailure,
                    recipientIds = recipientIds
                }
            )

            conversationMessageStore.updateMessage(str1, { content = content, status = "Failed" })
        end)
    end)
end

return sendFriendsChatMessage
