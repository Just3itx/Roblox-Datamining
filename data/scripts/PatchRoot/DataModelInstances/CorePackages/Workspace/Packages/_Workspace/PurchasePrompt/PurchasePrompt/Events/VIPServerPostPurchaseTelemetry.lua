-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:01:09Z
-- Luau bytecode version: 14 | Luau type version: 3
local PurchasePromptParent = script:FindFirstAncestor("PurchasePrompt").Parent
local LoggingProtocol = require(PurchasePromptParent.LoggingProtocol)

local throttlingPercentage = game:DefineFastInt("VIPServerPostPurchaseTelemetryThrottleHundredthsPercent", 10000)

return {
    PrivateServerConfigEvent = {
        eventName = "privateServerConfig",
        backends = { LoggingProtocol.TelemetryBackends.EventIngest },
        lastUpdated = { 2026, 11, 6 },
        throttlingPercentage = throttlingPercentage,
        description = "Impressions and clicks on the in-experience private server setup and join screens."
    },
    VIPServerTeleportFailedCounter = {
        eventName = "VIPServerPostPurchaseTeleportFailedCounter",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        lastUpdated = { 2026, 11, 6 },
        throttlingPercentage = throttlingPercentage,
        description = "Counter fired when teleporting the buyer into their new private server fails."
    }
}
