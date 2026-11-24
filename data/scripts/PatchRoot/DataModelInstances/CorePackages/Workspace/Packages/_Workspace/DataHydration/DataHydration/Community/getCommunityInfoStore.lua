-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:11:18Z
-- Luau bytecode version: 14 | Luau type version: 3
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local Signals = require(DataHydrationParent.Signals)

local createCommunityInfoStore = require(script.Parent.createCommunityInfoStore)

return Signals.createComputed(createCommunityInfoStore)
