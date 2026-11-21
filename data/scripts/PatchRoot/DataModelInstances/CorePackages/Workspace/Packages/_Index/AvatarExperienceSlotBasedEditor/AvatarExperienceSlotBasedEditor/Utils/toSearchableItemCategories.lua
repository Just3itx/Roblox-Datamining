-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:51:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSlotBasedEditor = script:FindFirstAncestor("AvatarExperienceSlotBasedEditor")

local InventorySearchConstants = require(AvatarExperienceSlotBasedEditor.InventorySearchConstants)
local _InventorySearchItemType = require(AvatarExperienceSlotBasedEditor.Enums.InventorySearchItemType)
local _Types = require(AvatarExperienceSlotBasedEditor.Types)

local SearchableSubtypesByItemType = InventorySearchConstants.SearchableSubtypesByItemType

local function toSearchableItemCategories(tbl1)
    local result = {}
    for _, value in tbl1 do
        local itemType = string.lower(value.itemType)
        local var1 = SearchableSubtypesByItemType[itemType]
        if var1 and var1[value.itemSubType] then
            table.insert(result, { itemType = itemType, itemSubType = value.itemSubType })
        end
    end

    return result
end

return toSearchableItemCategories
