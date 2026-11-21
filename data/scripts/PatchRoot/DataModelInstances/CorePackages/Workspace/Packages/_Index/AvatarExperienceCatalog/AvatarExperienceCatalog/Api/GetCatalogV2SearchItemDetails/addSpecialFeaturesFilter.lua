-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")

local _CatalogV2SearchItemDetails = require(AvatarExperienceCatalog.Models.CatalogV2SearchItemDetails)

local function addSpecialFeaturesFilter(arg1, requiredPropertyFilters)
    if requiredPropertyFilters == nil or #requiredPropertyFilters == 0 then
        return arg1
    end

    local var1 = table.clone(arg1)
    var1.requiredPropertyFilters = requiredPropertyFilters
    return var1
end

return addSpecialFeaturesFilter
