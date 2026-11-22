-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:20:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local cartPricingResponseLineItem = require(script.Parent.cartPricingResponseLineItem)

local function aggregateCartPricingForMultiItem(arg1)
    if type(arg1) ~= "table" then
        return nil
    end
    local errors = arg1.errors
    if type(errors) == "table" and next(errors) ~= nil then
        return nil
    end
    local items = arg1.items
    if type(items) ~= "table" or next(items) == nil then
        return nil
    end

    local num1 = 0
    local num2 = 0
    for _, item in ipairs(items) do
        local cartLineSalePriceInRobux = cartPricingResponseLineItem.getCartLineSalePriceInRobux(item)
        if cartLineSalePriceInRobux == nil then
            return nil
        end
        num1 += cartPricingResponseLineItem.getCartLineRegularPriceInRobux(item, cartLineSalePriceInRobux)
        num2 += cartLineSalePriceInRobux
    end

    local savingsRobux = num1 - num2
    return if savingsRobux <= 0 then nil else {
        subtotalRobux = num1,
        totalRobux = num2,
        savingsRobux = savingsRobux,
        itemCount = #items
    }
end

return aggregateCartPricingForMultiItem
