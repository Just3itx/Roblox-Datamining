-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:40:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local InExperienceOffers = require(PurchasePromptParent.InExperienceOffers)
local Promise = require(PurchasePrompt.Promise)
local Network = require(PurchasePrompt.Services.Network)
local ExternalSettings = require(PurchasePrompt.Services.ExternalSettings)
local Thunk = require(PurchasePrompt.Thunk)
local _types = require(PurchasePrompt.types)

local postInGameItemCartPricing = require(PurchasePrompt.Network.postInGameItemCartPricing)
local MockPostInGameItemCartPricing = require(PurchasePrompt.Mocks.MockPostInGameItemCartPricing)
local FFlagMockCartPricingResponseInStudio = require(PurchasePrompt.Flags.FFlagMockCartPricingResponseInStudio)
local getInGameItemCartPricingRequestedItems = require(PurchasePrompt.Utils.getInGameItemCartPricingRequestedItems)
local getInGameItemProductIdentifier = require(PurchasePrompt.Utils.getInGameItemProductIdentifier)
local getFeatureKeyForSurface = require(PurchasePrompt.Utils.getFeatureKeyForSurface)
local getProductTypeFromRequestType = require(PurchasePrompt.Utils.getProductTypeFromRequestType)
local logUnifiedPurchaseTelemetryCounter = require(PurchasePrompt.Utils.logUnifiedPurchaseTelemetryCounter)
local UnifiedPurchaseTelemetry = require(PurchasePrompt.Events.UnifiedPurchaseTelemetry)

local SetCartPricingFetching = require(PurchasePrompt.Actions.SetCartPricingFetching)
local SetCartPricingResponse = require(PurchasePrompt.Actions.SetCartPricingResponse)
local SetCartPricingFetchFailed = require(PurchasePrompt.Actions.SetCartPricingFetchFailed)

local tbl1 = FFlagMockCartPricingResponseInStudio and { Network, ExternalSettings } or { Network }

local function resolveProductIdentifier(state)
    local promptRequest = state.promptRequest
    if promptRequest == nil then
        return nil
    end
    return getInGameItemProductIdentifier(promptRequest.infoType, promptRequest.id)
end

local function fetchInGameItemCartPricing(tbl2)
    return Thunk.new(script.Name, tbl1, function(arg1, arg2)
        local var1 = arg2[Network]
        local state = arg1:getState()

        local var2 = FFlagMockCartPricingResponseInStudio and arg2[ExternalSettings].isStudio()
        local var3 = if var2 then MockPostInGameItemCartPricing else postInGameItemCartPricing
        local inGameItemCartPricingRequestedItems = getInGameItemCartPricingRequestedItems(resolveProductIdentifier(state))
        if inGameItemCartPricingRequestedItems == nil or #inGameItemCartPricingRequestedItems == 0 then
            return Promise.resolve(nil)
        end

        local userId = Players.LocalPlayer.UserId
        local purchaseAnalyticsMetadata = state.purchaseAnalyticsMetadata
        local surface = purchaseAnalyticsMetadata and purchaseAnalyticsMetadata.surface
        local featureKeyForSurface = getFeatureKeyForSurface(surface)

        if not var2 then
            local var4 = InExperienceOffers.getOffersStore(false).getOffers(false)
            if InExperienceOffers.Utils.getOffersForKey(var4, featureKeyForSurface, InExperienceOffers.OfferStatuses.Available) == nil then
                return Promise.resolve(nil)
            end
        end

        local productTypeFromRequestType = getProductTypeFromRequestType(state.promptRequest.requestType)

        local str1 = HttpService:GenerateGUID(false)
        arg1:dispatch(SetCartPricingFetching(str1))

        local function isCurrentRequest(): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
            local cartPricing = arg1:getState().cartPricing
            return not (cartPricing == nil) and cartPricing.requestId == str1
        end

        return var3(var1, userId, featureKeyForSurface, inGameItemCartPricingRequestedItems, tbl2, surface, productTypeFromRequestType):andThen(
            function(arg3)
                if not isCurrentRequest() then
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
return fetchInGameItemCartPricing
