-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:30:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")

local ServerTriggeredModalImpressionsParent = script:FindFirstAncestor("ServerTriggeredModalImpressions").Parent

local LoggingProtocol = require(ServerTriggeredModalImpressionsParent.LoggingProtocol)

local bool1 = game:DefineFastFlag("ModalImpressionEventAddSessionInfo", false)

local config = {
    eventName = "ModalImpression",
    backends = { LoggingProtocol.TelemetryBackends.EventIngest },
    throttlingPercentage = game:DefineFastInt("ModalImpressionThrottleHundrethsPercent", 10000),
    lastUpdated = { 25, 9, 9 },
    description = "Sent when a modal is shown",
    links = ""
}

return function(modalId: string, modalType: string)
    TelemetryService:LogEvent(config, {
        standardizedFields = bool1 and { "addSessionInfo" } or nil,
        customFields = { modalId = modalId, modalType = modalType }
    })
end
