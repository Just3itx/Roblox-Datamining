-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
local SquadsCoreParent = script:FindFirstAncestor("SquadsCore").Parent

local RoduxNetworking = require(script.Parent.RoduxNetworking)

return require(SquadsCoreParent.NetworkingSquads).config({ roduxNetworking = RoduxNetworking })
