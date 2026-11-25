-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:20:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local PurchaseError = require(scriptParentParent.Enums.PurchaseError)
local Promise = require(scriptParentParent.Promise)
local _LuauPolyfill = require(scriptParentParent.Parent.LuauPolyfill)

local FFlagRefreshPriceOnRetryAfterUpsell = require(scriptParentParent.Flags.FFlagRefreshPriceOnRetryAfterUpsell)

local FFlagEnableFetchCartPricingDuringInExperience = require(scriptParentParent.Parent.SharedFlags).FFlagEnableFetchCartPricingDuringInExperience
local getCatalogItemDetails = require(scriptParentParent.Network.getCatalogItemDetails)
local getResellers = require(scriptParentParent.Network.getResellers)
local resolveRefreshedExpectedPrice = require(scriptParentParent.Utils.resolveRefreshedExpectedPrice)
local FFlagFixTimedOptionRefresh = require(scriptParentParent.Flags.FFlagFixTimedOptionRefresh)
local resolveRefreshedProductInfo = require(scriptParentParent.Utils.resolveRefreshedProductInfo)

local function convertDiscountInfoToPriceDiscountDetails(discountInformation)
    if not discountInformation or type(discountInformation.discounts) ~= "table" then
        return nil
    end
    local result = {}
    for _, discount in ipairs(discountInformation.discounts) do
        table.insert(result, {
            Type = discount.discountCampaign,
            AmountInRobux = discount.robuxDiscountAmount,
            Percent = discount.robuxDiscountPercentage
        })
    end
    return result
end

local function normalizeBundleFields(arg1)
    if not arg1.UserBasePriceInRobux then
        local discountInformation = arg1.discountInformation
        local basePriceInRobux = arg1.BasePriceInRobux

        if not basePriceInRobux then
            basePriceInRobux = (if discountInformation then discountInformation.originalPrice else nil) or arg1.PriceInRobux
            basePriceInRobux = basePriceInRobux or (if arg1.product then arg1.product.priceInRobux else nil) or 0
        end

        arg1.UserBasePriceInRobux = basePriceInRobux
    end

    if not arg1.PriceDiscountDetails and arg1.discountInformation then
        arg1.PriceDiscountDetails = convertDiscountInfoToPriceDiscountDetails(arg1.discountInformation)
    end

    return arg1
end

local function getBundleDetails(arg1, arg2, tbl1, func1: ((...any) -> (...any))?)
    local bundleDetails = arg1.getBundleDetails(arg2):andThen(function(arg3)
        if not (FFlagEnableFetchCartPricingDuringInExperience
            and arg3.collectibleItemDetail
            and arg3.collectibleItemDetail.collectibleItemId
            and func1) then
            return Promise.resolve((normalizeBundleFields(arg3)))
        end

        return func1(arg3.collectibleItemDetail.collectibleItemId):andThen(function()
            return (normalizeBundleFields(arg3))
        end):catch(function()
            return (normalizeBundleFields(arg3))
        end)
    end):catch(function(_)
        return Promise.reject(PurchaseError.UnknownFailure)
    end)

    if not (FFlagRefreshPriceOnRetryAfterUpsell and tbl1) then
        return bundleDetails
    end

    local collectibleItemId = tbl1.collectibleItemId
    local collectibleItemInstanceId = tbl1.collectibleItemInstanceId

    local all = Promise.all

    local tbl2 = {
        catalogItemDetails = getCatalogItemDetails(arg1, arg2, "bundle"):catch(function()
            return nil
        end),
        resellersData = if collectibleItemInstanceId and collectibleItemInstanceId ~= "" and collectibleItemId and collectibleItemId ~= "" then getResellers(arg1, collectibleItemId, 10):catch(function()
            return nil
        end) else Promise.resolve(nil)
    }

    local refreshedExpectedPrice = all(tbl2):andThen(function(arg3)
        if FFlagFixTimedOptionRefresh then
            return resolveRefreshedProductInfo(
                arg3.catalogItemDetails,
                arg3.resellersData,
                collectibleItemInstanceId,
                tbl1.timedOptionDays
            )
        end
        return (resolveRefreshedExpectedPrice(
            arg3.catalogItemDetails,
            arg3.resellersData,
            collectibleItemInstanceId,
            tbl1.timedOptionDays
        ))
    end)

    return Promise.all({ bundleDetails = bundleDetails, refreshedExpectedPrice = refreshedExpectedPrice }):andThen(function(arg3)
        local bundleDetails = arg3.bundleDetails
        if FFlagFixTimedOptionRefresh then
            local refreshedExpectedPrice = arg3.refreshedExpectedPrice
            if refreshedExpectedPrice ~= nil then
                for k, value in pairs(refreshedExpectedPrice) do
                    bundleDetails[k] = value
                end

                return bundleDetails
            end
        else
            bundleDetails.refreshedExpectedPrice = arg3.refreshedExpectedPrice
        end
        return bundleDetails
    end)
end

return getBundleDetails
