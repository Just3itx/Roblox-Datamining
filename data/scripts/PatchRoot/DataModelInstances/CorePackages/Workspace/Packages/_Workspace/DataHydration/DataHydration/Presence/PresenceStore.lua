-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:01:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local Signals = require(DataHydrationParent.Signals)

local createPresenceStore = require(script.Parent.createPresenceStore)

local computed = Signals.createComputed(createPresenceStore)

return {
    get = function()
        return computed(false)
    end
}
