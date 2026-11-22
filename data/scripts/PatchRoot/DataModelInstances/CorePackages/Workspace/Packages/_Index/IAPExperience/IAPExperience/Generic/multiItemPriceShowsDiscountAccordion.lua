-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:10:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local IAPExperience = script:FindFirstAncestor("IAPExperience")
local _PricingTypes = require(IAPExperience.ProductPurchase.PricingTypes)

local multiItemPriceQualifiesForDetailsDiscountSummary = require(IAPExperience.Generic.multiItemPriceQualifiesForDetailsDiscountSummary)

local function multiItemPriceShowsDiscountAccordion(arg1)
    if not arg1 then
        return false
    end

    local basePriceInRobux = arg1.basePriceInRobux
    local priceInRobux = arg1.priceInRobux
    if typeof(basePriceInRobux) ~= "number" or typeof(priceInRobux) ~= "number" or basePriceInRobux <= priceInRobux then
        return false
    end

    return multiItemPriceQualifiesForDetailsDiscountSummary(arg1)
end

return multiItemPriceShowsDiscountAccordion
