-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:31:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Gifting = script:FindFirstAncestor("Gifting")

local ItemType = require(Gifting.Enums.ItemType)
local _Types = require(Gifting.Types)

return {
    buildItemGiftabilityKey = function(arg1): string
        return `{arg1.itemType}:{arg1.itemId}`
    end,
    parseItemGiftabilityKey = function(str1: string)
        local var1 = string.find(str1, ":", 1, true)
        if var1 == nil then
            return nil
        end

        local itemType = ItemType.fromValue(string.sub(str1, 1, var1 - 1))
        if itemType == nil or itemType == ItemType.Invalid then
            return nil
        end

        local itemId = string.sub(str1, var1 + 1)
        return if itemId == "" then nil else { itemType = itemType, itemId = itemId }
    end
}
