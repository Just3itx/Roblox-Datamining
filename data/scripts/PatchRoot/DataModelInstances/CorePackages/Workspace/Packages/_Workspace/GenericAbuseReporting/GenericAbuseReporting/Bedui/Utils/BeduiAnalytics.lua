-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent
local LocalPlayer = game:GetService("Players").LocalPlayer
local TelemetryService = game:GetService("TelemetryService")

local ArgCheck = require(GenericAbuseReportingParent.ArgCheck)
local Dash = require(GenericAbuseReportingParent.Dash)

local AbuseEntrypoint = require(GenericAbuseReporting.Enums.AbuseEntrypoint)
local _AbuseVector = require(GenericAbuseReporting.Enums.AbuseVector)

local config = {
    eventName = "DynamicAbuseReportEvent",
    description = "Event to track dynamic abuse report",
    lastUpdated = { 2024, 6, 18 },
    backends = { "EventIngest", "Points" },
    throttlingPercentage = game:DefineFastInt("DynamicAbuseReportThrottleHundredthsPercent", 0),
    links = "https://github.rbx.com/Roblox/proto-schemas/pull/6068"
}

local function buildCustomFields(tbl1)
    local meta = if tbl1.meta then Dash.pretty(tbl1.meta, { depth = 10, multiline = false }) else nil
    return {
        abuse_vector = tbl1.context.abuseVector,
        user_id = if LocalPlayer then LocalPlayer.UserId else 0,
        event_type = tbl1.eventType,
        entry_point = AbuseEntrypoint.APP,
        meta = meta
    }
end

return {
    sendAnalyticsEvent = function(tbl1)
        ArgCheck.assert(tbl1.context, "customFields must be provided")
        ArgCheck.assert(tbl1.context.abuseVector, "customFields.abuse_vector must be provided")

        TelemetryService:LogEvent(config, { customFields = buildCustomFields(tbl1) })
    end,
    TelemetryEventType = {
        Abandoned = "EVENT_ABANDONED",
        Error = "EVENT_ERROR",
        Rendered = "EVENT_RENDERED",
        Submitted = "EVENT_SUBMITTED"
    }
}
