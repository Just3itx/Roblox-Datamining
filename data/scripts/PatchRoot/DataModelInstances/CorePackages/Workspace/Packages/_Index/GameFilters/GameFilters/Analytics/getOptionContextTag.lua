-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:20:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameFiltersParent = script:FindFirstAncestor("GameFilters").Parent
local _DiscoveryTypes = require(GameFiltersParent.DiscoveryTypes)

return function(arg1, optionId: string?)
    if optionId == nil then
        return nil
    end

    for _, filterOption in arg1.filterOptions do
        if filterOption.optionId == optionId then
            return if filterOption.optionContextTag and filterOption.optionContextTag ~= "" then filterOption.optionContextTag else nil
        end
    end

    return nil
end
