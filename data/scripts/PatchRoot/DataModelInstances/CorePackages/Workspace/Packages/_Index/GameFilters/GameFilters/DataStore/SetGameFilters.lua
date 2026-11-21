-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:20:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameFiltersParent = script:FindFirstAncestor("GameFilters").Parent
local makeActionCreator = require(GameFiltersParent.Rodux).makeActionCreator
local _DiscoveryTypes = require(GameFiltersParent.DiscoveryTypes)

return makeActionCreator(script.Name, function(groupId: string, filters, updatedTimestamp: number)
    return { groupId = groupId, filters = filters, updatedTimestamp = updatedTimestamp }
end)
