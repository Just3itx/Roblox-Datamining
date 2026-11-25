-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:30:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent

local Rodux = require(PurchasePromptParent.PurchasePromptDeps).Rodux

local Constants = require(PurchasePrompt.Misc.Constants)
local CompleteRequest = require(PurchasePrompt.Actions.CompleteRequest)
local ProductInfoReceived = require(PurchasePrompt.Actions.ProductInfoReceived)
local BundleProductInfoReceived = require(PurchasePrompt.Actions.BundleProductInfoReceived)
local ItemType = require(PurchasePrompt.Enums.ItemType)
local getPreviewImageUrl = require(PurchasePrompt.getPreviewImageUrl)

local FFlagEnableUnifiedPurchaseFlowForDevSubs = require(PurchasePrompt.Parent.SharedFlags).FFlagEnableUnifiedPurchaseFlowForDevSubs

local FFlagUnifiedPurchaseOptimizeTTIMarketplace = require(PurchasePrompt.Parent.SharedFlags).FFlagUnifiedPurchaseOptimizeTTIMarketplace

local GetFFlagFixBundlePromptThumbnail = require(PurchasePrompt.Flags.GetFFlagFixBundlePromptThumbnail)
local GetFFlagEnableCreatorStorePurchasingCutover = require(PurchasePrompt.Flags.GetFFlagEnableCreatorStorePurchasingCutover)
local ProductTypeEnum = require(PurchasePrompt.types).ProductTypeEnum
local normalizePriceDiscountDetails = require(PurchasePrompt.Utils.normalizePriceDiscountDetails)

local FFlagPurchasePromptFetchCartPricingForLooks = require(PurchasePrompt.Parent.SharedFlags).FFlagPurchasePromptFetchCartPricingForLooks

local FFlagLuaAppsEnablePromptVIPServerPurchase = require(PurchasePrompt.Parent.SharedFlags).FFlagLuaAppsEnablePromptVIPServerPurchase

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[ProductInfoReceived.name] = function(_, arg1)
    local productInfo = arg1.productInfo

    local str1 = ""
    local str2 = ""
    local bool1 = if FFlagUnifiedPurchaseOptimizeTTIMarketplace then productInfo.ProductType == Constants.ProductType.Asset or productInfo.ProductType == Constants.ProductType.Bundle else nil

    if productInfo.ProductType == Constants.ProductType.CollectibleItem
        or FFlagUnifiedPurchaseOptimizeTTIMarketplace and bool1
    then
        str1 = productInfo.CollectibleItemId
        str2 = productInfo.CollectibleProductId
    end

    return {
        name = productInfo.DisplayName or productInfo.Name,
        description = productInfo.Description,
        basePrice = productInfo.UserBasePriceInRobux or productInfo.BasePriceInRobux or productInfo.PriceInRobux or 0,
        price = productInfo.PriceInRobux or 0,
        priceDiscountDetails = if normalizePriceDiscountDetails then normalizePriceDiscountDetails(productInfo.PriceDiscountDetails) else nil,
        savingsSummaryOverride = productInfo.SavingsSummaryOverride,
        premiumPrice = productInfo.PremiumPriceInRobux,
        imageUrl = getPreviewImageUrl(productInfo),
        assetTypeId = productInfo.AssetTypeId,
        assetType = if GetFFlagEnableCreatorStorePurchasingCutover() then productInfo.AssetType else nil,
        productId = productInfo.ProductId,
        productType = productInfo.ProductType,
        membershipTypeRequired = productInfo.MinimumMembershipLevel,
        itemType = productInfo.AssetTypeId,
        collectibleItemId = str1,
        collectibleItemIds = if FFlagPurchasePromptFetchCartPricingForLooks then productInfo.CollectibleItemIds else nil,
        cartPricingRequestedItems = if FFlagPurchasePromptFetchCartPricingForLooks then productInfo.CartPricingRequestedItems else nil,
        collectibleProductId = str2,
        productTargetId = if productInfo.TargetId then productInfo.TargetId else nil,
        displayPrice = if FFlagEnableUnifiedPurchaseFlowForDevSubs and productInfo.ProductType == ProductTypeEnum.DeveloperSubscription then productInfo.DisplayPrice else nil,
        isFreeWithRobloxPlus = if FFlagLuaAppsEnablePromptVIPServerPurchase then productInfo.IsFreeWithRobloxPlus else nil,
        isMonthlyPrice = if FFlagLuaAppsEnablePromptVIPServerPurchase then productInfo.IsMonthlyPrice else nil
    }
end

tbl1[BundleProductInfoReceived.name] = function(_, arg1)
    local bundleProductInfo = arg1.bundleProductInfo

    local id = nil
    for _, item in ipairs(bundleProductInfo.items) do
        if item.type ~= "UserOutfit" then
            continue
        end

        id = item.id
        if GetFFlagFixBundlePromptThumbnail() then
            break
        end
    end

    bundleProductInfo.costumeId = id
    bundleProductInfo.itemType = ItemType.Bundle

    local tbl2 = {
        name = 0,
        basePrice = 0,
        price = 0,
        priceDiscountDetails = 0,
        imageUrl = 0,
        assetTypeId = nil,
        productId = 0,
        membershipTypeRequired = nil,
        itemType = 0
    }
    local name = bundleProductInfo.name

    if not name then
        if FFlagUnifiedPurchaseOptimizeTTIMarketplace then
            name = bundleProductInfo.Name
        else
            name = nil
        end
    end

    tbl2.name = name

    tbl2.basePrice = bundleProductInfo.UserBasePriceInRobux or bundleProductInfo.BasePriceInRobux or bundleProductInfo.PriceInRobux or 0

    local priceInRobux = bundleProductInfo.product.priceInRobux
        or (if FFlagUnifiedPurchaseOptimizeTTIMarketplace then bundleProductInfo.PriceInRobux else nil)
        or 0
    tbl2.price = priceInRobux

    tbl2.priceDiscountDetails = if normalizePriceDiscountDetails then normalizePriceDiscountDetails(bundleProductInfo.PriceDiscountDetails) else nil

    tbl2.imageUrl = getPreviewImageUrl(bundleProductInfo)

    tbl2.productId = bundleProductInfo.product.id

    tbl2.itemType = bundleProductInfo.itemType
    return tbl2
end

tbl1[CompleteRequest.name] = function(_, _)
    return {}
end

return (createReducer({}, tbl1))
