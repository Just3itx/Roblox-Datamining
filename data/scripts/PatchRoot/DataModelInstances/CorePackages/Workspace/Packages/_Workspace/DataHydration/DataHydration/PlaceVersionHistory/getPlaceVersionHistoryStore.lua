-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:01:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local Signals = require(DataHydrationParent.Signals)

local createPlaceVersionHistoryStore = require(script.Parent.createPlaceVersionHistoryStore)

return Signals.createComputed(function()
    return createPlaceVersionHistoryStore()
end)
