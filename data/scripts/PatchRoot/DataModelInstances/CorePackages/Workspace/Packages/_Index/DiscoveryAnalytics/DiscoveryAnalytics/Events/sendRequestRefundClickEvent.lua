-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")
local DiscoveryAnalyticsParent = script:FindFirstAncestor("DiscoveryAnalytics").Parent
local t = require(DiscoveryAnalyticsParent.t)
local DiscoveryEventErrorLogger = require(DiscoveryAnalyticsParent.DiscoveryUtils).DiscoveryEventErrorLogger

local throttlingPercentage = game:DefineFastInt("RequestRefundClickThrottleHundredthsPercent", 0)

local var1 = t.strictInterface({ placeId = t.string })

local config = {
    eventName = "requestRefundClick",
    backends = { "EventIngest" },
    throttlingPercentage = throttlingPercentage,
    lastUpdated = { 26, 4, 24 }
}

return function(customFields, eventContext)
    if type(eventContext) ~= "string" or eventContext == "" then
        DiscoveryEventErrorLogger.reportError(
            "RequestRefundClickInvalidInterface",
            `string eventContext expected, got {type(eventContext)} with value {tostring(eventContext)}`
        )
    end

    local var2, var3 = var1(customFields)
    if not var2 then
        DiscoveryEventErrorLogger.reportError("RequestRefundClickInvalidInterface", var3)
    end

    TelemetryService:LogEvent(
        config,
        {
            eventContext = eventContext,
            standardizedFields = { "addSessionInfo" },
            customFields = customFields
        }
    )
end
