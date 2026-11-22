-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:40:59Z
-- Luau bytecode version: 14 | Luau type version: 3
local RobloxSubscriptionPurchaseAppParent = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp").Parent
local LoggingProtocol = require(RobloxSubscriptionPurchaseAppParent.LoggingProtocol)

local throttlingPercentage = game:DefineFastInt("RobloxSubscriptionUpsellTelemetryEventIngestThrottleHundredthsPercent", 0)

return {
    RobloxSubscriptionUpsellModalInitiatedCounter = {
        eventName = "RobloxSubscriptionUpsellModalInitiatedCounter",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        lastUpdated = { 2026, 3, 3 },
        throttlingPercentage = throttlingPercentage,
        description = "Counter fired when Roblox Subscription Upsell Modal is initiated."
    },
    RobloxSubscriptionUpsellModalShownCounter = {
        eventName = "RobloxSubscriptionUpsellModalShownCounter",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        lastUpdated = { 2026, 3, 3 },
        throttlingPercentage = throttlingPercentage,
        description = "Counter fired when Roblox Subscription Upsell Modal is shown."
    },
    RobloxSubscriptionUpsellModalBuyButtonClickedCounter = {
        eventName = "RobloxSubscriptionUpsellModalBuyButtonClickedCounter",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        lastUpdated = { 2026, 3, 3 },
        throttlingPercentage = throttlingPercentage,
        description = "Counter fired when Roblox Subscription Upsell Modal buy button is clicked."
    },
    RobloxSubscriptionUpsellFlowCompletedCounter = {
        eventName = "RobloxSubscriptionUpsellFlowCompletedCounter",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        lastUpdated = { 2026, 3, 3 },
        throttlingPercentage = throttlingPercentage,
        description = "Counter fired when purchase was succesful."
    },
    RobloxSubscriptionUpsellNativePurchaseCompletedCounter = {
        eventName = "RobloxSubscriptionUpsellNativePurchaseCompletedCounter",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        lastUpdated = { 2026, 3, 3 },
        throttlingPercentage = throttlingPercentage,
        description = "Counter fired when purchase was succesful."
    },
    RobloxSubscriptionUpsellDismissedCounter = {
        eventName = "RobloxSubscriptionUpsellDismissedCounter",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        lastUpdated = { 2026, 3, 3 },
        throttlingPercentage = throttlingPercentage,
        description = "Counter fired when modal is dismissed."
    },
    RobloxSubscriptionUpsellPurchaseFailedCounter = {
        eventName = "RobloxSubscriptionUpsellPurchaseFailedCounter",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        lastUpdated = { 2026, 3, 3 },
        throttlingPercentage = throttlingPercentage,
        description = "Counter fired when purchase failed."
    },
    RobloxSubscriptionUpsellPurchaseSucceededCounter = {
        eventName = "RobloxSubscriptionUpsellPurchaseSucceededCounter",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        lastUpdated = { 2026, 3, 9 },
        throttlingPercentage = throttlingPercentage,
        description = "Counter fired when purchase succeeded."
    },
    RobloxSubscriptionUpsellNativePurchasePollingTimeoutCounter = {
        eventName = "RobloxSubscriptionUpsellNativePurchasePollingTimeoutCounter",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        lastUpdated = { 2026, 3, 9 },
        throttlingPercentage = throttlingPercentage,
        description = "Counter fired when native purchase polling timeout occurs after native purchase attempt."
    },
    RobloxSubscriptionPurchaseAttemptedCounter = {
        eventName = "RobloxSubscriptionPurchaseAttemptedCounter",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        lastUpdated = { 2026, 3, 9 },
        throttlingPercentage = throttlingPercentage,
        description = "Counter fired when purchase attempt is made."
    },
    RobloxSubscriptionPurchaseErrorShownCounter = {
        eventName = "RobloxSubscriptionPurchaseErrorShownCounter",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        lastUpdated = { 2026, 3, 24 },
        throttlingPercentage = throttlingPercentage,
        description = "Counter fired when purchase error is shown."
    },
    RobloxSubscriptionCreatePaymentSessionFailedCounter = {
        eventName = "RobloxSubscriptionCreatePaymentSessionFailedCounter",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        lastUpdated = { 2026, 3, 25 },
        throttlingPercentage = throttlingPercentage,
        description = "Counter fired when create payment session fails."
    },
    RobloxSubscriptionCreatePaymentSessionFailedEvent = {
        eventName = "RobloxSubscriptionCreatePaymentSessionFailed",
        backends = { LoggingProtocol.TelemetryBackends.Points },
        lastUpdated = { 2026, 5, 1 },
        throttlingPercentage = throttlingPercentage,
        description = "Point event logged when create payment session fails, includes error details for Kibana."
    }
}
