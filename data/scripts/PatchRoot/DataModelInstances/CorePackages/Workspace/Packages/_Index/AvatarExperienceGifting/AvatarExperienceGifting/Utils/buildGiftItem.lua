-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:21:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceGiftingParent = script:FindFirstAncestor("AvatarExperienceGifting").Parent

local ItemType = require(AvatarExperienceGiftingParent.Gifting).Enums.ItemType

local function buildGiftItem(itemId: string?): {itemId: string, itemType: any}?
    return if itemId == nil or itemId == "" then nil else {
        itemType = ItemType.CollectibleItem,
        itemId = itemId
    }
end

return buildGiftItem
