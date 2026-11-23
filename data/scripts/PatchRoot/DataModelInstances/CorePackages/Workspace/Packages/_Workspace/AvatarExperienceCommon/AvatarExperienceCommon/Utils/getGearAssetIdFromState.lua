-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:51:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")

local ASSET_TYPE_NAME_TO_ID_STRING = require(AvatarExperienceCommon.Constants).ASSET_TYPE_NAME_TO_ID_STRING
local getEquippedAssetIdsForType = require(script.Parent.getEquippedAssetIdsForType)

return function(arg1): number
    local equippedAssets = arg1.AvatarEditor.Character.EquippedAssets
    if equippedAssets == nil then
        return 0
    end

    local equippedAssetIdsForType = getEquippedAssetIdsForType(equippedAssets, ASSET_TYPE_NAME_TO_ID_STRING.Gear)
    local _, var1 = next(equippedAssetIdsForType)
    return if var1 then tonumber(var1) or 0 else 0
end
