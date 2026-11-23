-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:40:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local DataHydration = require(AppChatParent.DataHydration)
local _Signals = require(AppChatParent.Signals)

local ConversationChannels = require(AppChat.Models.ConversationChannels)
local _GetChatModerationStatusDataHydration = require(AppChat.Stores.GetChatModerationStatusDataHydration)
local _GetConversationStore = require(AppChat.Stores.GetConversationStore)
local useIsUserPending = require(AppChat.Hooks.useIsUserPending)
local getEffectiveChatTimeoutDetails = require(AppChat.Utils.getEffectiveChatTimeoutDetails)
local getUserSendEligibilityStatus = require(AppChat.Utils.getUserSendEligibilityStatus)
local toTimeoutEntry = require(AppChat.Utils.toTimeoutEntry)

local function isConversationPending(conversation) -- Luacid: Inlined by compiler; 1 call site recovered
    return conversation.participantPendingStatus == ConversationChannels.UserPendingStatus.Pending
        or useIsUserPending(conversation)
end

local function getConversationSendEligibilityStatus(tbl1)
    local conversation = tbl1.conversation
    if not tbl1.isAvailable then
        return "ineligible"
    end
    if not tbl1.isGroupChatEnabled and conversation.conversationType == "MultiUserConversation" then
        return "ineligible"
    end

    if isConversationPending(conversation) then
        return "ineligible"
    end

    local userSendEligibilityStatus = getUserSendEligibilityStatus(
        {
            currentTimestamp = tbl1.currentTimestamp,
            isAvailable = tbl1.isAvailable,
            scope = tbl1.scope
        }
    )

    if userSendEligibilityStatus ~= "eligible" then
        return userSendEligibilityStatus
    end

    if conversation.source == "friends" then
        return "eligible"
    end

    local conversationStatus = tbl1.timeoutStore.getConversationStatus(conversation.id)
    local var1 = conversationStatus.status(tbl1.scope)

    if tbl1.allowConversationStatusLoading or var1 ~= DataHydration.DataStatus.NotReady then
        if var1 == DataHydration.DataStatus.Failed
            or not getEffectiveChatTimeoutDetails(nil, toTimeoutEntry(conversationStatus.data(tbl1.scope)), nil, tbl1.currentTimestamp).isTimedOut
        then
            return "eligible"
        end

        return "ineligible"
    end

    return "loading"
end

return getConversationSendEligibilityStatus
