-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:50:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")

local ServerTriggeredModalsParent = script:FindFirstAncestor("ServerTriggeredModals").Parent

local config = {
    eventName = "PromptModalSkipped",
    backends = { require(ServerTriggeredModalsParent.LoggingProtocol).TelemetryBackends.EventIngest },
    throttlingPercentage = game:DefineFastInt("PromptModalSkippedThrottleHundredthsPercent", 10000),
    lastUpdated = { 26, 11, 11 },
    description = "Sent when a served prompt modal is not shown",
    links = ""
}

return function(customFields)
    TelemetryService:LogEvent(config, { standardizedFields = { "addSessionInfo" }, customFields = customFields })
end
