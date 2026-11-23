-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local _DeveloperProduct = require(BuildExperienceParent.DataHydration.DeveloperProduct)
local DeveloperSubscription = require(BuildExperienceParent.DataHydration.DeveloperSubscription)
local GamePassConfig = require(BuildExperienceParent.DataHydration.GamePassConfig)

local FFlagBuildExperienceMonetizationKindRegionalPricing = require(BuildExperience.Flags.FFlagBuildExperienceMonetizationKindRegionalPricing)
local _MonetizationPageView = require(script.Parent.MonetizationPageView)
local mapDeveloperProductsToMonetizationProducts = require(script.Parent.mapDeveloperProductsToMonetizationProducts)

local CurrencyType = DeveloperSubscription.CurrencyType
local ProductStatusType = DeveloperSubscription.ProductStatusType

local function identity(arg1, str1: string): string -- Luacid: unused: defined but never referenced
    return `{arg1}:{str1}`
end

local function robuxPrice(priceInRobux: number?, str1: string): (string, boolean) -- Luacid: Inlined by compiler; 2 call sites recovered
    if priceInRobux ~= nil then
        str1 = tostring(priceInRobux)
    end

    return str1, priceInRobux ~= nil
end

local function mapGamePasses(gamePasses, tbl1, tbl2)
    if gamePasses == nil then
        return
    end
    for _, value in gamePasses.gamePasses do
        local id = tostring(value.gamePassId)
        local defaultPriceInRobux = if value.priceInformation == nil then nil else value.priceInformation.defaultPriceInRobux
        local price, showRobuxIcon = robuxPrice(defaultPriceInRobux, tbl1.priceUnavailable)
        table.insert(tbl2, {
            id = id,
            identity = `GamePass:{id}`,
            productKind = "GamePass",
            canManage = false,
            name = value.name or tbl1.gamePassType,
            price = price,
            priceInRobux = defaultPriceInRobux,
            showRobuxIcon = showRobuxIcon,
            isForSale = value.isForSale == true,
            isManagedPricingEnabled = if FFlagBuildExperienceMonetizationKindRegionalPricing then GamePassConfig.isManagedPricingEnabled(value) == true else nil,
            isArchived = value.isArchived,
            kind = tbl1.gamePassType,
            saleStatus = if value.isForSale == true then tbl1.onSale else tbl1.offSale,
            image = if value.iconAssetId == nil then nil else `rbxassetid://{value.iconAssetId}`,
            description = value.description or ""
        })
    end
end

local function mapSubscriptions(subscriptions, tbl1, tbl2)
    if subscriptions == nil then
        return
    end
    for _, developerSubscription in subscriptions.developerSubscriptions do
        local priceInRobux = if developerSubscription.currencyType == CurrencyType.Robux then developerSubscription.priceInRobux else nil
        local price, showRobuxIcon = robuxPrice(priceInRobux, tbl1.priceUnavailable)
        local isForSale = if developerSubscription.productStatusType == nil then nil else developerSubscription.productStatusType == ProductStatusType.Active
        table.insert(tbl2, {
            id = developerSubscription.id,
            identity = `Subscription:{developerSubscription.id}`,
            productKind = "Subscription",
            canManage = false,
            name = developerSubscription.name or tbl1.subscriptionType,
            price = price,
            priceInRobux = priceInRobux,
            showRobuxIcon = showRobuxIcon,
            isForSale = isForSale,
            isImmutable = developerSubscription.productStatusType == ProductStatusType.ToBeActivated
                or developerSubscription.productStatusType == ProductStatusType.ToBeDeactivated,
            kind = tbl1.subscriptionType,
            saleStatus = if isForSale == nil then nil elseif isForSale then tbl1.onSale else tbl1.offSale,
            image = if developerSubscription.imageAssetId == nil then nil else `rbxassetid://{developerSubscription.imageAssetId}`,
            description = developerSubscription.description or ""
        })
    end
end

local function mapMonetizationCatalog(tbl1, tbl2)
    local var1 = mapDeveloperProductsToMonetizationProducts(tbl1.developerProducts, {
        formatDefaultProductName = tbl2.formatDefaultProductName,
        priceUnavailable = tbl2.priceUnavailable,
        productType = tbl2.developerProductType,
        onSale = tbl2.onSale,
        offSale = tbl2.offSale
    })
    for _, value in var1 do
        value.identity = `DeveloperProduct:{value.id}`
        value.productKind = "DeveloperProduct"
        value.canManage = true
        value.showRobuxIcon = value.priceInRobux ~= nil
    end
    mapGamePasses(tbl1.gamePasses, tbl2, var1)
    mapSubscriptions(tbl1.subscriptions, tbl2, var1)
    return var1
end

return mapMonetizationCatalog
