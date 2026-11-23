-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:51:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local AppChatNetworking = require(AppChatParent.AppChatNetworking)

local processConversations = require(script.Parent.processConversations)
local ConversationChannels = require(AppChat.Models.ConversationChannels)
local Logger = require(AppChat.Logger)
local FFlagAppChatPerfTracking = require(AppChat.Flags.FFlagAppChatPerfTracking)
local FFlagAppChatMessageTTIMilestones = require(AppChat.Flags.FFlagAppChatMessageTTIMilestones)
local AppChatPerfTracker = require(AppChat.Telemetry.AppChatPerfTracker)

return function(conversationId: string)
    return function(arg1)
        Logger:info("Fetching latest conversation details for conversationId: {}", conversationId)

        if FFlagAppChatPerfTracking and FFlagAppChatMessageTTIMilestones then
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
                "GetConversationDetails",
                tbl1
            )
        end

        return arg1:dispatch(AppChatNetworking.rodux.GetConversationDetails.API(conversationId)):andThen(function(arg2)
            local responseBody = arg2.responseBody

            assert(
                responseBody.conversations and #responseBody.conversations == 1,
                "Expected exactly one conversation in response body"
            )

            arg1:dispatch(processConversations(responseBody.conversations))

            if FFlagAppChatPerfTracking and FFlagAppChatMessageTTIMilestones then
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
            end

            return ConversationChannels.fromChannelsApi(responseBody.conversations[1])
        end):catch(function(arg2)
            Logger:warning("Failure in fetchLatestConversationDetails, Status: " .. tostring(arg2))
        end)
    end
end
