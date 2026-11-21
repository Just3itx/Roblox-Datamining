-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:21:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent
local Constants = require(AvatarExperienceCatalogParent.AvatarExperienceCommon).Constants

function getTryOnItemsContainsOnlyMakeupTypes(tbl1)
    if #tbl1 == 0 then
        return false
    end

    for _, value in tbl1 do
        if not Constants.MAKEUP_LOOK_ASSET_TYPES[value.itemSubType] then
            return false
        end
    end
    return true
end

return getTryOnItemsContainsOnlyMakeupTypes
