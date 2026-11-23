-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:00:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent
local FFlagBuildExperienceModelPicker = require(BuildExperience.Flags.FFlagBuildExperienceModelPicker)

local CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)
local SharedFlags = require(BuildExperienceParent.SharedFlags)
local Signals = require(BuildExperienceParent.Signals)
local LocalizationStrings = require(BuildExperience.LocalizationStrings)
local FFlagBuildExperiencePromptFailureTelemetry = SharedFlags.FFlagBuildExperiencePromptFailureTelemetry
local FFlagBuildExperienceLibrary = SharedFlags.FFlagBuildExperienceLibrary
local FFlagBuildExperienceManageDevProduct = require(BuildExperience.Flags.FFlagBuildExperienceManageDevProduct)
local FFlagBuildExperienceManageGamePass = SharedFlags.FFlagBuildExperienceManageGamePass
local FFlagBuildExperienceManageSubscription = SharedFlags.FFlagBuildExperienceManageSubscription

local _chatTypes = require(script.Parent.chatTypes)
local askUserController = require(script.Parent.askUserController)
local clientDataModelController = require(script.Parent.clientDataModelController)
local clientLogsController = require(script.Parent.clientLogsController)
local localToolOverlay = require(script.Parent.localToolOverlay)
local isWaitingOnUserInput = require(script.Parent.isWaitingOnUserInput)
local proposePlanController = require(script.Parent.proposePlanController)
local askManageDevProductController = if FFlagBuildExperienceManageDevProduct then require(script.Parent.askManageDevProductController) else nil
local var1 = FFlagBuildExperienceManageGamePass and FFlagBuildExperienceManageDevProduct
local askManageGamePassController = if var1 then require(script.Parent.askManageGamePassController) else nil
local var2 = FFlagBuildExperienceManageSubscription and FFlagBuildExperienceManageDevProduct
local var3 = var1 or var2
local askManageSubscriptionController = if var2 then require(script.Parent.askManageSubscriptionController) else nil
local unifiedMonetizationTool = require(script.Parent.unifiedMonetizationTool)
local createPromptLifecycleTelemetry = require(BuildExperience.Telemetry.createPromptLifecycleTelemetry)
local sendBuildExperienceEvent = require(BuildExperience.Telemetry.sendBuildExperienceEvent)
local FFlagBuildEventsUpdate1 = require(BuildExperience.Flags.FFlagBuildEventsUpdate1)
local FFlagBuildExperienceHistoryPollTelemetry = SharedFlags.FFlagBuildExperienceHistoryPollTelemetry
local FFlagBuildExperienceChatOpenId = require(BuildExperience.Flags.FFlagBuildExperienceChatOpenId)

local StudioAskUserTool = CreatorAgentChat.StudioAskUserTool
local StudioClientDataModelTools = CreatorAgentChat.StudioClientDataModelTools
local StudioClientLogsTool = CreatorAgentChat.StudioClientLogsTool
local StudioProposePlanTool = CreatorAgentChat.StudioProposePlanTool
local StudioManageDevProductTool = CreatorAgentChat.StudioManageDevProductTool
local StudioManageGamePassTool = CreatorAgentChat.StudioManageGamePassTool
local StudioManageSubscriptionTool = CreatorAgentChat.StudioManageSubscriptionTool
local debug2 = CreatorAgentChat.debug
local TurnStateReducer = CreatorAgentChat.TurnStateReducer

local ErrorCodes = CreatorAgentChat.ErrorCodes

local Forbidden = ErrorCodes.Forbidden
local tbl1 = {
    FreeTrialExhausted = "FreeTrialExhausted",
    DailyLimitReached = "DailyLimitReached",
    InsufficientRobuxBalance = "InsufficientRobuxBalance"
}

local tbl2 = {
    [ErrorCodes.InvalidParams] = LocalizationStrings.CHAT_ERROR_INVALID_PARAMS,
    [ErrorCodes.Unauthorized] = LocalizationStrings.CHAT_ERROR_UNAUTHORIZED,
    [ErrorCodes.Forbidden] = LocalizationStrings.CHAT_ERROR_FORBIDDEN,
    [ErrorCodes.NotFound] = LocalizationStrings.CHAT_ERROR_NOT_FOUND,
    [ErrorCodes.Conflict] = LocalizationStrings.CHAT_ERROR_CONFLICT,
    [ErrorCodes.Gone] = LocalizationStrings.CHAT_ERROR_GONE,
    [ErrorCodes.UpstreamUnavailable] = LocalizationStrings.CHAT_ERROR_UPSTREAM_UNAVAILABLE,
    [ErrorCodes.InternalError] = LocalizationStrings.CHAT_ERROR_INTERNAL,
    [ErrorCodes.OutOfCredits] = LocalizationStrings.CHAT_ERROR_OUT_OF_CREDITS
}

local function getPromptFailureComposerError(tbl3) -- Luacid: Inlined by compiler; 5 call sites recovered
    if tbl3.isContentPolicy then
        return LocalizationStrings.CHAT_POLICY_REJECTION
    end
    if tbl3.setupStage == "missing_project" then
        return LocalizationStrings.CHAT_MISSING_PROJECT
    end
    if tbl3.errorCode ~= nil then
        local var4 = tbl2[tbl3.errorCode]
        if var4 ~= nil then
            return var4
        end
    end
    return LocalizationStrings.CHAT_DEFAULT_FAILURE
end

local function getOutOfCreditsReason(error: string?) -- Luacid: Inlined by compiler; 2 call sites recovered
    return if error == nil then nil else tbl1[error]
end

local function resolvePromptFailure(arg1, setupError)
    if arg1 == nil then
        if setupError == nil then
            return nil
        end
        return {
            errorCode = setupError.errorCode,
            outOfCreditsReason = nil,
            isContentPolicy = false,
            setupStage = setupError.stage,
            requestFailure = if FFlagBuildExperiencePromptFailureTelemetry then setupError.requestFailure else nil
        }
    end
    if arg1.status ~= "failed" then
        return nil
    end
    local tbl3 = {
        errorCode = arg1.errorCode,
        outOfCreditsReason = if arg1.errorCode == ErrorCodes.OutOfCredits then (if FFlagBuildExperienceModelPicker then arg1.fundingReason else nil) or getOutOfCreditsReason(arg1.error) else nil,
        isContentPolicy = arg1.errorCode == Forbidden,
        requestFailure = if FFlagBuildExperiencePromptFailureTelemetry then arg1.requestFailure else nil
    }
    return tbl3
end

local function getPromptFailureTelemetryParameters(tbl3)
    local tbl4 = {
        isContentPolicy = tostring(tbl3.isContentPolicy)
    }
    if tbl3.errorCode ~= nil then
        tbl4.errorCode = tostring(tbl3.errorCode)
    end
    if tbl3.outOfCreditsReason ~= nil then
        tbl4.outOfCreditsReason = tbl3.outOfCreditsReason
    end
    if tbl3.setupStage ~= nil then
        tbl4.setupStage = tbl3.setupStage
    end
    return tbl4
end

local function getHistoryPollDropTelemetryParameters(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local tbl3 = {
        pollTrigger = arg1.pollTrigger,
        appliedFromThisPoll = tostring(arg1.appliedFromThisPoll)
    }
    if arg1.priorSequenceId ~= nil then
        tbl3.priorSequenceId = tostring(arg1.priorSequenceId)
    end
    return tbl3
end

local function addPromptFailureTelemetryParameters(promptFailureTelemetryParameters, tbl3) -- Luacid: Inlined by compiler; 1 call site recovered
    local requestFailure = tbl3.requestFailure
    if requestFailure ~= nil then
        promptFailureTelemetryParameters.failureKind = requestFailure.kind
        if requestFailure.httpStatusCode ~= nil then
            promptFailureTelemetryParameters.httpStatusCode = tostring(requestFailure.httpStatusCode)
        end
    end

    promptFailureTelemetryParameters.errorCopyKey = getPromptFailureComposerError(tbl3)
end

local function addLifecycleTelemetryParameters(tbl3, lifecycleParameters) -- Luacid: Inlined by compiler; 2 call sites recovered
    for k, lifecycleParameter in lifecycleParameters do
        tbl3[k] = lifecycleParameter
    end
end

local function getAgentTurnFailureTelemetryParameters(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local tbl3 = {
        status = arg1.status
    }

    if arg1.stopReason ~= nil then
        tbl3.stopReason = arg1.stopReason
    end

    if arg1.errorCode ~= nil then
        tbl3.errorCode = tostring(arg1.errorCode)
    end

    return tbl3
end

local tbl3 = {
    agent_message = true,
    agent_message_chunk = true,
    tool_call_update = true,
    tool_call_content_chunk = true
}

local tbl4 = { tool_call_update = true, tool_call_content_chunk = true }

local function trackPromptActivity(arg1, arg2, getOptimisticLocalTools)
    local emptyTurnState = TurnStateReducer.createEmptyTurnState("", nil)
    local bool1 = false
    local bool2 = false
    local var4 = nil
    local var5 = nil

    local function reportActivity() -- Luacid: Inlined by compiler; 2 call sites recovered
        arg2.markActivity({ hasResponse = bool1, isWaitingOnUser = bool2 })
    end

    local function onUpdate(arg3, sequenceNumber: number?)
        if tbl3[arg3.sessionUpdate] == true then
            bool1 = true
        end
        if tbl4[arg3.sessionUpdate] == true then
            emptyTurnState = TurnStateReducer.applySessionUpdate(emptyTurnState, arg3, { sequenceNumber = sequenceNumber })
            bool2 = isWaitingOnUserInput(emptyTurnState, getOptimisticLocalTools(false).submittedToolCallIds)
        end

        reportActivity()
    end

    local effect = Signals.createEffect(function(arg3)
        local turnHandle = arg1.getTurnHandle(arg3)
        local submittedToolCallIds = getOptimisticLocalTools(arg3).submittedToolCallIds
        if turnHandle ~= nil and turnHandle ~= var4 and turnHandle.onUpdate ~= nil then
            var4 = turnHandle
            var5 = turnHandle.onUpdate(onUpdate)
        end

        local var6 = isWaitingOnUserInput(emptyTurnState, submittedToolCallIds)
        if var6 ~= bool2 then
            bool2 = var6
            reportActivity()
        end
    end)

    return function()
        effect()
        if var5 ~= nil then
            var5()
            var5 = nil
        end
    end
end

local function isAgentTurnFailure(arg1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return arg1.status == "failed" or arg1.stopReason == "error"
end

local function formatSetupErrorMessage(setupError) -- Luacid: Inlined by compiler; 1 call site recovered
    return getPromptFailureComposerError(
        {
            errorCode = setupError.errorCode,
            isContentPolicy = false,
            setupStage = setupError.stage
        }
    )
end

local function createLocalToolControllers(arg1, arg2, func1: ((...any) -> (...any))?)
    local tbl5 = {}
    local var4 = localToolOverlay()
    local var5 = askUserController(arg1, tbl5, var4, arg2)

    local var6 = proposePlanController(arg1, tbl5, var4, arg2)

    local var7 = clientLogsController(arg1, tbl5, func1)

    local var8 = clientDataModelController(arg1, tbl5, func1)
    local var9 = if askManageDevProductController == nil then nil else askManageDevProductController(arg1, tbl5, var4, arg2, unifiedMonetizationTool.toolsByKind.developerProduct)
    local tbl6 = {}
    if var1 then
        table.insert(tbl6, askManageGamePassController(arg1, tbl5, var4, arg2))
    end

    if var2 then
        table.insert(tbl6, askManageSubscriptionController(arg1, tbl5, var4, arg2))
    end

    return {
        getOptimisticLocalTools = var4.getOptimisticLocalTools,
        getLocalToolActions = var4.getLocalToolActions,
        hasDisplayedAnswerStack = var5.hasDisplayedAnswerStack,
        syncFromTurnState = function(arg3)
            var5.syncAnswerStack(arg3)
            var6.syncPlanProposal(arg3)
            var7.syncClientLogsRequest(arg3)
            var8.syncClientDataModelRequests(arg3)
            if var9 ~= nil then
                var9.syncManageDevProductRequests(arg3)
            end
            if not var3 then
                return
            end

            for _, value in tbl6 do
                value.syncRequests(arg3)
            end
        end,
        trySubmitComposerText = function(str1: string)
            if not var3 then
                local var10 = var5.trySubmitComposerText(str1) or var6.trySubmitComposerText(str1)
                return var10 or var9 ~= nil and var9.trySubmitComposerText(str1)
            end

            if var5.trySubmitComposerText(str1)
                or var6.trySubmitComposerText(str1)
                or var9 ~= nil and var9.trySubmitComposerText(str1)
            then
                return true
            end
            for _, value in tbl6 do
                if value.trySubmitComposerText(str1) then
                    return true
                end
            end
            return false
        end,
        trySubmitAnswerText = var5.trySubmitAnswerText,
        stopPending = function()
            var5.stopPendingAnswer()
            var6.stopPendingPlan()
            var8.revokePending()
            if var9 ~= nil then
                var9.stopPending()
            end
            if not var3 then
                return
            end

            for _, value in tbl6 do
                value.stopPending()
            end
        end
    }
end

return {
    createLiveAssistantTurn = function(arg1, prompt, callback: (...any) -> (...any), arg2, func1: ((...any) -> (...any))?, callback2: ((...any) -> (...any))?, callback3: ((...any) -> (...any))?, sendConfiguration, expectedSessionId: string?, isCancelled: ((...any) -> (...any))?)
        local localToolControllers = createLocalToolControllers(arg1, arg2, func1)
        local universeId = arg1.universeId
        local chatOpenId = if FFlagBuildExperienceChatOpenId then CreatorAgentChat.chatOpenTelemetry.getChatOpenIdForUniverse(universeId) else nil
        local localTools = { StudioAskUserTool.LOCAL_TOOL_DEFINITION, StudioProposePlanTool.LOCAL_TOOL_DEFINITION, StudioClientLogsTool.LOCAL_TOOL_DEFINITION }

        table.insert(localTools, StudioClientDataModelTools.SEARCH_LOCAL_TOOL_DEFINITION)
        table.insert(localTools, StudioClientDataModelTools.INSPECT_LOCAL_TOOL_DEFINITION)
        if unifiedMonetizationTool.localToolDefinition ~= nil then
            table.insert(localTools, unifiedMonetizationTool.localToolDefinition)
        else
            if FFlagBuildExperienceManageDevProduct then
                table.insert(localTools, StudioManageDevProductTool.LOCAL_TOOL_DEFINITION)
            end
            if var1 then
                table.insert(localTools, StudioManageGamePassTool.LOCAL_TOOL_DEFINITION)
            end
            if var2 then
                table.insert(localTools, StudioManageSubscriptionTool.LOCAL_TOOL_DEFINITION)
            end
        end

        local promptMeta = {
            _roblox = {
                application = "build-on-mobile",
                localTools = localTools,
                providerConfig = { universeId = universeId }
            }
        }

        local promptLifecycleTelemetry = if FFlagBuildExperiencePromptFailureTelemetry then createPromptLifecycleTelemetry(function()
            return {
                universeId = universeId,
                placeId = arg1.placeId,
                conversationId = arg1.getCasSessionId(),
                chatOpenId = chatOpenId
            }
        end) else nil

        local function onDroppedChatMessage(messageId: number, arg3)
            local tbl7 = {
                universeId = universeId,
                placeId = arg1.placeId,
                conversationId = arg1.getCasSessionId(),
                chatOpenId = chatOpenId,
                messageId = messageId
            }
            sendBuildExperienceEvent(
                "DROPPED_CHAT_MESSAGE",
                tbl7,
                if FFlagBuildExperienceHistoryPollTelemetry and arg3 ~= nil then getHistoryPollDropTelemetryParameters(arg3) else nil
            )
        end

        local bool1 = false
        local function handleReceived(turnId: number?)
            if FFlagBuildEventsUpdate1 and not bool1 then
                sendBuildExperienceEvent("SEND_PROMPT_RECIEVED", {
                    universeId = universeId,
                    placeId = arg1.placeId,
                    conversationId = arg1.getCasSessionId(),
                    chatOpenId = chatOpenId,
                    turnId = turnId
                })
            end
            if callback2 ~= nil then
                callback2(turnId)
            end
        end

        local onAccepted = if FFlagBuildExperienceLibrary then callback3 ~= nil and function()
            if FFlagBuildEventsUpdate1 then
                bool1 = true
                sendBuildExperienceEvent(
                    "SEND_PROMPT_RECIEVED",
                    {
                        universeId = universeId,
                        placeId = arg1.placeId,
                        conversationId = arg1.getCasSessionId(),
                        chatOpenId = chatOpenId
                    }
                )
            end

            callback3()
        end or nil else nil

        local var5 = nil
        local var6 = nil

        local function finishPromptTelemetry(arg3) -- Luacid: Inlined by compiler; 2 call sites recovered
            if var6 ~= nil then
                var6()
                var6 = nil
            end

            arg3.finish()
        end

        local function completeTurn(arg3)
            local var7 = resolvePromptFailure(arg3, var5.getSetupError(false))
            if var7 ~= nil then
                debug2.log("info", "prompt send failed", {
                    errorCode = var7.errorCode,
                    isContentPolicy = var7.isContentPolicy,
                    setupStage = var7.setupStage,
                    universeId = universeId,
                    placeId = arg1.placeId
                })

                local promptFailureTelemetryParameters = getPromptFailureTelemetryParameters(var7)
                if FFlagBuildExperiencePromptFailureTelemetry and promptLifecycleTelemetry ~= nil then
                    addPromptFailureTelemetryParameters(promptFailureTelemetryParameters, var7)
                    addLifecycleTelemetryParameters(promptFailureTelemetryParameters, (promptLifecycleTelemetry.getLifecycleParameters()))
                end

                sendBuildExperienceEvent(
                    "SEND_PROMPT_FAILED",
                    {
                        universeId = universeId,
                        placeId = arg1.placeId,
                        conversationId = arg1.getCasSessionId(),
                        chatOpenId = chatOpenId
                    },
                    promptFailureTelemetryParameters
                )
            elseif FFlagBuildExperiencePromptFailureTelemetry
                and promptLifecycleTelemetry ~= nil
                and arg3 ~= nil
                and isAgentTurnFailure(arg3)
            then
                local agentTurnFailureTelemetryParameters = getAgentTurnFailureTelemetryParameters(arg3)
                addLifecycleTelemetryParameters(
                    agentTurnFailureTelemetryParameters,
                    (promptLifecycleTelemetry.getLifecycleParameters())
                )
                sendBuildExperienceEvent(
                    "AGENT_TURN_FAILED",
                    {
                        universeId = universeId,
                        placeId = arg1.placeId,
                        conversationId = arg1.getCasSessionId(),
                        chatOpenId = chatOpenId
                    },
                    agentTurnFailureTelemetryParameters
                )
            end

            if FFlagBuildExperiencePromptFailureTelemetry and promptLifecycleTelemetry ~= nil then
                finishPromptTelemetry(promptLifecycleTelemetry)
            end

            callback(var7)
        end

        local tbl7 = {
            prompt = prompt,
            promptMeta = promptMeta,
            onDroppedChatMessage = onDroppedChatMessage,
            onReceived = 0,
            onAccepted = 0,
            onCompleted = 0
        }

        if not FFlagBuildEventsUpdate1 and callback2 == nil then
            handleReceived = nil
        end

        tbl7.onReceived = handleReceived
        tbl7.onAccepted = onAccepted
        tbl7.onCompleted = completeTurn

        if FFlagBuildExperienceModelPicker then
            tbl7.sendConfiguration = sendConfiguration
            tbl7.expectedSessionId = expectedSessionId
            tbl7.isCancelled = isCancelled
        end
        var5 = arg1.sendPrompt(tbl7)

        return {
            getOptimisticLocalTools = localToolControllers.getOptimisticLocalTools,
            getLocalToolActions = localToolControllers.getLocalToolActions,
            getSetupErrorText = function(arg3)
                local setupError = var5.getSetupError(arg3)
                if setupError ~= nil then
                    return formatSetupErrorMessage(setupError)
                end

                return nil
            end,
            start = function()
                if FFlagBuildExperiencePromptFailureTelemetry and promptLifecycleTelemetry ~= nil then
                    promptLifecycleTelemetry.start()
                    if var6 == nil then
                        var6 = trackPromptActivity(var5, promptLifecycleTelemetry, localToolControllers.getOptimisticLocalTools)
                    end
                end

                var5.start()
            end,
            stop = function()
                localToolControllers.stopPending()
                var5.stop()
            end,
            reportUserStop = if FFlagBuildExperiencePromptFailureTelemetry and promptLifecycleTelemetry ~= nil then promptLifecycleTelemetry.reportUserStop else nil,
            detach = FFlagBuildExperiencePromptFailureTelemetry and promptLifecycleTelemetry ~= nil and function()
                localToolControllers.stopPending()
                finishPromptTelemetry(promptLifecycleTelemetry)
            end or localToolControllers.stopPending,
            syncFromTurnState = localToolControllers.syncFromTurnState,
            trySubmitComposerText = localToolControllers.trySubmitComposerText,
            trySubmitAnswerText = localToolControllers.trySubmitAnswerText
        }
    end,
    createResumedAssistantTurn = function(arg1, arg2, func1: (...any) -> (...any), afterSequenceId: number?, arg3, func2: ((...any) -> (...any))?)
        local localToolControllers = createLocalToolControllers(arg1, arg3, func2)
        local chatOpenId = if FFlagBuildExperienceChatOpenId then CreatorAgentChat.chatOpenTelemetry.getChatOpenIdForUniverse(arg1.universeId) else nil
        local signal = Signals.createSignal(nil)

        local bool1 = false
        local bool2 = false
        local var4 = nil
        local effect = nil

        local function cleanupObservers() -- Luacid: Inlined by compiler; 3 call sites recovered
            if effect ~= nil then
                effect()
                effect = nil
            end
            if var4 ~= nil then
                var4()
                var4 = nil
            end
        end

        local function finish()
            if bool2 then
                return
            end
            bool2 = true
            cleanupObservers()

            if FFlagBuildExperiencePromptFailureTelemetry then
                local var5 = arg2.state(false)

                if isAgentTurnFailure(var5) and var5.requestId == nil then
                    local agentTurnFailureTelemetryParameters = getAgentTurnFailureTelemetryParameters(var5)
                    agentTurnFailureTelemetryParameters.isResumedTurn = "true"

                    sendBuildExperienceEvent("AGENT_TURN_FAILED", {
                        universeId = arg1.universeId,
                        placeId = arg1.placeId,
                        conversationId = arg1.getCasSessionId(),
                        chatOpenId = chatOpenId
                    }, agentTurnFailureTelemetryParameters)
                end
            end

            local func3 = func1
            local tbl5

            if FFlagBuildExperienceModelPicker then
                local var5 = arg2.state(false)

                if var5 == nil or var5.status ~= "failed" then
                    tbl5 = nil
                else
                    tbl5 = {
                        errorCode = var5.errorCode,
                        outOfCreditsReason = if var5.errorCode == ErrorCodes.OutOfCredits then (if FFlagBuildExperienceModelPicker then var5.fundingReason else nil) or getOutOfCreditsReason(var5.error) else nil,
                        isContentPolicy = var5.errorCode == Forbidden,
                        requestFailure = if FFlagBuildExperiencePromptFailureTelemetry then var5.requestFailure else nil
                    }
                end
            else
                tbl5 = nil
            end

            func3(tbl5)
        end

        local bool3 = false

        return {
            getOptimisticLocalTools = localToolControllers.getOptimisticLocalTools,
            getLocalToolActions = localToolControllers.getLocalToolActions,
            getSetupErrorText = function(arg4)
                return signal(arg4)
            end,
            start = function()
                if bool1 then
                    return
                end
                bool1 = true
                local tbl5 = {
                    onDroppedChatMessage = function(messageId: number, arg4)
                        local tbl5 = {
                            universeId = arg1.universeId,
                            placeId = arg1.placeId,
                            conversationId = arg1.getCasSessionId(),
                            chatOpenId = chatOpenId,
                            messageId = messageId
                        }
                        sendBuildExperienceEvent(
                            "DROPPED_CHAT_MESSAGE",
                            tbl5,
                            if FFlagBuildExperienceHistoryPollTelemetry and arg4 ~= nil then getHistoryPollDropTelemetryParameters(arg4) else nil
                        )
                    end
                }

                if afterSequenceId ~= nil then
                    tbl5.afterSequenceId = afterSequenceId
                end
                var4 = arg1.startPollingActiveTurn(tbl5)

                effect = Signals.createEffect(function(arg4)
                    if arg2.state(arg4).isDone then
                        finish()
                    end
                end)
            end,
            stop = function()
                if FFlagBuildExperienceModelPicker then
                    localToolControllers.stopPending()
                    arg2.cancel()
                    return
                end
                bool2 = true
                cleanupObservers()
                localToolControllers.stopPending()
                arg2.cancel()
            end,
            reportUserStop = FFlagBuildExperiencePromptFailureTelemetry and function()
                if bool2 or bool3 then
                    return
                end

                bool3 = true

                sendBuildExperienceEvent("SEND_PROMPT_STOPPED", {
                    universeId = arg1.universeId,
                    placeId = arg1.placeId,
                    conversationId = arg1.getCasSessionId(),
                    chatOpenId = chatOpenId
                }, { isResumedTurn = "true" })
            end or nil,
            detach = function()
                bool2 = true
                cleanupObservers()
                localToolControllers.stopPending()
            end,
            syncFromTurnState = localToolControllers.syncFromTurnState,
            trySubmitComposerText = localToolControllers.trySubmitComposerText,
            trySubmitAnswerText = localToolControllers.trySubmitAnswerText
        }
    end,
    getPromptFailureComposerError = getPromptFailureComposerError,
    getToolResultFailureComposerError = function(errorCode: number?)
        return getPromptFailureComposerError(
            {
                errorCode = errorCode,
                outOfCreditsReason = nil,
                isContentPolicy = errorCode == Forbidden,
                setupStage = nil
            }
        )
    end
}
