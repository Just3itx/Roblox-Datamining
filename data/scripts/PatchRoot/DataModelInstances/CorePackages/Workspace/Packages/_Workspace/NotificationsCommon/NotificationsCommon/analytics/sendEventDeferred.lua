-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:20:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EventIngestService = game:GetService("EventIngestService")
local scriptParentParentParent = script.Parent.Parent.Parent
local getPlatformTarget = require(scriptParentParentParent.Analytics).getPlatformTarget

return function(eventContext: string, eventName: string, tbl1)
    EventIngestService:SendEventDeferred(getPlatformTarget(), eventContext, eventName, tbl1 or {})
end
