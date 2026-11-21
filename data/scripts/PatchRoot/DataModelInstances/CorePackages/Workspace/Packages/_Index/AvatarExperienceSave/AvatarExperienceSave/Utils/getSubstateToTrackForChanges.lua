-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSave = script:FindFirstAncestor("AvatarExperienceSave")
local AvatarExperienceSaveParent = AvatarExperienceSave.Parent

local Dash = require(AvatarExperienceSaveParent.Dash)

local _AvatarSaveContext = require(AvatarExperienceSave.Context.AvatarSaveContext)

local FFlagAXBackgroundsPersistence = require(AvatarExperienceSaveParent.AvatarExperienceFlags).FFlagAXBackgroundsPersistence

local function getSubstateToTrackForChanges(arg1, bool1: boolean?)
    local tryOnItems = ({})
    if arg1.tryOn.OutfitTryOn.TryOnItems then
        for k, tryOnItem in arg1.tryOn.OutfitTryOn.TryOnItems do
            if bool1 then
                tryOnItem = Dash.omit(tryOnItem, { "order" })
            end

            tryOnItems[k] = tryOnItem
        end
    end

    local equippedAssets = ({})
    if arg1.equipped.EquippedAssets then
        for k, equippedAsset in arg1.equipped.EquippedAssets do
            equippedAssets[k] = {}
            for value, value2 in equippedAsset do
                local var1 = equippedAssets[k]

                if bool1 then
                    value2 = Dash.omit(value2, { "order" })
                end

                var1[value] = value2
            end
        end
    end

    return {
        OutfitTryOn = {
            TryOnItems = tryOnItems,
            LookId = arg1.tryOn.OutfitTryOn.LookId,
            LookType = arg1.tryOn.OutfitTryOn.LookType,
            BodyColor3s = arg1.tryOn.OutfitTryOn.BodyColor3s,
            BodyPartColorRangeIds = arg1.tryOn.OutfitTryOn.BodyPartColorRangeIds,
            Scale = arg1.tryOn.OutfitTryOn.Scale
        },
        LastSavedTriedOnOutfit = arg1.tryOn.LastSavedTriedOnOutfit,
        AvatarType = arg1.equipped.AvatarType,
        AvatarScales = arg1.equipped.AvatarScales,
        BodyColor3s = arg1.equipped.BodyColor3s,
        BodyPartRangeIds = arg1.equipped.BodyPartRangeIds,
        EquippedAssets = equippedAssets,
        EquippedEmotes = {
            slotInfo = arg1.equipped.EquippedEmotes.slotInfo
        },
        BackgroundAssetId = if FFlagAXBackgroundsPersistence then arg1.equipped.BackgroundAssetId else nil
    }
end

return getSubstateToTrackForChanges
