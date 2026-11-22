-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:41:00Z
-- Luau bytecode version: 14 | Luau type version: 3
local RobloxSubscriptionPurchaseAppParent = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp").Parent

return {
    SubscriptionPurchaseFlowEvent = {
        eventName = "SubscriptionPurchaseFlow",
        backends = { require(RobloxSubscriptionPurchaseAppParent.LoggingProtocol).TelemetryBackends.EventIngest },
        throttlingPercentage = game:DefineFastInt("SubscriptionPurchaseFlowEventIngestThrottleHundredthsPercent", 0),
        lastUpdated = { 2026, 4, 2 },
        description = "Subscription purchase funnel (upsell, modal, purchase outcomes); correlates via client_session_id_type + client_session_id."
    }
}
