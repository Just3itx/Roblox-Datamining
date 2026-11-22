-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:20:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)

local View = require(scriptParentParentParentParent.Foundation).View

local ProductDetailsContainer = require(scriptParentParentParent.Generic.ProductDetailsContainer)
local CartPricingLoading = require(script.Parent.CartPricingLoading)
local _useCartPricing = require(script.Parent.useCartPricing)

local _UnifiedPurchaseModalTypeEnum = require(scriptParentParentParent.Enums.UnifiedPurchaseModalTypeEnum)

local FFlagUnifiedPurchaseAddSkeleton = require(scriptParentParentParent.Parent.SharedFlags).FFlagUnifiedPurchaseAddSkeleton

local FFlagLuaAppsEnablePromptVIPServerPurchase = require(scriptParentParentParent.Parent.SharedFlags).FFlagLuaAppsEnablePromptVIPServerPurchase

local function CartPricingProductDetails(tbl1)
    local cartPricing = tbl1.cartPricing
    local cartPricingLoading = if tbl1.isCartPricingLoading then React.createElement(CartPricingLoading, { LayoutOrder = 2, isLoading = tbl1.isCartPricingLoading }) else nil
    local createElement = React.createElement
    local var1 = View
    local tbl2 = {
        tag = "col align-x-center align-y-center gap-medium size-full-0 auto-y",
        LayoutOrder = 1
    }

    local tbl3 = {
        Details = React.createElement(ProductDetailsContainer, {
            purchaseModalType = tbl1.purchaseModalType,
            product = cartPricing.mergedProductForDetails,
            subtitleView = tbl1.subtitleView,
            priceSuffix = tbl1.priceSuffix,
            includePriceSuffixOnOriginal = if FFlagLuaAppsEnablePromptVIPServerPurchase then tbl1.includePriceSuffixOnOriginal else nil,
            priceText = if FFlagLuaAppsEnablePromptVIPServerPurchase then tbl1.priceText else nil,
            isLoading = if FFlagUnifiedPurchaseAddSkeleton then tbl1.isLoading else nil,
            subtotalItemCount = if cartPricing.showCartOfferUi and cartPricing.cartAggregate then cartPricing.cartAggregate.itemCount else nil,
            hideProductDetails = cartPricing.shouldHideLookProductDetails,
            hideDiscountSummary = tbl1.isCartPricingLoading,
            savingsSummary = cartPricing.cartPricingSavingsSummary
        }),
        CartPricingLoading = cartPricingLoading
    }
    return createElement(var1, tbl2, tbl3)
end

return CartPricingProductDetails
