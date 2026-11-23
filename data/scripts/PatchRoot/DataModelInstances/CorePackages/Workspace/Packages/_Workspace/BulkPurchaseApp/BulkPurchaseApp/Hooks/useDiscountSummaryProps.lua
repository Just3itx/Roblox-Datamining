-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseApp = script:FindFirstAncestor("BulkPurchaseApp")
local BulkPurchaseAppParent = BulkPurchaseApp.Parent
local React = require(BulkPurchaseAppParent.React)

local DiscountType = require(BulkPurchaseAppParent.IAPExperience).DiscountType

local _Types = require(BulkPurchaseApp.Store.Types)

local FFlagAXAddOffersToBulkPurchase = require(BulkPurchaseApp.Flags.FFlagAXAddOffersToBulkPurchase)

local function useDiscountSummaryProps(arg1, priceInRobux: number, str1: string?)
    return React.useMemo(function(): {itemPrice: {basePriceInRobux: any, discounts: {[any]: any}, priceInRobux: number}, savingsSummary: number}?
        if not arg1 then
            return nil
        end
        local discounts = {}
        for _, discount in arg1.discounts do
            table.insert(discounts, {
                type = DiscountType[discount.discountCampaign] or DiscountType.Uncategorized,
                amountInRobux = discount.robuxDiscountAmount or 0,
                percent = discount.robuxDiscountPercentage or 0,
                localizedDiscountAttribution = discount.localizedDiscountAttribution
            })
        end
        return {
            itemPrice = {
                basePriceInRobux = arg1.originalPrice,
                priceInRobux = priceInRobux,
                discounts = discounts
            },
            savingsSummary = if FFlagAXAddOffersToBulkPurchase then str1 else nil
        }
    end, { arg1, priceInRobux, str1 })
end

return useDiscountSummaryProps
