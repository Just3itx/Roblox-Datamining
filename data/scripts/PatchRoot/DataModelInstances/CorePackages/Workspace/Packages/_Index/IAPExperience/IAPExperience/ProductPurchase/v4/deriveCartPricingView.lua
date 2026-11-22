-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:20:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local IAPExperience = script:FindFirstAncestor("IAPExperience")
local cartPricingResponseLineItem = require(script.Parent.cartPricingResponseLineItem)

local FFlagPurchasePromptFetchCartPricingForLooks = require(IAPExperience.Parent.SharedFlags).FFlagPurchasePromptFetchCartPricingForLooks
local bool1 = game:DefineFastFlag("AXAllowFreeItemsFromOffer", false)

local _PricingTypes = require(script.Parent.Parent.PricingTypes)

local function deriveCartPricingView(arg1)
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
    for _, item in items do
        local cartLineSalePriceInRobux = cartPricingResponseLineItem.getCartLineSalePriceInRobux(item)
        if cartLineSalePriceInRobux == nil then
            return nil
        end
        num1 += cartLineSalePriceInRobux
        num2 += cartPricingResponseLineItem.getCartLineRegularPriceInRobux(item, cartLineSalePriceInRobux)
    end
    if not bool1 and num1 <= 0 then
        return nil
    end
    if bool1 and num1 < 0 then
        return nil
    end

    local offers = cartPricingResponseLineItem.extractCartPricingMarketingOffers(arg1)
    local selectedOfferIds = {}
    for _, value in offers do
        if value.selected then
            table.insert(selectedOfferIds, value.offerId)
        end
    end

    local var2

    if FFlagPurchasePromptFetchCartPricingForLooks then
        local var3 = cartPricingResponseLineItem.extractDiscountRowsFromLineItems(items)
        var2 = cartPricingResponseLineItem.consolidateRobloxPlusDiscounts(var3)
    else
        var2 = nil
    end

    local tbl2 = {
        priceAfterDiscount = num1,
        originalPrice = num2,
        priceWithoutOffersDiscounts = cartPricingResponseLineItem.computePriceWithoutOffersDiscounts(items, num1),
        hasSavings = num1 < num2,
        itemCount = #items,
        discounts = 0,
        offers = 0,
        selectedOfferIds = 0,
        savingsSummary = 0
    }

    if not FFlagPurchasePromptFetchCartPricingForLooks then
        var2 = cartPricingResponseLineItem.extractDiscountRowsFromLineItems(items)
    end

    tbl2.discounts = var2

    tbl2.offers = offers
    tbl2.selectedOfferIds = selectedOfferIds
    tbl2.savingsSummary = cartPricingResponseLineItem.extractCartPricingSavingsSummary(arg1)
    return tbl2
end

return deriveCartPricingView
