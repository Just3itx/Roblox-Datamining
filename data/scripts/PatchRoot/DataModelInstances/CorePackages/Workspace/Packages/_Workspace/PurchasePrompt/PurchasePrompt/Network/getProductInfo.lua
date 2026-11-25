-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:20:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local PurchaseError = require(scriptParentParent.Enums.PurchaseError)
local Promise = require(scriptParentParent.Promise)
local _LuauPolyfill = require(scriptParentParent.Parent.LuauPolyfill)
local IAPExperience = require(scriptParentParent.Parent.IAPExperience)
local getAssetInfo = require(scriptParentParent.Network.getAssetInfo)
local getCreatorStoreProductInfo = require(scriptParentParent.Network.getCreatorStoreProductInfo)
local _Constants = require(scriptParentParent.Misc.Constants)
local isCreatorStoreAssetType = require(scriptParentParent.Utils.isCreatorStoreAssetType)
local getAssetInfoUtil = require(scriptParentParent.Utils.getAssetInfoUtil)
local getCreatorStoreProductInfoUtil = require(scriptParentParent.Utils.getCreatorStoreProductInfoUtil)
local getExperienceProductInfoUtil = require(scriptParentParent.Utils.getExperienceProductInfoUtil)
local getExperienceProductImageUrl = require(scriptParentParent.Utils.getExperienceProductImageUrl)
local FFlagExperiencePurchaseFallbackToGameIcon = require(scriptParentParent.Flags.FFlagExperiencePurchaseFallbackToGameIcon)
local handleLooksProductInfoResult = require(scriptParentParent.Utils.handleLooksProductInfoResult)
local ProductTypeEnum = require(scriptParentParent.types).ProductTypeEnum

local FFlagEnableFetchCartPricingDuringInExperience = require(scriptParentParent.Parent.SharedFlags).FFlagEnableFetchCartPricingDuringInExperience

local FFlagEnableUnifiedPurchaseFlowForDevSubs = require(scriptParentParent.Parent.SharedFlags).FFlagEnableUnifiedPurchaseFlowForDevSubs

local FFlagUnifiedPurchaseSupportRefetchingLooksAfterUpsell = require(scriptParentParent.Flags.FFlagUnifiedPurchaseSupportRefetchingLooksAfterUpsell)

local GetFFlagDiscountInfoForSubscriptionPurchaseModalLua = require(scriptParentParent.Parent.SharedFlags).GetFFlagDiscountInfoForSubscriptionPurchaseModalLua

local FFlagLuaAppsEnablePromptVIPServerPurchase = require(scriptParentParent.Parent.SharedFlags).FFlagLuaAppsEnablePromptVIPServerPurchase
local FFlagRefreshPriceOnRetryAfterUpsell = require(scriptParentParent.Flags.FFlagRefreshPriceOnRetryAfterUpsell)
local FFlagRefreshLookPriceOnRetryAfterUpsell = require(scriptParentParent.Flags.FFlagRefreshLookPriceOnRetryAfterUpsell)
local getCatalogItemDetails = require(scriptParentParent.Network.getCatalogItemDetails)
local getResellers = require(scriptParentParent.Network.getResellers)
local getUniversePrivateServerSettings = require(scriptParentParent.Network.getUniversePrivateServerSettings)
local resolveRefreshedExpectedPrice = require(scriptParentParent.Utils.resolveRefreshedExpectedPrice)
local FFlagFixTimedOptionRefresh = require(scriptParentParent.Flags.FFlagFixTimedOptionRefresh)
local resolveRefreshedProductInfo = require(scriptParentParent.Utils.resolveRefreshedProductInfo)

local function fetchRefreshedPrice(arg1, arg2, str1: string, tbl1)
    local collectibleItemId = tbl1.collectibleItemId
    local collectibleItemInstanceId = tbl1.collectibleItemInstanceId
    local all = Promise.all

    local tbl2 = {
        catalogItemDetails = getCatalogItemDetails(arg1, arg2, str1):catch(function()
            return nil
        end),
        resellersData = if collectibleItemInstanceId and collectibleItemInstanceId ~= "" and collectibleItemId and collectibleItemId ~= "" then getResellers(arg1, collectibleItemId, 10):catch(function()
            return nil
        end) else Promise.resolve(nil)
    }

    return all(tbl2):andThen(function(arg3)
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
end

local function getProductInfo(arg1, arg2, arg3, arg4, tbl1, func1: ((...any) -> (...any))?)
    if arg3 == Enum.InfoType.Asset then
        local productInfo = getAssetInfo(arg1, arg2):andThen(function(arg5)
            local asset = nil
            if arg5 and arg5.data and arg5.data[1] then
                if not getAssetInfoUtil.isAssetValid(arg5.data[1]) then
                    return Promise.reject(PurchaseError.UnknownFailureNoItemName)
                end
                asset = getAssetInfoUtil.fromAsset(arg5.data[1])
            end
            local type = asset and asset.type or ""

            if isCreatorStoreAssetType(type) then
                return getCreatorStoreProductInfo(arg1, arg2, type):andThen(function(arg6)
                    local product = getCreatorStoreProductInfoUtil.fromProduct(arg6)
                    return {
                        AssetId = asset.id,
                        AssetType = type,
                        AssetTypeId = asset.typeId,
                        Creator = {
                            CreatorTargetId = asset.creator.targetId,
                            CreatorType = asset.creator.type
                        },
                        Description = asset.description,
                        IsFiatPriced = product.basePrice and product.basePrice.quantity and product.basePrice.quantity.significand ~= 0,
                        IsForSale = product.purchasable,
                        IsPublicDomain = asset.isPublicDomainEnabled,
                        Name = asset.name,
                        PriceInRobux = 0,
                        ProductId = asset.id
                    }
                end)
            elseif FFlagEnableFetchCartPricingDuringInExperience then
                return arg1.getProductInfo(arg2, arg3):andThen(function(arg6)
                    if not (arg6.CollectibleItemId and func1) then
                        return arg6
                    end

                    return func1(arg6.CollectibleItemId):andThen(function()
                        return arg6
                    end):catch(function()
                        return arg6
                    end)
                end):catch(function(_)
                    return Promise.reject(PurchaseError.UnknownFailureNoItemName)
                end)
            end
            return arg1.getProductInfo(arg2, arg3):catch(function(_)
                return Promise.reject(PurchaseError.UnknownFailureNoItemName)
            end)
        end):catch(function(_)
            return Promise.reject(PurchaseError.UnknownFailureNoItemName)
        end)

        if FFlagRefreshPriceOnRetryAfterUpsell and tbl1 then
            return Promise.all({ productInfo = productInfo, refreshedPrice = fetchRefreshedPrice(arg1, arg2, "asset", tbl1) }):andThen(
                function(arg5)
                    local productInfo = arg5.productInfo
                    if FFlagFixTimedOptionRefresh then
                        local refreshedPrice = arg5.refreshedPrice
                        if refreshedPrice ~= nil then
                            for k, value in pairs(refreshedPrice) do
                                productInfo[k] = value
                            end

                            return productInfo
                        end
                    elseif arg5.refreshedPrice ~= nil then
                        productInfo.refreshedExpectedPrice = arg5.refreshedPrice
                    end

                    return productInfo
                end
            )
        end
        return productInfo
    elseif arg3 == ProductTypeEnum.Experience then
        return arg1.getExperienceProductInfo(arg2):andThen(function(arg5)
            if not (arg5 and arg5.data and arg5.data[1] and arg4.name and (FFlagExperiencePurchaseFallbackToGameIcon or arg4.imageUrl)) then
                return Promise.reject(PurchaseError.UnknownFailureNoItemName)
            end

            local product = getExperienceProductInfoUtil.fromProduct(arg5.data[1])
            local imageUrl = arg4.imageUrl
            if FFlagExperiencePurchaseFallbackToGameIcon then
                imageUrl = getExperienceProductImageUrl(arg4.imageUrl, arg2)
            end
            return {
                IsForSale = product.isForSale,
                PriceInRobux = product.price,
                ProductId = product.productId,
                SellerId = product.sellerId,
                Name = arg4.name,
                ImageUrl = imageUrl
            }
        end):catch(function(_)
            return Promise.reject(PurchaseError.UnknownFailureNoItemName)
        end)
    elseif arg3 == ProductTypeEnum.Look then
        if FFlagUnifiedPurchaseSupportRefetchingLooksAfterUpsell then
            return arg1.GetLookDetailsV2ProductInfo(arg2):andThen(function(arg5)
                local var1 = handleLooksProductInfoResult(arg5, arg4)
                if not var1 then
                    return Promise.reject(PurchaseError.UnknownFailureNoItemName)
                end
                if FFlagRefreshLookPriceOnRetryAfterUpsell then
                    var1.refreshedExpectedPrice = var1.PriceInRobux
                end
                return var1
            end):catch(function()
                return Promise.reject(PurchaseError.UnknownFailureNoItemName)
            end)
        end
        return Promise.resolve({ PriceInRobux = arg4.expectedPrice, IsForSale = true, Name = "Looks" })
    elseif FFlagEnableUnifiedPurchaseFlowForDevSubs and arg3 == ProductTypeEnum.DeveloperSubscription then
        return arg1.getSubscriptionProductInfo(arg2):andThen(function(arg5)
            if not (arg5 and arg5.Name) then
                return Promise.reject(PurchaseError.UnknownFailureNoItemName)
            end

            local fFlagDiscountInfoForSubscriptionPurchaseModalLua = GetFFlagDiscountInfoForSubscriptionPurchaseModalLua()
            local userBasePriceInRobux = if fFlagDiscountInfoForSubscriptionPurchaseModalLua then arg5.UserBasePriceInRobux else nil
            local priceDiscountDetails = if fFlagDiscountInfoForSubscriptionPurchaseModalLua then arg5.PriceDiscountDetails else nil
            return {
                Name = arg5.Name,
                Description = arg5.Description,
                IconImageAssetId = arg5.IconImageAssetId,
                IsForSale = arg5.IsForSale,
                DisplayPrice = arg5.DisplayPrice,
                SubscriptionProviderName = arg5.SubscriptionProviderName,
                PriceInRobux = arg5.PriceInRobux,
                PriceTier = arg5.PriceTier,
                ProductType = ProductTypeEnum.DeveloperSubscription,
                UserBasePriceInRobux = userBasePriceInRobux,
                PriceDiscountDetails = priceDiscountDetails
            }
        end):catch(function(_)
            return Promise.reject(PurchaseError.UnknownFailureNoItemName)
        end)
    elseif FFlagLuaAppsEnablePromptVIPServerPurchase and arg3 == ProductTypeEnum.VIPServer then
        return getUniversePrivateServerSettings(arg1, arg2):andThen(function(arg5)
            local privateServerData = arg5.privateServerData
            local num1 = 0
            for _, value in privateServerData.discounts or {} do
                if value.source == "RobloxSubscription" and value.robux > 0 then
                    num1 += value.robux
                end
            end

            local price = privateServerData.price or 0
            local isFreeWithRobloxPlus = price == 0 and num1 > 0
            local var1 = nil
            local var2 = nil
            if num1 > 0 then
                local var3 = price + num1
                var1 = var3
                var2 = {{
                    Type = IAPExperience.DiscountType.RobloxPlusSubscription,
                    AmountInRobux = num1,
                    Percent = math.floor(num1 * 100 / var3)
                }}
            end

            return arg1.getProductInfo(arg5.rootPlaceId, Enum.InfoType.Asset):andThen(function(arg6)
                return {
                    IsForSale = true,
                    PriceInRobux = privateServerData.price,
                    UserBasePriceInRobux = var1,
                    PriceDiscountDetails = var2,
                    ProductId = privateServerData.privateServerProductId,
                    Name = arg6.Name,
                    ImageUrl = getExperienceProductImageUrl(nil, arg2),
                    IsFreeWithRobloxPlus = isFreeWithRobloxPlus,
                    IsMonthlyPrice = true,
                    Creator = {
                        CreatorType = if game.CreatorType == Enum.CreatorType.Group then "Group" else "User",
                        CreatorTargetId = game.CreatorId
                    }
                }
            end):catch(function()
                return Promise.reject(PurchaseError.UnknownFailureNoItemName)
            end)
        end)
    else
        return arg1.getProductInfo(arg2, arg3):catch(function(_)
            return Promise.reject(PurchaseError.UnknownFailureNoItemName)
        end)
    end
end

return getProductInfo
