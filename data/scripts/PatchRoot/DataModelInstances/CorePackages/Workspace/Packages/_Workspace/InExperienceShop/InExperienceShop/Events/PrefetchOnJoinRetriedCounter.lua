-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:20:52Z
-- Luau bytecode version: 14 | Luau type version: 3
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local LoggingProtocol = require(InExperienceShopParent.LoggingProtocol)

local FIntInExperienceShopTelemetryThrottleHundredthsPercent = require(InExperienceShop.Flags.FIntInExperienceShopTelemetryThrottleHundredthsPercent)

return {
    eventName = "InExperienceShop_PrefetchOnJoin_Retried",
    backends = { LoggingProtocol.TelemetryBackends.Counter },
    lastUpdated = { 2026, 5, 17 },
    throttlingPercentage = FIntInExperienceShopTelemetryThrottleHundredthsPercent,
    description = "Counter fired each time the join-time prefetch schedules a retry after a transient fetch error under `FFlagHideShopMenuOnFailure`. One increment per scheduled retry, logged at the decision site (so users who leave during backoff still count). Ratio against `_Fired_PrimaryPath`/`_Fired_FallbackPath` approximates retries per prefetch lifecycle.",
    links = ""
}
