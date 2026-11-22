-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T20:01:27Z
-- Luau bytecode version: 14 | Luau type version: 3
local SocialStopwatchParent = script:FindFirstAncestor("SocialStopwatch").Parent
local default = require(SocialStopwatchParent.LoggingProtocol).default

local throttlingPercentage = game:DefineFastInt("SocialStopwatchTelementyThrottleHundrethsPercent", 10000)

return {
    eventName = "SocialStopwatchTelementy",
    backends = { default.TelemetryBackends.Points },
    throttlingPercentage = throttlingPercentage,
    lastUpdated = { 24, 5, 6 },
    description = "Report errors with using the Social Time Stopwatch Library.",
    links = ""
}
