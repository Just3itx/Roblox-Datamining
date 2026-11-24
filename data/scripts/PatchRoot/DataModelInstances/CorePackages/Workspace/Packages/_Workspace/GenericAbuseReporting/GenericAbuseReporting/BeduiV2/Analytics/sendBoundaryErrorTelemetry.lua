-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:31:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local Dash = require(GenericAbuseReportingParent.Dash)

local analyticsService = require(GenericAbuseReporting.BeduiV2.Analytics.analyticsService)

local sendAnalyticsEvent = analyticsService.sendAnalyticsEvent
local TelemetryEventType = analyticsService.TelemetryEventType

local function sendBoundaryErrorTelemetry(arg1, tbl1)
    local var1 = Dash.pretty(arg1, { depth = 10, multiline = true })

    sendAnalyticsEvent(
        {
            abuse_vector = tbl1.abuse_vector,
            target_id = tbl1.target_id,
            run_id = "err",
            total_duration = 0,
            path = {}
        },
        {
            sub_event_type = TelemetryEventType.Error,
            error_detail = {
                error_message = `Render error: {var1}`
            }
        }
    )
end
return sendBoundaryErrorTelemetry
