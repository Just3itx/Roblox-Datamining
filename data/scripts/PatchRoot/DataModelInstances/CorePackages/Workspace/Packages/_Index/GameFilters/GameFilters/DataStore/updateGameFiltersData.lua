-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:21:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameFilters = script:FindFirstAncestor("GameFilters")

local GameFiltersParent = GameFilters.Parent
local _DiscoveryTypes = require(GameFiltersParent.DiscoveryTypes)

local GameFilterModel = require(GameFilters.DataStore.GameFilterModel)
local SetGameFilters = require(GameFilters.DataStore.SetGameFilters)

return function(arg1, arg2, arg3)
    if not arg3 or #arg3 == 0 then
        warn("Found no filters in this sort")
    end

    local tbl1 = {}
    for _, value in arg3 do
        table.insert(tbl1, (GameFilterModel.fromExploreJsonData(value)))
    end

    local now = tick()

    arg1:dispatch(SetGameFilters(arg2, tbl1, now))
end
