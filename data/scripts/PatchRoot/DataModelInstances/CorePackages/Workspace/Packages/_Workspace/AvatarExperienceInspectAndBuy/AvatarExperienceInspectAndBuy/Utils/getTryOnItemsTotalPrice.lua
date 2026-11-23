-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:40:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuy = script:FindFirstAncestor("AvatarExperienceInspectAndBuy")
local AvatarExperienceInspectAndBuyParent = AvatarExperienceInspectAndBuy.Parent
local _AXCommon = require(AvatarExperienceInspectAndBuyParent.AXCommon)
local _Types = require(AvatarExperienceInspectAndBuy.Types)
local PriceStatus = require(AvatarExperienceInspectAndBuy.Enums.PriceStatus)
local getPriceStatus = require(AvatarExperienceInspectAndBuy.Utils.getPriceStatus)
local _getPriceLineContent = require(AvatarExperienceInspectAndBuy.Utils.getPriceLineContent)
local getPriceInRobux = require(AvatarExperienceInspectAndBuy.Utils.itemDetailsUtils).getPriceInRobux
local getPriceStatusInShop = require(AvatarExperienceInspectAndBuy.Utils.getPriceStatusInShop)
local isPurchasableItem = require(AvatarExperienceInspectAndBuy.Utils.bulkPurchaseUtils).isPurchasableItem
local FFlagAXIaBEnableShopContext = require(AvatarExperienceInspectAndBuyParent.AvatarExperienceFlags).FFlagAXIaBEnableShopContext

local FIntBlackbirdUpsellMinPriceForDiscountInclusive = require(AvatarExperienceInspectAndBuyParent.SharedFlags).FIntBlackbirdUpsellMinPriceForDiscountInclusive

local FIntBlackbirdUpsellMaxPriceForDiscountInclusive = require(AvatarExperienceInspectAndBuyParent.SharedFlags).FIntBlackbirdUpsellMaxPriceForDiscountInclusive

local tbl1 = { isShopContext = true }

local function getDiscount(itemData, purchaseFromRoblox) -- Luacid: Inlined by compiler; 1 call site recovered
    if purchaseFromRoblox ~= PriceStatus.PurchaseFromRoblox then
        return nil
    end
    local discountInformation = itemData.discountInformation
    return if discountInformation and discountInformation.totalDiscountAmount and discountInformation.totalDiscountAmount > 0 then discountInformation else nil
end

local function isDiscountEligible(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1 == nil then
        return false
    end
    local var1 = FIntBlackbirdUpsellMaxPriceForDiscountInclusive
    local originalPrice = arg1.originalPrice
    return FIntBlackbirdUpsellMinPriceForDiscountInclusive < originalPrice and (var1 == 0 or arg1.originalPrice < var1)
end

local function classifyPriceStatus(itemData, arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if FFlagAXIaBEnableShopContext and arg1.isShopContext then
        return getPriceStatusInShop(itemData)
    end
    return getPriceStatus(itemData, true)
end

local function getTryOnItemsTotalPrice(tbl2, arg1)
    local var1 = arg1 or tbl1
    local num1 = 0
    local num2 = 0
    local num3 = 0
    local bool1 = false
    local bool2 = false

    for _, value in tbl2 do
        if not value.isEquipped then
            continue
        end

        local var2 = classifyPriceStatus(value.itemData, var1)
        if not isPurchasableItem(var2) then
            continue
        end

        local var3, discount

        if var2 == PriceStatus.Free then
            var3 = getPriceInRobux(value.itemData, var2) or 0

            discount = getDiscount(value.itemData, var2)

            num1 += var3

            if discount then
                var3 = discount.originalPrice
            end

            num2 += var3

            if isDiscountEligible(discount) then
                bool1 = true
            else
                bool2 = true
            end

            num3 += 1
        else
            var3 = getPriceInRobux(value.itemData, var2)
            if var3 ~= nil then
                discount = getDiscount(value.itemData, var2)

                num1 += var3

                if discount then
                    var3 = discount.originalPrice
                end

                num2 += var3

                if isDiscountEligible(discount) then
                    bool1 = true
                else
                    bool2 = true
                end

                num3 += 1
            end
        end
    end

    return {
        totalPrice = num1,
        originalPrice = num2,
        itemCount = num3,
        hasNonDiscountedItems = bool1 and bool2
    }
end

return getTryOnItemsTotalPrice
