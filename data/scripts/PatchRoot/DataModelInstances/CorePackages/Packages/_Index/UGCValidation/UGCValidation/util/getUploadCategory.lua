-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:31:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ValidationEnums = require(scriptParentParent.validationSystem.ValidationEnums)
local Constants = require(scriptParentParent.Constants)
local ConstantsInterface = require(scriptParentParent.ConstantsInterface)
local getFStringUGCLCAllowedAssetTypeIds = require(scriptParentParent.flags.getFStringUGCLCAllowedAssetTypeIds)
local getFFlagUGCValidationEyebrowEyelashCategory = require(scriptParentParent.flags.getFFlagUGCValidationEyebrowEyelashCategory)
local tbl1 = string.split(getFStringUGCLCAllowedAssetTypeIds(), ",")

local function getUploadCategory(arg1, assetType, bundleType)
    if bundleType ~= nil then
        if bundleType == Enum.BundleType.BodyParts then
            return ValidationEnums.UploadCategory.FULL_BODY
        end

        if bundleType == Enum.BundleType.Animations then
            return ValidationEnums.UploadCategory.ANIMATION_PACK
        end

        return ValidationEnums.UploadCategory.BOTH_SHOES
    end

    assert(assetType)
    local var1 = nil
    if assetType == Enum.AssetType.EmoteAnimation then
        var1 = ValidationEnums.UploadCategory.EMOTE_ANIMATION
    elseif Constants.ASSET_TYPE_INFO[assetType] and Constants.ASSET_TYPE_INFO[assetType].isBodyPart then
        var1 = assetType == Enum.AssetType.DynamicHead and ValidationEnums.UploadCategory.DYNAMIC_HEAD
            or ValidationEnums.UploadCategory.TORSO_AND_LIMBS
    else
        local find = table.find

        if find(tbl1, tostring(assetType.Value)) then
            local bool1 = assetType == Enum.AssetType.EyebrowAccessory or assetType == Enum.AssetType.EyelashAccessory
            if getFFlagUGCValidationEyebrowEyelashCategory() and bool1 then
                var1 = ValidationEnums.UploadCategory.EYEBROW_EYELASH
            else
                var1 = ValidationEnums.UploadCategory.LAYERED_CLOTHING
            end
        elseif Constants.ASSET_TYPE_INFO[assetType] and Constants.ASSET_TYPE_INFO[assetType].rigidAllowed then
            var1 = ValidationEnums.UploadCategory.RIGID_ACCESSORY
        elseif ConstantsInterface.isMakeupAsset(assetType) then
            var1 = ValidationEnums.UploadCategory.MAKEUP
        elseif Constants.ANIMATION_ASSET_INFO and Constants.ANIMATION_ASSET_INFO[assetType] then
            var1 = ValidationEnums.UploadCategory.ANIMATION
        end
    end
    if var1 == nil then
        error(`No assigned validation category for {arg1.Name}, {assetType}, {bundleType} `)
    end

    return var1
end

return getUploadCategory
