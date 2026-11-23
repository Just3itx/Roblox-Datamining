-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:31:01Z
-- Luau bytecode version: 14 | Luau type version: 3
local VirtualEventsState = script:FindFirstAncestor("VirtualEventsState")

local Players = game:GetService("Players")

local NetworkingVirtualEvents = require(VirtualEventsState.network).NetworkingVirtualEvents
return require(script.Parent["rsvps.impl"])(NetworkingVirtualEvents, Players)
