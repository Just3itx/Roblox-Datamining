-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T14:00:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent

local FFlagAXRemoveExpiredItemsFromInventory = require(AvatarExperienceCommonParent.AvatarExperienceFlags).FFlagAXRemoveExpiredItemsFromInventory

local function isDurableItemExpired(isoDate: string): boolean
    if not FFlagAXRemoveExpiredItemsFromInventory then
        return false
    end

    local dateTime = DateTime.fromIsoDate(isoDate)
    return if dateTime then DateTime.now().UnixTimestamp >= dateTime.UnixTimestamp else false
end

return isDurableItemExpired
