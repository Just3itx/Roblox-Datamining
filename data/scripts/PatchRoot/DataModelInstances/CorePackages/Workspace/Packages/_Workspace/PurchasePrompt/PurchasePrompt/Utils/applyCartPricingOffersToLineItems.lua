-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:50:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent

local _IAPExperience = require(PurchasePromptParent.IAPExperience)
local _types = require(PurchasePrompt.types)

local function applyCartPricingOffersToLineItems(tbl1, arg1, tbl2)
    local tbl3 = ({})
    for _, value in tbl2 do
        tbl3[value] = true
    end

    local tbl4 = ({})
    for _, value in arg1.items or {} do
        local discountInformation = value.discountInformation
        local offerIds = {}
        for _, value2 in discountInformation and discountInformation.discounts or {} do
            local discountId = value2.discountId
            if discountId ~= nil and tbl3[discountId] then
                table.insert(offerIds, discountId)
            end
        end
        if not (#offerIds > 0) then
            continue
        end

        local collectibleItemId = value.collectibleItemId
        tbl4[collectibleItemId] = {
            offerIds = offerIds,
            priceInRobux = value.priceInRobux
        }
    end

    local result = {}
    for _, value in tbl1 do
        local var1 = tbl4[value.collectibleItemId]
        if var1 ~= nil then
            local var2 = table.clone(value)
            var2.offerIds = var1.offerIds
            if var1.priceInRobux ~= nil then
                var2.agreedPriceRobux = var1.priceInRobux
            end
            table.insert(result, var2)
        else
            table.insert(result, value)
        end
    end
    return result
end

return applyCartPricingOffersToLineItems
