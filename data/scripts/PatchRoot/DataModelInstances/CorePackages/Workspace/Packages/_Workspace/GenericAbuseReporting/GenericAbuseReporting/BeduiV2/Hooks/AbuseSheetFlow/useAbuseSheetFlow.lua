-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:41:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local Dash = require(GenericAbuseReportingParent.Dash)
local _LuauPolyfill = require(GenericAbuseReportingParent.LuauPolyfill)
local Promise = require(GenericAbuseReportingParent.Promise)
local React = require(GenericAbuseReportingParent.React)
local RoactNetworking = require(GenericAbuseReportingParent.RoactServiceTags).RoactNetworking
local useRoactService = require(GenericAbuseReportingParent.RobloxAppHooks).useRoactService

local _AbuseReportAnalyticsContext = require(GenericAbuseReporting.BeduiV2.Analytics.AbuseReportAnalyticsContext)
local _AbuseSheetFlowTypes = require(script.Parent.AbuseSheetFlowTypes)
local AbuseVector = require(GenericAbuseReporting.Enums.AbuseVector)
local analyticsService = require(GenericAbuseReporting.BeduiV2.Analytics.analyticsService)
local ContentNode = require(GenericAbuseReporting.BeduiV2.Hooks.AbuseSheetFlow.ContentNode)
local getInitialState = require(GenericAbuseReporting.BeduiV2.Hooks.AbuseSheetFlow.reducer).getInitialState
local reducer = require(GenericAbuseReporting.BeduiV2.Hooks.AbuseSheetFlow.reducer)
local resolveArConfig = require(GenericAbuseReporting.BeduiV2.Utils.Resolver.configResolvers).resolveArConfig
local resolveStartNode = require(GenericAbuseReporting.BeduiV2.Utils.Resolver.resolveStartNode).resolveStartNode
local sendReport = require(GenericAbuseReporting.BeduiV2.Api.sendReport)
local useOpenLink = require(GenericAbuseReporting.BeduiV2.Hooks.useOpenLink)

local getNewRunId = reducer.getNewRunId
local reducer2 = reducer.reducer
local selectStore = reducer.selectStore
local sendAnalyticsEvent = analyticsService.sendAnalyticsEvent
local TelemetryEventType = analyticsService.TelemetryEventType
local LinkOpenedSource = analyticsService.LinkOpenedSource
local SubmitSource = analyticsService.SubmitSource
local formatErrorDetailForAnalytics = analyticsService.formatErrorDetailForAnalytics
local FFlagAbuseReportSubmissionTargetV4 = require(GenericAbuseReportingParent.SharedFlags).FFlagAbuseReportSubmissionTargetV4
local FFlagAbuseReportImproveErrorEvents = require(GenericAbuseReporting.Flags.FFlagAbuseReportImproveErrorEvents)

local function getSubmissionTargetTelemetry(arg1)
    if type(arg1) ~= "table" then
        return {}
    end

    if arg1.type == "default" then
        return { target_type = "default" }
    end

    if arg1.type ~= "clientAction" then
        return {}
    end

    return {
        target_type = "clientAction",
        client_action_name = if type(arg1.name) == "string" then arg1.name else nil
    }
end

local function useAbuseSheetAnalytics(arg1, abuseVector: string?, targetId: string?, configName: string?)
    return (React.useCallback(function(arg2)
        local unixTimestampMillis = DateTime.now().UnixTimestampMillis
        local totalDuration = if arg1.openTime then unixTimestampMillis - arg1.openTime else 0
        local path = Dash.map(arg1.stack, function(arg3)
            return arg3.nodeId
        end)
        local tbl1 = {
            run_id = arg1.runId,
            user_id = arg1.userId,
            abuse_vector = abuseVector,
            target_id = targetId,
            total_duration = totalDuration,
            path = path,
            config_name = configName
        }

        sendAnalyticsEvent(tbl1, arg2)
    end, {
        arg1.stack,
        arg1.openTime,
        arg1.runId,
        abuseVector,
        targetId,
        configName
    }))
end

local function useAbuseSheetFlow(arg1, tbl1): {analytics: number, canGoBack: boolean, config: any, currentNodeId: number, currentNodeType: number, currentPageElement: number, dismissInlineAlert: number, display: any, goBack: () -> (), isSubmitting: boolean, navigationDirection: number, onClose: () -> (), pendingInlineAlert: number, reset: (any) -> ()}?
    local startNodeId = React.useMemo(function()
        if arg1 then
            return (resolveStartNode(arg1))
        end

        return "root"
    end, { arg1 })
    local var2, var3 = React.useReducer(reducer2, nil, function()
        return getInitialState(getNewRunId(), DateTime.now().UnixTimestampMillis, startNodeId)
    end)
    local var4 = useOpenLink()

    local var5 = useRoactService(RoactNetworking)

    local func1 = useAbuseSheetAnalytics

    local abuseVector = tbl1.abuseVector
    local analyticsTargetId = tbl1.analyticsTargetId
    local name = if arg1 then arg1.name else nil
    local var6 = func1(var2, abuseVector, analyticsTargetId, name)

    local store = React.useMemo(function()
        return selectStore(var2)
    end, { var2 })

    local config = React.useMemo(function()
        if not arg1 then
            return nil
        end
        return resolveArConfig(arg1, { attribute = arg1.attributes, resources = arg1.resources or {}, store = store })
    end, { arg1, store })

    local var9 = React.useRef(true)
    local var10 = React.useRef(false)

    local bool1 = tbl1.attemptTrigger == "onFirstAction"

    local var11 = React.useRef("none")
    local var12 = React.useRef(var6)
    var12.current = var6

    local var13 = React.useRef(var2.submissionState)
    var13.current = var2.submissionState

    local function setPendingInlineAlert(arg2) -- Luacid: Inlined by compiler; 7 call sites recovered
        if tbl1.inlineAlertController then
            tbl1.inlineAlertController.setInlineAlert(arg2)
        end
    end

    React.useEffect(function()
        return function()
            if var11.current ~= "started" then
                return
            end
            var11.current = "completed"
            var12.current(
                var13.current == "completed" and {
                    sub_event_type = TelemetryEventType.ReportCompleted
                }
                    or {
                        sub_event_type = TelemetryEventType.ReportAbandoned
                    }
            )
        end
    end, {})

    React.useEffect(function()
        if tbl1.open and not var9.current then
            local runId = getNewRunId()
            local unixTimestampMillis = DateTime.now().UnixTimestampMillis
            var3({ type = "reset", payload = { runId = runId, initialEnterTime = unixTimestampMillis, startNodeId = startNodeId } })
            setPendingInlineAlert(nil)
            var10.current = false
        end

        var9.current = false

        if tbl1.open and not bool1 then
            var6({ sub_event_type = TelemetryEventType.ReportStarted })
            var11.current = "started"
        end
    end, { tbl1.open })

    React.useLayoutEffect(function()
        if not arg1 or #var2.stack > 1 then
            return
        end

        local var14 = var2.stack[1]
        if var14 and var14.nodeId == startNodeId then
            return
        end
        local unixTimestampMillis = DateTime.now().UnixTimestampMillis
        var3({
            type = "reset",
            payload = {
                runId = var2.runId,
                initialEnterTime = var2.openTime or unixTimestampMillis,
                startNodeId = startNodeId
            }
        })
    end, { arg1, startNodeId })

    local var14 = Dash.last(var2.stack)
    local node = config and config.nodes and var14 and config.nodes[var14.nodeId]

    React.useEffect(function()
        if not tbl1.open or var10.current then
            return
        end

        if not arg1 then
            return
        end

        if not var14 then
            var6({
                sub_event_type = TelemetryEventType.Error,
                error_detail = { error_message = "No current page found in abuse sheet flow." }
            })
            var10.current = true
            return
        end

        if not var14.nodeId then
            var6({
                sub_event_type = TelemetryEventType.Error,
                error_detail = { error_message = "Current page has no nodeId in abuse sheet flow." }
            })
            var10.current = true
            return
        end

        if not (config and config.nodes) then
            var6({
                sub_event_type = TelemetryEventType.Error,
                error_detail = { error_message = "Abuse sheet flow config or nodes is nil." }
            })
            var10.current = true
            return
        end

        if node then
            return
        end

        var6({
            sub_event_type = TelemetryEventType.Error,
            error_detail = FFlagAbuseReportImproveErrorEvents
                and {
                    error_message = "No config found for current nodeId",
                    error_metadata = {
                        node_id = var14.nodeId
                    }
                }
                or {
                    error_message = `No config found for current nodeId: {var14.nodeId}`
                }
        })
        var10.current = true
    end, {
        tbl1.open,
        arg1,
        config,
        var14,
        node,
        var6
    })

    local function onExternalSubmit(submitSource)
        var12.current({ sub_event_type = TelemetryEventType.Submit, submit_detail = { submit_source = submitSource } })

        var3({ type = "completedSubmission" })
        var13.current = "completed"
        var12.current({ sub_event_type = TelemetryEventType.SubmitSuccess, submit_detail = { submit_source = submitSource } })
    end

    local function notifyFinish()
        if tbl1.onFinish then
            tbl1.onFinish({ didSubmit = var13.current == "completed" })
        end

        if var11.current ~= "started" then
            return
        end

        var11.current = "completed"
        var12.current(
            var13.current == "completed" and {
                sub_event_type = TelemetryEventType.ReportCompleted
            }
                or {
                    sub_event_type = TelemetryEventType.ReportAbandoned
                }
        )
    end

    local function handleClose() -- Luacid: Inlined by compiler; 3 call sites recovered
        notifyFinish()
        tbl1.onClose()
    end

    local function reset(arg2)
        local runId = getNewRunId()
        local unixTimestampMillis = DateTime.now().UnixTimestampMillis
        var3({ type = "reset", payload = { runId = runId, initialEnterTime = unixTimestampMillis, startNodeId = startNodeId } })
        setPendingInlineAlert(arg2)
        var11.current = "none"
    end

    React.useEffect(function()
        if not config or not node or var2.navigationState ~= "gotoNext" and var2.navigationState ~= "gotoFailure" then
            return
        end

        local var16 = Dash.last(var2.stack)
        if not (var16 and var16.nodeId) then
            warn("Navigation triggered but current page or nodeId is invalid")
            return
        end

        local var17 = config.nodes[var16.nodeId]
        if not var17 then
            warn(`Navigation triggered but no config found for nodeId: {var16.nodeId}`)
            return
        end

        local function handleNextSimple(nodeId)
            if not nodeId then
                warn("handleNextSimple called with nil next value")
                tbl1.onClose()
                return
            end

            local unixTimestampMillis = DateTime.now().UnixTimestampMillis
            local inlineAlert = if type(nodeId) == "table" then nodeId.inlineAlert else nil

            if type(nodeId) == "string" then
                var3({ type = "gotoNode", payload = { nodeId = nodeId, enterTime = unixTimestampMillis } })
                setPendingInlineAlert(nil)
                return
            end

            if type(nodeId) == "table" and nodeId.type == "goto" then
                if nodeId.replace then
                    var3({ type = "replaceAndGotoNode", payload = { nodeId = nodeId.nodeId, enterTime = unixTimestampMillis } })
                    setPendingInlineAlert(inlineAlert)
                    return
                end

                var3({ type = "gotoNode", payload = { nodeId = nodeId.nodeId, enterTime = unixTimestampMillis } })
                setPendingInlineAlert(nil)
                return
            end

            if type(nodeId) == "table" and nodeId.type == "link" then
                var12.current({
                    sub_event_type = TelemetryEventType.LinkOpened,
                    link_detail = {
                        href = nodeId.href,
                        source = LinkOpenedSource.NextAction
                    }
                })
                var4("", nodeId.href)
                handleClose()
            elseif type(nodeId) == "table" and nodeId.type == "close" then
                handleClose()
            elseif type(nodeId) == "table" and nodeId.type == "reset" then
                notifyFinish()
                reset(inlineAlert)
            else
                warn(`Unknown next type: {typeof(nodeId)}, value: {nodeId}`)
                handleClose()
            end
        end

        local submission = config.submission
        local target = submission and submission.target
        local var18 = not FFlagAbuseReportSubmissionTargetV4 and {} or getSubmissionTargetTelemetry(target)

        local var19 = nil

        local function onSubmitForm()
            if not FFlagAbuseReportSubmissionTargetV4 then
                if tbl1.onCustomSubmit then
                    if tbl1.abuseVector ~= AbuseVector.MomentsFeed then
                        return (tbl1.onCustomSubmit(submission))
                    end

                    local var20 = tbl1.onCustomSubmit(submission)
                    if var20 ~= nil then
                        return var20
                    end
                end
                return sendReport(var5, submission.endpoint, submission.data)
            end

            if type(target) == "table" and target.type == "default" then
                return sendReport(var5, "abuse-reporting/v1/abuse-report", submission.data)
            end

            if type(target) ~= "table" or target.type ~= "clientAction" then
                var19 = "unsupported-submission-target"
                return Promise.reject("Unsupported submission target")
            end

            local name2 = target.name
            local clientActionHandler = tbl1.clientActionHandlers and tbl1.clientActionHandlers[name2]
            if clientActionHandler then
                return (clientActionHandler(submission))
            end
            var19 = "missing-client-action-handler"
            return Promise.reject(`Missing client action handler: {name2}`)
        end

        local var20 = if var2.navigationState == "gotoFailure" then var17.nextOnFailure else node.next

        if not var20 then
            warn("Navigation target is nil, closing")
            tbl1.onClose()
            return
        end

        if type(var20) ~= "table" or var20.type ~= "submitForm" then
            handleNextSimple(var20)
            return
        end

        local unixTimestampMillis = DateTime.now().UnixTimestampMillis
        var6({
            sub_event_type = TelemetryEventType.Submit,
            submit_detail = {
                submit_source = SubmitSource.Flow,
                target_type = var18.target_type,
                client_action_name = var18.client_action_name
            }
        })

        var3({ type = "startedSubmission" })

        local var21 = if FFlagAbuseReportSubmissionTargetV4 then Promise.try(function()
            return (onSubmitForm())
        end) else onSubmitForm()

        var21:andThen(function(arg2)
            var3({ type = "completedSubmission" })
            var6({
                sub_event_type = TelemetryEventType.SubmitSuccess,
                submit_detail = {
                    report_id = arg2.responseBody and arg2.responseBody.reportId,
                    submit_api_duration = DateTime.now().UnixTimestampMillis - unixTimestampMillis,
                    submit_source = SubmitSource.Flow,
                    target_type = var18.target_type,
                    client_action_name = var18.client_action_name
                }
            })

            var13.current = "completed"
            handleNextSimple(var20.onSuccess)
        end):catch(function(arg2)
            var3({ type = "submissionFailed" })
            var6({
                sub_event_type = TelemetryEventType.SubmitFail,
                submit_detail = {
                    submit_api_duration = DateTime.now().UnixTimestampMillis - unixTimestampMillis,
                    submit_source = SubmitSource.Flow,
                    target_type = var18.target_type,
                    client_action_name = var18.client_action_name,
                    target_failure_reason = var19
                }
            })
            var6({
                sub_event_type = TelemetryEventType.Error,
                error_detail = not FFlagAbuseReportImproveErrorEvents and {
                    error_message = "submitReport: " .. Dash.pretty(arg2, { depth = 10 })
                }
                    or formatErrorDetailForAnalytics("submitReport failed", arg2)
            })

            var13.current = "failed"
            if var20.onFailure then
                handleNextSimple(var20.onFailure)
            end
        end)
    end, { var2.navigationState })

    local bool2 = #var2.stack > 1 and not (var2.submissionState == "completed")

    local function goBack()
        if not (config and node and var14) then
            return
        end
        local unixTimestampMillis = DateTime.now().UnixTimestampMillis
        if not bool2 then
            return
        end

        var3({ type = "goBack" })
        setPendingInlineAlert(nil)
        var6({
            sub_event_type = TelemetryEventType.NodeDone,
            node_done_detail = {
                node_id = var14.nodeId,
                node_type = node.type,
                node_duration = unixTimestampMillis - var14.enterTime,
                node_exit_reason = "back"
            }
        })
    end

    local var16 = node and node.next ~= nil
    local var17 = node and node.nextOnFailure ~= nil
    local function onNext(tbl2)
        if not (config and node and var14) then
            return
        end

        if var11.current == "none" then
            var11.current = "started"
            var12.current({ sub_event_type = TelemetryEventType.ReportStarted })
        end

        local unixTimestampMillis = DateTime.now().UnixTimestampMillis
        var3({
            type = "updateDataAndNavigateNext",
            payload = {
                store = not (tbl2 and tbl2.store) and {} or tbl2.store,
                expectedFromNodeId = var14.nodeId
            }
        })
        var6({
            sub_event_type = TelemetryEventType.NodeDone,
            node_done_detail = {
                node_id = var14.nodeId,
                node_type = node.type,
                node_duration = unixTimestampMillis - var14.enterTime,
                node_exit_reason = "next"
            }
        })
    end

    local function onFailure()
        if not (config and node and var14) then
            return
        end

        local unixTimestampMillis = DateTime.now().UnixTimestampMillis
        var3({ type = "navigateFailure", payload = { expectedFromNodeId = var14.nodeId } })

        var6({
            sub_event_type = TelemetryEventType.NodeDone,
            node_done_detail = {
                node_id = var14.nodeId,
                node_type = node.type,
                node_duration = unixTimestampMillis - var14.enterTime,
                node_exit_reason = "failure"
            }
        })
    end

    local dismissInlineAlert = React.useCallback(function()
        setPendingInlineAlert(nil)
    end, {})

    local analytics = React.useMemo(function()
        return { sendEvent = var6 }
    end, { var6 })

    if not (config and node and var14) then
        return nil
    end

    local tbl2 = {
        config = config,
        canGoBack = bool2,
        goBack = goBack,
        reset = reset,
        isSubmitting = var2.submissionState == "submitting",
        display = config.display,
        onClose = handleClose,
        currentPageElement = 0,
        currentNodeId = 0,
        currentNodeType = 0,
        navigationDirection = 0,
        analytics = 0,
        pendingInlineAlert = 0,
        dismissInlineAlert = 0
    }
    local createElement = React.createElement
    local var20 = ContentNode
    local tbl3 = {
        key = var14.nodeId,
        node = node,
        onNext = 0,
        onFailure = 0,
        goBack = 0,
        onExternalSubmit = 0,
        store = 0,
        isSubmitting = 0
    }

    if not var16 then
        onNext = nil
    end

    tbl3.onNext = onNext
    if not var17 then
        onFailure = nil
    end

    tbl3.onFailure = onFailure
    tbl3.goBack = goBack
    tbl3.onExternalSubmit = onExternalSubmit
    tbl3.store = store
    tbl3.isSubmitting = var2.submissionState == "submitting"
    tbl2.currentPageElement = createElement(var20, tbl3)

    tbl2.currentNodeId = var14.nodeId
    tbl2.currentNodeType = node.type
    tbl2.navigationDirection = var2.lastNavigationDirection
    tbl2.analytics = analytics
    tbl2.pendingInlineAlert = if tbl1.inlineAlertController then tbl1.inlineAlertController.pendingInlineAlert else nil

    tbl2.dismissInlineAlert = dismissInlineAlert
    return tbl2
end

return useAbuseSheetFlow
