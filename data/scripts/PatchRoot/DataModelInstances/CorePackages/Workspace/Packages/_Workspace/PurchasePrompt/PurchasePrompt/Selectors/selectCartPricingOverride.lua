-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:31:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent

local deriveCartPricingView = require(PurchasePromptParent.IAPExperience).deriveCartPricingView

local ProductTypeEnum = require(PurchasePrompt.types).ProductTypeEnum
local RequestType = require(PurchasePrompt.Enums.RequestType)

local function isCartPricingKind(productPayload, str1: string?) -- Luacid: Inlined by compiler; 1 call site recovered
    if type(productPayload) == "table" then
        local kind = productPayload.kind
        if kind == ProductTypeEnum.Asset or kind == ProductTypeEnum.Bundle or kind == ProductTypeEnum.Look then
            return true
        end
    end
    return str1 == RequestType.GamePass or str1 == RequestType.Product
end

local function selectCartPricingOverride(tbl1)
    if tbl1 == nil then
        return nil
    end

    if not isCartPricingKind(tbl1.productPayload, tbl1.promptRequest and tbl1.promptRequest.requestType) then
        return nil
    end
    local cartPricing = tbl1.cartPricing
    if cartPricing == nil then
        return nil
    end

    local var1 = deriveCartPricingView(cartPricing.response)
    return if var1 == nil then nil else {
        priceInRobux = var1.priceAfterDiscount,
        basePriceInRobux = var1.originalPrice
    }
end

return selectCartPricingOverride
