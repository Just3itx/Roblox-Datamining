-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:11:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")
local AvatarExperienceModel = require(AvatarExperienceCommon.Parent.AvatarExperienceModel)

local FFlagAXTryOnBackgroundRespectsSelection = require(AvatarExperienceCommon.Parent.AvatarExperienceFlags).FFlagAXTryOnBackgroundRespectsSelection

local ItemTypeEnum = AvatarExperienceModel.Enums.ItemTypeEnum
local AvatarBackground = require(AvatarExperienceCommon.Constants).ASSET_TYPE_NAME_TO_ID_STRING.AvatarBackground

local function selectTryOnBackgroundId(arg1)
    local var1 = arg1 and (arg1.AvatarExperience or arg1)
    local avatarScene = var1 and var1.AvatarScene
    local tryOnItems = avatarScene and avatarScene.OutfitTryOn and avatarScene.OutfitTryOn.TryOnItems
    if not tryOnItems then
        return nil
    end

    for _, tryOnItem in tryOnItems do
        if tryOnItem.isUnequipped
            or FFlagAXTryOnBackgroundRespectsSelection and tryOnItem.selectedInTryOnManager == false and tryOnItem.lookId ~= nil
            or tryOnItem.itemType ~= ItemTypeEnum.Asset
            or tryOnItem.itemSubType ~= AvatarBackground
        then
            continue
        end

        local var2 = tonumber(tryOnItem.itemId)
        if var2 then
            return var2
        end
    end

    return nil
end

return selectTryOnBackgroundId
