-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T14:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")

local AvatarExperienceCommonParent = AvatarExperienceCommon.Parent
local AvatarExperienceModel = require(AvatarExperienceCommonParent.AvatarExperienceModel)
local AvatarExperienceFlags = require(AvatarExperienceCommonParent.AvatarExperienceFlags)

local _TryOnItemComparisonData = require(AvatarExperienceCommon.Types.TryOnItemComparisonData)
local Constants = require(AvatarExperienceCommon.Constants)
local ItemTypeEnum = AvatarExperienceModel.Enums.ItemTypeEnum

local FFlagAXCatalogMakeupSupport = AvatarExperienceFlags.FFlagAXCatalogMakeupSupport

function shouldReplaceTryOn(arg1, arg2)
    if arg1.isDynamicHead and arg2.isClassicHeadOrFace then
        return true
    end

    if arg1.isClassicHeadOrFace and arg2.isDynamicHead then
        return true
    end

    if arg1.itemType == ItemTypeEnum.Asset and arg2.itemType == ItemTypeEnum.Asset then
        if arg1.itemSubType == arg2.itemSubType
            and not (FFlagAXCatalogMakeupSupport and Constants.ASSET_TYPE_ID_STRING_TO_MAKEUP_TYPE[arg2.itemSubType])
        then
            return true
        end

        for value, _ in arg2.layeredClothingCategories do
            if arg1.layeredClothingCategories[value] then
                return true
            end
        end
    end

    if arg1.itemType == ItemTypeEnum.Bundle then
        if arg2.itemType == ItemTypeEnum.Bundle and arg1.itemSubType == arg2.itemSubType then
            return true
        end

        local bool1 = arg2.itemType == ItemTypeEnum.Bundle and arg2.itemSubType == tostring(Enum.BundleType.BodyParts.Value)

        for value, _ in arg1.assetTypes do
            if arg2.assetTypes[value] and not bool1 then
                return true
            end
        end

        for value, _ in arg1.layeredClothingCategories do
            if arg2.layeredClothingCategories[value] and not bool1 then
                return true
            end
        end
    end

    return false
end

return shouldReplaceTryOn
