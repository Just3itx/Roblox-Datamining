-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:51:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local enums = require(VirtualEvents.Parent.VirtualEventsState).enums
local sendEventDeferred = require(script.Parent.sendEventDeferred)

return function(tbl1)
    sendEventDeferred(enums.AnalyticsEvent.VirtualEventImpression, tbl1)
end
