-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:11:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local AvatarExperienceRoduxParent = script:FindFirstAncestor("AvatarExperienceRodux").Parent

local ASSET_TYPE_NAME_TO_ID_STRING = require(AvatarExperienceRoduxParent.AvatarExperienceCommon).Constants.ASSET_TYPE_NAME_TO_ID_STRING

local AssetCategory = { LCTops = "LCTops", LCBottoms = "LCBottoms" }

local AssetCategoryToAssetTypes = {
    [AssetCategory.LCTops] = { ASSET_TYPE_NAME_TO_ID_STRING.ShirtAccessory, ASSET_TYPE_NAME_TO_ID_STRING.TShirtAccessory, ASSET_TYPE_NAME_TO_ID_STRING.SweaterAccessory },
    [AssetCategory.LCBottoms] = { ASSET_TYPE_NAME_TO_ID_STRING.PantsAccessory, ASSET_TYPE_NAME_TO_ID_STRING.ShortsAccessory, ASSET_TYPE_NAME_TO_ID_STRING.DressSkirtAccessory }
}

local AssetTypeToAssetCategory = ({})
for value, value2 in AssetCategoryToAssetTypes do
    for _, value3 in value2 do
        AssetTypeToAssetCategory[value3] = value
    end
end

return {
    AssetCategory = AssetCategory,
    AssetCategoryToAssetTypes = AssetCategoryToAssetTypes,
    AssetTypeToAssetCategory = AssetTypeToAssetCategory
}
