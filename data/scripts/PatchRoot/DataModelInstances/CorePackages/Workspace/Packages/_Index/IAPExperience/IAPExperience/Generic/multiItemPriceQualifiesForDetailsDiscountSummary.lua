-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:10:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local IAPExperience = script:FindFirstAncestor("IAPExperience")
local DiscountType = require(IAPExperience.ProductPurchase.PricingTypes).DiscountType

local function multiItemPriceQualifiesForDetailsDiscountSummary(arg1)
    if not arg1 then
        return false
    end
    if #arg1.discounts >= 2 then
        return true
    end
    for _, discount in arg1.discounts do
        if discount.type == DiscountType.BlackbirdSubscription or discount.type == DiscountType.RobloxPlusSubscription then
            return true
        end
    end
    return false
end

return multiItemPriceQualifiesForDetailsDiscountSummary
