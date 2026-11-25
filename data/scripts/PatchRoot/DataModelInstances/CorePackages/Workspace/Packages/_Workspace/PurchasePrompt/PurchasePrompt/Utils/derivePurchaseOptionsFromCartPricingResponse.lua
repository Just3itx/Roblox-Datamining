-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:50:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent

local _IAPExperience = require(PurchasePromptParent.IAPExperience)

local _types = require(PurchasePrompt.types)
local deriveSelectedOfferIdsFromCartPricing = require(script.Parent.deriveSelectedOfferIdsFromCartPricing)

local function derivePurchaseOptionsFromCartPricingResponse(arg1)
    if arg1 == nil then
        return nil
    end
    local var1 = deriveSelectedOfferIdsFromCartPricing(arg1)
    if #var1 == 0 then
        return nil
    end
    local offers = {}
    for _, id in var1 do
        table.insert(offers, { Id = id })
    end
    return { Offers = offers }
end

return derivePurchaseOptionsFromCartPricingResponse
