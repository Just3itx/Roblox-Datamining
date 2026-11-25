-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:10:46Z
-- Luau bytecode version: 14 | Luau type version: 3
local SquadsCoreParent = script:FindFirstAncestor("SquadsCore").Parent
local Signals = require(SquadsCoreParent.Signals)

local createScheduledSquadStore = require(script.createScheduledSquadStore)

return Signals.createComputed(createScheduledSquadStore)
