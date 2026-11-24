-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local Signals = require(DataHydrationParent.Signals)

local createMomentsReactionsStore = require(script.Parent.createMomentsReactionsStore)

return Signals.createComputed(function(_)
    return createMomentsReactionsStore()
end)
