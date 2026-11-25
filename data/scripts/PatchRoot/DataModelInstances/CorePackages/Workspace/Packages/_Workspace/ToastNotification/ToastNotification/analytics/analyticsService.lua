-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:31:15Z
-- Luau bytecode version: 14 | Luau type version: 3
local EventIngestService = game:GetService("EventIngestService")
return {
    EventStream = {
        sendEventDeferred = require(script.Parent.sendEventDeferred)(EventIngestService)
    }
}
