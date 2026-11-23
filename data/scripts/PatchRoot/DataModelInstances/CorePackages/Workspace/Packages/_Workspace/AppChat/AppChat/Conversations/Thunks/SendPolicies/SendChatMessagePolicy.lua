-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:01:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Immutable = require(AppChatParent.AppCommonLib).Immutable

local SendMessagePolicy = require(script.Parent.SendMessagePolicy)
local MessageModel = require(AppChat.Models.MessageModel)
local DateTime = require(AppChatParent.Time).DateTime

local ReceivedChatResponse = require(AppChat.Conversations.Thunks.ReceivedChatResponse)
local SendingMessage = require(AppChat.Conversations.Actions.SendingMessage)
local SentMessage = require(AppChat.Conversations.Actions.SentMessage)
local StatusCodes = require(AppChatParent.Http).StatusCodes
local MessageFailedToSend = require(AppChat.Conversations.Actions.MessageFailedToSend)
local MessageModerated = require(AppChat.Conversations.Actions.MessageModerated)
local ResponseStatus = require(AppChatParent.AppChatNetworking).Constants.ResponseStatus
local NavigateIntoChat = require(AppChat.Actions.NavigateIntoChat)
local ReceivedChannelsMigrationConflict = require(AppChat.Conversations.Actions.ReceivedChannelsMigrationConflict)
local EnumScreens = require(AppChat.EnumScreens)
local getDeepValue2 = require(AppChat.Utils.getDeepValue2)
local _ConversationChannels = require(AppChat.Models.ConversationChannels)
local GetConversationMessageListStore = require(AppChat.Stores.GetConversationMessageListStore)
local FFlagAppChatCoalesceSendMessageWrites = require(AppChat.Flags.FFlagAppChatCoalesceSendMessageWrites)
local FFlagAppChatPerfTracking = require(AppChat.Flags.FFlagAppChatPerfTracking)
local FFlagAppChatMessageTTIMilestones = require(AppChat.Flags.FFlagAppChatMessageTTIMilestones)
local AppChatPerfTracker = require(AppChat.Telemetry.AppChatPerfTracker)

local num1 = 0

local var1 = require(AppChat.Logger):new(script.Name)

local function getAscendingNumber(): number -- Luacid: Inlined by compiler; 1 call site recovered
    num1 += 1
    return num1
end

local var2 = setmetatable({}, SendMessagePolicy)
var2.__index = var2

function var2.new(arg1, conversationId, replyingToMessage)
    return (setmetatable({
        messageSendingId = MessageModel.newSendingId(),
        conversationId = conversationId,
        replyingToMessage = replyingToMessage
    }, arg1))
end

function var2.onBeforeSendingMessage(arg1, arg2)
    var1:trace(
        "onBeforeSendingMessage conversationId: {} messageSendingId: {}, replyingToId: {}",
        arg1.conversationId,
        arg1.messageSendingId,
        if arg1.replyingToMessage then arg1.replyingToMessage.id else nil
    )

    local deepValue2 = getDeepValue2(arg2:getState(), `ChatAppReducer.Conversations.{arg1.conversationId}`)
    local moderationType = deepValue2 and deepValue2.moderationType

    local var3 = MessageModel.newSending(
        Immutable.JoinDictionaries({
            id = arg1.messageSendingId,
            order = getAscendingNumber(),
            conversationId = arg1.conversationId,
            repliesTo = arg1.replyingToMessage,
            sent = DateTime.now(),
            moderationType = moderationType
        }, arg1:sendingMessagePayload())
    )
    arg1.sendingMessageStableKey = var3.stableKey
    assert(var3, "Failed to create sending message placeholder")

    arg2:dispatch(SendingMessage(arg1.conversationId, var3))
end

function var2.sendingMessagePayload(_)
    error("Override me")
end

function var2.onSuccess(arg1, arg2, arg3)
    var1:debug(
        "Message sent successfully. conversationId: {} messageSendingId: {} replyingToId: {}",
        arg1.conversationId,
        arg1.messageSendingId,
        if arg1.replyingToMessage then arg1.replyingToMessage.id else nil
    )

    if FFlagAppChatPerfTracking then
        if FFlagAppChatMessageTTIMilestones then
            local tbl1 = {
                conversationId = arg1.conversationId
            }
            AppChatPerfTracker.trackMilestone(
                AppChatPerfTracker.Events.MessageSendTTI,
                AppChatPerfTracker.Milestone.PrimaryDataReady.Name,
                tbl1
            )

            AppChatPerfTracker.trackSubphase(
                AppChatPerfTracker.Events.MessageSendTTI,
                AppChatPerfTracker.Milestone.PrimaryDataReady.Name,
                AppChatPerfTracker.Milestone.PrimaryDataReady.Subphase.ResponseReceived,
                tbl1
            )
        else
            AppChatPerfTracker.start(
                AppChatPerfTracker.Events.MessageSendResponseToFinalRender,
                {
                    conversationId = arg1.conversationId
                }
            )
        end
    end
    if FFlagAppChatCoalesceSendMessageWrites then
        GetConversationMessageListStore(false).batchMutations(function()
            arg2:dispatch(SentMessage(arg1.conversationId, arg1.messageSendingId))
            arg2:dispatch(ReceivedChatResponse(arg1.conversationId, arg3.responseBody, arg1.sendingMessageStableKey))
        end)

        return arg3
    end

    arg2:dispatch(SentMessage(arg1.conversationId, arg1.messageSendingId))
    arg2:dispatch(ReceivedChatResponse(arg1.conversationId, arg3.responseBody, arg1.sendingMessageStableKey))
    return arg3
end

function var2.onFailure(arg1, arg2, arg3)
    var1:error(
        "Failed to send message. conversationId: {}, messageSendingId: {}, responseCode: {}",
        arg1.conversationId,
        arg1.messageSendingId,
        arg3.responseCode
    )

    if FFlagAppChatPerfTracking then
        if FFlagAppChatMessageTTIMilestones then
            local tbl1 = {
                conversationId = arg1.conversationId
            }
            AppChatPerfTracker.trackMilestone(
                AppChatPerfTracker.Events.MessageSendTTI,
                AppChatPerfTracker.Milestone.PrimaryDataReady.Name,
                tbl1
            )

            AppChatPerfTracker.trackSubphase(
                AppChatPerfTracker.Events.MessageSendTTI,
                AppChatPerfTracker.Milestone.PrimaryDataReady.Name,
                AppChatPerfTracker.Milestone.PrimaryDataReady.Subphase.ResponseReceived,
                tbl1
            )
        else
            AppChatPerfTracker.start(
                AppChatPerfTracker.Events.MessageSendResponseToFinalRender,
                {
                    conversationId = arg1.conversationId
                }
            )
        end
    end
    if not arg3
        or arg3.responseCode ~= nil and arg3.responseCode ~= StatusCodes.OK
        or arg3.StatusCode ~= nil and arg3.StatusCode ~= StatusCodes.OK
        or not arg3.responseBody
        or not arg3.responseBody.messages
        or #arg3.responseBody.messages == 0
    then
        if arg3.StatusCode ~= StatusCodes.CONFLICT then
            arg2:dispatch(MessageFailedToSend(arg1.conversationId, arg1.messageSendingId))
            var1:error("Message could not be sent, no response body or no messages in response body")
            return arg3
        end

        var1:error("Message sent conflicting system (409). Reloading messages...")
        arg2:dispatch(ReceivedChannelsMigrationConflict())
        local var3 = NavigateIntoChat
        local tbl1 = {
            screen = EnumScreens.ChatLanding,
            params = {
                key = tostring(os.clock())
            }
        }
        arg2:dispatch(var3(tbl1))
        return arg3
    elseif arg3.responseBody.messages[1].status and arg3.responseBody.messages[1].status == ResponseStatus.MODERATED then
        arg2:dispatch(MessageModerated(arg1.conversationId, arg1.messageSendingId))
        var1:error("Message was moderated.")
        return arg3
    else
        arg2:dispatch(MessageFailedToSend(arg1.conversationId, arg1.messageSendingId))
        var1:error("Message could not be sent, no response body or no messages in response body")

        return arg3
    end
end
return var2
