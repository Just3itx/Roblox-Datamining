-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:40:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")

local DiscoveryAnalyticsParent = script:FindFirstAncestor("DiscoveryAnalytics").Parent

local t = require(DiscoveryAnalyticsParent.t)
local DiscoveryEventErrorLogger = require(DiscoveryAnalyticsParent.DiscoveryUtils).DiscoveryEventErrorLogger

local config = {
    eventName = "playButtonLoadingDuration",
    backends = { "EventIngest", "Points" },
    throttlingPercentage = game:DefineFastInt("LuaAppPlayButtonLoadingDurationTelemetryThrottleHundredthsPercent", 10000),
    lastUpdated = { 26, 5, 12 },
    description = "Fires when a mounted Play Button leaves the Loading state."
}

local var1 = t.strictInterface({
    universeId = t.string,
    durationMs = t.number,
    endReason = t.string,
    endPlayButtonState = t.optional(t.string),
    endPlayabilityStatus = t.optional(t.string),
    pageName = t.optional(t.string)
})

return function(customFields, eventContext: string?)
    local var2, var3 = var1(customFields)
    if not var2 then
        DiscoveryEventErrorLogger.reportError("PlayButtonLoadingDurationInvalidInterface", var3)
    end

    TelemetryService:LogEvent(config, {
        eventContext = eventContext,
        standardizedFields = { "addSessionInfo", "addSessionId", "addOSInfo" },
        customFields = customFields
    })
end
