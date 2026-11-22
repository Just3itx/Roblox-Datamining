-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:21:09Z
-- Luau bytecode version: 14 | Luau type version: 3
local EventIngestService = game:GetService("EventIngestService")
local StreamNotifications = script:FindFirstAncestor("StreamNotifications")
return {
    EventStream = {
        sendEventDeferred = require(StreamNotifications.analytics.sendEventDeferred)(EventIngestService)
    }
}
