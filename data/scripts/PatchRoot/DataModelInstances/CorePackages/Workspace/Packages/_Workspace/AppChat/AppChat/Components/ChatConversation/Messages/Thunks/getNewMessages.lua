-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:31:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local Promise = require(AppChatParent.Promise)
local FFlagDisableLegacyReportToDiag = require(AppChatParent.SharedFlags.FFlagDisableLegacyReportToDiag)
local FFlagAppChatEnableReactions = require(AppChatParent.SharedFlags).FFlagAppChatEnableReactions

local Constants = require(AppChat.Constants)
local reportToDiagByCountryCode = require(AppChat.Utils.reportToDiagByCountryCode)
local var1 = require(AppChat.Logger):new(script.Name)
local FFlagAppChatPerfTracking = require(AppChat.Flags.FFlagAppChatPerfTracking)
local FFlagAppChatMessageTTIMilestones = require(AppChat.Flags.FFlagAppChatMessageTTIMilestones)
local AppChatPerfTracker = require(AppChat.Telemetry.AppChatPerfTracker)
local GetMessageReactionsStore = require(AppChat.Stores.GetMessageReactionsStore)

local function func1(num1: number) -- Luacid: Inlined by compiler; 1 call site recovered
    local var2 = tick() - num1
    reportToDiagByCountryCode(Constants.PerformanceMeasurement.LUA_CHAT_RECEIVE_MESSAGE, "MessageReceivedTime", var2)
end

return function(conversationId: string, bool1: boolean, num1: number)
    var1:info("Getting new messages for {}", conversationId)
    return function(arg1)
        local tbl1 = {}
        if not arg1:getState().ChatAppReducer.Conversations[conversationId] then
            local var2 = arg1:dispatch(AppChatNetworking.rodux.GetConversationDetails.API(conversationId))

            table.insert(tbl1, var2:catch(function(arg2)
                var1:error(`AppChatNetworking failure in GetConversationDetails: {tostring(arg2)}`)
            end))
        end

        local var2 = FFlagAppChatPerfTracking and FFlagAppChatMessageTTIMilestones and not bool1

        if var2 then
            local tbl2 = { conversationId = conversationId }
            AppChatPerfTracker.trackMilestone(
                AppChatPerfTracker.Events.MessageReceiveTTI,
                AppChatPerfTracker.Milestone.PrimaryDataStarted.Name,
                tbl2
            )

            AppChatPerfTracker.trackSubphase(
                AppChatPerfTracker.Events.MessageReceiveTTI,
                AppChatPerfTracker.Milestone.PrimaryDataStarted.Name,
                AppChatPerfTracker.Milestone.PrimaryDataStarted.Subphase.NetworkFetch,
                tbl2
            )

            AppChatPerfTracker.trackRequest(
                AppChatPerfTracker.Events.MessageReceiveTTI,
                AppChatPerfTracker.Milestone.PrimaryDataStarted.Name,
                "GetNewerMessages",
                tbl2
            )
        end

        local var3 = arg1:dispatch(AppChatNetworking.rodux.GetNewerMessages.API(conversationId)):andThen(function(arg2)
            if not FFlagDisableLegacyReportToDiag then
                func1(num1)
            end
            if var2 then
                local tbl2 = { conversationId = conversationId }
                AppChatPerfTracker.trackMilestone(
                    AppChatPerfTracker.Events.MessageReceiveTTI,
                    AppChatPerfTracker.Milestone.PrimaryDataReady.Name,
                    tbl2
                )

                AppChatPerfTracker.trackSubphase(
                    AppChatPerfTracker.Events.MessageReceiveTTI,
                    AppChatPerfTracker.Milestone.PrimaryDataReady.Name,
                    AppChatPerfTracker.Milestone.PrimaryDataReady.Subphase.ResponseReceived,
                    tbl2
                )
            end

            if FFlagAppChatEnableReactions and arg2.responseBody then
                GetMessageReactionsStore(false).ingestMessageReactions(arg2.responseBody.messages)
            end
        end)

        table.insert(tbl1, var3:catch(function(arg2)
            var1:error(`AppChatNetworking failure in GetNewerMessages: {tostring(arg2)}`)
        end))

        return Promise.allSettled(tbl1)
    end
end
