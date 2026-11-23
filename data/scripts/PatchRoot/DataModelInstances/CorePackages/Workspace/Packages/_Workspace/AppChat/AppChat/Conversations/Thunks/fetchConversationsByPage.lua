-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:51:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local var1 = require(AppChat.Logger):new(script.Name)

local processConversations = require(script.Parent.processConversations)
local FFlagAppChatPerfTracking = require(AppChat.Flags.FFlagAppChatPerfTracking)
local FFlagAppChatMessageTTIMilestones = require(AppChat.Flags.FFlagAppChatMessageTTIMilestones)
local FFlagAppChatConversationStore = require(AppChat.Flags.FFlagAppChatConversationStore)
local AppChatPerfTracker = require(AppChat.Telemetry.AppChatPerfTracker)
local ReceivedPageConversations = require(AppChat.Conversations.Actions.ReceivedPageConversations)
local RequestPageConversations = require(AppChat.Conversations.Actions.RequestPageConversations)

return function(str1: string?)
    var1:info("Fetching conversations by page with cursor {}", str1 or "nil")
    return function(arg1)
        if FFlagAppChatPerfTracking and FFlagAppChatMessageTTIMilestones and str1 == nil then
            AppChatPerfTracker.trackMilestone(
                AppChatPerfTracker.Events.ChatLandingTTI,
                AppChatPerfTracker.Milestone.PrimaryDataStarted.Name
            )
            AppChatPerfTracker.trackSubphase(
                AppChatPerfTracker.Events.ChatLandingTTI,
                AppChatPerfTracker.Milestone.PrimaryDataStarted.Name,
                AppChatPerfTracker.Milestone.PrimaryDataStarted.Subphase.NetworkFetch
            )
            AppChatPerfTracker.trackRequest(
                AppChatPerfTracker.Events.ChatLandingTTI,
                AppChatPerfTracker.Milestone.PrimaryDataStarted.Name,
                "GetUserConversations"
            )
        end

        if FFlagAppChatConversationStore then
            arg1:dispatch(RequestPageConversations())
        end

        return arg1:dispatch(AppChatNetworking.rodux.GetUserConversations.API(str1)):tap(function(arg2)
            arg1:dispatch(processConversations(arg2.responseBody.conversations))
            if FFlagAppChatConversationStore then
                arg1:dispatch(ReceivedPageConversations())
            end

            if FFlagAppChatPerfTracking and FFlagAppChatMessageTTIMilestones and str1 == nil then
                AppChatPerfTracker.trackMilestone(
                    AppChatPerfTracker.Events.ChatLandingTTI,
                    AppChatPerfTracker.Milestone.PrimaryDataReady.Name
                )
                AppChatPerfTracker.trackSubphase(
                    AppChatPerfTracker.Events.ChatLandingTTI,
                    AppChatPerfTracker.Milestone.PrimaryDataReady.Name,
                    AppChatPerfTracker.Milestone.PrimaryDataReady.Subphase.ResponseReceived
                )
            end
        end):andThen(function(arg2)
            local responseBody = arg2.responseBody
            if responseBody and responseBody.next_cursor and responseBody.next_cursor ~= "" then
                var1:debug("Next cursor found: {}", responseBody.next_cursor)
                return str1, responseBody.next_cursor
            end
            var1:debug("No next cursor found")
            return str1, ""
        end):catch(function(arg2)
            if FFlagAppChatConversationStore then
                arg1:dispatch(ReceivedPageConversations())
            end
            var1:warning("Error in GetUserConversations request. Error: {}", tostring(arg2))
        end)
    end
end
