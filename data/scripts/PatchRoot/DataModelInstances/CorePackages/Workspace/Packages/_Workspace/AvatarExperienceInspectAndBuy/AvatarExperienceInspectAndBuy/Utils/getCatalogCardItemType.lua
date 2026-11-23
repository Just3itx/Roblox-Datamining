-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:31:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuyParent = script:FindFirstAncestor("AvatarExperienceInspectAndBuy").Parent
local AXCommon = require(AvatarExperienceInspectAndBuyParent.AXCommon)
local ItemRestrictions = AXCommon.Enums.ItemRestrictions
local CatalogItemCardItemTypeEnum = AXCommon.Components.CatalogItemCard.CatalogItemCardItemTypeEnum

local function getCatalogCardItemType(tbl1)
    if not tbl1 then
        return nil
    end

    if tbl1[ItemRestrictions.Limited] then
        return CatalogItemCardItemTypeEnum.Limited
    end

    if tbl1[ItemRestrictions.Collectible] or tbl1[ItemRestrictions.LimitedUnique] then
        return CatalogItemCardItemTypeEnum.Collectible
    end

    return nil
end

return getCatalogCardItemType
