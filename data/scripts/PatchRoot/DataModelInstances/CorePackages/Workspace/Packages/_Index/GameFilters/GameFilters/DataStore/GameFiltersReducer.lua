-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:20:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameFilters = script:FindFirstAncestor("GameFilters")

local SetGameFilters = require(GameFilters.DataStore.SetGameFilters)

local GameFiltersParent = GameFilters.Parent
local Cryo = require(GameFiltersParent.Cryo)
local _DiscoveryTypes = require(GameFiltersParent.DiscoveryTypes)

return {
    key = "GameFiltersKey",
    reducer = function(arg1, arg2)
        local var1 = arg1 or {}

        if arg2.type == SetGameFilters.name then
            var1 = Cryo.Dictionary.join(var1, { [arg2.groupId] = { allFilters = arg2.filters, updatedTimestamp = arg2.updatedTimestamp } })
        end

        return var1
    end
}
