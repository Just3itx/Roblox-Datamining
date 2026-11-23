-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:01:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Signals = require(BuildExperienceParent.Signals)

local createMyCreationsFilterStore = require(BuildExperience.Stores.GetMyCreationsFilterStore.createMyCreationsFilterStore)
local GamesFilter = require(BuildExperience.Stores.GetMyCreationsFilterStore.GamesFilter)

return Signals.createComputed(function()
    local myCreationsFilterStore = createMyCreationsFilterStore()
    myCreationsFilterStore.setFilter({ games = GamesFilter.SharedGames })
    return myCreationsFilterStore
end)
