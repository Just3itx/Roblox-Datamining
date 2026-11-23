-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:40:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuy = script:FindFirstAncestor("AvatarExperienceInspectAndBuy")
local AvatarExperienceInspectAndBuyParent = AvatarExperienceInspectAndBuy.Parent
local _Types = require(AvatarExperienceInspectAndBuy.Types)

local AXCommon = require(AvatarExperienceInspectAndBuyParent.AXCommon)
local AvatarExperienceModel = require(AvatarExperienceInspectAndBuyParent.AvatarExperienceModel)
local Constants = AXCommon.Constants
local ASSET_TYPE_TO_ACCESSORY_TYPE = Constants.ASSET_TYPE_TO_ACCESSORY_TYPE
local ASSET_TYPE_ID_STRING_TO_HUMANOID_DESCRIPTION_PROP = Constants.ASSET_TYPE_ID_STRING_TO_HUMANOID_DESCRIPTION_PROP
local LAYERED_ASSET_TYPES = Constants.LAYERED_ASSET_TYPES
local AVATAR_ANIMATIONS_BUNDLE_TYPE_ID = Constants.AVATAR_ANIMATIONS_BUNDLE_TYPE_ID
local SHOES_BUNDLE_TYPE_ID = Constants.SHOES_BUNDLE_TYPE_ID
local AvatarBackground = Constants.ASSET_TYPE_NAME_TO_ID_STRING.AvatarBackground
local ItemTypeEnum = AvatarExperienceModel.Enums.ItemTypeEnum

local AvatarExperienceFlags = require(AvatarExperienceInspectAndBuyParent.AvatarExperienceFlags)

local function isItemAvailableForTryOn(arg1, arg2)
    local itemSubType = arg2.itemSubType
    local var1 = arg1 and arg1.Humanoid and arg1.Humanoid.RigType == Enum.HumanoidRigType.R6

    if arg2.itemType == ItemTypeEnum.Bundle and itemSubType == AVATAR_ANIMATIONS_BUNDLE_TYPE_ID then
        return false
    end

    if arg2.itemType == ItemTypeEnum.Bundle and itemSubType == SHOES_BUNDLE_TYPE_ID and var1 then
        return false
    end

    if arg2.itemType ~= ItemTypeEnum.Asset then
        return true
    end

    if not itemSubType then
        return false
    end

    if itemSubType == AvatarBackground then
        return AvatarExperienceFlags.FFlagAXBackgroundsTryOn
    end

    local bool1 = ASSET_TYPE_TO_ACCESSORY_TYPE[itemSubType] ~= nil
        or ASSET_TYPE_ID_STRING_TO_HUMANOID_DESCRIPTION_PROP[itemSubType] ~= nil

    local var2 = var1 and LAYERED_ASSET_TYPES[itemSubType] ~= nil

    return bool1 and not var2
end

return isItemAvailableForTryOn
