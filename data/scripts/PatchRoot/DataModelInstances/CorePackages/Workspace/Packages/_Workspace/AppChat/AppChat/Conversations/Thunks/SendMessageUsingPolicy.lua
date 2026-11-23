-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:00:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local RequestTimeDiag = require(AppChatParent.Analytics).RequestTimeDiag
local FFlagDisableLegacyReportToDiag = require(AppChatParent.SharedFlags.FFlagDisableLegacyReportToDiag)
local Constants = require(AppChat.Constants)
local Promise = require(AppChatParent.Promise)
local StatusCodes = require(AppChatParent.Http).StatusCodes

local ResponseStatus = require(AppChatParent.AppChatNetworking).Constants.ResponseStatus
local FFlagAppChatPerfTracking = require(AppChat.Flags.FFlagAppChatPerfTracking)
local FFlagAppChatMessageTTIMilestones = require(AppChat.Flags.FFlagAppChatMessageTTIMilestones)
local AppChatPerfTracker = require(AppChat.Telemetry.AppChatPerfTracker)
local var1 = require(AppChat.Logger):new(script.Name)

local function invokeSendMessage(arg1, arg2)
    local success, result = pcall(function()
        return arg1:sendMessage(arg2)
    end)
    if success then
        return result
    end

    var1:error("sendPolicy:sendMessage threw synchronously: {}", tostring(result))
    return Promise.reject({ sendMessageSyncError = tostring(result) })
end

return function(arg1, _)
    local var2 = if FFlagDisableLegacyReportToDiag then nil else RequestTimeDiag:new(Constants.PerformanceMeasurement.LUA_CHAT_SEND_MESSAGE)

    return function(arg2)
        arg1:onBeforeSendingMessage(arg2)

        if FFlagAppChatPerfTracking and FFlagAppChatMessageTTIMilestones then
            local tbl1 = {
                conversationId = arg1.conversationId
            }
            AppChatPerfTracker.trackMilestone(
                AppChatPerfTracker.Events.MessageSendTTI,
                AppChatPerfTracker.Milestone.PrimaryDataStarted.Name,
                tbl1
            )

            AppChatPerfTracker.trackSubphase(
                AppChatPerfTracker.Events.MessageSendTTI,
                AppChatPerfTracker.Milestone.PrimaryDataStarted.Name,
                AppChatPerfTracker.Milestone.PrimaryDataStarted.Subphase.NetworkFetch,
                tbl1
            )

            AppChatPerfTracker.trackRequest(
                AppChatPerfTracker.Events.MessageSendTTI,
                AppChatPerfTracker.Milestone.PrimaryDataStarted.Name,
                "SendChatTextMessage",
                tbl1
            )
        end

        return invokeSendMessage(arg1, arg2):andThen(function(arg3)
            if var2 then
                var2:report()
            end

            if not arg3
                or not arg3.responseBody
                or arg3.responseCode ~= StatusCodes.OK
                or not arg3.responseBody.messages
                or #arg3.responseBody.messages == 0
                or arg3.responseBody.messages[1].status
                    and arg3.responseBody.messages[1].status ~= ""
                    and arg3.responseBody.messages[1].status ~= ResponseStatus.SUCCESS
            then
                return Promise.reject(arg3)
            end

            return arg3
        end):andThen(function(arg3)
            return arg1:onSuccess(arg2, arg3)
        end):catch(function(arg3)
            return arg1:onFailure(arg2, arg3)
        end)
    end
end
