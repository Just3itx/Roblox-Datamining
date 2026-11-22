-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:10:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local React = require(scriptParentParentParent.React)

local Foundation = require(scriptParentParentParent.Foundation)
local FoundationText = Foundation.Text
local View = Foundation.View
local Divider = Foundation.Divider

local useLocalization = require(scriptParentParentParent.Localization).Hooks.useLocalization
local useRobuxText = require(scriptParentParent.Generic.Hooks.useRobuxText)
local usePlaceholderLocalization = require(scriptParentParent.Generic.Hooks.usePlaceholderLocalization)

local PriceLineItem = require(scriptParentParent.Generic.PriceLineItem)
local DiscountRow = require(scriptParentParent.Generic.DiscountRow)

local FFlagUnifiedPurchaseFlowMarketplaceUIImprovements = require(scriptParentParent.Parent.SharedFlags).FFlagUnifiedPurchaseFlowMarketplaceUIImprovements
local _PricingTypes = require(scriptParentParent.ProductPurchase.PricingTypes)
local bool1 = game:DefineFastFlag("PriceSummaryV2UseLocalizedBreakdown", false)

local function shouldShowPriceBreakdown(itemPrice): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    if not itemPrice then
        return false
    end

    local basePriceInRobux = itemPrice.basePriceInRobux
    local priceInRobux = itemPrice.priceInRobux

    return typeof(basePriceInRobux) == "number" and typeof(priceInRobux) == "number" and priceInRobux < basePriceInRobux
end

local function PriceSummaryV2(tbl1)
    local itemPrice = tbl1.itemPrice
    local var1 = if itemPrice then itemPrice.priceInRobux else tbl1.amount
    local bool2 = shouldShowPriceBreakdown(itemPrice)
    local var2 = useLocalization({
        Total = "Feature.Catalog.Label.TotalUnformatted",
        TotalPrice = if FFlagUnifiedPurchaseFlowMarketplaceUIImprovements then "IAPExperience.PurchasePrompt.Label.TotalPriceV2" else nil
    })

    local var3 = usePlaceholderLocalization({
        SubtotalLabel = tbl1.subtotalItemCount
            and {
                "IAPExperience.PurchasePrompt.Label.SubtotalWithItemCount",
                itemCount = tbl1.subtotalItemCount
            }
            or "IAPExperience.PurchasePrompt.Label.Subtotal",
        TotalLabel = "IAPExperience.PurchasePrompt.Label.Total"
    })

    if bool1 then
        var3 = useLocalization({
            SubtotalLabel = tbl1.subtotalItemCount
                and {
                    "IAPExperience.PurchasePrompt.Label.SubtotalWithItemCount",
                    itemCount = tbl1.subtotalItemCount
                }
                or "IAPExperience.PurchasePrompt.Label.Subtotal",
            TotalLabel = "IAPExperience.PurchasePrompt.Label.Total"
        })
    end

    local var4 = not (bool2 and itemPrice) and (var1 or 0) or itemPrice.basePriceInRobux
    local amount = useRobuxText(var1)
    local var5 = useRobuxText(var4 or 0)

    if bool2 and itemPrice then
        local tbl2 = {}
        local layoutOrder = 1

        tbl2.SubtotalRow = React.createElement(PriceLineItem, { label = var3.SubtotalLabel, amount = var5, LayoutOrder = layoutOrder })

        local num2 = layoutOrder + 1

        for i, discount in ipairs(itemPrice.discounts) do
            if not (discount.amountInRobux > 0) then
                continue
            end

            local str1 = "DiscountRow_" .. tostring(i)
            tbl2[str1] = React.createElement(
                DiscountRow,
                {
                    discount = discount,
                    label = discount.localizedDiscountAttribution,
                    LayoutOrder = num2
                }
            )
            num2 += 1
        end

        tbl2.BreakdownDivider = React.createElement(
            View,
            {
                LayoutOrder = num2,
                tag = "col size-full-0 auto-y shrink-0 self-stretch padding-top-small"
            },
            {
                Line = React.createElement(Divider, { tag = "size-full-0 auto-y" })
            }
        )

        local num1 = num2 + 1

        tbl2.TotalRow = React.createElement(PriceLineItem, {
            label = var3.TotalLabel,
            amount = amount,
            textStyle = "text-title-medium",
            tag = "row size-full-0 auto-y align-y-center padding-x-xsmall padding-y-xsmall",
            LayoutOrder = num1
        })

        return React.createElement(
            View,
            {
                tag = "size-full-0 auto-y padding-left-xxsmall padding-right-xxsmall padding-top-small padding-bottom-xsmall"
            },
            {
                BorderContainer = React.createElement(
                    View,
                    {
                        tag = "col size-full-0 auto-y shrink-0 radius-medium padding-x-large padding-y-small stroke-default gap-xsmall"
                    },
                    tbl2
                )
            }
        )
    end

    local createElement = React.createElement
    local var7 = View
    local tbl2 = {
        tag = "size-full-1300 padding-left-xxsmall padding-right-xxsmall padding-top-small padding-bottom-large"
    }
    local tbl3 = { BorderContainer = 0 }
    local createElement2 = React.createElement
    local var8 = View
    local tbl4 = {
        tag = "auto-xy align-y-center align-x-center radius-medium padding-x-large row stroke-default padding-y-xsmall"
    }
    local tbl5 = { LeftSide = 0, RightSide = 0 }
    local createElement3 = React.createElement
    local var9 = View
    local tbl6 = {
        LayoutOrder = 1,
        tag = "row gap-small align-y-center align-x-start padding-y-xsmall",
        Size = UDim2.new(0.5, 0, 0, 0)
    }
    local tbl7 = {
        RobuxAmount = React.createElement(FoundationText, {
            LayoutOrder = 1,
            Text = if FFlagUnifiedPurchaseFlowMarketplaceUIImprovements then var2.TotalPrice else var2.Total,
            tag = if FFlagUnifiedPurchaseFlowMarketplaceUIImprovements then "auto-xy text-title-medium content-default text-align-x-left padding-y-xsmall" else "auto-xy text-label-medium content-default text-align-x-left padding-y-xsmall"
        })
    }
    tbl5.LeftSide = createElement3(var9, tbl6, tbl7)

    tbl5.RightSide = React.createElement(
        View,
        {
            LayoutOrder = 2,
            tag = "row align-y-center align-x-right gap-large padding-y-xsmall",
            Size = UDim2.new(0.5, 0, 0, 0)
        },
        {
            RobuxPrice = if FFlagUnifiedPurchaseFlowMarketplaceUIImprovements then React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = amount,
                tag = "auto-xy text-title-medium content-emphasis text-align-x-right padding-y-xsmall",
                RichText = true
            }) else React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = amount,
                tag = "auto-xy text-label-medium content-emphasis text-align-x-right padding-y-xsmall"
            })
        }
    )
    tbl3.BorderContainer = createElement2(var8, tbl4, tbl5)
    return createElement(var7, tbl2, tbl3)
end

return PriceSummaryV2
