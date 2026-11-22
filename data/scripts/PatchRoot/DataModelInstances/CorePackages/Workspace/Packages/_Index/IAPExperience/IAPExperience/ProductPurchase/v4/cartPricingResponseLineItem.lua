-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:20:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local IAPExperience = script:FindFirstAncestor("IAPExperience")
local decodeLuauUnicodeEscapes = require(IAPExperience.Utility.decodeLuauUnicodeEscapes)
local FFlagCartPricingSupportGameItemOffer = require(IAPExperience.Flags.FFlagCartPricingSupportGameItemOffer)

local DiscountType = require(script.Parent.Parent.PricingTypes).DiscountType

local tbl1 = { RobloxPlus = "ROBLOX_PLUS", MarketplaceOffer = "MARKETPLACE_OFFER", Offer = "OFFER" }

local function mapCartPricingDiscountType(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return if str1 == "ROBLOX_PLUS" then DiscountType.RobloxPlusSubscription else DiscountType.Uncategorized
end

local function isOfferDiscountType(arg1) -- Luacid: unused: defined but never referenced
    return arg1 == "MARKETPLACE_OFFER" or FFlagCartPricingSupportGameItemOffer and arg1 == "OFFER"
end

return {
    getCartLineSalePriceInRobux = function(tbl2)
        if type(tbl2) ~= "table" then
            return nil
        end
        local priceInRobux = tbl2.priceInRobux
        return if type(priceInRobux) == "number" and not (priceInRobux < 0) then priceInRobux else nil
    end,
    getCartLineRegularPriceInRobux = function(tbl2, num1: number)
        if type(tbl2) == "table" then
            local regularPriceInRobux = tbl2.regularPriceInRobux
            if type(regularPriceInRobux) == "number" and num1 <= regularPriceInRobux then
                return regularPriceInRobux
            end
        end
        return num1
    end,
    extractCartPricingMarketingOffers = function(tbl2)
        local result = {}
        if type(tbl2) ~= "table" then
            return result
        end
        local availableOffers = tbl2.availableOffers
        if type(availableOffers) ~= "table" then
            return result
        end
        for _, availableOffer in availableOffers do
            if type(availableOffer) ~= "table" then
                continue
            end

            local offerId = availableOffer.offerId
            local localizedDescription = availableOffer.localizedDescription
            if type(offerId) ~= "string" or offerId == "" or type(localizedDescription) ~= "string" or localizedDescription == "" then
                continue
            end

            local expirationTimeUtc = availableOffer.expirationTimeUtc
            local tbl3 = {
                offerId = offerId,
                localizedDescription = decodeLuauUnicodeEscapes(localizedDescription),
                selected = availableOffer.selected == true,
                expirationTimeUtc = 0
            }

            if type(expirationTimeUtc) ~= "string" or expirationTimeUtc == "" then
                expirationTimeUtc = nil
            end

            tbl3.expirationTimeUtc = expirationTimeUtc
            table.insert(result, tbl3)
        end

        return result
    end,
    extractDiscountRowsFromLineItems = function(tbl2)
        local result = {}
        if type(tbl2) ~= "table" then
            return result
        end
        for _, value in tbl2 do
            if type(value) ~= "table" then
                continue
            end

            local discountInformation = value.discountInformation
            if type(discountInformation) ~= "table" then
                continue
            end

            local discounts = discountInformation.discounts
            if type(discounts) ~= "table" then
                continue
            end

            for _, discount in discounts do
                if type(discount) ~= "table" then
                    continue
                end

                local robuxDiscountAmount = discount.robuxDiscountAmount
                local localizedDiscountAttribution = discount.localizedDiscountAttribution

                if type(robuxDiscountAmount) ~= "number"
                    or robuxDiscountAmount <= 0
                    or type(localizedDiscountAttribution) ~= "string"
                    or localizedDiscountAttribution == ""
                then
                    continue
                end

                table.insert(result, {
                    type = if discount.discountType == tbl1.RobloxPlus then mapCartPricingDiscountType("ROBLOX_PLUS") else DiscountType.Uncategorized,
                    amountInRobux = robuxDiscountAmount,
                    percent = 0,
                    localizedDiscountAttribution = decodeLuauUnicodeEscapes(localizedDiscountAttribution)
                })
            end
        end
        return result
    end,
    consolidateRobloxPlusDiscounts = require(IAPExperience.Parent.SharedFlags).FFlagPurchasePromptFetchCartPricingForLooks and function(tbl2) -- name: consolidateRobloxPlusDiscounts
        local result = {}
        local var1 = nil
        for _, value in tbl2 do
            if value.type ~= DiscountType.RobloxPlusSubscription then
                table.insert(result, value)
            elseif var1 == nil then
                table.insert(result, {
                    type = value.type,
                    amountInRobux = value.amountInRobux,
                    percent = value.percent,
                    localizedDiscountAttribution = value.localizedDiscountAttribution
                })
                var1 = #result
            else
                local var2 = result[var1]
                var2.amountInRobux += value.amountInRobux
            end
        end
        return result
    end or nil,
    computePriceWithoutOffersDiscounts = function(tbl2, num1: number)
        if type(tbl2) ~= "table" then
            return num1
        end
        for _, value in tbl2 do
            if type(value) ~= "table" then
                continue
            end

            local discountInformation = value.discountInformation
            if type(discountInformation) ~= "table" then
                continue
            end

            local discounts = discountInformation.discounts
            if type(discounts) ~= "table" then
                continue
            end

            for _, discount in discounts do
                if type(discount) ~= "table" then
                    continue
                end

                local discountType = discount.discountType

                if discountType ~= tbl1.MarketplaceOffer and (not FFlagCartPricingSupportGameItemOffer or discountType ~= tbl1.Offer) then
                    continue
                end

                local robuxDiscountAmount = discount.robuxDiscountAmount
                if type(robuxDiscountAmount) == "number" and robuxDiscountAmount > 0 then
                    num1 += robuxDiscountAmount
                end
            end
        end
        return num1
    end,
    extractCartPricingSavingsSummary = function(tbl2)
        if type(tbl2) ~= "table" then
            return nil
        end
        local savingsSummary = tbl2.savingsSummary
        if type(savingsSummary) ~= "string" or savingsSummary == "" then
            return nil
        end
        return decodeLuauUnicodeEscapes(savingsSummary)
    end
}
