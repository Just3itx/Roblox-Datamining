-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:41:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")
local ItemTypeEnum = require(AvatarExperienceCommon.Parent.AvatarExperienceModel).Enums.ItemTypeEnum
local Constants = require(AvatarExperienceCommon.Constants)

local function getBodiesInTryOns(tryOnItems)
    local bodiesInTryOns = {}
    for _, tryOnItem in tryOnItems do
        if tryOnItem.itemType == ItemTypeEnum.Bundle and tryOnItem.itemSubType == Constants.BODY_BUNDLE_TYPE_ID then
            table.insert(bodiesInTryOns, tryOnItem.itemId)
        end
    end
    return bodiesInTryOns
end

local function selectTryOnBodyIds(arg1)
    local outfitTryOn = arg1.AvatarExperience.AvatarScene.OutfitTryOn
    if outfitTryOn and outfitTryOn.TryOnItems then
        return (getBodiesInTryOns(outfitTryOn.TryOnItems))
    end

    return {}
end

return selectTryOnBodyIds
