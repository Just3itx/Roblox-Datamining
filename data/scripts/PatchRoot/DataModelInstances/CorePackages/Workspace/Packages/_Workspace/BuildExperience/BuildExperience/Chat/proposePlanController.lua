-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:00:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)

local _chatTypes = require(script.Parent.chatTypes)
local chatConstants = require(script.Parent.chatConstants)
local _localToolOverlay = require(script.Parent.localToolOverlay)
local toolControllerUtils = require(script.Parent.toolControllerUtils)

local StudioProposePlanTool = CreatorAgentChat.StudioProposePlanTool
local debug2 = CreatorAgentChat.debug
local awaitRequestState = toolControllerUtils.awaitRequestState
local getToolCallOrder = toolControllerUtils.getToolCallOrder

local function buildOptimisticPlanTool(tbl1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return {
        toolCallId = tbl1.toolCallId,
        callOrder = tbl1.proposal.callOrder or 0,
        isAccepted = tbl1.proposal.isAccepted,
        feedbackText = tbl1.proposal.feedbackText
    }
end

local function createPlanProposalSync(callback: (...any) -> (...any), callback2: (...any) -> (...any), func1: (...any) -> (...any)) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = nil
    local var2 = nil
    local bool1 = false

    return function(arg1): boolean
        local var3, toolCallId, var5, turnId, referenceId = StudioProposePlanTool.findPlanInTurnState(arg1, func1())
        if var3 == nil or toolCallId == nil then
            if bool1 then
                debug2.log("info", "present_plan proposal cleared", { turn = debug2.formatTurnState(arg1) })

                bool1 = false
                var1 = nil
                var2 = nil
                callback(nil)
                callback2(nil)
            end
            return false
        end

        bool1 = true
        if toolCallId ~= var1 or var5 ~= var2 then
            var1 = toolCallId
            var2 = var5
            local tbl1 = {
                sessionId = arg1.sessionId,
                toolCallId = toolCallId,
                turnId = turnId,
                referenceId = referenceId,
                proposal = {
                    title = var3.title,
                    textContent = var3.textContent,
                    summary = var3.summary,
                    toolCallId = toolCallId,
                    callOrder = getToolCallOrder(arg1, toolCallId),
                    isAccepted = false
                },
                submitted = false
            }

            callback2(tbl1)
            callback(tbl1.proposal)
            debug2.log(
                "info",
                "present_plan proposal displayed",
                {
                    toolCallId = toolCallId,
                    turnId = turnId,
                    referenceId = referenceId,
                    turn = debug2.formatTurnState(arg1)
                }
            )
        end

        return true
    end
end

local function createProposePlanController(arg1, tbl1, arg2, callback)
    local var1 = nil
    local onPlanAcceptedImpl = nil

    local function setPlanFlow(tbl2) -- Luacid: Inlined by compiler; 2 call sites recovered
        var1 = tbl2
    end

    local function recoverFailedSubmission(tbl2, str1: string?, num1: number?)
        tbl2.submitted = false
        if callback == nil then
            return
        end

        tbl2.proposal = {
            title = tbl2.proposal.title,
            textContent = tbl2.proposal.textContent,
            summary = tbl2.proposal.summary,
            toolCallId = tbl2.proposal.toolCallId,
            callOrder = tbl2.proposal.callOrder,
            isAccepted = false,
            feedbackText = nil
        }

        arg2.setPlanTool((buildOptimisticPlanTool(tbl2)))
        callback(str1, num1)
    end

    local function submitPlanResult(tbl2, tbl3, resultKind: string, str1: string?)
        debug2.log("info", "present_plan tool_result submitting", {
            sessionId = tbl2.sessionId,
            toolCallId = tbl2.toolCallId,
            turnId = tbl2.turnId,
            referenceId = tbl2.referenceId,
            resultKind = resultKind
        })
        local startTime = os.clock()
        local var2 = arg1.submitActiveToolResult(tbl3, false, tbl2.turnId, tbl2.referenceId)
        if var2 == nil then
            debug2.log(
                "warn",
                "present_plan tool_result submit aborted (no active session)",
                {
                    toolCallId = tbl2.toolCallId,
                    resultKind = resultKind
                }
            )
            recoverFailedSubmission(tbl2, str1, nil)
            return
        end

        local var3 = awaitRequestState(var2.state, os.clock() + chatConstants.CAS_RPC_TIMEOUT_SECONDS)
        local durationMs = math.floor((os.clock() - startTime) * 1000 + 0.5)
        if var3.status ~= "succeeded" then
            recoverFailedSubmission(tbl2, str1, var3.errorCode)
            debug2.log("warn", "present_plan tool_result submit failed", {
                sessionId = tbl2.sessionId,
                toolCallId = tbl2.toolCallId,
                turnId = tbl2.turnId,
                referenceId = tbl2.referenceId,
                durationMs = durationMs,
                state = debug2.formatRequestState(var3),
                resultKind = resultKind
            })
            return
        end

        debug2.log("info", "present_plan tool_result submitted", {
            sessionId = tbl2.sessionId,
            toolCallId = tbl2.toolCallId,
            turnId = tbl2.turnId,
            referenceId = tbl2.referenceId,
            durationMs = durationMs,
            resultKind = resultKind
        })
        tbl1[tbl2.toolCallId] = true
        arg2.markSubmitted(tbl2.toolCallId)
        arg2.removePlanAction(tbl2.toolCallId)
        setPlanFlow(nil)
    end

    local function submitPlanAccepted(tbl2) -- Luacid: Inlined by compiler; 1 call site recovered
        submitPlanResult(tbl2, StudioProposePlanTool.formatAcceptedContent(), "accept", nil)
    end

    local function submitPlanFeedback(tbl2, feedbackText: string) -- Luacid: Inlined by compiler; 1 call site recovered
        submitPlanResult(tbl2, StudioProposePlanTool.formatFeedbackContent(feedbackText), "feedback", feedbackText)
    end

    local function setCurrentPlanProposal(arg3)
        if arg3 ~= nil then
            local var2 = var1
            if var2 ~= nil then
                arg2.setPlanTool((buildOptimisticPlanTool(var2)))
                arg2.setPlanAction(var2.toolCallId, onPlanAcceptedImpl)
            end
            return
        end

        local var2 = var1
        if var2 ~= nil then
            arg2.removePlanTool(var2.toolCallId)
            arg2.removePlanAction(var2.toolCallId)
        end
    end

    local syncPlanProposal = createPlanProposalSync(setCurrentPlanProposal, setPlanFlow, function() -- name: getSubmittedToolCallIds
        return tbl1
    end)

    onPlanAcceptedImpl = function()
        local var2 = var1
        if var2 == nil or var2.submitted then
            return
        end

        var2.submitted = true
        var2.proposal = {
            title = var2.proposal.title,
            textContent = var2.proposal.textContent,
            summary = var2.proposal.summary,
            toolCallId = var2.proposal.toolCallId,
            callOrder = var2.proposal.callOrder,
            isAccepted = true,
            feedbackText = nil
        }

        setCurrentPlanProposal(var2.proposal)
        task.spawn(function()
            submitPlanAccepted(var2)
        end)
    end

    return {
        syncPlanProposal = syncPlanProposal,
        stopPendingPlan = function(): boolean
            local var2 = var1
            if var2 == nil or var2.submitted then
                return false
            end
            var2.submitted = true
            setPlanFlow(nil)
            arg2.removePlanTool(var2.toolCallId)
            arg2.removePlanAction(var2.toolCallId)
            return true
        end,
        trySubmitComposerText = function(feedbackText: string): boolean
            local var2 = var1
            if var2 == nil or var2.submitted then
                return false
            end

            var2.submitted = true
            var2.proposal = {
                title = var2.proposal.title,
                textContent = var2.proposal.textContent,
                summary = var2.proposal.summary,
                toolCallId = var2.proposal.toolCallId,
                callOrder = var2.proposal.callOrder,
                isAccepted = false,
                feedbackText = feedbackText
            }
            setCurrentPlanProposal(var2.proposal)
            task.spawn(function()
                submitPlanFeedback(var2, feedbackText)
            end)
            return true
        end
    }
end
return createProposePlanController
