-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:21:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent
local AvatarExperienceCommon = require(AvatarExperienceCatalogParent.AvatarExperienceCommon)
local FFlagParseHeadShapeFromAPIResponse = require(AvatarExperienceCatalogParent.AvatarExperienceFlags).FFlagParseHeadShapeFromAPIResponse

local Constants = AvatarExperienceCommon.Constants

local function getEquippableAssetsFromTryOnItems(tbl1)
    table.sort(tbl1, function(arg1, arg2): boolean
        return tonumber(arg1.itemRecency) < tonumber(arg2.itemRecency)
    end)

    local equippableAssetsFromTryOnItems = {}
    for _, value in tbl1 do
        if value.itemId == Constants.AVATAR_BLOCKY_DEFAULT_BUNDLE_ID then
            continue
        end

        if value.itemType == Enum.AvatarItemType.Asset.Name then
            table.insert(
                equippableAssetsFromTryOnItems,
                {
                    assetId = value.itemId,
                    assetTypeId = value.itemSubType,
                    order = value.order
                }
            )
        elseif value.itemType == Enum.AvatarItemType.Bundle.Name then
            for assetId, value3 in value.bundleInfo do
                table.insert(equippableAssetsFromTryOnItems, {
                    assetId = assetId,
                    assetTypeId = value3.assetType,
                    headShape = if FFlagParseHeadShapeFromAPIResponse and value3 then value3.headShape else nil
                })
            end
        end
    end
    return equippableAssetsFromTryOnItems
end

return getEquippableAssetsFromTryOnItems
