-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:30:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSave = script:FindFirstAncestor("AvatarExperienceSave")
local AvatarExperienceSaveParent = AvatarExperienceSave.Parent

local _AvatarSaveContext = require(AvatarExperienceSave.Context.AvatarSaveContext)
local FFlagAXBackgroundsPersistence = require(AvatarExperienceSaveParent.AvatarExperienceFlags).FFlagAXBackgroundsPersistence

local function selectCharacterData(arg1)
    return {
        tryOn = {
            TryOn = arg1.AvatarExperience.AvatarScene.TryOn,
            OutfitTryOn = arg1.AvatarExperience.AvatarScene.OutfitTryOn,
            LastSavedTriedOnOutfit = arg1.AvatarExperience.AvatarScene.LastSavedTriedOnOutfit
        },
        equipped = {
            AvatarType = arg1.AvatarExperience.AvatarEditor.Character.AvatarType,
            AvatarScales = arg1.AvatarExperience.AvatarEditor.Character.AvatarScales,
            BodyColor3s = arg1.AvatarExperience.AvatarEditor.Character.BodyColor3s,
            BodyPartRangeIds = arg1.AvatarExperience.AvatarEditor.Character.BodyPartRangeIds,
            EquippedAssets = arg1.AvatarExperience.AvatarEditor.Character.EquippedAssets,
            EquippedEmotes = arg1.AvatarExperience.AvatarEditor.EquippedEmotes,
            BackgroundAssetId = if FFlagAXBackgroundsPersistence then arg1.AvatarExperience.AvatarScene.ProfileConfiguration.BackgroundAssetId else nil
        }
    }
end

return selectCharacterData
