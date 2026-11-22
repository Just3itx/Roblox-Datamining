-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:10:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local IconName = require(scriptParentParentParentParent.Foundation).Enums.IconName

local _PricingTypes = require(scriptParentParentParent.ProductPurchase.PricingTypes)

local function useDiscountAccordionConfig(tbl1)
    local itemPrice = tbl1.itemPrice
    local hasSubscriptionDiscount = tbl1.hasSubscriptionDiscount
    local blackbirdSummaryText = tbl1.blackbirdSummaryText
    local savingsSummary = tbl1.savingsSummary
    local showAccordion = itemPrice.basePriceInRobux > itemPrice.priceInRobux and (hasSubscriptionDiscount or #itemPrice.discounts >= 2)

    local accordionHeaderText = React.useMemo(function()
        return if savingsSummary == nil or savingsSummary == "" then blackbirdSummaryText else savingsSummary
    end, { savingsSummary, blackbirdSummaryText })

    return {
        showAccordion = showAccordion,
        accordionHeaderText = accordionHeaderText,
        accordionLeadingIcon = if hasSubscriptionDiscount then IconName.RobloxPlus else IconName.Tag
    }
end

return useDiscountAccordionConfig
