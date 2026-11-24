-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:01:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")

local _Types = require(InExperienceShop.Types)
local formatUpdatedDate = require(InExperienceShop.Utils.formatUpdatedDate)
local FFlagShopProductsUseDisplayName = require(InExperienceShop.Flags.FFlagShopProductsUseDisplayName)

local function toShopItemThumbnail(arg1): string -- Luacid: Inlined by compiler; 1 call site recovered
    return if arg1 == nil then "" else "rbxassetid://" .. tostring(arg1)
end

local function toShopItemCreator(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1 == nil then
        return nil
    end

    return {
        name = arg1.Name,
        hasVerifiedBadge = arg1.HasVerifiedBadge == true
    }
end

local function toShopItemName(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if FFlagShopProductsUseDisplayName then
        return arg1.DisplayName or arg1.Name
    end

    return arg1.Name
end

return {
    makeRequestKey = function(num1: number, arg1): string
        return tostring(num1) .. ":" .. tostring(arg1)
    end,
    toShopItemThumbnail = toShopItemThumbnail,
    toShopItemCreator = toShopItemCreator,
    toShopItem = function(arg1, itemType, num1: number)
        local var1 = if itemType == "Product" then tostring(arg1.ProductId) else tostring(num1)
        return {
            id = var1,
            name = toShopItemName(arg1),
            thumbnail = toShopItemThumbnail(arg1.IconImageAssetId),
            price = arg1.PriceInRobux,
            userBasePriceInRobux = arg1.UserBasePriceInRobux or arg1.BasePriceInRobux,
            description = arg1.Description,
            updated = formatUpdatedDate(arg1.Updated),
            isOwned = false,
            itemType = itemType,
            creator = toShopItemCreator(arg1.Creator)
        }
    end
}
