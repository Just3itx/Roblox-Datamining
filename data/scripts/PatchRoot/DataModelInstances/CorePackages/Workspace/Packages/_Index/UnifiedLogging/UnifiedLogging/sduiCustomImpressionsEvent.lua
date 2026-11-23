-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:20:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")

local throttlingPercentage = game:DefineFastInt("LuaAppItemImpressionsEventThrottlingHundredthsPercent", 10000)

local function sduiCustomImpressionsEvent(eventName: string, eventContext: string, customFields)
    TelemetryService:LogEvent({
        eventName = eventName,
        backends = { "EventIngest", "Points" },
        throttlingPercentage = throttlingPercentage,
        lastUpdated = { 26, 3, 17 },
        description = `SDUI custom impression event: {eventName}`
    }, {
        eventContext = eventContext,
        standardizedFields = { "addSessionInfo", "addSessionId", "addOSInfo" },
        customFields = customFields
    })
end

return sduiCustomImpressionsEvent
