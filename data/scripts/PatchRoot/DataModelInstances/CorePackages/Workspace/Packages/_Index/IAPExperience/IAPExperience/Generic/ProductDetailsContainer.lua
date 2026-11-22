-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:11:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local IAPExperience = script:FindFirstAncestor("IAPExperience")
local IAPExperienceParent = IAPExperience.Parent

local React = require(IAPExperienceParent.React)

local View = require(IAPExperienceParent.Foundation).View

local UnifiedProductDetails = require(IAPExperience.Generic.UnifiedProductDetails)
local PriceSummaryV2 = require(IAPExperience.Generic.PriceSummaryV2)
local DiscountSummary = require(IAPExperience.Generic.DiscountSummary)
local multiItemPriceShowsDiscountAccordion = require(IAPExperience.Generic.multiItemPriceShowsDiscountAccordion)

local UnifiedPurchaseModalTypeEnum = require(IAPExperience.Enums.UnifiedPurchaseModalTypeEnum)
local _PricingTypes = require(IAPExperience.ProductPurchase.PricingTypes)
local _VirtualItemBadgeType = require(IAPExperience.Enums.VirtualItemBadgeType)

local FFlagLuaAppsEnablePromptVIPServerPurchase = require(IAPExperienceParent.SharedFlags).FFlagLuaAppsEnablePromptVIPServerPurchase

local function itemPriceHasDiscountBreakdown(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    if not arg1 then
        return false
    end

    local basePriceInRobux = arg1.basePriceInRobux
    local priceInRobux = arg1.priceInRobux

    return typeof(basePriceInRobux) == "number" and typeof(priceInRobux) == "number" and priceInRobux < basePriceInRobux
end

local function ProductDetailsContainer(tbl1)
    local itemPrice = tbl1.product and tbl1.product.itemPrice
    local bool1 = itemPriceHasDiscountBreakdown(itemPrice)
    local var1 = multiItemPriceShowsDiscountAccordion(itemPrice)
    local uDim2 = UDim2.new(1, 0, 0, 100)

    if tbl1.purchaseModalType ~= UnifiedPurchaseModalTypeEnum.MultiItem then
        local element = if itemPrice and var1 then React.createElement(
            View,
            {
                tag = "size-full-0 auto-y padding-xxsmall",
                LayoutOrder = 2,
                Visible = not tbl1.hideDiscountSummary
            },
            {
                Discount = React.createElement(DiscountSummary, { itemPrice = itemPrice, savingsSummary = tbl1.savingsSummary })
            }
        ) else nil

        if not bool1 then
            element = nil
        end

        local createElement = React.createElement
        local var2 = View
        local tbl2 = {
            tag = "col align-x-center align-y-top gap-medium size-full-0 auto-y",
            Size = 0
        }

        if not var1 then
            uDim2 = nil
        end

        tbl2.Size = uDim2
        local tbl3 = {
            Details = React.createElement(UnifiedProductDetails, {
                layoutOrder = 1,
                isPortrait = false,
                isCompact = tbl1.isCompact,
                itemIcon = tbl1.product.itemIcon,
                itemName = tbl1.product.itemName,
                itemRobuxCost = tbl1.product.itemRobuxCost,
                itemPrice = itemPrice,
                model = tbl1.product.model,
                subtitleView = tbl1.subtitleView,
                itemDisplayPrice = tbl1.product.itemDisplayPrice,
                isLoading = tbl1.isLoading,
                priceSuffix = tbl1.priceSuffix,
                includePriceSuffixOnOriginal = if FFlagLuaAppsEnablePromptVIPServerPurchase then tbl1.includePriceSuffixOnOriginal else nil,
                priceText = if FFlagLuaAppsEnablePromptVIPServerPurchase then tbl1.priceText else nil
            }),
            DiscountSummary = element
        }
        return createElement(var2, tbl2, tbl3)
    end

    if multiItemPriceShowsDiscountAccordion(itemPrice) then
        local createElement = React.createElement
        local var2 = View
        local tbl2 = { tag = "col align-x-center align-y-top gap-medium size-full-0 auto-y" }

        local tbl3 = { Details = 0, DiscountSummary = 0 }
        local element

        if tbl1.hideProductDetails then
            element = nil
        else
            element = React.createElement(UnifiedProductDetails, {
                layoutOrder = 1,
                isPortrait = false,
                isCompact = tbl1.isCompact,
                itemIcon = tbl1.product.itemIcon,
                itemName = tbl1.product.itemName,
                itemRobuxCost = itemPrice.priceInRobux,
                itemPrice = itemPrice,
                model = tbl1.product.model,
                subtitleView = tbl1.subtitleView,
                itemDisplayPrice = tbl1.product.itemDisplayPrice,
                isLoading = tbl1.isLoading,
                priceSuffix = tbl1.priceSuffix,
                includePriceSuffixOnOriginal = if FFlagLuaAppsEnablePromptVIPServerPurchase then tbl1.includePriceSuffixOnOriginal else nil,
                priceText = if FFlagLuaAppsEnablePromptVIPServerPurchase then tbl1.priceText else nil
            })
        end

        tbl3.Details = element

        tbl3.DiscountSummary = React.createElement(
            View,
            {
                tag = "size-full-0 auto-y padding-xxsmall",
                LayoutOrder = 2,
                Visible = not tbl1.hideDiscountSummary
            },
            {
                Discount = React.createElement(DiscountSummary, { itemPrice = itemPrice, savingsSummary = tbl1.savingsSummary })
            }
        )
        return createElement(var2, tbl2, tbl3)
    elseif bool1 then
        return React.createElement(View, {
            tag = "col align-x-center align-y-top size-full-0",
            Size = uDim2
        }, {
            Summary = React.createElement(
                PriceSummaryV2,
                {
                    amount = tbl1.product.itemRobuxCost,
                    itemPrice = itemPrice,
                    subtotalItemCount = tbl1.subtotalItemCount
                }
            )
        })
    else
        return (React.createElement(
            PriceSummaryV2,
            {
                amount = tbl1.product.itemRobuxCost,
                itemPrice = itemPrice,
                subtotalItemCount = tbl1.subtotalItemCount
            }
        ))
    end
end

return ProductDetailsContainer
