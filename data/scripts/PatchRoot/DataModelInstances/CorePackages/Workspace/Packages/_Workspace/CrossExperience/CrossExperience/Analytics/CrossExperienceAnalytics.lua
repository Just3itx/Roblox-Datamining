-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T12:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")

local throttlingPercentage = game:DefineFastInt("FIntCrossExperienceEventThrottleHunderedthsPercent", 10000)

function logEvent(eventName: string, customFields)
    TelemetryService:LogEvent({
        eventName = eventName,
        backends = { "EventIngest" },
        throttlingPercentage = throttlingPercentage,
        lastUpdated = { 2025, 6, 30 },
        description = "Cross Experience Analytics Events"
    }, { customFields = customFields })
end

return {
    logEvent = logEvent
}
