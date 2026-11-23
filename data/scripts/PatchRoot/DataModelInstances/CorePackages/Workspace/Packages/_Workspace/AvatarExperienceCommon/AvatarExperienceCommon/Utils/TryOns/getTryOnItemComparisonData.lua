-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T14:01:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")
local ItemTypeEnum = require(AvatarExperienceCommon.Parent.AvatarExperienceModel).Enums.ItemTypeEnum

local _TryOnItemComparisonData = require(AvatarExperienceCommon.Types.TryOnItemComparisonData)

local tbl1 = {}
local ShirtAccessoryValue = Enum.AssetType.ShirtAccessory.Value
tbl1[tostring(ShirtAccessoryValue)] = "LCTops"
local TShirtAccessoryValue = Enum.AssetType.TShirtAccessory.Value
tbl1[tostring(TShirtAccessoryValue)] = "LCTops"
local SweaterAccessoryValue = Enum.AssetType.SweaterAccessory.Value
tbl1[tostring(SweaterAccessoryValue)] = "LCTops"
local PantsAccessoryValue = Enum.AssetType.PantsAccessory.Value
tbl1[tostring(PantsAccessoryValue)] = "LCBottoms"
local ShortsAccessoryValue = Enum.AssetType.ShortsAccessory.Value
tbl1[tostring(ShortsAccessoryValue)] = "LCBottoms"
local DressSkirtAccessoryValue = Enum.AssetType.DressSkirtAccessory.Value
tbl1[tostring(DressSkirtAccessoryValue)] = "LCBottoms"

function getTryOnItemComparisonData(tbl2)
    local assetTypes = ({})
    local layeredClothingCategories = ({})
    local bool1 = false
    local bool2 = false

    local function addAssetTypeAndLayeredClothingCategory(str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
        assetTypes[str1] = true
        local var1 = tbl1[str1]
        if var1 then
            layeredClothingCategories[var1] = true
        end
    end

    if tbl2.itemType == ItemTypeEnum.Asset then
        addAssetTypeAndLayeredClothingCategory(tbl2.itemSubType)

        if tbl2.itemSubType == tostring(Enum.AssetType.Head.Value) or tbl2.itemSubType == tostring(Enum.AssetType.Face.Value) then
            bool1 = true
        end
    elseif tbl2.itemType == ItemTypeEnum.Bundle and tbl2.bundleInfo then
        if tbl2.itemSubType == tostring(Enum.BundleType.DynamicHead.Value) then
            bool2 = true
        end

        for _, value in tbl2.bundleInfo do
            addAssetTypeAndLayeredClothingCategory(value.assetType)
        end
    end

    return {
        assetTypes = assetTypes,
        layeredClothingCategories = layeredClothingCategories,
        isClassicHeadOrFace = bool1,
        isDynamicHead = bool2,
        itemType = tbl2.itemType,
        itemSubType = tbl2.itemSubType
    }
end

return getTryOnItemComparisonData
