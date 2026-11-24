-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:11:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local Signals = require(DataHydrationParent.Signals)

local createProfileInsightsStore = require(script.Parent.createProfileInsightsStore)

local computed = Signals.createComputed(function()
    return createProfileInsightsStore()
end)

return {
    get = function()
        return computed(false)
    end
}
