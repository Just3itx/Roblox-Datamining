-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:21:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameFilters = script:FindFirstAncestor("GameFilters")

local GameFiltersParent = GameFilters.Parent
local _DiscoveryTypes = require(GameFiltersParent.DiscoveryTypes)
local useSelector = require(GameFiltersParent.RoactUtils).Hooks.RoactRodux.useSelector

local GameFiltersReducer = require(GameFilters.DataStore.GameFiltersReducer)

local function useGameFiltersSelector(str1: string)
    return (useSelector(function(arg1)
        return arg1.Personalization[GameFiltersReducer.key][str1]
    end))
end
return useGameFiltersSelector
