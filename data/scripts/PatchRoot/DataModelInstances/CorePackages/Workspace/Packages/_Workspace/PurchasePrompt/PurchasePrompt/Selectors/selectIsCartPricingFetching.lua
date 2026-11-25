-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")

local _CartPricingReducer = require(PurchasePrompt.Reducers.CartPricingReducer)

local function selectIsCartPricingFetching(tbl1): boolean
    local cartPricing = tbl1.cartPricing
    return not (cartPricing == nil) and cartPricing.isFetching == true
end

return selectIsCartPricingFetching
