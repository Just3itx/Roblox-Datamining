-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:20:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameFiltersParent = script:FindFirstAncestor("GameFilters").Parent
local _DiscoveryTypes = require(GameFiltersParent.DiscoveryTypes)

local function getSelectedGameFilterOptions(tbl1)
    local selectedGameFilterOptions = {}

    for _, value in tbl1 do
        if value.selectedOptionId ~= value.defaultOptionId then
            selectedGameFilterOptions[value.filterType] = value.selectedOptionId
        end
    end

    return selectedGameFilterOptions
end

return getSelectedGameFilterOptions
