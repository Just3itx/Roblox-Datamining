-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:11:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")
local AvatarExperienceCommonParent = AvatarExperienceCommon.Parent

local AvatarExperienceFlags = require(AvatarExperienceCommonParent.AvatarExperienceFlags)
local FFlagAXOutfitSaveSkipUnownedTryOnBackground = AvatarExperienceFlags.FFlagAXOutfitSaveSkipUnownedTryOnBackground
local FFlagAXTryOnBackgroundRespectsSelection = AvatarExperienceFlags.FFlagAXTryOnBackgroundRespectsSelection

local AvatarBackground = require(AvatarExperienceCommon.Constants).ASSET_TYPE_NAME_TO_ID_STRING.AvatarBackground
local NO_BACKGROUND_ASSET_ID = require(script.Parent.constants).NO_BACKGROUND_ASSET_ID
local selectTryOnBackgroundId = require(script.Parent.selectTryOnBackgroundId)

local function scanTryOnForBackground(tbl1)
    if not tbl1 then
        return nil
    end
    for _, value in tbl1 do
        if value.isUnequipped or value.itemType ~= "Asset" or value.itemSubType ~= AvatarBackground then
            continue
        end

        local var1 = tonumber(value.itemId)
        if var1 then
            return var1
        end
    end

    return nil
end

local function firstEquippedBackgroundId(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    if not tbl1 then
        return nil
    end
    local var1 = tbl1[AvatarBackground]
    if not var1 then
        return nil
    end
    for value in var1 do
        local var2 = tonumber(value)
        if var2 then
            return var2
        end
    end
    return nil
end

local function selectActiveBackground(arg1, tbl1)
    if not AvatarBackground then
        return nil
    end

    local var1 = arg1 and (arg1.AvatarExperience or arg1)

    local bool1 = FFlagAXOutfitSaveSkipUnownedTryOnBackground

    if bool1 then
        if tbl1 == nil then
            bool1 = false
        else
            bool1 = tbl1.ignoreTryOn == true
        end
    end

    if AvatarExperienceFlags.FFlagAXBackgroundsCustomizeHydration and not bool1 then
        local var2

        if FFlagAXTryOnBackgroundRespectsSelection then
            var2 = selectTryOnBackgroundId(var1)
        else
            local outfitTryOn = var1 and var1.AvatarScene and var1.AvatarScene.OutfitTryOn
            var2 = scanTryOnForBackground(outfitTryOn and outfitTryOn.TryOnItems)
        end
        if var2 then
            return var2
        end
    end

    local profileConfiguration = var1 and var1.AvatarScene and var1.AvatarScene.ProfileConfiguration
    if profileConfiguration and profileConfiguration.BackgroundAssetId ~= nil then
        local backgroundAssetId = profileConfiguration.BackgroundAssetId
        return if backgroundAssetId == NO_BACKGROUND_ASSET_ID then nil else backgroundAssetId
    end

    local character = var1 and var1.AvatarEditor and var1.AvatarEditor.Character
    return firstEquippedBackgroundId(character and character.EquippedAssets)
end

return selectActiveBackground
