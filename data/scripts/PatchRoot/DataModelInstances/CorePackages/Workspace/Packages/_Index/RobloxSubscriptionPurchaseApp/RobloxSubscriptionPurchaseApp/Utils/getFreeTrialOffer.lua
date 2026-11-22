-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:51:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")
local _GetRobloxSubscriptionProductsModel = require(RobloxSubscriptionPurchaseApp.Models.GetRobloxSubscriptionProductsModel)

local function getFreeTrialOffer(arg1)
    if not arg1 then
        return nil
    end

    local eligibleOffers = arg1.EligibleOffers
    local eligibleOffer = eligibleOffers and eligibleOffers[1]
    return if eligibleOffer == nil or eligibleOffer.OfferType ~= "FreeTrial" then nil else eligibleOffer
end

return getFreeTrialOffer
