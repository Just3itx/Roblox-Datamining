-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:40:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local HttpService = game:GetService("HttpService")

local Promise = require(PurchasePrompt.Promise)
local Network = require(PurchasePrompt.Services.Network)
local Thunk = require(PurchasePrompt.Thunk)

local postCartPricing = require(PurchasePrompt.Network.postCartPricing)
local getCartPricingRequestedItemsForCartPricing = require(PurchasePrompt.Utils.getCartPricingRequestedItemsForCartPricing)
local getProductTypeFromRequestType = require(PurchasePrompt.Utils.getProductTypeFromRequestType)
local logUnifiedPurchaseTelemetryCounter = require(PurchasePrompt.Utils.logUnifiedPurchaseTelemetryCounter)
local UnifiedPurchaseTelemetry = require(PurchasePrompt.Events.UnifiedPurchaseTelemetry)

local FFlagEnableFetchCartPricingDuringInExperience = require(PurchasePrompt.Parent.SharedFlags).FFlagEnableFetchCartPricingDuringInExperience
local bool1 = game:DefineFastFlag("DisableInExpMarketplaceOffersTemp", false)

local SetCartPricingFetching = require(PurchasePrompt.Actions.SetCartPricingFetching)
local SetCartPricingResponse = require(PurchasePrompt.Actions.SetCartPricingResponse)
local SetCartPricingFetchFailed = require(PurchasePrompt.Actions.SetCartPricingFetchFailed)

local tbl1 = { Network }

local function resolveCollectibleItemId(state) -- Luacid: Inlined by compiler; 2 call sites recovered
    local productInfo = state.productInfo
    if productInfo ~= nil and type(productInfo.collectibleItemId) == "string" and productInfo.collectibleItemId ~= "" then
        return productInfo.collectibleItemId
    end
    local promptRequest = state.promptRequest
    local collectibleItemId = promptRequest and promptRequest.collectibleItemId
    return if type(collectibleItemId) == "string" and collectibleItemId ~= "" then collectibleItemId else nil
end

local function fetchCartPricing(tbl2, str1: string?)
    return Thunk.new(script.Name, tbl1, function(arg1, arg2)
        local var1 = arg2[Network]

        local state = arg1:getState()
        if not FFlagEnableFetchCartPricingDuringInExperience then
            local purchaseOptions = state.purchaseOptions

            if purchaseOptions == nil or not purchaseOptions.shouldFetchCartPricing then
                return nil
            end
        end

        local cartPricingRequestedItemsForCartPricing = getCartPricingRequestedItemsForCartPricing(
            if FFlagEnableFetchCartPricingDuringInExperience then str1 or resolveCollectibleItemId(state) else resolveCollectibleItemId(state),
            state.productPayload,
            state.productInfo
        )
        if cartPricingRequestedItemsForCartPricing == nil or #cartPricingRequestedItemsForCartPricing == 0 then
            if FFlagEnableFetchCartPricingDuringInExperience then
                return Promise.resolve(nil)
            end
            return nil
        end

        local purchaseAnalyticsMetadata = state.purchaseAnalyticsMetadata
        local surface = purchaseAnalyticsMetadata and purchaseAnalyticsMetadata.surface

        local productTypeFromRequestType = getProductTypeFromRequestType(state.promptRequest.requestType)

        local str2 = HttpService:GenerateGUID(false)
        arg1:dispatch(SetCartPricingFetching(str2))

        local function isCurrentRequest(): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
            local cartPricing = arg1:getState().cartPricing
            return not (cartPricing == nil) and cartPricing.requestId == str2
        end

        return postCartPricing(var1, cartPricingRequestedItemsForCartPricing, tbl2, surface, productTypeFromRequestType):andThen(
            function(arg3)
                if bool1 and str1 then
                    arg1:dispatch(SetCartPricingFetchFailed())
                    return nil
                elseif not isCurrentRequest() then
                    return nil
                elseif arg3 == nil then
                    arg1:dispatch(SetCartPricingFetchFailed())
                    return nil
                else
                    arg1:dispatch(SetCartPricingResponse(arg3))
                    return arg3
                end
            end
        ):catch(
            function()
                logUnifiedPurchaseTelemetryCounter(
                    UnifiedPurchaseTelemetry.UnifiedCartPricingHandlerErrorCounter,
                    surface,
                    productTypeFromRequestType
                )

                if isCurrentRequest() then
                    arg1:dispatch(SetCartPricingFetchFailed())
                end
            end
        )
    end)
end
return fetchCartPricing
