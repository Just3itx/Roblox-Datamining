-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePromptParent = script:FindFirstAncestor("PurchasePrompt").Parent

local deriveCartPricingView = require(PurchasePromptParent.IAPExperience).deriveCartPricingView

local function deriveSelectedOfferIdsFromCartPricing(arg1)
    local var1 = deriveCartPricingView(arg1)
    return if var1 == nil then {} else var1.selectedOfferIds
end

return deriveSelectedOfferIdsFromCartPricing
