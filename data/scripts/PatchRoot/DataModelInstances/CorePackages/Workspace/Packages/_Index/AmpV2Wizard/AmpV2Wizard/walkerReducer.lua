-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:50:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpV2Wizard = script:FindFirstAncestor("AmpV2Wizard")

local _Types = require(AmpV2Wizard.Types)
local FFlagAmpV2WizardRateLimitedOutcome = require(AmpV2Wizard.FFlagAmpV2WizardRateLimitedOutcome)
local FFlagAmpV2WizardTerminalOutcome = require(AmpV2Wizard.FFlagAmpV2WizardTerminalOutcome)

local module = {}

local function appendStep<T>(history, arg1: T): {T} -- Luacid: Inlined by compiler; 2 call sites recovered
    local var1 = table.clone(history)
    table.insert(var1, arg1)
    return var1
end

local function errorExit(arg1, history, outcome: string?)
    return {
        flowId = arg1.flowId,
        analyticsSessionId = arg1.analyticsSessionId,
        chosenFlow = arg1.chosenFlow,
        nodes = arg1.nodes,
        currentNodeId = arg1.currentNodeId,
        history = history,
        flowInputs = arg1.flowInputs,
        flowState = arg1.flowState,
        analyticsStrings = arg1.analyticsStrings,
        isLoading = false,
        presentingError = false,
        exited = true,
        exitResult = {
            reason = "Error",
            flowId = arg1.flowId,
            outcome = outcome
        }
    }
end

local function mergeAnalytics(arg1, analytics) -- Luacid: Inlined by compiler; 1 call site recovered
    if analytics == nil then
        return arg1
    end
    if arg1 == nil then
        return analytics
    end
    local var1 = table.clone(arg1)
    for k, analytic in analytics do
        var1[k] = analytic
    end
    return var1
end

local function enterFragment(arg1, history, flowId: string, analyticsSessionId: string, chosenFlow: string, arg2, arg3, arg4)
    local bool1 = not (arg1.entry == nil) and arg1.entry ~= ""
    local bool2 = bool1 and arg1.nodes[arg1.entry] ~= nil

    local bool3 = not bool1 and arg1.outcome == "Error"
    if FFlagAmpV2WizardRateLimitedOutcome and not bool1 and arg1.outcome == "RateLimited" then
        bool3 = true
    end

    local var1

    if bool1 then
        var1 = not bool2 and { reason = "Error", flowId = flowId } or nil
    else
        local var2 = history[#history]
        local outcome = if FFlagAmpV2WizardTerminalOutcome then if var2 ~= nil then var2.outcome else arg1.outcome else nil
        var1 = bool3 and {
            reason = "Error",
            flowId = flowId,
            outcome = arg1.outcome
        }
            or { reason = "Completed", flowId = flowId, outcome = outcome }
    end

    return {
        flowId = flowId,
        analyticsSessionId = analyticsSessionId,
        chosenFlow = chosenFlow,
        nodes = arg1.nodes,
        currentNodeId = if bool2 then arg1.entry else nil,
        history = history,
        flowInputs = arg1.flowInputs or arg2,
        flowState = arg1.state or arg3,
        analyticsStrings = mergeAnalytics(arg4, arg1.analytics),
        isLoading = false,
        presentingError = bool3,
        exited = not (bool2 or bool3),
        exitResult = var1
    }
end

function module.init(arg1)
    return (enterFragment(arg1, {}, arg1.flowId, arg1.analyticsSessionId or "", arg1.chosenFlow, nil, nil, nil))
end

local function reduceReport(arg1, tbl1)
    assert(tbl1.type == "ReportOutcome", "reduceReport called with wrong action")

    local currentNodeId = arg1.currentNodeId
    if currentNodeId == nil then
        return arg1
    end

    local var1 = arg1.nodes[currentNodeId]
    local transition = if var1 then var1.transitions[tbl1.outcome] else nil
    local tbl2 = {
        flow = arg1.chosenFlow,
        node = currentNodeId,
        outcome = tbl1.outcome,
        data = tbl1.data
    }
    local history = appendStep(arg1.history, tbl2)

    if transition == nil then
        return (errorExit(arg1, history, tbl1.outcome))
    elseif transition.kind == "Goto" then
        local node = transition.node
        if node == nil or arg1.nodes[node] == nil then
            return (errorExit(arg1, history, tbl1.outcome))
        end
        return {
            flowId = arg1.flowId,
            analyticsSessionId = arg1.analyticsSessionId,
            chosenFlow = arg1.chosenFlow,
            nodes = arg1.nodes,
            currentNodeId = node,
            history = history,
            flowInputs = arg1.flowInputs,
            flowState = arg1.flowState,
            analyticsStrings = arg1.analyticsStrings,
            isLoading = false,
            presentingError = false,
            exited = false,
            exitResult = nil
        }
    else
        if transition.kind == "Continue" then
            return {
                flowId = arg1.flowId,
                analyticsSessionId = arg1.analyticsSessionId,
                chosenFlow = arg1.chosenFlow,
                nodes = arg1.nodes,
                currentNodeId = arg1.currentNodeId,
                history = history,
                flowInputs = arg1.flowInputs,
                flowState = arg1.flowState,
                analyticsStrings = arg1.analyticsStrings,
                isLoading = true,
                presentingError = false,
                exited = false,
                exitResult = nil
            }
        end

        return {
            flowId = arg1.flowId,
            analyticsSessionId = arg1.analyticsSessionId,
            chosenFlow = arg1.chosenFlow,
            nodes = arg1.nodes,
            currentNodeId = arg1.currentNodeId,
            history = history,
            flowInputs = arg1.flowInputs,
            flowState = arg1.flowState,
            analyticsStrings = arg1.analyticsStrings,
            isLoading = false,
            presentingError = false,
            exited = true,
            exitResult = {
                reason = "Completed",
                flowId = arg1.flowId,
                outcome = tbl1.outcome
            }
        }
    end
end

local function reduceFragmentLoaded(arg1, response)
    local flowId = if response.flowId ~= "" then response.flowId else arg1.flowId
    local analyticsSessionId = response.analyticsSessionId
    if analyticsSessionId == nil or analyticsSessionId == "" then
        analyticsSessionId = arg1.analyticsSessionId
    end

    local chosenFlow = if response.chosenFlow ~= "" then response.chosenFlow else arg1.chosenFlow
    return (enterFragment(
        response,
        arg1.history,
        flowId,
        analyticsSessionId,
        chosenFlow,
        arg1.flowInputs,
        arg1.flowState,
        arg1.analyticsStrings
    ))
end

function module.reduce(arg1, tbl1)
    if tbl1.type == "DismissPresentation" then
        local var1 = table.clone(arg1)
        var1.isLoading = false
        var1.presentingError = false
        var1.exited = false
        var1.exitResult = nil
        if arg1.currentNodeId ~= nil then
            var1.history = appendStep(arg1.history, { flow = arg1.chosenFlow, node = arg1.currentNodeId, outcome = "Cancel" })
        end

        if tbl1.nodeId == nil or tbl1.node == nil then
            var1.exited = true
            var1.exitResult = {
                reason = "Cancelled",
                flowId = arg1.flowId,
                outcome = "Cancel"
            }
        else
            var1.nodes = table.clone(arg1.nodes)
            var1.nodes[tbl1.nodeId] = tbl1.node
            var1.currentNodeId = tbl1.nodeId
        end

        return var1
    elseif tbl1.type == "ReportOutcome" then
        return (reduceReport(arg1, tbl1))
    elseif tbl1.type == "FragmentLoaded" then
        return (reduceFragmentLoaded(arg1, tbl1.response))
    end

    if tbl1.type ~= "ContinueFailed" then
        if tbl1.type ~= "AcknowledgeError" then
            return arg1
        end

        if not arg1.presentingError then
            return arg1
        end
        local var1 = table.clone(arg1)
        var1.presentingError = false
        var1.exited = true
        return var1
    end

    return {
        flowId = arg1.flowId,
        analyticsSessionId = arg1.analyticsSessionId,
        chosenFlow = arg1.chosenFlow,
        nodes = arg1.nodes,
        currentNodeId = arg1.currentNodeId,
        history = arg1.history,
        flowInputs = arg1.flowInputs,
        flowState = arg1.flowState,
        analyticsStrings = arg1.analyticsStrings,
        isLoading = false,
        presentingError = false,
        exited = true,
        exitResult = {
            reason = "Error",
            flowId = arg1.flowId
        }
    }
end

return module
