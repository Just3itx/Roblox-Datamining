-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent

local _IAPExperience = require(PurchasePromptParent.IAPExperience)
local FFlagFixResaleDisplayPrice = require(PurchasePrompt.Flags.FFlagFixResaleDisplayPrice)
local selectCartPricingOverride = require(script.Parent.selectCartPricingOverride)

local function selectPrice(tbl1)
    local productInfo = tbl1.productInfo

    local price = productInfo.price or 0
    local var1 = productInfo.basePrice or price
    local discounts = productInfo.priceDiscountDetails or {}

    if FFlagFixResaleDisplayPrice and tbl1.promptRequest then
        local collectibleItemInstanceId = tbl1.promptRequest.collectibleItemInstanceId
        if collectibleItemInstanceId and collectibleItemInstanceId ~= "" then
            local expectedPrice = tbl1.promptRequest.expectedPrice
            if expectedPrice ~= nil then
                var1 = expectedPrice
                price = var1
            end
        end
    end

    local var3 = selectCartPricingOverride(tbl1)
    if var3 ~= nil then
        price = var3.priceInRobux
        if var3.basePriceInRobux ~= nil then
            var1 = var3.basePriceInRobux
        end
    end

    return {
        priceInRobux = price,
        basePriceInRobux = var1,
        discounts = discounts,
        savingsSummaryOverride = productInfo.savingsSummaryOverride
    }
end

return selectPrice
