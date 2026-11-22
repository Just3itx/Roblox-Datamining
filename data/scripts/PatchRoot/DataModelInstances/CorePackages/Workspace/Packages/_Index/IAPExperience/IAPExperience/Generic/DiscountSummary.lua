-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local IAPExperience = script:FindFirstAncestor("IAPExperience")
local IAPExperienceParent = IAPExperience.Parent

local React = require(IAPExperienceParent.React)

local Foundation = require(IAPExperienceParent.Foundation)
local Accordion = Foundation.Accordion
local View = Foundation.View
local Divider = Foundation.Divider
local formatNumber = require(IAPExperience.Utility.formatNumber)

local LocalizationService = game:GetService("LocalizationService")
local useLocalization = require(IAPExperienceParent.Localization).Hooks.useLocalization
local useRobuxText = require(IAPExperience.Generic.Hooks.useRobuxText)
local useDiscountAccordionConfig = require(IAPExperience.Generic.Hooks.useDiscountAccordionConfig)

local DiscountType = require(IAPExperience.ProductPurchase.PricingTypes).DiscountType
local DiscountRow = require(IAPExperience.Generic.DiscountRow)
local PriceLineItem = require(IAPExperience.Generic.PriceLineItem)

local robuxIcon = utf8.char(57346)

local function DiscountSummary(tbl1)
    local itemPrice = tbl1.itemPrice
    local robloxLocaleId = LocalizationService.RobloxLocaleId

    local discounts = itemPrice.discounts
    local amount = useRobuxText(itemPrice.basePriceInRobux)
    local var1 = useRobuxText(itemPrice.priceInRobux)

    local var3, var4 = React.useMemo(function()
        local num1 = 0
        local tbl2 = ({})
        for i, discount in ipairs(discounts) do
            if not (discount.amountInRobux > 0) then
                continue
            end

            num1 += discount.amountInRobux
            local str2 = "DiscountRow_" .. tostring(i)
            tbl2[str2] = React.createElement(
                DiscountRow,
                {
                    discount = discount,
                    label = discount.localizedDiscountAttribution,
                    LayoutOrder = i + 1
                }
            )
        end
        return num1, tbl2
    end, { discounts })

    local var5 = useLocalization({
        Subtotal = "IAPExperience.PurchasePrompt.Label.Subtotal",
        Total = "IAPExperience.PurchasePrompt.Label.Total",
        BlackbirdSummary = {
            "IAPExperience.PurchasePrompt.Label.BlackbirdSummary",
            robuxIcon = robuxIcon,
            savingsAmount = formatNumber(robloxLocaleId, var3)
        }
    })

    local hasSubscriptionDiscount = React.useMemo(function()
        for _, discount in ipairs(discounts) do
            if discount.type == DiscountType.BlackbirdSubscription or discount.type == DiscountType.RobloxPlusSubscription then
                return true
            end
        end
        return false
    end, { discounts })

    local var7 = useDiscountAccordionConfig({
        itemPrice = itemPrice,
        hasSubscriptionDiscount = hasSubscriptionDiscount,
        blackbirdSummaryText = var5.BlackbirdSummary,
        savingsSummary = tbl1.savingsSummary
    })
    local showAccordion = var7.showAccordion
    local accordionHeaderText = var7.accordionHeaderText
    local accordionLeadingIcon = var7.accordionLeadingIcon

    local var8 = React.useMemo(function()
        local tbl2 = {
            SubtotalRow = React.createElement(PriceLineItem, { label = var5.Subtotal, amount = amount, LayoutOrder = 1 })
        }

        for k, value in pairs(var4) do
            tbl2[k] = value
        end
        return tbl2
    end, { var5.Subtotal, amount, var4 })

    if not showAccordion then
        return nil
    end

    return React.createElement(View, {
        tag = "size-full-0 auto-y padding-x-small stroke-default radius-medium"
    }, {
        AccordionContent = React.createElement(Accordion.Root, {
            width = UDim.new(1, 0),
            size = "Small"
        }, {
            SavingsItem = React.createElement(
                Accordion.Item,
                {
                    leadingIcon = accordionLeadingIcon,
                    text = accordionHeaderText,
                    id = "discount",
                    isExpanded = false,
                    hasDivider = false,
                    LayoutOrder = 1
                },
                React.createElement(View, { tag = "col gap-xsmall size-full-0 auto-y" }, {
                    BreakdownSection = React.createElement(View, { LayoutOrder = 1, tag = "col gap-xsmall size-full-0 auto-y padding-y-xsmall" }, var8),
                    BreakdownDivider = React.createElement(Divider, { LayoutOrder = 2 }),
                    TotalRow = React.createElement(PriceLineItem, {
                        label = var5.Total,
                        amount = var1,
                        textStyle = "text-caption-medium",
                        tag = "row size-full-0 auto-y align-y-center padding-x-xsmall padding-top-small",
                        LayoutOrder = 3
                    })
                })
            )
        })
    })
end

return DiscountSummary
