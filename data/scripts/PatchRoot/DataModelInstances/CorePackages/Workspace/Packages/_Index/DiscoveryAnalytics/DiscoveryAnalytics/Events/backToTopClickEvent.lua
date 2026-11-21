-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:30:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")

local config = {
    eventName = "backToTopClick",
    backends = { "EventIngest", "Points" },
    throttlingPercentage = game:DefineFastInt("LuaAppBackToTopClickEventThrottlingHundredthsPercent", 10000),
    lastUpdated = { 26, 7, 22 },
    description = "User clicked the back to top button at the end of a scrollable surface"
}

return function(eventContext: string?)
    TelemetryService:LogEvent(
        config,
        {
            eventContext = eventContext,
            standardizedFields = { "addSessionInfo", "addSessionId", "addOSInfo" }
        }
    )
end
