-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local Foundation = require(GenericAbuseReportingParent.Foundation)
local Motion = require(GenericAbuseReportingParent.Motion)
local React = require(GenericAbuseReportingParent.React)

local AlertSeverity = Foundation.Enums.AlertSeverity
local FeedbackAlert = Foundation.FeedbackAlert
local View = Foundation.View

local AbuseReportAnalyticsContext = require(GenericAbuseReporting.BeduiV2.Analytics.AbuseReportAnalyticsContext)
local TelemetryEventType = require(GenericAbuseReporting.BeduiV2.Analytics.analyticsService).TelemetryEventType
local useAbuseReportAnalytics = AbuseReportAnalyticsContext.useAbuseReportAnalytics

local FFlagAbuseReportImproveErrorEvents = require(GenericAbuseReporting.Flags.FFlagAbuseReportImproveErrorEvents)

local state = Motion.createState(
    {
        groupTransparency = 1,
        position = UDim2.new(0, 0, -0.5, 0),
        sizeY = 0
    },
    {
        default = Motion.transition(Motion.TransitionPreset.Default, { duration = 0.15 })
    }
)
local tbl1 = {
    error = AlertSeverity.Error,
    warning = AlertSeverity.Warning,
    info = AlertSeverity.Info,
    success = AlertSeverity.Success
}

return React.memo(function(tbl2) -- name: Feedback
    local var1 = Motion.usePresence()
    local var2, var3 = Motion.useMotion(state)
    local var4 = React.useRef(0)
    local var5 = React.useRef(var1.isPresent)
    local sendEvent = useAbuseReportAnalytics().sendEvent

    React.useEffect(function()
        if tbl1[tbl2.severity] then
            return
        end

        local var6 = sendEvent
        local tbl3 = {
            sub_event_type = TelemetryEventType.Error,
            error_detail = 0
        }
        local tbl4

        if FFlagAbuseReportImproveErrorEvents then
            tbl4 = {
                error_message = "feedback missing correct severity",
                error_metadata = {
                    received_severity = tbl2.severity
                }
            }
        else
            tbl4 = { error_message = 0 }

            local severity = tbl2.severity
            tbl4.error_message = "feedback missing correct severity, received type: " .. tostring(severity)
        end

        tbl3.error_detail = tbl4
        var6(tbl3)
    end, { tbl2.severity, sendEvent })

    React.useEffect(function()
        var5.current = var1.isPresent
    end, { var1.isPresent })

    React.useEffect(function()
        if var1.isPresent then
            if var4.current > 0 then
                var3({ groupTransparency = 0, position = UDim2.new(0, 0, 0, 1), sizeY = var4.current + 2 + (tbl2.bottomMargin or 0) })
            end

            return
        end

        var3({
            groupTransparency = 1,
            position = UDim2.new(0, 0, -0.5, 0),
            sizeY = 0
        }, {
            onAnimationComplete = function(arg1)
                if arg1 == true then
                    var1.onExitComplete()
                end
            end
        })
    end, {
        var1.isPresent,
        var3,
        var1.onExitComplete,
        tbl2.bottomMargin
    })
    local var6 = React.useCallback(function(arg1)
        local absoluteSizeY = arg1.AbsoluteSize.Y
        if absoluteSizeY <= 0 or absoluteSizeY == var4.current then
            return
        end

        var4.current = absoluteSizeY

        if not var5.current then
            return
        end

        var3({ groupTransparency = 0, position = UDim2.new(0, 0, 0, 1), sizeY = absoluteSizeY + 2 + (tbl2.bottomMargin or 0) })
    end, { var3, tbl2.bottomMargin })

    local maxWidth = tbl2.maxWidth
    local createElement = React.createElement
    local var7 = View

    local tbl3 = {
        Size = var2.sizeY:map(function(yOffset: number): UDim2
            if maxWidth ~= nil then
                return UDim2.new(0, maxWidth, 0, yOffset)
            end
            return UDim2.new(1, 0, 0, yOffset)
        end),
        ClipsDescendants = true,
        LayoutOrder = tbl2.layoutOrder
    }

    local tbl4 = {
        Content = React.createElement("CanvasGroup", {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            GroupTransparency = var2.groupTransparency,
            Position = var2.position,
            [React.Change.AbsoluteSize] = var6
        }, {
            Padding = React.createElement("UIPadding", {
                PaddingTop = UDim.new(0, 1),
                PaddingBottom = UDim.new(0, 1),
                PaddingLeft = UDim.new(0, 1),
                PaddingRight = UDim.new(0, 1)
            }),
            Alert = React.createElement(FeedbackAlert, {
                severity = tbl1[tbl2.severity] or AlertSeverity.Info,
                title = tbl2.title,
                subtitle = tbl2.subtitle,
                onClose = tbl2.onClose
            })
        })
    }
    return createElement(var7, tbl3, tbl4)
end)
