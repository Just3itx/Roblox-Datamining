-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:40:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")
local DynamicHead = require(AvatarExperienceCommon.Constants).ASSET_TYPE_NAME_TO_ID_STRING.DynamicHead
local bool1 = game:DefineFastFlag("AXDHEquippedAssetsNilCheck", false)

local function selectHasDynamicHead(arg1)
    local equippedAssets = arg1.AvatarExperience.AvatarEditor.Character.EquippedAssets
    if bool1 and not equippedAssets then
        return false
    end
    local equippedAsset = equippedAssets[DynamicHead]
    if equippedAsset then
        for _ in equippedAsset do
            return true
        end
    end

    local tryOnItems = arg1.AvatarExperience.AvatarScene.OutfitTryOn and arg1.AvatarExperience.AvatarScene.OutfitTryOn.TryOnItems
    if tryOnItems then
        for _, tryOnItem in tryOnItems do
            if tryOnItem.assetType == DynamicHead then
                return true
            end
        end
    end
    return false
end

return selectHasDynamicHead
