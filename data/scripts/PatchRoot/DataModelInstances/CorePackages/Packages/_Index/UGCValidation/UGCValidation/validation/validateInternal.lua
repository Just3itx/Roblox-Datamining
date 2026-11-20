-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:41:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local _Types = require(scriptParentParent.util.Types)
local Constants = require(scriptParentParent.Constants)
local ConstantsInterface = require(scriptParentParent.ConstantsInterface)

local isMeshPartAccessory = require(scriptParentParent.util.isMeshPartAccessory)
local isLayeredClothing = require(scriptParentParent.util.isLayeredClothing)

local validateLayeredClothingAccessory = require(scriptParentParent.validation.validateLayeredClothingAccessory)
local validateLegacyAccessory = require(scriptParentParent.validation.validateLegacyAccessory)
local validateMeshPartAccessory = require(scriptParentParent.validation.validateMeshPartAccessory)
local validateMakeupAsset = require(scriptParentParent.validation.validateMakeupAsset)
local validateLimbsAndTorso = require(scriptParentParent.validation.validateLimbsAndTorso)
local validateDynamicHeadMeshPartFormat = require(scriptParentParent.validation.validateDynamicHeadMeshPartFormat)
local validatePackage = require(scriptParentParent.validation.validatePackage)
local ValidateEmoteAnimation = require(scriptParentParent.validation.ValidateEmoteAnimation)

local function validateBodyPartInternal(arg1)
    local assetTypeEnum = arg1.assetTypeEnum
    assert(assetTypeEnum ~= nil, "assetTypeEnum is required in validateBodyPartInternal")
    assert(ConstantsInterface.isBodyPart(assetTypeEnum))

    if Enum.AssetType.DynamicHead == assetTypeEnum then
        return validateDynamicHeadMeshPartFormat(arg1)
    end
    return validateLimbsAndTorso(arg1)
end

local function validateInternal(arg1)
    assert(arg1.instances ~= nil, "instances required in validationContext for validateInternal")
    assert(arg1.assetTypeEnum ~= nil, "assetTypeEnum required in validationContext for validateInternal")
    local instances = arg1.instances
    local assetTypeEnum = arg1.assetTypeEnum
    local validateMeshPartAccessories = arg1.validateMeshPartAccessories

    if Constants.ANIMATION_ASSET_INFO and Constants.ANIMATION_ASSET_INFO[assetTypeEnum] then
        return true
    elseif assetTypeEnum == Enum.AssetType.EmoteAnimation then
        return ValidateEmoteAnimation.validate(arg1)
    elseif ConstantsInterface.isMakeupAsset(assetTypeEnum) then
        return validateMakeupAsset(arg1)
    elseif ConstantsInterface.isBodyPart(assetTypeEnum) then
        return validateBodyPartInternal(arg1)
    elseif assetTypeEnum == Enum.AssetType.Model then
        return validatePackage(arg1)
    elseif validateMeshPartAccessories then
        local var1 = instances[1]
        if isMeshPartAccessory(var1) then
            if isLayeredClothing(var1) then
                return validateLayeredClothingAccessory(arg1)
            end
            return validateMeshPartAccessory(arg1)
        end

        return validateLegacyAccessory(arg1)
    elseif isLayeredClothing(instances[1]) then
        return validateLayeredClothingAccessory(arg1)
    else
        return validateLegacyAccessory(arg1)
    end
end

return validateInternal
