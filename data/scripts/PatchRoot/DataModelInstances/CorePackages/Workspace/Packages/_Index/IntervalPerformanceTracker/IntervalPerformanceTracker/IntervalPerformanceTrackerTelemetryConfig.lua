-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:31:00Z
-- Luau bytecode version: 14 | Luau type version: 3
local IntervalPerformanceTrackerParent = script:FindFirstAncestor("IntervalPerformanceTracker").Parent
local LoggingProtocol = require(IntervalPerformanceTrackerParent.LoggingProtocol)

game:DefineFastInt("IntervalPerformanceTrackerEventThrottleHundrethsPercent", 10000)

return {
    eventName = "luaIntervalPerformanceTrackerTelemetry",
    backends = { LoggingProtocol.TelemetryBackends.Points },
    throttlingPercentage = game:GetFastInt("IntervalPerformanceTrackerEventThrottleHundrethsPercent"),
    lastUpdated = { 24, 1, 10 },
    description = "Report lua performance tracking metrics to Grafana.",
    links = "https://roblox.atlassian.net/wiki/spaces/USER/pages/2379481365/Parallelize+work+through+the+new+multi-threading+API"
}
