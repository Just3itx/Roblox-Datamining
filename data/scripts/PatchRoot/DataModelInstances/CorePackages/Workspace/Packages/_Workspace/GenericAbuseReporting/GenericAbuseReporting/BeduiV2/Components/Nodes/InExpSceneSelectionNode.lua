-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:41:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local React = require(GenericAbuseReportingParent.React)

local AbuseReportAnalyticsContext = require(GenericAbuseReporting.BeduiV2.Analytics.AbuseReportAnalyticsContext)
local analyticsService = require(GenericAbuseReporting.BeduiV2.Analytics.analyticsService)
local inExpSceneSelectionAdapter = require(script.Parent.inExpSceneSelectionAdapter)
local getIsInExpSceneSelectionAvailable = require(script.Parent.getIsInExpSceneSelectionAvailable)
local LayoutSlots = require(GenericAbuseReporting.BeduiV2.Components.LayoutSlots)
local TextWithTranslation = require(GenericAbuseReporting.BeduiV2.Utils.Translate.TextWithTranslation)
local _translate = require(GenericAbuseReporting.BeduiV2.Utils.Translate.translate)

local SubmitSource = analyticsService.SubmitSource
local TelemetryEventType = analyticsService.TelemetryEventType
local useAbuseReportAnalytics = AbuseReportAnalyticsContext.useAbuseReportAnalytics
local useLayoutSlots = LayoutSlots.useLayoutSlots

return React.memo(function(current) -- name: InExpSceneSelectionNode
    local input, var2 = React.useState(current.loadingText)
    local sendEvent = useAbuseReportAnalytics().sendEvent

    local var3 = useLayoutSlots()
    local layout = var3.Layout
    local title = var3.Title

    local var4 = React.useRef(current)
    var4.current = current

    local var5 = React.useRef(sendEvent)
    var5.current = sendEvent

    React.useEffect(function()
        if not getIsInExpSceneSelectionAvailable() then
            var5.current({
                sub_event_type = TelemetryEventType.SceneCaptureResult,
                scene_capture_detail = { exit_reason = "unavailable", success = false }
            })

            local current2 = var4.current
            if current2.onFailure then
                current2.onFailure()
                return
            end
            var2(current2.errorText)

            return
        end

        local var6 = nil
        var6 = inExpSceneSelectionAdapter.subscribeOnceToExitReason(function(arg1)
            var6 = nil
            var5.current({
                sub_event_type = TelemetryEventType.SceneCaptureResult,
                scene_capture_detail = {
                    exit_reason = arg1.reason,
                    success = arg1.reason == "submit"
                }
            })
            local current2 = var4.current
            if arg1.reason ~= "submit" then
                if current2.goBack then
                    current2.goBack()
                end

                return
            end

            if current2.onExternalSubmit then
                current2.onExternalSubmit(SubmitSource.SceneSelection)
            end
            if current2.onNext then
                current2.onNext()
            end
        end)

        if not pcall(inExpSceneSelectionAdapter.start) then
            var5.current({
                sub_event_type = TelemetryEventType.SceneCaptureResult,
                scene_capture_detail = { exit_reason = "start_failed", success = false }
            })

            if var6 then
                var6:Disconnect()
                var6 = nil
            end
            local current2 = var4.current
            if current2.onFailure then
                current2.onFailure()
            else
                var2(current2.errorText)
            end
        end

        return function()
            if var6 then
                var6:Disconnect()
                var6 = nil
            end
        end
    end, {})

    local createElement = React.createElement
    local tbl1 = {
        body = React.createElement(React.Fragment, nil, {
            Title = React.createElement(title, { input = current.title, layoutOrder = 1 }),
            Message = if input then React.createElement(TextWithTranslation, { input = input, tag = "size-full-0 auto-y text-body-small", layoutOrder = 2 }) else nil
        })
    }
    return createElement(layout, tbl1)
end)
