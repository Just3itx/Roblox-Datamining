-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:10:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local Signals = require(DataHydrationParent.Signals)

local createProfileCTAStore = require(script.Parent.createProfileCTAStore)

local computed = if require(DataHydrationParent.SharedFlags).FFlagJoinabilityCTARefactor then Signals.createComputed(function()
    return createProfileCTAStore()
end) else Signals.createComputed(createProfileCTAStore)

return {
    get = function()
        return computed(false)
    end
}
