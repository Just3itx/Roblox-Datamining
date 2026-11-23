-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T14:00:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")

local ASSET_TYPE_NAME_TO_ID_STRING = require(AvatarExperienceCommon.Constants).ASSET_TYPE_NAME_TO_ID_STRING
local isMakeupAssetType = require(AvatarExperienceCommon.Utils.isMakeupAssetType)

local _CategoryTypes = require(AvatarExperienceCommon.Types.CategoryTypes.CategoryTypes)
local OutfitTypes = require(AvatarExperienceCommon.Enums.OutfitTypes)

local function isValidAssetTypeForOutfitType(str1: string, arg1)
    return not arg1
        or (if arg1 == OutfitTypes.Makeup then isMakeupAssetType(str1)
            or str1 == ASSET_TYPE_NAME_TO_ID_STRING.EyebrowAccessory
            or str1 == ASSET_TYPE_NAME_TO_ID_STRING.EyelashAccessory else arg1 == OutfitTypes.Avatar or arg1 == OutfitTypes.EditableAvatar or true)
end

return isValidAssetTypeForOutfitType
