-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:41:16Z
-- Luau bytecode version: 14 | Luau type version: 3
local AvatarExperienceAnalytics = script:FindFirstAncestor("AvatarExperienceAnalytics")
local AvatarExperienceAnalyticsParent = AvatarExperienceAnalytics.Parent

local LoggingProtocol = require(AvatarExperienceAnalyticsParent.LoggingProtocol)

local FIntBulkPurchaseMissingPurchaseOptionsCounterThrottleHundredthsPercent = require(AvatarExperienceAnalytics.Flags.FIntBulkPurchaseMissingPurchaseOptionsCounterThrottleHundredthsPercent)

return {
    eventName = "BulkPurchaseMissingPurchaseOptionsCounter",
    backends = { LoggingProtocol.TelemetryBackends.Counter },
    lastUpdated = { 2026, 5, 7 },
    throttlingPercentage = FIntBulkPurchaseMissingPurchaseOptionsCounterThrottleHundredthsPercent(),
    description = "Counter fired when bulk purchase server response contains at least one item missing purchaseOptions while FFlagBulkPurchaseUsesPurchaseOptionDiscount is on.",
    links = ""
}
