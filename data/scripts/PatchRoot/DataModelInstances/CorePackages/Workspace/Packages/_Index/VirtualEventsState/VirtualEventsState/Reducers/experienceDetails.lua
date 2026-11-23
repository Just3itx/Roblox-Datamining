-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:30:55Z
-- Luau bytecode version: 14 | Luau type version: 3
local VirtualEventsState = script:FindFirstAncestor("VirtualEventsState")

local NetworkingGames = require(VirtualEventsState.network).NetworkingGames
return require(script.Parent["experienceDetails.impl"])(NetworkingGames)
