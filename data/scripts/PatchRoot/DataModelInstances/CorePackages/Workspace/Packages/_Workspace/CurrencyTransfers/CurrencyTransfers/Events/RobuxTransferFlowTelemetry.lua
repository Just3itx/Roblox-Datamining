-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:31:06Z
-- Luau bytecode version: 14 | Luau type version: 3
local CurrencyTransfersParent = script:FindFirstAncestor("CurrencyTransfers").Parent

return {
    RobuxTransferFlowEvent = {
        eventName = "RobuxTransferFlow",
        backends = { require(CurrencyTransfersParent.LoggingProtocol).TelemetryBackends.EventIngest },
        throttlingPercentage = game:DefineFastInt("RobuxTransferFlowEventIngestThrottleHundredthsPercent", 0),
        lastUpdated = { 2026, 4, 2 },
        description = "Robux transfer funnel; correlate via transfer_request_id and transfer_client_session_id."
    }
}
