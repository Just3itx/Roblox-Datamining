-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:01:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local _DeveloperProduct = require(BuildExperienceParent.DataHydration.DeveloperProduct)

local LocalizationStrings = require(BuildExperience.LocalizationStrings)
local _MonetizationPageView = require(script.Parent.MonetizationPageView)

local tbl1 = {
    formatDefaultProductName = function(num1: number)
        return (string.gsub(LocalizationStrings.MONETIZATION_DEFAULT_PRODUCT_NAME, "{PRODUCT_ID}", tostring(num1)))
    end,
    priceUnavailable = LocalizationStrings.MONETIZATION_PRICE_UNAVAILABLE,
    productType = LocalizationStrings.AGENT_DEV_PRODUCT_TITLE,
    onSale = LocalizationStrings.MONETIZATION_ON_SALE,
    offSale = LocalizationStrings.MONETIZATION_OFF_SALE
}

local function hasEnabledFeature(arg1, str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    local priceInformation = arg1.priceInformation
    if priceInformation == nil then
        return false
    end
    local enabledFeatures = priceInformation.enabledFeatures
    if enabledFeatures == nil then
        return false
    end
    for _, value in enabledFeatures do
        if value == str1 then
            return true
        end
    end
    return false
end

local function mapProduct(arg1, tbl2)
    local defaultPriceInRobux = if arg1.priceInformation == nil then nil else arg1.priceInformation.defaultPriceInRobux
    return {
        id = tostring(arg1.productId),
        name = arg1.name or tbl2.formatDefaultProductName(arg1.productId),
        price = if defaultPriceInRobux ~= nil then tostring(defaultPriceInRobux) else tbl2.priceUnavailable,
        priceInRobux = defaultPriceInRobux,
        isForSale = arg1.isForSale == true,
        isManagedPricingEnabled = arg1.isManagedPricingEnabled,
        isArchived = arg1.isArchived,
        isImmutable = arg1.isImmutable,
        isInActivePriceOptimizationExperiment = hasEnabledFeature(arg1, "PriceOptimization"),
        kind = tbl2.productType,
        saleStatus = if arg1.isForSale == true then tbl2.onSale else tbl2.offSale,
        image = if arg1.iconImageAssetId == nil then nil else `rbxassetid://{arg1.iconImageAssetId}`,
        description = arg1.description or ""
    }
end

local function mapDeveloperProductsToMonetizationProducts(arg1, tbl2)
    local result = {}
    if arg1 == nil then
        return result
    end

    for _, developerProduct in arg1.developerProducts do
        table.insert(result, (mapProduct(developerProduct, tbl2 or tbl1)))
    end

    return result
end

return mapDeveloperProductsToMonetizationProducts
