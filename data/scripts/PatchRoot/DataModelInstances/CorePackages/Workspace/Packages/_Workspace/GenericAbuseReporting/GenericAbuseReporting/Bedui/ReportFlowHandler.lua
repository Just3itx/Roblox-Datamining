-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent
local Players = game:GetService("Players")

local ArgCheck = require(GenericAbuseReportingParent.ArgCheck)
local Cryo = require(GenericAbuseReportingParent.Cryo)
local Dash = require(GenericAbuseReportingParent.Dash)
local React = require(GenericAbuseReportingParent.React)
local RoactNetworking = require(GenericAbuseReportingParent.RoactServiceTags).RoactNetworking
local Foundation = require(GenericAbuseReportingParent.Foundation)
local ButtonVariant = Foundation.Enums.ButtonVariant
local Empty = Foundation.Empty
local FillBehavior = Foundation.Enums.FillBehavior
local Radius = Foundation.Enums.Radius
local Skeleton = Foundation.Skeleton
local useLayerCollector = require(GenericAbuseReportingParent.UIBlox).Core.Layout.LayerCollector.useLayerCollector
local useRoactService = require(GenericAbuseReportingParent.RobloxAppHooks).useRoactService
local useTokens = Foundation.Hooks.useTokens

local AbuseReportBeduiTypes = require(GenericAbuseReporting.Bedui.Provider.AbuseReportBeduiTypes)
local AbuseReportBeduiContextStatus = AbuseReportBeduiTypes.AbuseReportBeduiContextStatus
local AbuseCategory = require(GenericAbuseReporting.Enums.AbuseCategory)
local AbuseVector = require(GenericAbuseReporting.Enums.AbuseVector)
local BeduiAnalytics = require(GenericAbuseReporting.Bedui.Utils.BeduiAnalytics)
local createReport = require(GenericAbuseReporting.Bedui.Utils.createReport)
local getReportBody = require(GenericAbuseReporting.Bedui.Utils.getReportBody)
local getReportTags = require(GenericAbuseReporting.Bedui.Utils.getReportTags)
local InnerContentConfigType = AbuseReportBeduiTypes.InnerContentConfigType
local sendAnalyticsEvent = BeduiAnalytics.sendAnalyticsEvent
local SingleStepContainer = require(GenericAbuseReporting.Bedui.SingleStepContainer)
local SingleStepInnerContentRenderer = require(GenericAbuseReporting.Bedui.SingleStepInnerContentRenderer)
local Stepper = require(GenericAbuseReporting.Common.Stepper)
local TelemetryEventType = BeduiAnalytics.TelemetryEventType
local submitReport = require(GenericAbuseReporting.Bedui.Utils.submitReport)
local submitReportV1 = require(GenericAbuseReporting.Bedui.Utils.submitReportV1)
local useAnalyticsContext = require(GenericAbuseReporting.Bedui.Provider.useAnalyticsContext)
local useBeduiData = require(GenericAbuseReporting.Bedui.Provider.useBeduiData)
local useFormData = require(GenericAbuseReporting.Bedui.Provider.useFormData)
local validateBeduiData = require(GenericAbuseReporting.Bedui.Provider.validateBeduiData)
local ValueToAbuseCategory = require(GenericAbuseReporting.Enums.ValueToAbuseCategory)

local FFlagAddThumbnailSelectorReport = require(GenericAbuseReportingParent.SharedFlags).FFlagAddThumbnailSelectorReport
local FFlagGenericAbuseReportingUnifyReportTags = require(GenericAbuseReporting.Flags.FFlagGenericAbuseReportingUnifyReportTags)

return React.memo(function(tbl1) -- name: ReportFlowHandler
    local var1 = useTokens()
    local formDataKeysWithError, var3 = React.useState({})
    local var4 = useBeduiData()
    local formData = useFormData().formData
    local additionalReportTags = useFormData().additionalReportTags
    local var5 = useRoactService(RoactNetworking)

    local context = useAnalyticsContext()
    local isReportSubmitted = context.isReportSubmitted
    local setIsReportSubmitted = context.setIsReportSubmitted

    local bool1 = useLayerCollector().absoluteSize.X < 540

    local var7 = React.useMemo(function(): boolean
        return var4 == nil or var4.status == AbuseReportBeduiContextStatus.Loading
    end, { var4 })

    local var8 = React.useMemo(function(): boolean
        if var7 or var4 == nil then
            return true
        end
        local var8, var9 = validateBeduiData(var4.beduiData)
        if var8 then
            return var4.status == AbuseReportBeduiContextStatus.Error
        end

        sendAnalyticsEvent({
            eventType = TelemetryEventType.Error,
            context = context,
            meta = {
                error = `ReportFlowHandler - Invalid Bedui data: {tostring(var9)}`
            }
        })
        return true
    end, {
        var4,
        var7,
        validateBeduiData,
        sendAnalyticsEvent,
        context
    })

    local var9 = React.useCallback(function(arg1): boolean
        if arg1 == nil then
            return true
        end

        local bool2 = false
        if arg1.type == InnerContentConfigType.ConfigurableComponentList then
            for _, component in arg1.configurableComponentList.components do
                if not component.isOptional and formData[component.formDataKey] == nil then
                    var3(Cryo.List.join(formDataKeysWithError, { component.formDataKey }))
                    bool2 = true
                end
            end
        end
        return not bool2
    end, { formData, formDataKeysWithError })

    local var10 = React.useCallback(function()
        local localPlayer = Players.LocalPlayer
        if localPlayer == nil then
            sendAnalyticsEvent(
                {
                    eventType = TelemetryEventType.Error,
                    context = context,
                    meta = { error = "ReportFlowHandler - LocalPlayer is nil" }
                }
            )
            return
        end

        if tbl1.abuseVector == AbuseVector.AdV2 then
            local reportBody = getReportBody({
                abuseVector = tbl1.abuseVector,
                formData = formData,
                localPlayerUserId = localPlayer.UserId,
                targetIdStr = tbl1.targetId,
                additionalReportTags = additionalReportTags
            })
            submitReportV1(var5, reportBody):andThen(function(_)
                sendAnalyticsEvent({ eventType = TelemetryEventType.Submitted, context = context })

                if tbl1.onSubmit then
                    tbl1.onSubmit()
                end
            end):catch(function(arg1)
                local var10 = Dash.pretty(arg1, { depth = 10 })
                sendAnalyticsEvent({
                    eventType = TelemetryEventType.Error,
                    context = context,
                    meta = {
                        error = `ReportFlowHandler - Submitting v1 report: {var10}`
                    }
                })
            end)

            return
        end

        if FFlagGenericAbuseReportingUnifyReportTags or FFlagAddThumbnailSelectorReport then
            local reportTags = getReportTags({
                formData = formData,
                localPlayerUserId = tostring(localPlayer.UserId),
                abuseVector = tbl1.abuseVector,
                targetId = tbl1.targetId,
                custom = tbl1.custom,
                additionalReportTags = additionalReportTags
            })

            submitReport(var5, reportTags):andThen(function(_)
                sendAnalyticsEvent({ eventType = TelemetryEventType.Submitted, context = context })

                if tbl1.onSubmit then
                    tbl1.onSubmit()
                end
            end):catch(function(arg1)
                local var10 = Dash.pretty(arg1, { depth = 10 })
                sendAnalyticsEvent({
                    eventType = TelemetryEventType.Error,
                    context = context,
                    meta = {
                        error = `ReportFlowHandler - Submitting report: {var10}`
                    }
                })
            end)
        else
            local report = createReport({
                abuseCategory = ValueToAbuseCategory[formData.legacy_abuse_category] or formData.abuse_category or AbuseCategory.ABUSE_CATEGORY_INVALID,
                abuseVector = tbl1.abuseVector,
                comment = formData.free_comment,
                submitterId = tostring(localPlayer.UserId),
                targetId = tbl1.targetId,
                custom = tbl1.custom
            })
            submitReport(var5, report):andThen(function(_)
                sendAnalyticsEvent({ eventType = TelemetryEventType.Submitted, context = context })
            end):catch(function(arg1)
                local var10 = Dash.pretty(arg1, { depth = 10 })
                sendAnalyticsEvent({
                    eventType = TelemetryEventType.Error,
                    context = context,
                    meta = {
                        error = `ReportFlowHandler - Submitting report: {var10}`
                    }
                })
            end)
        end
    end, {
        formData,
        Players.LocalPlayer,
        tbl1.abuseVector,
        tbl1.targetId,
        sendAnalyticsEvent,
        context
    })

    local steps = React.useMemo(function()
        if var7 then
            return {}
        end
        if var8 or not (var4.beduiData and var4.beduiData.nodes) then
            sendAnalyticsEvent({
                eventType = TelemetryEventType.Error,
                context = context,
                meta = { error = "ReportFlowHandler - Invalid Bedui data or no nodes found" }
            })

            return {}
        end

        local result = ({})
        for _, value in var4.beduiData.nodes do
            local node = Dash.joinDeep({}, value)

            local innerContentConfig = node.innerContentConfig
            local footerContentConfig = bool1 and value.footerContentConfig
            if footerContentConfig then
                innerContentConfig = {
                    type = innerContentConfig.type,
                    configurableComponentList = {
                        components = Cryo.List.join(
                            innerContentConfig.configurableComponentList.components,
                            node.footerContentConfig.configurableComponentList.components
                        )
                    }
                }
            end

            if result[node.stepId] ~= nil then
                local var12 = sendAnalyticsEvent
                local tbl2 = {
                    eventType = TelemetryEventType.Error,
                    context = context,
                    meta = 0
                }
                local meta = { error = 0 }
                local stepId = node.stepId
                meta.error = `ReportFlowHandler - Duplicate stepId found: {tostring(stepId)}`
                tbl2.meta = meta
                var12(tbl2)

                return {}
            end

            local stepId = node.stepId
            local tbl2 = {
                stepId = node.stepId,
                predefinedNextStepId = node.actionInfo.predefinedNextStepId,
                content = React.createElement(
                    SingleStepContainer,
                    {
                        node = node,
                        contentConfig = innerContentConfig,
                        formDataKeysWithError = formDataKeysWithError
                    }
                ),
                footer = if node.footerContentConfig and not footerContentConfig then React.createElement(
                    SingleStepInnerContentRenderer,
                    {
                        contentConfig = node.footerContentConfig,
                        formDataKeysWithError = formDataKeysWithError
                    }
                ) else nil,
                labels = {
                    continueButton = node.actionInfo.actionLabel
                },
                onStepCancel = nil,
                onStepContinue = 0,
                validateState = 0,
                stepStyle = 0
            }

            function tbl2.onStepContinue()
                ArgCheck.assert(isReportSubmitted == false, "Report should only be able to be submitted once")
                if isReportSubmitted then
                    local var12 = sendAnalyticsEvent
                    local tbl3 = {
                        eventType = TelemetryEventType.Error,
                        context = context,
                        meta = 0
                    }
                    local meta = { error = 0 }

                    local stepId2 = node.stepId
                    meta.error = `ReportFlowHandler - Report already submitted for stepId: {tostring(stepId2)}`
                    tbl3.meta = meta
                    var12(tbl3)
                end

                if node.actionInfo.shouldSubmit and not isReportSubmitted then
                    var10()
                    setIsReportSubmitted(true)
                end
            end
            function tbl2.validateState()
                return var9(innerContentConfig)
            end
            tbl2.stepStyle = {
                continueButton = {
                    variant = if node.actionInfo.shouldSubmit then ButtonVariant.Emphasis else ButtonVariant.Standard,
                    fillBehavior = if bool1 then FillBehavior.Fill else FillBehavior.Fit
                },
                buttonXAlignment = "align-x-right"
            }
            result[stepId] = tbl2
        end

        return result
    end, {
        var7,
        var8,
        var4,
        formDataKeysWithError,
        bool1,
        var10,
        var9,
        isReportSubmitted,
        sendAnalyticsEvent,
        context
    })

    if var7 then
        return (React.createElement(Skeleton, { radius = Radius.Medium, Size = UDim2.new(1, 0, 0, var1.Size.Size_2500) }))
    elseif var8 or not next(steps) then
        return (React.createElement(Empty, {}))
    elseif next(steps) and var4.beduiData then
        return (React.createElement(Stepper, { currentStep = var4.beduiData.rootStepId, steps = steps }))
    end
    return nil
end)
