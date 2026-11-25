-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:41:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local PurchasePromptParent = PurchasePrompt.Parent
local IAPExperience = require(PurchasePromptParent.IAPExperience)
local isEconomicRestrictionResponse = IAPExperience.Utility.isEconomicRestrictionResponse

local ErrorOccurred = require(PurchasePrompt.Actions.ErrorOccurred)
local SetEconomicRestrictionError = require(PurchasePrompt.Actions.SetEconomicRestrictionError)
local VIPServerCreated = require(PurchasePrompt.Actions.VIPServerCreated)
local PurchaseError = require(PurchasePrompt.Enums.PurchaseError)
local Network = require(PurchasePrompt.Services.Network)
local Analytics = require(PurchasePrompt.Services.Analytics)
local Thunk = require(PurchasePrompt.Thunk)
local Promise = require(PurchasePrompt.Promise)
local Constants = require(PurchasePrompt.Misc.Constants)
local _types = require(PurchasePrompt.types)
local ProductTypeEnum = require(PurchasePrompt.types).ProductTypeEnum
local completePurchase = require(script.Parent.completePurchase)
local handlePriceChangedError = require(PurchasePrompt.Utils.handlePriceChangedError)

local performDevProductEdpPurchase = require(PurchasePrompt.Network.performDevProductEdpPurchase)
local performExperiencePurchase = require(PurchasePrompt.Network.performExperiencePurchase)
local performLookPurchase = require(PurchasePrompt.Network.performLookPurchase)
local performDeveloperSubscriptionRobuxPurchase = require(PurchasePrompt.Network.performDeveloperSubscriptionRobuxPurchase)
local performDeveloperSubscriptionFiatPurchase = require(PurchasePrompt.Network.performDeveloperSubscriptionFiatPurchase)
local performVIPServerPurchase = require(PurchasePrompt.Network.performVIPServerPurchase)

local deriveSelectedOfferIdsFromCartPricing = require(PurchasePrompt.Utils.deriveSelectedOfferIdsFromCartPricing)
local applyCartPricingOffersToLineItems = require(PurchasePrompt.Utils.applyCartPricingOffersToLineItems)
local selectProductPrice = require(PurchasePrompt.Selectors.selectProductPrice)

local FFlagEnableUnifiedPurchaseFlowForDevSubs = require(PurchasePromptParent.SharedFlags).FFlagEnableUnifiedPurchaseFlowForDevSubs

local FFlagPurchasePromptFetchCartPricingForLooks = require(PurchasePromptParent.SharedFlags).FFlagPurchasePromptFetchCartPricingForLooks
local FFlagEnablePriceChangedErrorHandling = require(PurchasePrompt.Flags.FFlagEnablePriceChangedErrorHandling)
local FFlagEnableRequestLocationTypeForSduiPurchase = require(PurchasePrompt.Flags.FFlagEnableRequestLocationTypeForSduiPurchase)
local FFlagEnableSearchGameItemOwnershipUpdate = require(PurchasePromptParent.SharedFlags).FFlagEnableSearchGameItemOwnershipUpdate
local FFlagEnableEdpPreviewPurchaseSurface = require(PurchasePromptParent.SharedFlags).FFlagEnableEdpPreviewPurchaseSurface

local FFlagLuaAppsEnablePromptVIPServerPurchase = require(PurchasePromptParent.SharedFlags).FFlagLuaAppsEnablePromptVIPServerPurchase
local RobloxTranslator = require(PurchasePromptParent.RobloxTranslator)

local ProductPurchaseSurface = require(PurchasePromptParent.PurchasePromptLite).Enums.ProductPurchaseSurface

local tbl1 = {
    [ProductPurchaseSurface.EDP] = "ExperienceDetailPage",
    [ProductPurchaseSurface.EDPPreview] = if FFlagEnableEdpPreviewPurchaseSurface then "ExperienceDetailPagePreview" else nil,
    [ProductPurchaseSurface.HomePageGameItemShop] = "HomePageGameItemShop",
    [ProductPurchaseSurface.SearchPageGameItemShop] = if FFlagEnableSearchGameItemOwnershipUpdate then "SearchPageGameItemShop" else nil
}

local function decodePurchasePayload(purchasePayload: string?) -- Luacid: Inlined by compiler; 1 call site recovered
    if type(purchasePayload) ~= "string" or purchasePayload == "" then
        return nil
    end

    local success, result = pcall(HttpService.JSONDecode, HttpService, purchasePayload)
    return if success and type(result) == "table" and type(result.surface) == "table" then result else nil
end

local parseEconomicRestrictionsFailureReason = IAPExperience.Utility.parseEconomicRestrictionsFailureReason

local parseEconomicRestrictionsExpirationTimeInMinutes = IAPExperience.Utility.parseEconomicRestrictionsExpirationTimeInMinutes

local tbl2 = { Network, Analytics }

local function handleGenericPurchaseError(arg1, arg2, str1: string?)
    if isEconomicRestrictionResponse(arg2) then
        local var1 = parseEconomicRestrictionsFailureReason(arg2)
        local var2 = parseEconomicRestrictionsExpirationTimeInMinutes(arg2)
        arg1:dispatch(SetEconomicRestrictionError(var1, var2))
        arg1:dispatch(ErrorOccurred(PurchaseError.EconomicRestriction))
        return
    end

    if handlePriceChangedError(arg1, arg2, str1) then
        return
    end

    if PurchaseError.isMember(arg2) then
        arg1:dispatch(ErrorOccurred(arg2))
    else
        arg1:dispatch(ErrorOccurred(PurchaseError.UnknownFailure))
    end
end

local function performLuaPurchase()
    return Thunk.new(script.Name, tbl2, function(arg1, arg2)
        local var1 = arg2[Network]
        local var2 = arg2[Analytics]

        local state = arg1:getState()
        local productInfo = state.productInfo
        local price = productInfo.price
        local productId = productInfo.productId
        local promptRequest = state.promptRequest
        local id = state.promptRequest.id
        local productPayload = state.productPayload

        if productPayload.kind == "Product" then
            local tbl3 = {
                expectedCurrency = Constants.Currency.Robux,
                expectedPrice = price,
                saleLocationId = productPayload.universeId
            }

            if FFlagEnableRequestLocationTypeForSduiPurchase then
                local surface = state.purchaseAnalyticsMetadata and state.purchaseAnalyticsMetadata.surface
                tbl3.requestLocationType = if surface == nil then "" else tbl1[surface] or ""
            end

            tbl3.purchasePayload = decodePurchasePayload(productPayload.purchasePayload)

            return performDevProductEdpPurchase(var1, productId, tbl3):andThen(function(arg3)
                arg1:dispatch(completePurchase(arg3))

                var2.signalPurchaseSuccess(id, Enum.InfoType.Product, nil, arg3)

                return Promise.resolve(arg3)
            end):catch(function(arg3)
                handleGenericPurchaseError(arg1, arg3, if FFlagEnablePriceChangedErrorHandling then productPayload.kind else nil)
            end)
        end

        if productPayload.kind == ProductTypeEnum.Experience then
            local tbl3 = {
                expectedCurrency = Constants.Currency.Robux,
                expectedPrice = price,
                sellerId = productInfo.sellerId
            }
            return performExperiencePurchase(var1, productId, tbl3):andThen(function(arg3)
                arg1:dispatch(completePurchase(arg3))

                return Promise.resolve(arg3)
            end):catch(function(arg3)
                handleGenericPurchaseError(arg1, arg3, if FFlagEnablePriceChangedErrorHandling then productPayload.kind else nil)
            end)
        end

        if productPayload.kind ~= ProductTypeEnum.Look then
            if FFlagEnableUnifiedPurchaseFlowForDevSubs and productPayload.kind == ProductTypeEnum.DeveloperSubscription then
                local subscriptionId = productPayload.subscriptionId
                local var3

                if productPayload.isSubscriptionInRobux then
                    local expectedPrice = productPayload.expectedPrice
                    var3 = performDeveloperSubscriptionRobuxPurchase(var1, subscriptionId, expectedPrice)
                else
                    var3 = performDeveloperSubscriptionFiatPurchase(var1, subscriptionId)
                end

                return var3:andThen(function()
                    arg1:dispatch(completePurchase())
                    return Promise.resolve()
                end):catch(function(arg3)
                    handleGenericPurchaseError(arg1, arg3, if FFlagEnablePriceChangedErrorHandling then productPayload.kind else nil)
                end)
            end

            if FFlagLuaAppsEnablePromptVIPServerPurchase and productPayload.kind == ProductTypeEnum.VIPServer then
                local tbl3 = {
                    name = RobloxTranslator:FormatByKey(
                        "Feature.PrivateServers.Label.OwnersServer",
                        {
                            displayName = Players.LocalPlayer.DisplayName
                        }
                    ),
                    expectedPrice = price,
                    idempotencyKey = promptRequest.idempotencyKey
                }

                return performVIPServerPurchase(var1, productPayload.universeId, tbl3):andThen(function(arg3)
                    local name = if type(arg3.name) == "string" then arg3.name else tbl3.name
                    local accessCode = if type(arg3.accessCode) == "string" then arg3.accessCode else nil
                    arg1:dispatch(VIPServerCreated(arg3.vipServerId, name, accessCode))
                    arg1:dispatch(completePurchase(arg3))

                    return Promise.resolve(arg3)
                end):catch(function(arg3)
                    handleGenericPurchaseError(arg1, arg3, if FFlagEnablePriceChangedErrorHandling then productPayload.kind else nil)
                end)
            end

            return
        end

        local expectedPrice = productPayload.expectedPrice
        local bulkPurchaseLineItems, var3

        if FFlagPurchasePromptFetchCartPricingForLooks then
            bulkPurchaseLineItems = productPayload.bulkPurchaseLineItems

            local cartPricing = state.cartPricing
            local response = cartPricing and cartPricing.response
            if response == nil then
                var3 = {}
            else
                expectedPrice = selectProductPrice(state) or expectedPrice
                var3 = deriveSelectedOfferIdsFromCartPricing(response)

                if bulkPurchaseLineItems ~= nil then
                    bulkPurchaseLineItems = applyCartPricingOffersToLineItems(bulkPurchaseLineItems, response, var3)
                end
            end
        else
            var3 = nil
            bulkPurchaseLineItems = nil
        end

        local tbl3 = {
            lookId = productPayload.id,
            idempotencyKey = HttpService:GenerateGUID(false),
            expectedPrice = expectedPrice,
            salesLocationId = productPayload.salesLocationId,
            excludedAssets = productPayload.excludedAssetIds,
            excludedBundles = productPayload.excludedBundleIds,
            timedOptions = productPayload.timedOptions,
            selectedOfferIds = var3,
            bulkPurchaseLineItems = 0
        }

        if not FFlagPurchasePromptFetchCartPricingForLooks then
            bulkPurchaseLineItems = nil
        end

        tbl3.bulkPurchaseLineItems = bulkPurchaseLineItems

        return performLookPurchase(var1, productPayload.id, tbl3):andThen(function(arg3)
            arg1:dispatch(completePurchase(arg3))

            return Promise.resolve(arg3)
        end):catch(function(arg3)
            handleGenericPurchaseError(arg1, arg3, if FFlagEnablePriceChangedErrorHandling then productPayload.kind else nil)
        end)
    end)
end

return performLuaPurchase
