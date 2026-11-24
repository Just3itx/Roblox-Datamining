-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:20:40Z
-- Luau bytecode version: 14 | Luau type version: 3
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local Signals = require(DataHydrationParent.Signals)

local createSongInfoStore = require(script.Parent.createSongInfoStore)

return Signals.createComputed(createSongInfoStore)
