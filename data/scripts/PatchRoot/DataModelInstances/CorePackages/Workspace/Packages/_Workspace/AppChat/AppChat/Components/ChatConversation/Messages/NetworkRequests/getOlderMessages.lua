-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:30:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local FFlagAppChatEnableReactions = require(AppChatParent.SharedFlags).FFlagAppChatEnableReactions

local FFlagAppChatPerfTracking = require(AppChat.Flags.FFlagAppChatPerfTracking)
local FFlagAppChatMessageTTIMilestones = require(AppChat.Flags.FFlagAppChatMessageTTIMilestones)
local FFlagAppChatIncrementalPaginationProjection = require(AppChat.Flags.FFlagAppChatIncrementalPaginationProjection)
local AppChatPerfTracker = require(AppChat.Telemetry.AppChatPerfTracker)
local GetConversationMessageViewModelStore = require(AppChat.Stores.GetConversationMessageViewModelStore)
local GetMessageReactionsStore = require(AppChat.Stores.GetMessageReactionsStore)

return function(conversationId: string, _, str1: string?)
    return function(arg1)
        local var1 = FFlagAppChatPerfTracking and FFlagAppChatMessageTTIMilestones and str1 == nil

        if var1 then
            local tbl1 = { conversationId = conversationId }
            AppChatPerfTracker.trackMilestone(
                AppChatPerfTracker.Events.ChatConversationTTI,
                AppChatPerfTracker.Milestone.PrimaryDataStarted.Name,
                tbl1
            )

            AppChatPerfTracker.trackSubphase(
                AppChatPerfTracker.Events.ChatConversationTTI,
                AppChatPerfTracker.Milestone.PrimaryDataStarted.Name,
                AppChatPerfTracker.Milestone.PrimaryDataStarted.Subphase.NetworkFetch,
                tbl1
            )

            AppChatPerfTracker.trackRequest(
                AppChatPerfTracker.Events.ChatConversationTTI,
                AppChatPerfTracker.Milestone.PrimaryDataStarted.Name,
                "GetOlderMessages",
                tbl1
            )
        end

        if FFlagAppChatIncrementalPaginationProjection then
            GetConversationMessageViewModelStore(false).conversationMessageListStore.setLoading(conversationId, true)
        end
        local var2 = arg1:dispatch(AppChatNetworking.rodux.GetOlderMessages.API(conversationId, str1))

        if var1 then
            var2 = var2:tap(function()
                local tbl1 = { conversationId = conversationId }
                AppChatPerfTracker.trackMilestone(
                    AppChatPerfTracker.Events.ChatConversationTTI,
                    AppChatPerfTracker.Milestone.PrimaryDataReady.Name,
                    tbl1
                )

                AppChatPerfTracker.trackSubphase(
                    AppChatPerfTracker.Events.ChatConversationTTI,
                    AppChatPerfTracker.Milestone.PrimaryDataReady.Name,
                    AppChatPerfTracker.Milestone.PrimaryDataReady.Subphase.ResponseReceived,
                    tbl1
                )
            end)
        end

        if FFlagAppChatEnableReactions then
            var2 = var2:andThen(function(arg2)
                if arg2.responseBody then
                    GetMessageReactionsStore(false).ingestMessageReactions(arg2.responseBody.messages)
                end
                return arg2
            end)
        end

        if FFlagAppChatIncrementalPaginationProjection then
            var2 = var2:finally(function()
                GetConversationMessageViewModelStore(false).conversationMessageListStore.setLoading(conversationId, false)
            end)
        end

        return var2:catch(function(arg2)
            warn("AppChatNetworking failure in getOlderMessages, Status: " .. tostring(arg2))
        end)
    end
end
