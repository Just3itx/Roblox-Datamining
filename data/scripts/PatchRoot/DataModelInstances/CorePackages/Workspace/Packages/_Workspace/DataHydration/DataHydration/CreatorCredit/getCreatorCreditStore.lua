-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:40:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local Signals = require(DataHydrationParent.Signals)

local createCreatorCreditStore = require(script.Parent.createCreatorCreditStore)
local _types = require(script.Parent.types)

return Signals.createComputed(function() -- name: createDefaultStore
    return createCreatorCreditStore()
end)
