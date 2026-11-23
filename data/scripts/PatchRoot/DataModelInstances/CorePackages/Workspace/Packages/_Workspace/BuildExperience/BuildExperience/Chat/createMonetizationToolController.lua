-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:00:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)
local FFlagBuildExperienceDevProductRecovery = require(BuildExperience.Flags.FFlagBuildExperienceDevProductRecovery)

local FFlagBuildExperienceMonetizationFailureCauses = require(BuildExperience.Flags.FFlagBuildExperienceMonetizationFailureCauses)
local HttpClient = require(BuildExperienceParent.HttpClient)
local Promise = require(BuildExperienceParent.Promise)

local _chatTypes = require(script.Parent.chatTypes)
local chatConstants = require(script.Parent.chatConstants)
local _localToolOverlay = require(script.Parent.localToolOverlay)
local toolControllerUtils = require(script.Parent.toolControllerUtils)
local monetizationFailureCauses = require(BuildExperience.utils.monetizationFailureCauses)

local debug2 = CreatorAgentChat.debug

local tbl1 = {
    outcome = "unverified",
    errorMessage = "The request timed out and its outcome is unknown. List again before retrying."
}

local function describeRejection(arg1) -- Luacid: Inlined by compiler; 5 call sites recovered
    if typeof(arg1) == "table" and typeof(arg1.errorMessage) == "string" then
        return arg1.errorMessage
    end
    return tostring(arg1)
end

local function awaitPromise(arg1, num1: number?) -- Luacid: unused: defined but never referenced
    local var1, var2 = arg1:timeout(num1 or chatConstants.CAS_RPC_TIMEOUT_SECONDS, tbl1):await()
    if var1 then
        if var2 ~= nil then
            return var2, nil, nil
        end
        return nil, "The request returned no result.", nil
    end
    if var2 == nil then
        return nil, "The request returned no result.", nil
    end
    return nil, describeRejection(var2), var2
end

local function detailCodeForFailure(action: string, arg1): string -- Luacid: Inlined by compiler; 1 call site recovered
    return if typeof(arg1) == "table" and arg1.outcome == "unverified" then "outcome_unknown" else action .. "_failed"
end

local function isRetryableFailure(action: string, arg1, arg2): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1 ~= nil or typeof(arg2) ~= "table" then
        return false
    end
    if arg2.retryable == true then
        return true
    end
    local cause = arg2.cause

    return action == "create" and arg2.outcome == "failed" and typeof(cause) == "table" and cause.responseCode == 429
end

local function createMonetizationToolController(tbl2, arg1, tbl3, arg2, callback)
    local tool = tbl2.tool
    local toolName = tool.TOOL_NAME
    local var1 = nil
    local tbl4 = ({})
    local num1 = 0
    local tbl5 = ({})
    local num2 = 0

    local function isGenerationCurrent(num3: number): boolean -- Luacid: Inlined by compiler; 14 call sites recovered
        return num1 == num3
    end

    local function isFlowCurrent(tbl6): boolean -- Luacid: Inlined by compiler; 7 call sites recovered
        return var1 == tbl6 and not not isGenerationCurrent(tbl6.generation)
    end

    local function isAutomaticWorkCurrent(num3: number, num4: number): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
        return not not isGenerationCurrent(num3) and num2 == num4
    end

    local function awaitReply(arg3, str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
        local var2 = HttpClient.asPromise(arg3):timeout(chatConstants.CAS_RPC_TIMEOUT_SECONDS)
        tbl5[var2] = str1
        local var3, var4 = var2:awaitStatus()
        tbl5[var2] = nil
        return var3, var4
    end

    local function cancelReplies(str1: string?)
        for value, value2 in table.clone(tbl5) do
            if str1 == nil or value2 == str1 then
                tbl5[value] = nil
                value:cancel()
            end
        end
    end

    local function invalidateAutomaticWork() -- Luacid: Inlined by compiler; 6 call sites recovered
        num2 += 1
        for value in tbl4 do
            tbl3[value] = nil
        end
        table.clear(tbl4)
        cancelReplies("automatic")
    end

    local function invalidateAsyncWork() -- Luacid: Inlined by compiler; 3 call sites recovered
        num1 += 1
        invalidateAutomaticWork()
        cancelReplies("afterDecision")
    end

    local function proposalFromFlow(tbl6, isApproved: boolean, isRejected: boolean)
        local input = tbl6.input
        local tbl7 = {
            toolCallId = tbl6.toolCallId,
            callOrder = tbl6.callOrder,
            action = input.action,
            name = input.name,
            description = input.description,
            priceInRobux = input.priceInRobux,
            itemKind = tbl2.itemKind,
            itemId = tbl2.itemIdOf(input),
            isApproved = isApproved,
            isRejected = isRejected,
            isPending = if FFlagBuildExperienceDevProductRecovery then tbl6.isPending else nil,
            hasError = if FFlagBuildExperienceDevProductRecovery then not (tbl6.resultError == nil) and not isRejected else nil,
            errorCause = if FFlagBuildExperienceDevProductRecovery
                and FFlagBuildExperienceMonetizationFailureCauses
                and tbl6.resultError ~= nil
                and not isRejected then monetizationFailureCauses.classify(tbl6.resultError) or (if tbl6.canRetry == true then "rateLimited" else nil) else nil,
            canRetry = if FFlagBuildExperienceDevProductRecovery then tbl6.canRetry == true and not isRejected else nil
        }
        if tbl2.cardFields ~= nil then
            for value, value2 in tbl2.cardFields(input) do
                tbl7[value] = value2
            end
        end
        return tbl7
    end

    local function submitAutomaticResult(toolCallId: string, tbl6, tbl7, bool1: boolean, num3: number, num4: number)
        if not isAutomaticWorkCurrent(num3, num4) then
            return
        end
        local var2 = arg1.submitActiveToolResult(tbl7, bool1, tbl6.turnId, tbl6.referenceId)
        if var2 == nil then
            tbl4[toolCallId] = nil

            if isGenerationCurrent(num3) then
                tbl3[toolCallId] = nil
            end
            return
        end

        local status, var4 = awaitReply(var2, "automatic")

        if not isAutomaticWorkCurrent(num3, num4) then
            return
        end
        tbl4[toolCallId] = nil
        if status == Promise.Status.Resolved then
            tbl3[toolCallId] = true
            return
        end
        tbl3[toolCallId] = nil
        debug2.log(
            "warn",
            toolName .. " automatic submit failed",
            {
                toolCallId = toolCallId,
                status = status,
                reason = describeRejection(var4)
            }
        )
    end
    local function runList(toolCallId: string, tbl6, num3: number, num4: number)
        if not isAutomaticWorkCurrent(num3, num4) then
            return
        end
        local var2 = nil
        local noUniverse

        if arg1.universeId == nil then
            noUniverse = monetizationFailureCauses.MESSAGES.noUniverse
        else
            local var3, var4 = tbl2.list(arg1.universeId)
            local var5, var6 = var3:timeout(var4 or chatConstants.CAS_RPC_TIMEOUT_SECONDS, tbl1):await()
            if var5 then
                if var6 == nil then
                    var2 = nil
                    noUniverse = "The request returned no result."
                else
                    var2 = var6
                    noUniverse = nil
                end
            elseif var6 == nil then
                var2 = nil
                noUniverse = "The request returned no result."
            else
                var2 = nil
                noUniverse = describeRejection(var6)
            end
        end

        if not isAutomaticWorkCurrent(num3, num4) then
            return
        end
        local tbl7 = { status = "ok", action = "list" }
        if var2 == nil then
            tbl7 = {
                status = "error",
                action = "list",
                detailCode = "list_failed",
                message = noUniverse or "The list request failed."
            }
        else
            for value, value2 in var2 do
                tbl7[value] = value2
            end
        end

        local var3, var4 = tool.formatResultContent(tbl7)
        submitAutomaticResult(toolCallId, tbl6, var3, var4 or var2 == nil, num3, num4)
    end

    local function recoverFailedSubmission(tbl6, str1: string?, num3: number?)
        if not isFlowCurrent(tbl6) then
            arg2.removeDevProductAction(tbl6.toolCallId)
            return
        end

        if not tbl6.toolCallPresent then
            arg2.removeDevProductTool(tbl6.toolCallId)
            arg2.removeDevProductAction(tbl6.toolCallId)
            var1 = nil
            return
        end

        if not FFlagBuildExperienceDevProductRecovery
            or not FFlagBuildExperienceMonetizationFailureCauses
            or not tbl6.attempted
            or not toolControllerUtils.isConversationGone(num3)
        then
            tbl6.submitted = false
            if callback == nil then
                return
            end
            arg2.setDevProductTool((proposalFromFlow(tbl6, false, false)))
            callback(str1, num3)
            return
        end

        tbl6.isPending = false
        tbl6.canRetry = false
        tbl3[tbl6.toolCallId] = true
        arg2.markSubmitted(tbl6.toolCallId)
        arg2.setDevProductTool((proposalFromFlow(tbl6, true, false)))
        arg2.removeDevProductAction(tbl6.toolCallId)
        var1 = nil
        if callback ~= nil then
            callback(str1, num3)
        end
    end
    local function submitResult(tbl6, tbl7, bool1: boolean, str1: string?)
        if not isFlowCurrent(tbl6) then
            return
        end
        local var2 = arg1.submitActiveToolResult(tbl7, bool1, tbl6.turnId, tbl6.referenceId)
        local var3, var4

        if var2 == nil then
            var3 = "no session"
            var4 = nil
        else
            var3, var4 = awaitReply(var2, "afterDecision")
        end

        if not isFlowCurrent(tbl6) then
            return
        end

        if var3 ~= Promise.Status.Resolved then
            recoverFailedSubmission(tbl6, str1, if typeof(var4) == "table" then var4.responseCode else nil)

            debug2.log("warn", toolName .. " tool_result submit failed", {
                sessionId = tbl6.sessionId,
                toolCallId = tbl6.toolCallId,
                action = tbl6.input.action,
                status = var3,
                reason = describeRejection(var4)
            })
        else
            tbl3[tbl6.toolCallId] = true
            arg2.markSubmitted(tbl6.toolCallId)
            arg2.removeDevProductAction(tbl6.toolCallId)
            if var1 == tbl6 then
                var1 = nil
            end
        end
    end
    local function submitApproval(tbl6)
        if not isFlowCurrent(tbl6) then
            return
        end
        if not tbl6.attempted then
            tbl6.attempted = true
            local var2 = nil
            local var3 = nil
            local var4 = nil
            local noUniverse

            if tbl6.universeId == nil then
                noUniverse = monetizationFailureCauses.MESSAGES.noUniverse
            else
                local var5 = tbl2.mutate(tbl6.universeId, tbl6.input)
                if var5 == nil then
                    noUniverse = "The write was not sent."
                else
                    local var6 = if tbl6.input.imageAssetId ~= nil then chatConstants.CAS_RPC_TIMEOUT_SECONDS * 2 else nil
                    local var7
                    var7, var3 = var5:timeout(var6 or chatConstants.CAS_RPC_TIMEOUT_SECONDS, tbl1):await()
                    if var7 then
                        if var3 == nil then
                            var2 = nil
                            noUniverse = "The request returned no result."
                            var3 = nil
                        else
                            var2 = var3
                            noUniverse = nil
                            var3 = nil
                        end
                    elseif var3 == nil then
                        var2 = nil
                        noUniverse = "The request returned no result."
                        var3 = nil
                    else
                        var2 = nil
                        noUniverse = describeRejection(var3)
                    end
                end
            end

            if not isFlowCurrent(tbl6) then
                return
            end
            if var2 == nil and typeof(var3) == "table" then
                var2 = var3[tbl2.resultKey]
            end
            if noUniverse ~= nil then
                var4 = detailCodeForFailure(tbl6.input.action, var3)
            end
            tbl6.result = var2
            tbl6.resultError = noUniverse
            tbl6.resultDetailCode = var4

            if FFlagBuildExperienceDevProductRecovery
                and FFlagBuildExperienceMonetizationFailureCauses
                and noUniverse ~= nil
                and isRetryableFailure(tbl6.input.action, var2, var3)
            then
                tbl6.attempted = false
                tbl6.submitted = false
                tbl6.isPending = false
                tbl6.canRetry = true
                arg2.setDevProductTool((proposalFromFlow(tbl6, false, false)))
                return
            end
        end
        if FFlagBuildExperienceDevProductRecovery then
            tbl6.isPending = false
            if arg2.getOptimisticLocalTools(false).devProductByToolCallId[tbl6.toolCallId] ~= nil then
                arg2.setDevProductTool((proposalFromFlow(tbl6, true, false)))
            end
        end

        local tbl7 = {
            action = tbl6.input.action
        }
        tbl7[tbl2.resultKey] = tbl6.result
        if tbl6.resultError == nil then
            tbl7.status = "ok"
        else
            tbl7.status = "error"
            tbl7.detailCode = tbl6.resultDetailCode
            tbl7.message = tbl6.resultError
        end
        local var2, var3 = tool.formatResultContent(tbl7)
        submitResult(tbl6, var2, var3 or tbl6.resultError ~= nil, nil)
    end

    local function submitRejection(tbl6, str1: string?)
        if not isFlowCurrent(tbl6) then
            return
        end

        if tbl6.attempted then
            arg2.setDevProductTool((proposalFromFlow(tbl6, true, false)))
            submitApproval(tbl6)
        else
            submitResult(tbl6, tool.formatRejectionContent(tbl6.input.action, str1), false, str1)
        end
    end
    local function settle(tbl6, isPending: boolean, str1: string?): boolean
        if not isFlowCurrent(tbl6) or tbl6.submitted then
            return false
        end
        tbl6.submitted = true
        if FFlagBuildExperienceDevProductRecovery then
            tbl6.isPending = isPending
            tbl6.canRetry = false
        end
        arg2.setDevProductTool((proposalFromFlow(tbl6, isPending, not isPending)))
        task.spawn(function()
            if isPending then
                submitApproval(tbl6)
                return
            end
            submitRejection(tbl6, str1)
        end)

        return true
    end

    local function clearMutationFlow() -- Luacid: Inlined by compiler; 3 call sites recovered
        local var2 = var1
        if var2 ~= nil then
            arg2.removeDevProductTool(var2.toolCallId)
            arg2.removeDevProductAction(var2.toolCallId)
        end
        var1 = nil
    end

    return {
        syncRequests = function(arg3): boolean
            if var1 ~= nil then
                var1.toolCallPresent = arg3.toolCalls[var1.toolCallId] ~= nil
            end
            for value in tbl4 do
                if arg3.toolCalls[value] == nil then
                    invalidateAutomaticWork()
                    break
                end
            end

            local toolCallId, var3, turnId, referenceId = tool.findRequestInTurnState(arg3, tbl3)
            if toolCallId == nil then
                if var1 == nil or var1.submitted or var1.attempted then
                    return false
                end

                invalidateAsyncWork()
                clearMutationFlow()
                return false
            elseif tbl4[toolCallId] then
                return true
            else
                local tbl6 = { turnId = turnId, referenceId = referenceId }

                local var6, str1 = tool.parseInput(var3)
                if var6 ~= nil and var6.createAndGoLive == true then
                    var6 = nil
                    str1 = "createAndGoLive is not supported yet. Create without it and ask the creator to activate the product separately."
                end
                if var6 == nil then
                    tbl4[toolCallId] = true
                    local num3 = num1
                    local num4 = num2
                    task.spawn(function()
                        local var7 = tool.formatResultContent({ status = "error", action = "unknown", detailCode = "invalid_arguments", message = str1 })

                        submitAutomaticResult(toolCallId, tbl6, var7, true, num3, num4)
                    end)
                    return true
                end

                if tool.getActionKind(var6.action) ~= "read" then
                    if var1 ~= nil and (var1.submitted or var1.attempted) then
                        return true
                    end

                    if var1 == nil or toolCallId ~= var1.toolCallId then
                        if var1 ~= nil then
                            invalidateAsyncWork()
                            clearMutationFlow()
                        end

                        local tbl7 = {
                            sessionId = arg3.sessionId,
                            toolCallId = toolCallId,
                            callOrder = toolControllerUtils.getToolCallOrder(arg3, toolCallId),
                            turnId = turnId,
                            referenceId = referenceId,
                            universeId = arg1.universeId,
                            input = var6,
                            submitted = false,
                            attempted = false,
                            toolCallPresent = true,
                            isPending = false,
                            generation = num1
                        }
                        var1 = tbl7
                        arg2.setDevProductTool((proposalFromFlow(tbl7, false, false)))
                        arg2.setDevProductAction(toolCallId, function()
                            settle(tbl7, true, nil)
                        end, function()
                            settle(tbl7, false, nil)
                        end)
                        debug2.log(
                            "info",
                            toolName .. " proposal displayed",
                            {
                                toolCallId = toolCallId,
                                turnId = turnId,
                                action = var6.action
                            }
                        )
                    end

                    return true
                end

                tbl3[toolCallId] = true
                tbl4[toolCallId] = true
                task.spawn(runList, toolCallId, tbl6, num1, num2)
                return true
            end
        end,
        stopPending = function(): boolean
            local var2 = var1
            if var2 ~= nil and (var2.submitted or var2.attempted) then
                local bool1 = next(tbl4) ~= nil
                if bool1 then
                    invalidateAutomaticWork()
                end

                return bool1
            end
            local bool1 = var1 ~= nil or next(tbl4) ~= nil or next(tbl5) ~= nil
            if bool1 then
                invalidateAsyncWork()
            end

            if var2 ~= nil then
                var2.submitted = true
                tbl3[var2.toolCallId] = nil
                clearMutationFlow()
            end

            return bool1
        end,
        trySubmitComposerText = function(str1: string)
            local var2 = var1
            return not (var2 == nil) and settle(var2, false, str1)
        end
    }
end

return createMonetizationToolController
