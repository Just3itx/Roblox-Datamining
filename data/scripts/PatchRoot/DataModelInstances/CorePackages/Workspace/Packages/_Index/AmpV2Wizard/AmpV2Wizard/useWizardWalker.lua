-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:50:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpV2Wizard = script:FindFirstAncestor("AmpV2Wizard")
local AmpV2WizardParent = AmpV2Wizard.Parent

local React = require(AmpV2WizardParent.React)

local _Types = require(AmpV2Wizard.Types)
local walkerReducer = require(AmpV2Wizard.walkerReducer)
local WizardEventNames = require(AmpV2Wizard.WizardEventNames)
local FFlagAmpV2WizardAnalytics = require(AmpV2Wizard.FFlagAmpV2WizardAnalytics)
local FFlagAmpV2WizardAuthorizationModal = require(AmpV2Wizard.FFlagAmpV2WizardAuthorizationModal)
local VpcEntryAnalytics = require(AmpV2Wizard.VpcEntryAnalytics)

local FFlagLuaAppAmpWizardSendAnalyticsSessionId = require(AmpV2WizardParent.SharedFlags).FFlagLuaAppAmpWizardSendAnalyticsSessionId

local EventNames = WizardEventNames.EventNames

local function buildEventContext(arg1, surface: string, rootFlow: string?)
    local currentNodeId = arg1.currentNodeId
    local var1 = if currentNodeId == nil then nil else arg1.nodes[currentNodeId]
    return {
        flowId = arg1.flowId,
        chosenFlow = arg1.chosenFlow,
        rootFlow = rootFlow,
        surface = surface,
        node = currentNodeId,
        nodeType = if var1 == nil then nil else var1.type,
        analyticsSessionId = if FFlagLuaAppAmpWizardSendAnalyticsSessionId and arg1.analyticsSessionId ~= "" then arg1.analyticsSessionId else nil
    }
end

local function mergeParams(eventContext: {analyticsSessionId: number, chosenFlow: any, flowId: any, node: any, nodeType: number, rootFlow: string?, surface: string}, arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    local var1 = table.clone(eventContext)
    if arg1 ~= nil then
        for value, value2 in arg1 do
            var1[value] = value2
        end
    end
    return var1
end

local function noopSend(_: string, _) end

local function useWizardWalker(tbl1)
    local api = tbl1.api
    local target = tbl1.target
    local rootFlow = tbl1.rootFlow
    local surface = tbl1.surface
    local onExit = tbl1.onExit
    local onEvent = tbl1.onEvent

    local func1 = noopSend
    if FFlagAmpV2WizardAnalytics then
        func1 = tbl1.sendEvent or require(AmpV2Wizard.WizardAnalytics).default
    end

    local current, var2 = React.useReducer(walkerReducer.reduce, tbl1.initialFragment, walkerReducer.init)

    local var3 = React.useRef(current)
    var3.current = current

    local var4 = React.useRef(false)
    local var5 = if current.currentNodeId then current.nodes[current.currentNodeId] else nil
    local var6 = nil
    local var7 = nil
    local var8

    if FFlagAmpV2WizardAuthorizationModal then
        var6 = React.useRef(nil)
        var7 = React.useRef(0)
        if var5 ~= nil then
            if var5.type == "VerificationMethodSelection" and current.currentNodeId ~= nil then
                local tbl2 = {
                    nodeId = current.currentNodeId,
                    node = var5,
                    flow = current.chosenFlow
                }
                var6.current = tbl2
            elseif var5.behavior == nil or var5.behavior.presentsOverPrevious ~= true then
                var6.current = nil
            end
        end
        var8 = React.useCallback(function()
            local current = var3.current
            local var9 = if current.currentNodeId then current.nodes[current.currentNodeId] else nil

            if current.exited or var9 == nil or var9.type ~= "SessionPolling" then
                return
            end
            local current2 = var6.current
            if current2 ~= nil and current2.flow ~= current.chosenFlow then
                current2 = nil
            end

            local var10 = var7
            var10.current += 1
            var4.current = false
            local tbl2 = {
                type = "DismissPresentation",
                nodeId = if current2 then current2.nodeId else nil,
                node = if current2 then current2.node else nil
            }
            var3.current = walkerReducer.reduce(current, tbl2)
            var2(tbl2)
        end, {})
    else
        var8 = nil
    end

    local eventContext = buildEventContext(current, surface, rootFlow)

    local logEvent = React.useCallback(function(str1: string, arg1)
        local var9 = func1
        local var10 = mergeParams(buildEventContext(var3.current, surface, rootFlow), nil)

        if arg1 ~= nil then
            for value, value2 in arg1 do
                var10[value] = value2
            end
        end

        var9(str1, var10)
    end, { func1, surface, rootFlow })

    local var10 = React.useRef(tbl1.initialFragment.resumeSourcePage ~= nil)

    React.useEffect(function()
        if var10.current or var3.current.currentNodeId == nil then
            return
        end
        var10.current = true
        logEvent(EventNames.FlowStart)
        if FFlagLuaAppAmpWizardSendAnalyticsSessionId then
            local current = var3.current
            VpcEntryAnalytics.sendWizardLaunch(
                current.analyticsStrings,
                current.analyticsSessionId,
                surface,
                rootFlow,
                current.chosenFlow,
                tbl1.initialFragment.entry
            )
        end
    end, {})

    React.useEffect(function()
        if current.currentNodeId == nil then
            return
        end
        logEvent(EventNames.NodeShown)
    end, { current.currentNodeId, current.chosenFlow })

    local exited = current.exited
    local exitResult = current.exitResult
    local var11 = React.useRef(false)
    React.useEffect(function()
        if not exited or var11.current then
            return
        end
        var11.current = true

        if exitResult == nil then
            return
        end

        if var10.current then
            logEvent(EventNames.FlowExit, { reason = exitResult.reason, outcome = exitResult.outcome })
        end

        if onExit then
            onExit(exitResult)
        end
    end, {
        exited,
        exitResult,
        onExit,
        logEvent
    })
    local report = React.useCallback(function(outcome: string, payload)
        local current = var3.current
        local currentNodeId = current.currentNodeId
        if currentNodeId == nil or current.exited or current.isLoading or var4.current then
            return
        end

        local var12 = current.nodes[currentNodeId]

        if FFlagAmpV2WizardAuthorizationModal and outcome == "Poll" and (var12 == nil or var12.type ~= "SessionPolling") then
            return
        end

        local transition = if var12 then var12.transitions[outcome] else nil
        local eventContext2 = buildEventContext(current, surface, rootFlow)

        local var13 = func1
        local nodeOutcome = EventNames.NodeOutcome
        local tbl3 = {
            outcome = outcome,
            transitionKind = if transition then transition.kind else nil
        }
        local var14 = mergeParams(eventContext2, nil)
        if tbl3 ~= nil then
            for value, value2 in tbl3 do
                var14[value] = value2
            end
        end

        var13(nodeOutcome, var14)

        if onEvent then
            onEvent({
                flowId = current.flowId,
                node = currentNodeId,
                outcome = outcome,
                transitionKind = if transition then transition.kind else nil
            })
        end

        var2({ type = "ReportOutcome", outcome = outcome, data = payload })

        if transition == nil or transition.kind ~= "Continue" then
            return
        end

        var4.current = true

        local history = table.clone(current.history)
        table.insert(history, { flow = current.chosenFlow, node = currentNodeId, outcome = outcome, data = payload })
        local current2 = if var7 then var7.current else nil

        api.continue({
            flowId = current.flowId,
            state = current.flowState,
            target = target,
            rootFlow = rootFlow,
            flowInputs = current.flowInputs,
            history = history,
            payload = payload
        }):andThen(
            function(response)
                if var7 and var7.current ~= current2 then
                    return
                end
                var4.current = false
                var2({ type = "FragmentLoaded", response = response })
            end
        ):catch(
            function(arg1)
                if var7 and var7.current ~= current2 then
                    return
                end
                var4.current = false
                local var16 = func1
                local continueFailed = EventNames.ContinueFailed
                local tbl4 = eventContext2
                local tbl5 = {
                    errorMessage = tostring(arg1)
                }
                local var17 = mergeParams(tbl4, nil)
                if tbl5 ~= nil then
                    for value, value2 in tbl5 do
                        var17[value] = value2
                    end
                end

                var16(continueFailed, var17)
                var2({ type = "ContinueFailed", message = tostring(arg1) })
            end
        )
    end, {
        api,
        target,
        rootFlow,
        surface,
        onEvent,
        func1,
        var7
    })
    local acknowledgeError = React.useCallback(function()
        var2({ type = "AcknowledgeError" })
    end, {})

    return {
        dismissPresentation = var8,
        currentNode = var5,
        currentNodeId = current.currentNodeId,
        isLoading = current.isLoading,
        exited = exited,
        presentingError = current.presentingError,
        acknowledgeError = acknowledgeError,
        analyticsStrings = current.analyticsStrings,
        analyticsSessionId = current.analyticsSessionId,
        report = report,
        eventContext = eventContext,
        logEvent = logEvent
    }
end

return useWizardWalker
