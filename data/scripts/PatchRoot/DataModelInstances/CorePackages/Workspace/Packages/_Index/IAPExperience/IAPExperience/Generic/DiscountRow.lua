-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:01:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local IAPExperience = script:FindFirstAncestor("IAPExperience")
local IAPExperienceParent = IAPExperience.Parent

local React = require(IAPExperienceParent.React)

local Foundation = require(IAPExperienceParent.Foundation)
local getIconRichText = Foundation.Utility.getIconRichText
local IconName = Foundation.Enums.IconName

local formatNumber = require(IAPExperience.Utility.formatNumber)

local LocalizationService = game:GetService("LocalizationService")
local useLocalization = require(IAPExperienceParent.Localization).Hooks.useLocalization
local PriceLineItem = require(IAPExperience.Generic.PriceLineItem)

local DiscountType = require(IAPExperience.ProductPurchase.PricingTypes).DiscountType

local iconRichText = getIconRichText(IconName.Robux)

local function resolveLabel(label: string?, discountLabel: string): string -- Luacid: Inlined by compiler; 2 call sites recovered
    return if label == nil or label == "" then discountLabel else label
end

local function RobloxSubscriptionDiscountRow(tbl1)
    local discount = tbl1.discount
    local robloxLocaleId = LocalizationService.RobloxLocaleId

    local amount = React.useMemo(function(): string
        return string.format("- %s %s", iconRichText, formatNumber(robloxLocaleId, discount.amountInRobux))
    end, { robloxLocaleId, discount.amountInRobux })
    local bool1 = discount.percent > 0
    local var2 = useLocalization({
        discountLabel = bool1 and {
            "IAPExperience.PurchasePrompt.Label.BlackbirdDiscountEligibleItems",
            discountPercentage = discount.percent
        }
            or "IAPExperience.PurchasePrompt.Label.BlackbirdDiscountNoPercent"
    })

    return React.createElement(
        PriceLineItem,
        {
            label = resolveLabel(tbl1.label, var2.discountLabel),
            amount = amount,
            LayoutOrder = tbl1.LayoutOrder
        }
    )
end

local function GenericDiscountRow(tbl1)
    local discount = tbl1.discount
    local robloxLocaleId = LocalizationService.RobloxLocaleId

    local amount = React.useMemo(function(): string
        return string.format("- %s %s", iconRichText, formatNumber(robloxLocaleId, discount.amountInRobux))
    end, { robloxLocaleId, discount.amountInRobux })
    local bool1 = discount.percent > 0
    local var2 = useLocalization({
        discountLabel = bool1 and {
            "IAPExperience.PurchasePrompt.Label.GenericDiscount",
            discountPercentage = discount.percent
        }
            or "IAPExperience.PurchasePrompt.Label.GenericDiscountNoPercent"
    })

    return React.createElement(
        PriceLineItem,
        {
            label = resolveLabel(tbl1.label, var2.discountLabel),
            amount = amount,
            LayoutOrder = tbl1.LayoutOrder
        }
    )
end
local tbl1 = {
    [DiscountType.BlackbirdSubscription] = RobloxSubscriptionDiscountRow,
    [DiscountType.RobloxPlusSubscription] = RobloxSubscriptionDiscountRow
}

local function DiscountRow(tbl2)
    local var1 = tbl1[tbl2.discount.type] or GenericDiscountRow
    return React.createElement(var1, tbl2)
end

return DiscountRow
