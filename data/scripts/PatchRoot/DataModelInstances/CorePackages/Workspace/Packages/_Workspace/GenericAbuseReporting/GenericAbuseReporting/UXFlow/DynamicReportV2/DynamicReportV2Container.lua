-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:01:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent
local CoreGui = game:GetService("CoreGui")

local Dash = require(GenericAbuseReportingParent.Dash)
local FocusNavigationUtils = require(GenericAbuseReportingParent.FocusNavigationUtils)
local Foundation = require(GenericAbuseReportingParent.Foundation)
local React = require(GenericAbuseReportingParent.React)
local Responsive = require(GenericAbuseReportingParent.Responsive)
local RoactNetworking = require(GenericAbuseReportingParent.RoactServiceTags).RoactNetworking
local useRoactService = require(GenericAbuseReportingParent.RobloxAppHooks).useRoactService

local InlineEventType = require(GenericAbuseReportingParent.OnPlatformSurveys.InlineEventType)
local InlineSurvey = require(GenericAbuseReportingParent.OnPlatformSurveys.InlineSurvey)
local SurveyEventPublisher = require(GenericAbuseReportingParent.OnPlatformSurveys.SurveyEventPublisher)
local WebViewEventType = require(GenericAbuseReportingParent.OnPlatformSurveys.WebViewEventType)

local DialogSize = Foundation.Enums.DialogSize
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local OverlayProvider = Foundation.OverlayProvider
local Sheet = Foundation.Sheet
local useIsSpatial = Responsive.useIsSpatial

local AbuseReportErrorBoundary = require(GenericAbuseReporting.BeduiV2.Components.AbuseReportErrorBoundary)
local _AbuseSheetFlowTypes = require(GenericAbuseReporting.BeduiV2.Hooks.AbuseSheetFlow.AbuseSheetFlowTypes)
local AbuseVector = require(GenericAbuseReporting.Enums.AbuseVector)
local analyticsService = require(GenericAbuseReporting.BeduiV2.Analytics.analyticsService)
local DynamicReportV2Error = require(script.Parent.DynamicReportV2Error)
local DynamicReportV2Loading = require(script.Parent.DynamicReportV2Loading)
local fetchConfigWithAttributes = require(GenericAbuseReporting.BeduiV2.Hooks.AbuseSheetFlow.fetchConfigWithAttributes)
local getNewRunId = require(GenericAbuseReporting.BeduiV2.Hooks.AbuseSheetFlow.reducer).getNewRunId
local AbuseReportContent = require(script.Parent.AbuseReportContent)
local sendBoundaryErrorTelemetry = require(GenericAbuseReporting.BeduiV2.Analytics.sendBoundaryErrorTelemetry)
local useFocusNavigationRefs = require(GenericAbuseReporting.BeduiV2.Hooks.FocusNavigation.useFocusNavigationRefs)
local useVrOverlay = require(GenericAbuseReporting.BeduiV2.Hooks.useVrOverlay)

local formatErrorDetailForAnalytics = analyticsService.formatErrorDetailForAnalytics
local sendAnalyticsEvent = analyticsService.sendAnalyticsEvent
local TelemetryEventType = analyticsService.TelemetryEventType

local bool1 = game:DefineFastFlag("FixDynamicReportV2VRAsync", false)
local FFlagEnableInlineSurveyOnUserReport = require(GenericAbuseReportingParent.SharedFlags).FFlagEnableInlineSurveyOnUserReport
local FFlagSurvBloxEventTypeEnabled = require(GenericAbuseReportingParent.SharedFlags).FFlagSurvBloxEventTypeEnabled
local FFlagAbuseReportAttributes = require(GenericAbuseReportingParent.SharedFlags).FFlagAbuseReportAttributes
local FFlagAbuseReportImproveErrorEvents = require(GenericAbuseReporting.Flags.FFlagAbuseReportImproveErrorEvents)

return React.memo(function(tbl1) -- name: DynamicReportV2Container
    local var1 = useRoactService(RoactNetworking)
    local rawConfig, var3 = React.useState(nil)
    local var4, var5 = React.useState(false)
    local var6, var7 = React.useState(true)
    local var8 = if FFlagAbuseReportAttributes then tbl1.analyticsTargetId else tbl1.targetId
    local var9 = nil
    if FFlagAbuseReportAttributes then
        var9 = React.useRef(var8)
        var9.current = var8
    end

    local var10 = nil
    local var11 = nil
    local var12 = nil
    if FFlagEnableInlineSurveyOnUserReport then
        local var13
        var10, var13 = React.useState(false)
        var11 = var13

        var12 = React.useRef(false)
    end

    local var13 = if FFlagAbuseReportAttributes then tbl1.attributes else tbl1.targetId

    if FFlagAbuseReportAttributes then
        local var14 = React.useRef(tbl1.attributes)
        if not Dash.shallowEqual(var14.current, tbl1.attributes) then
            var14.current = tbl1.attributes
        end
        var13 = var14.current or false
    end

    React.useEffect(function()
        local bool2 = false
        local unixTimestampMillis = DateTime.now().UnixTimestampMillis
        fetchConfigWithAttributes(
            var1,
            tbl1.abuseVector,
            not FFlagAbuseReportAttributes and {
                targetId = tbl1.targetId
            } or tbl1.attributes
        ):andThen(
            function(arg1)
                if bool2 then
                    return
                end

                local responseBody = arg1.responseBody
                local loadDurationMs = DateTime.now().UnixTimestampMillis - unixTimestampMillis
                var3(responseBody)
                sendAnalyticsEvent({
                    abuse_vector = tbl1.abuseVector,
                    target_id = if FFlagAbuseReportAttributes then var9.current else tbl1.targetId,
                    run_id = "unknown",
                    total_duration = 0,
                    path = {},
                    config_name = responseBody.name
                }, {
                    sub_event_type = TelemetryEventType.ConfigLoaded,
                    config_load_detail = {
                        load_duration_ms = loadDurationMs,
                        cache_hit = false,
                        retry_count = 0
                    }
                })
            end
        ):catch(
            function(arg1)
                if bool2 then
                    return
                end
                warn("Failed to fetch Dynamic Report V2 config:", arg1)
                var5(true)
                sendAnalyticsEvent({
                    abuse_vector = tbl1.abuseVector,
                    target_id = if FFlagAbuseReportAttributes then var9.current else tbl1.targetId,
                    run_id = getNewRunId(),
                    total_duration = 0,
                    path = {}
                }, {
                    sub_event_type = TelemetryEventType.Error,
                    error_detail = not FFlagAbuseReportImproveErrorEvents
                        and {
                            error_message = "Failed to fetch config: " .. Dash.pretty(arg1, { depth = 10, multiline = true })
                        }
                        or formatErrorDetailForAnalytics("Failed to fetch config", arg1)
                })
            end
        )
        return function()
            bool2 = true
        end
    end, { var1, tbl1.abuseVector, var13 })

    local ref = React.useRef(nil)

    local var15 = React.useRef(false)

    local var16 = nil
    local var17 = nil
    local var18 = nil
    local var19, var20

    if FFlagEnableInlineSurveyOnUserReport then
        var16 = React.useRef(false)

        var17 = React.useCallback(function(tbl2)
            if not tbl2.didSubmit then
                return
            end

            var16.current = true
            if tbl1.onSubmit then
                tbl1.onSubmit()
            end
        end, { tbl1.onSubmit })

        var18 = React.useCallback(function()
            if FFlagSurvBloxEventTypeEnabled then
                SurveyEventPublisher.publishSurveyEvent(WebViewEventType.ReportSubmitted)
            end
        end, {})

        var19 = React.useCallback(function()
            var12.current = true
        end, {})

        var20 = React.useCallback(function()
            if not var12.current then
                var18()
            end
            tbl1.onClose()
        end, { var18, tbl1.onClose })
    else
        var19 = nil
        var20 = nil
    end

    local onClose = React.useCallback(function()
        var15.current = true
        var7(false)
    end, {})

    local var2 = React.useCallback(function()
        if not var15.current and ref.current then
            ref.current.requestClose()
        end
        var7(false)

        if FFlagEnableInlineSurveyOnUserReport then
            if not var16.current then
                tbl1.onClose()
                return
            end

            if tbl1.abuseVector == AbuseVector.UserProfile then
                var11(true)
                return
            end
            var18()
        end

        tbl1.onClose()
    end, { tbl1.onClose, tbl1.abuseVector, var18 })

    local onResolveError = React.useCallback(function()
        var5(true)
    end, {})

    local onError = React.useCallback(function(arg1)
        warn("AbuseReportErrorBoundary caught:", arg1)
        sendBoundaryErrorTelemetry(arg1, { abuse_vector = tbl1.abuseVector, target_id = var8 })

        var5(true)
    end, { tbl1.abuseVector, var8 })

    local var25 = useFocusNavigationRefs(FocusNavigableSurfaceIdentifierEnum.CentralOverlay, function()
        var7(false)
    end)
    local var26, var27 = React.useState(true)
    local takeoverFocus = React.useCallback(function(bool2: boolean)
        var27(not bool2)
    end, {})
    local var14 = React.useCallback(function(current)
        if not var26 then
            current = nil
        end

        if typeof(var25) == "function" then
            var25(current)
        elseif var25 and typeof(var25) == "table" then
            var25.current = current
        end
    end, { var26, var25 })

    local vrCentralOverlay = CoreGui:FindFirstChild("VRCentralOverlay")
    local centralOverlaySurfaceGui = if vrCentralOverlay then vrCentralOverlay:FindFirstChild("CentralOverlay_SurfaceGui") else nil
    local var30 = useIsSpatial()
    if bool1 then
        centralOverlaySurfaceGui = useVrOverlay()
    end
    local createElement = React.createElement
    local root = Sheet.Root
    local tbl2 = {
        centerSheetHeight = 1,
        isOpen = var6,
        onClose = var2,
        preferCenterSheet = true,
        snapPoints = { 0.9 },
        size = DialogSize.Medium,
        ref = var14
    }
    local tbl3 = { AbuseReportDialog = 0, LoadingDialog = 0, ErrorDialog = 0 }
    local element

    if rawConfig and not var4 then
        element = React.createElement(AbuseReportErrorBoundary, { onError = onError }, {
            AbuseReportContent = React.createElement(AbuseReportContent, {
                ref = ref,
                rawConfig = rawConfig,
                abuseVector = tbl1.abuseVector,
                analyticsTargetId = var8,
                onClose = onClose,
                open = var6,
                takeoverFocus = takeoverFocus,
                onResolveError = onResolveError,
                onCustomSubmit = tbl1.onCustomSubmit,
                clientActionHandlers = tbl1.clientActionHandlers,
                onFinish = var17
            })
        })
    else
        element = nil
    end

    tbl3.AbuseReportDialog = element

    tbl3.LoadingDialog = if rawConfig or var4 then nil else React.createElement(DynamicReportV2Loading, nil)

    tbl3.ErrorDialog = if var4 then React.createElement(DynamicReportV2Error, nil) else nil
    local sheet = createElement(root, tbl2, tbl3)

    if bool1 and var30 and not centralOverlaySurfaceGui then
        return nil
    elseif FFlagEnableInlineSurveyOnUserReport and var10 then
        return React.createElement(OverlayProvider, { gui = centralOverlaySurfaceGui }, {
            Survey = React.createElement(
                InlineSurvey,
                {
                    eventType = InlineEventType.UserReportButtonClicked,
                    onEligible = var19,
                    onClose = var20
                }
            )
        })
    end
    return React.createElement(OverlayProvider, { gui = centralOverlaySurfaceGui }, { Sheet = sheet })
end)
