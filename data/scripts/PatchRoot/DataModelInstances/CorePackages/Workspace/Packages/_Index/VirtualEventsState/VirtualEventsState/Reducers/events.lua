-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:30:53Z
-- Luau bytecode version: 14 | Luau type version: 3
local VirtualEventsState = script:FindFirstAncestor("VirtualEventsState")

local NetworkingVirtualEvents = require(VirtualEventsState.network).NetworkingVirtualEvents
return require(script.Parent["events.impl"])(NetworkingVirtualEvents)
