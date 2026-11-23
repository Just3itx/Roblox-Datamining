-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:51:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")
local AvatarExperienceCommonParent = AvatarExperienceCommon.Parent

local OutfitTypes = require(AvatarExperienceCommon.Enums.OutfitTypes)
local _CategoryTypes = require(AvatarExperienceCommon.Types.CategoryTypes.CategoryTypes)
local InventoryOutfitType = require(AvatarExperienceCommonParent.AvatarExperienceModel).Enums.InventoryOutfitType

local function getInventoryOutfitType(arg1, bool1: boolean?)
    if arg1 == OutfitTypes.Avatar then
        if bool1 == false then
            return InventoryOutfitType.Body
        end

        return InventoryOutfitType.Avatar
    end

    if arg1 == OutfitTypes.DynamicHead then
        return InventoryOutfitType.DynamicHead
    end

    if arg1 == OutfitTypes.Shoes then
        return InventoryOutfitType.Shoes
    end

    if arg1 == OutfitTypes.Animations then
        return InventoryOutfitType.Animations
    end

    if arg1 == OutfitTypes.Makeup then
        if bool1 == false then
            return InventoryOutfitType.PurchasedMakeup
        end

        return InventoryOutfitType.CreatedMakeup
    end

    return nil
end

return getInventoryOutfitType
