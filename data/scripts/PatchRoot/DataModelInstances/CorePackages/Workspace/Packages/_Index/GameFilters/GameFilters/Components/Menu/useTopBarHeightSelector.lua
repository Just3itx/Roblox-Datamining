-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:20:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameFiltersParent = script:FindFirstAncestor("GameFilters").Parent

local useSelector = require(GameFiltersParent.RoactUtils).Hooks.RoactRodux.useSelector

local function useTopBarHeightSelector()
    return useSelector(function(arg1)
        return arg1.TopBar.topBarHeight
    end)
end

return useTopBarHeightSelector
