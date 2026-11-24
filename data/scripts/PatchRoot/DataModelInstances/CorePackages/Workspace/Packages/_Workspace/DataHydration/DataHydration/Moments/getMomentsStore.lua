-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:50:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local Signals = require(DataHydrationParent.Signals)

local createMomentsStore = require(script.Parent.createMomentsStore)

return Signals.createComputed(function(_)
    return createMomentsStore()
end)
