-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:50:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local Signals = require(DataHydrationParent.Signals)

local createMomentsTrendingStore = require(script.Parent.createMomentsTrendingStore)

return Signals.createComputed(function(_)
    return createMomentsTrendingStore()
end)
