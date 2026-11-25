-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:31:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePromptParent = script:FindFirstAncestor("PurchasePrompt").Parent

local _IAPExperience = require(PurchasePromptParent.IAPExperience)

local function selectCartPricingResponse(tbl1)
    local cartPricing = tbl1.cartPricing
    return if cartPricing == nil then nil else cartPricing.response
end

return selectCartPricingResponse
