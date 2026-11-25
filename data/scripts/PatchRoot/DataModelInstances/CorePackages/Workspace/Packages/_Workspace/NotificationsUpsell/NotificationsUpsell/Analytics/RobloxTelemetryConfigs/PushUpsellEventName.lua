-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:31:26Z
-- Luau bytecode version: 14 | Luau type version: 3
local NotificationsUpsellParent = script:FindFirstAncestor("NotificationsUpsell").Parent
local LoggingProtocol = require(NotificationsUpsellParent.LoggingProtocol)
local ModalEventConstants = require(script.Parent.Parent.ModalEventConstants)

game:DefineFastInt("LuaPushUpsellEventThrottleHundrethsPercent", 10000)

return {
    eventName = ModalEventConstants.OptInPushUpsellEventName,
    backends = { LoggingProtocol.TelemetryBackends.EventIngest },
    throttlingPercentage = game:GetFastInt("LuaPushUpsellEventThrottleHundrethsPercent"),
    lastUpdated = { 24, 6, 30 },
    description = "Tracks events related to push notifications upsell modal"
}
