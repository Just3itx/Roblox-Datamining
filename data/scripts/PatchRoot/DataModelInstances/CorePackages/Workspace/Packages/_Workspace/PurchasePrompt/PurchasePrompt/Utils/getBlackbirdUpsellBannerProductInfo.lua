-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:51:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePromptParent = script:FindFirstAncestor("PurchasePrompt").Parent

local _RobloxSubscriptionPurchaseApp = require(PurchasePromptParent.RobloxSubscriptionPurchaseApp)

local function getBlackbirdUpsellBannerProductInfo(arg1)
    if type(arg1) ~= "table" or #arg1 == 0 then
        return nil
    end

    local var1 = arg1[1]
    local isFreeTrial = if var1.EligibleOffers and var1.EligibleOffers[1] then var1.EligibleOffers[1].OfferType == "FreeTrial" else false
    local discountPercent = nil
    local featureConfig = var1.ProductTypeDetails
        and var1.ProductTypeDetails.RobloxSubscriptionProductDetails
        and var1.ProductTypeDetails.RobloxSubscriptionProductDetails.FeatureConfig

    if featureConfig and featureConfig.VirtualTransactionDiscounts then
        local virtualTransactionDiscount = featureConfig.VirtualTransactionDiscounts[1]
        if virtualTransactionDiscount then
            discountPercent = virtualTransactionDiscount.DiscountPercent
        end
    end

    return { isFreeTrial = isFreeTrial, initialDiscountPercentage = discountPercent }
end

return getBlackbirdUpsellBannerProductInfo
