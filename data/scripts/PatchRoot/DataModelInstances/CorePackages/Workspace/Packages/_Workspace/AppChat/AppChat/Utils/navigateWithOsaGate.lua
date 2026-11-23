-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:41:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local SharedFlags = require(AppChatParent.SharedFlags)
local Constants = require(AppChat.Constants)
local GetOverlayStore = require(AppChat.Stores.GetOverlayStore)
local OverlayTypes = require(AppChat.Stores.GetOverlayStore.OverlayTypes)
local Logger = require(AppChat.Logger)
local fetchLatestConversationDetails = require(AppChat.Conversations.Thunks.fetchLatestConversationDetails)
local shouldShowOSAForConversation = require(AppChat.Utils.shouldShowOSAForConversation)
local shouldShowU13ChatOptInForConversation = require(AppChat.Utils.shouldShowU13ChatOptInForConversation)
local RemovedConversation = require(AppChat.Conversations.Actions.RemovedConversation)
local ReceivedConversation = require(AppChat.Conversations.Actions.ReceivedConversation)
local GetConversationStore = require(AppChat.Stores.GetConversationStore)
local Conversation = require(AppChat.Models.Conversation)
local ConversationRoduxSeed = require(AppChat.Utils.ConversationRoduxSeed)
local isFriendsPlaceholderConversation = ConversationRoduxSeed.isFriendsPlaceholderConversation

local FFlagAppChatShowOSAOnPageEntry = SharedFlags.FFlagAppChatShowOSAOnPageEntry

local function evaluateAndShowGate(tbl1, arg1)
    local conversationId = tbl1.conversationId
    local dispatch = tbl1.dispatch
    local onAccepted = tbl1.onAccepted
    local onDeclined = tbl1.onDeclined

    local var1 = nil
    local var2 = shouldShowU13ChatOptInForConversation(arg1)
    if var2 and tbl1.requireMultiUserForU13 then
        var2 = arg1 and arg1.conversationType == Conversation.Type.MULTI_USER_CONVERSATION
    end
    if var2 then
        var1 = Constants.OptInVariant.ChatOptInInfoCard
    elseif shouldShowOSAForConversation(arg1) then
        var1 = Constants.OptInVariant.OsaContextCard
    end

    if not var1 then
        onAccepted()
        return
    end

    local overlayStore = GetOverlayStore(false)
    Logger:debug("[OSA Gate] Showing overlay variant={} for conversation {}", var1, conversationId)
    overlayStore.showOverlay(OverlayTypes.GroupOSADialog, {
        conversationId = conversationId,
        impressionId = HttpService:GenerateGUID(false),
        modalVariant = var1,
        onJoin = function()
            overlayStore.dismissOverlay()
            onAccepted()
        end,
        onDecline = function()
            if conversationId and arg1 and arg1.conversationType == Conversation.Type.MULTI_USER_CONVERSATION then
                dispatch(RemovedConversation(conversationId))
            end
            overlayStore.dismissOverlay()
            if onDeclined then
                onDeclined()
            end
        end,
        onClose = function()
            if onDeclined then
                onDeclined()
            end
        end
    })
end

local function getConversationFromStore(callback: (...any) -> (...any), str1: string) -- Luacid: unused: defined but never referenced
    local conversation = nil
    callback(function(arg1)
        conversation = arg1:getState().ChatAppReducer.Conversations[str1]
    end)
    return conversation
end

local function seedConversationFromSignals(callback: (...any) -> (...any), conversationId: string) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = GetConversationStore(false).getConversation(conversationId, false)
    if var1 == nil then
        return nil
    end

    local var2 = ConversationRoduxSeed.normalizeStoreConversationForRodux(var1)
    callback(ReceivedConversation(var2))
    return var2
end

return function(tbl1)
    local conversationId = tbl1.conversationId
    local dispatch = tbl1.dispatch
    local onAccepted = tbl1.onAccepted

    if not FFlagAppChatShowOSAOnPageEntry or not conversationId or conversationId == "" then
        onAccepted()
        return
    end

    local conversation = nil
    dispatch(function(arg1)
        conversation = arg1:getState().ChatAppReducer.Conversations[conversationId]
    end)
    local var1 = conversation

    if var1 == nil then
        var1 = seedConversationFromSignals(dispatch, conversationId)
    end

    if isFriendsPlaceholderConversation(conversationId, var1) then
        evaluateAndShowGate(tbl1, var1)
        return
    end

    dispatch(fetchLatestConversationDetails(conversationId)):andThen(function()
        local func1 = evaluateAndShowGate
        local tbl2 = tbl1
        local var2 = dispatch
        local var3 = conversationId
        local conversation2 = nil
        var2(function(arg1)
            conversation2 = arg1:getState().ChatAppReducer.Conversations[var3]
        end)
        func1(tbl2, conversation2)
    end):catch(function(arg1)
        Logger:warning("[OSA Gate] Error fetching conversation details for {}: {}", conversationId, tostring(arg1))
        if tbl1.onError then
            tbl1.onError(arg1)
        end
    end)
end
