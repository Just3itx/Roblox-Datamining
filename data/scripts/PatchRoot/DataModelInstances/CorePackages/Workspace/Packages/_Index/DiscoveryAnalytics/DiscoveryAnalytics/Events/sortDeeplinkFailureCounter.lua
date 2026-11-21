-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
local DiscoveryAnalyticsParent = script:FindFirstAncestor("DiscoveryAnalytics").Parent
local LoggingProtocol = require(DiscoveryAnalyticsParent.LoggingProtocol)

game:DefineFastInt("SortDeeplinkFailureEventThrottleHundrethsPercent", 10000)

return {
    eventName = "SortDeeplinkFailedCounter",
    backends = { LoggingProtocol.TelemetryBackends.Counter },
    throttlingPercentage = game:GetFastInt("SortDeeplinkFailureEventThrottleHundrethsPercent"),
    lastUpdated = { 24, 10, 18 },
    description = "Tracks failures to resolve sort deeplinks"
}
