-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:20:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)

local _ProductDetailsContainer = require(scriptParentParentParent.Generic.ProductDetailsContainer)
local _aggregateCartPricingForMultiItem = require(script.Parent.aggregateCartPricingForMultiItem)
local _cartPricingResponseLineItem = require(script.Parent.cartPricingResponseLineItem)
local deriveCartPricingView = require(script.Parent.deriveCartPricingView)

local UnifiedPurchaseModalTypeEnum = require(scriptParentParentParent.Enums.UnifiedPurchaseModalTypeEnum)

local _PricingTypes = require(scriptParentParentParent.ProductPurchase.PricingTypes)

local function useCartPricing(tbl1)
    local var1 = React.useMemo(function()
        return deriveCartPricingView(tbl1.cartPricingResponse)
    end, { tbl1.cartPricingResponse })

    local cartPricingOffers = var1 == nil and {} or var1.offers

    local cartAggregate = var1 ~= nil
        and var1.hasSavings
        and {
            subtotalRobux = var1.originalPrice,
            totalRobux = var1.priceAfterDiscount,
            savingsRobux = var1.originalPrice - var1.priceAfterDiscount,
            itemCount = var1.itemCount
        }
        or nil
    local priceWithoutOffersDiscounts = if var1 == nil then nil else var1.priceWithoutOffersDiscounts
    local priceAfterDiscount = if var1 == nil then nil else var1.priceAfterDiscount
    local shouldHideLookProductDetails = tbl1.purchaseModalType == UnifiedPurchaseModalTypeEnum.MultiItem
    local showCartOfferUi = cartAggregate ~= nil or #cartPricingOffers > 0

    local var2 = React.useMemo(function()
        if not showCartOfferUi or cartAggregate == nil or var1 == nil then
            return nil
        end

        return {
            basePriceInRobux = cartAggregate.subtotalRobux,
            priceInRobux = cartAggregate.totalRobux,
            discounts = var1.discounts
        }
    end, { showCartOfferUi, cartAggregate, var1 })

    local mergedProductForDetails = React.useMemo(function()
        if not showCartOfferUi or cartAggregate == nil then
            return tbl1.product
        end

        return {
            model = tbl1.product.model,
            itemIcon = tbl1.product.itemIcon,
            itemName = tbl1.product.itemName,
            itemRobuxCost = cartAggregate.totalRobux,
            itemPrice = var2 or tbl1.product.itemPrice,
            itemDisplayPrice = tbl1.product.itemDisplayPrice,
            badgeType = tbl1.product.badgeType
        }
    end, {
        tbl1.product,
        showCartOfferUi,
        cartAggregate,
        var2
    })
    local itemPrice = mergedProductForDetails.itemPrice
    local mergedProductPriceInRobux = if itemPrice then itemPrice.priceInRobux else mergedProductForDetails.itemRobuxCost
    local displayItemPriceForMultiItem = if showCartOfferUi then var2 or tbl1.product.itemPrice else tbl1.product.itemPrice
    local savingsSummary = if showCartOfferUi and var1 ~= nil then var1.savingsSummary else nil

    return {
        cartAggregate = cartAggregate,
        priceWithoutOffersDiscounts = priceWithoutOffersDiscounts,
        priceAfterOffersDiscounts = priceAfterDiscount,
        shouldHideLookProductDetails = shouldHideLookProductDetails,
        cartPricingOffers = cartPricingOffers,
        showCartOfferUi = showCartOfferUi,
        mergedProductForDetails = mergedProductForDetails,
        mergedProductItemPrice = itemPrice,
        mergedProductPriceInRobux = mergedProductPriceInRobux,
        displayItemPriceForMultiItem = displayItemPriceForMultiItem,
        cartPricingSavingsSummary = savingsSummary,
        toggleCartPricingOffer = React.useCallback(function(offerId: string)
            local onCartOfferAppliedChanged = tbl1.onCartOfferAppliedChanged
            if onCartOfferAppliedChanged == nil then
                return
            end

            local tbl2 = {}
            local bool3 = true
            for _, value in cartPricingOffers do
                if not (if value.offerId == offerId then not value.selected else value.selected) then
                    table.insert(tbl2, value.offerId)
                    bool3 = false
                end
            end

            onCartOfferAppliedChanged(bool3, tbl2)
        end, { cartPricingOffers, tbl1.onCartOfferAppliedChanged })
    }
end

return useCartPricing
