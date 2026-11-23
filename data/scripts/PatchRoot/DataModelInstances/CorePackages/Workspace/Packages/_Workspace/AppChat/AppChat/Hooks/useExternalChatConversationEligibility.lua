-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:40:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local Signals = require(AppChatParent.Signals)
local SignalsReact = require(AppChatParent.SignalsReact)
local createCurrentTimeSignal = require(AppChatParent.SignalsUtils).createCurrentTimeSignal

local GetChatModerationStatusDataHydration = require(AppChat.Stores.GetChatModerationStatusDataHydration)
local _GetConversationStore = require(AppChat.Stores.GetConversationStore)
local getConversationSendEligibilityStatus = require(AppChat.Utils.getConversationSendEligibilityStatus)

local function areResultsEqual(tbl1, tbl2)
    if tbl1.isLoading ~= tbl2.isLoading or #tbl1.eligibleConversations ~= #tbl2.eligibleConversations then
        return false
    end

    for k, eligibleConversation in tbl1.eligibleConversations do
        if eligibleConversation ~= tbl2.eligibleConversations[k] then
            return false
        end
    end

    return true
end

local function useExternalChatConversationEligibility(tbl1)
    local timeoutStore = GetChatModerationStatusDataHydration()
    local var1 = React.useMemo(function()
        return createCurrentTimeSignal(1)
    end, {})

    local var2 = React.useMemo(function()
        return Signals.createComputed(function(scope)
            local eligibleConversations = {}
            if not tbl1.isActive then
                return { eligibleConversations = eligibleConversations, isLoading = true }
            end

            local currentTimestamp = var1(scope)
            for _, conversation in tbl1.conversations do
                local conversationSendEligibilityStatus = getConversationSendEligibilityStatus({
                    allowConversationStatusLoading = false,
                    conversation = conversation,
                    currentTimestamp = currentTimestamp,
                    isAvailable = true,
                    isGroupChatEnabled = tbl1.isGroupChatEnabled,
                    scope = scope,
                    timeoutStore = timeoutStore
                })
                if conversationSendEligibilityStatus == "loading" then
                    return {
                        eligibleConversations = {},
                        isLoading = true
                    }
                end

                if conversationSendEligibilityStatus ~= "eligible" then
                    continue
                end

                table.insert(eligibleConversations, conversation)
                if #eligibleConversations >= tbl1.maxConversationCount then
                    break
                end
            end

            return { eligibleConversations = eligibleConversations, isLoading = false }
        end, areResultsEqual)
    end, {
        var1,
        tbl1.conversations,
        tbl1.isActive,
        tbl1.isGroupChatEnabled,
        tbl1.maxConversationCount,
        timeoutStore
    })

    return SignalsReact.useSignalState(var2)
end

return useExternalChatConversationEligibility
