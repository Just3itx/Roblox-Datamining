-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:21:04Z
-- Luau bytecode version: 14 | Luau type version: 3
local GameCollectionsParent = script:FindFirstAncestor("GameCollections").Parent
local LoggingProtocol = require(GameCollectionsParent.LoggingProtocol)

local FIntFeedItemRowDataCounterThrottle = require(script.Parent.FIntFeedItemRowDataCounterThrottle)

return {
    eventName = "feedItemRowDataHitCounter",
    backends = { LoggingProtocol.TelemetryBackends.Counter },
    throttlingPercentage = FIntFeedItemRowDataCounterThrottle,
    lastUpdated = { 24, 5, 29 },
    description = "Count the number of times feed item row data is accessible when game impression is sent"
}
