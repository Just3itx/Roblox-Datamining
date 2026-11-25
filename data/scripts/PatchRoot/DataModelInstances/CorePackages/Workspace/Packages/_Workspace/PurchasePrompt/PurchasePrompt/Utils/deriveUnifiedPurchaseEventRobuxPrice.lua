-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePromptParent = script:FindFirstAncestor("PurchasePrompt").Parent

local deriveCartPricingView = require(PurchasePromptParent.IAPExperience).deriveCartPricingView

local FFlagPurchasePromptUnifiedEventsUseOfferAdjustedPrice = require(PurchasePromptParent.SharedFlags).FFlagPurchasePromptUnifiedEventsUseOfferAdjustedPrice

local function deriveUnifiedPurchaseEventRobuxPrice(arg1, num1: number?)
    if not FFlagPurchasePromptUnifiedEventsUseOfferAdjustedPrice then
        return num1
    end
    local var1 = deriveCartPricingView(arg1)
    return if var1 == nil then num1 else var1.priceAfterDiscount
end

return deriveUnifiedPurchaseEventRobuxPrice
