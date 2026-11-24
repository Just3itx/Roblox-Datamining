-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:10:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local Signals = require(DataHydrationParent.Signals)

local createFriendsRequestsStore = require(script.Parent.createFriendsRequestsStore)

local computed = Signals.createComputed(createFriendsRequestsStore)

return {
    get = function()
        return computed(false)
    end
}
