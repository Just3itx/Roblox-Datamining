-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:41:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local ErrorOccurred = require(PurchasePrompt.Actions.ErrorOccurred)
local RequestBundlePurchase = require(PurchasePrompt.Actions.RequestBundlePurchase)
local SetProductPayload = require(PurchasePrompt.Actions.SetProductPayload)
local buildProductPayloadFromInitiateArgs = require(PurchasePrompt.Utils.buildProductPayloadFromInitiateArgs)
local SetPurchaseFlowUUID = require(PurchasePrompt.Actions.SetPurchaseFlowUUID)
local PurchaseError = require(PurchasePrompt.Enums.PurchaseError)
local getBundleDetails = require(PurchasePrompt.Network.getBundleDetails)
local getProductPurchasableDetails = require(PurchasePrompt.Network.getProductPurchasableDetails)
local getBalanceInfo = require(PurchasePrompt.Network.getBalanceInfo)
local getIsAlreadyOwned = require(PurchasePrompt.Network.getIsAlreadyOwned)
local Network = require(PurchasePrompt.Services.Network)
local ExternalSettings = require(PurchasePrompt.Services.ExternalSettings)
local hasPendingRequest = require(PurchasePrompt.Utils.hasPendingRequest)
local Promise = require(PurchasePrompt.Promise)
local Thunk = require(PurchasePrompt.Thunk)
local IXPServiceWrapper = require(PurchasePromptParent.IxpServiceWrapper).IXPServiceWrapper
local _Logging = require(PurchasePromptParent.AppCommonLib).Logging
local LoggingProtocol = require(PurchasePromptParent.LoggingProtocol)

local FFlagEnableFetchCartPricingDuringInExperience = require(PurchasePrompt.Parent.SharedFlags).FFlagEnableFetchCartPricingDuringInExperience

local FFlagAXFetchCartPricingDuringInExperienceExposure = require(PurchasePrompt.Parent.SharedFlags).FFlagAXFetchCartPricingDuringInExperienceExposure

local FStringAXFetchCartPricingDuringInExperienceLayerName = require(PurchasePrompt.Parent.SharedFlags).FStringAXFetchCartPricingDuringInExperienceLayerName
local getUnifiedPurchaseFlowEligibility = require(PurchasePrompt.Network.getUnifiedPurchaseFlowEligibility)

local resolveBundlePromptState = require(script.Parent.resolveBundlePromptState)
local fetchCartPricing = require(script.Parent.fetchCartPricing)
local FFlagEnableInExperiencePurchaseModalMetrics = require(PurchasePrompt.Flags.FFlagEnableInExperiencePurchaseModalMetrics)
local trackInExperiencePurchaseStart = require(PurchasePrompt.Utils.trackInExperiencePurchaseStart)

local FFlagEnablePurchaseFlowUUIDMigration = require(PurchasePrompt.Flags.FFlagEnablePurchaseFlowUUIDMigration)

local FFlagUnifiedPurchaseOptimizeTTIMarketplace = require(PurchasePrompt.Parent.SharedFlags).FFlagUnifiedPurchaseOptimizeTTIMarketplace

local FFlagRefreshPriceOnRetryAfterUpsell = require(PurchasePrompt.Flags.FFlagRefreshPriceOnRetryAfterUpsell)
local applyRefreshedPrice = if FFlagRefreshPriceOnRetryAfterUpsell then require(PurchasePrompt.Utils.applyRefreshedPrice) else nil
local getRobloxSubscriptionProducts = require(PurchasePromptParent.RobloxSubscriptionPurchaseApp).Network.getRobloxSubscriptionProducts

local PurchaseFlowUUIDTelemetry = require(PurchasePrompt.Events.PurchaseFlowUUIDTelemetry)

local tbl1 = { Network, ExternalSettings }

local function initiateBundlePurchase(arg1, arg2, arg3, collectibleItemId, collectibleItemInstanceId, arg4, arg5, bool1: boolean?)
    return Thunk.new(script.Name, tbl1, function(arg6, arg7)
        local var1 = arg7[Network]
        local var2 = arg7[ExternalSettings]

        if hasPendingRequest(arg6:getState()) and not bool1 then
            return nil
        end

        local productPayload = arg6:getState().productPayload
        if not (productPayload and productPayload.kind) then
            local productPayloadFromInitiateArgs = buildProductPayloadFromInitiateArgs(
                arg1,
                Enum.InfoType.Bundle,
                nil,
                nil,
                arg2,
                arg3,
                collectibleItemId,
                collectibleItemInstanceId,
                arg4,
                arg5,
                nil
            )
            if productPayloadFromInitiateArgs then
                arg6:dispatch(SetProductPayload(productPayloadFromInitiateArgs))
            end
        end

        if FFlagEnablePurchaseFlowUUIDMigration then
            local str1 = HttpService:GenerateGUID(false)
            arg6:dispatch(SetPurchaseFlowUUID(str1))

            LoggingProtocol.default:logRobloxTelemetryCounter(
                PurchaseFlowUUIDTelemetry.InitiatePurchaseCounter,
                1,
                { method = "initiateBundlePurchase" }
            )
        end

        arg6:dispatch(RequestBundlePurchase(arg1, arg2, arg3, collectibleItemId, collectibleItemInstanceId, arg4, arg5))

        if var2.getFlagOrder66() then
            arg6:dispatch(ErrorOccurred(PurchaseError.PurchaseDisabled))
            return nil
        end

        if FFlagEnableInExperiencePurchaseModalMetrics and not bool1 then
            trackInExperiencePurchaseStart(arg6)
        end

        local var3 = nil
        local providedRobuxBalance = nil
        local fetchProductInfo = nil
        if FFlagUnifiedPurchaseOptimizeTTIMarketplace then
            local state = arg6:getState()
            local purchaseOptions = state.purchaseOptions
            local purchaseCallbacks = state.purchaseCallbacks

            if purchaseOptions ~= nil and purchaseOptions.shouldSkipOwnershipCheck == true then
                var3 = true
            end

            if purchaseOptions ~= nil and purchaseOptions.providedRobuxBalance ~= nil then
                providedRobuxBalance = purchaseOptions.providedRobuxBalance
            end
            if purchaseCallbacks ~= nil and purchaseCallbacks.fetchProductInfo ~= nil then
                fetchProductInfo = purchaseCallbacks.fetchProductInfo
            end
        end

        local tbl2

        if FFlagRefreshPriceOnRetryAfterUpsell and bool1 then
            local productPayload2 = arg6:getState().productPayload
            tbl2 = {
                collectibleItemId = collectibleItemId,
                collectibleItemInstanceId = collectibleItemInstanceId,
                timedOptionDays = if productPayload2 then productPayload2.timedOptionDays else nil
            }
        else
            tbl2 = nil
        end

        local cartPricingResponse = if FFlagEnableFetchCartPricingDuringInExperience then if arg6:getState().purchaseOptions.shouldFetchCartPricing then arg6:dispatch(fetchCartPricing()) else nil else arg6:dispatch(fetchCartPricing())

        if FFlagAXFetchCartPricingDuringInExperienceExposure
            and not (arg6:getState().purchaseOptions.shouldFetchCartPricing or bool1)
        then
            IXPServiceWrapper:LogFlagLinkedUserLayerExposure(FStringAXFetchCartPricingDuringInExperienceLayerName)
        end

        local var5 = FFlagEnableFetchCartPricingDuringInExperience
            and not (arg6:getState().purchaseOptions.shouldFetchCartPricing or bool1)
            and function(arg8)
                return arg6:dispatch(fetchCartPricing(nil, arg8))
            end
            or nil

        local all = Promise.all
        local tbl3 = {
            bundleDetails = 0,
            accountInfo = 0,
            balanceInfo = 0,
            alreadyOwned = 0,
            isUserEligibleForUnifiedPurchaseFlow = 0,
            robloxSubscriptionProducts = 0,
            cartPricingResponse = 0
        }
        local var6

        if FFlagUnifiedPurchaseOptimizeTTIMarketplace and fetchProductInfo ~= nil and not bool1 then
            var6 = fetchProductInfo()
        else
            local var7 = getBundleDetails

            local var8 = arg1
            if not FFlagRefreshPriceOnRetryAfterUpsell then
                tbl2 = nil
            end

            if not FFlagEnableFetchCartPricingDuringInExperience then
                var5 = nil
            end

            var6 = var7(var1, var8, tbl2, var5)
        end

        tbl3.bundleDetails = var6

        tbl3.accountInfo = Promise.resolve({ isPremium = Players.LocalPlayer.MembershipType == Enum.MembershipType.Premium })

        local var7 = getBalanceInfo

        local bool2 = false
        local var8 = nil
        if not FFlagUnifiedPurchaseOptimizeTTIMarketplace then
            providedRobuxBalance = nil
        end

        tbl3.balanceInfo = var7(var1, var2, bool2, var8, providedRobuxBalance)

        local var9 = getIsAlreadyOwned

        local var10 = arg1
        local bundle = Enum.InfoType.Bundle
        if not FFlagUnifiedPurchaseOptimizeTTIMarketplace then
            var3 = nil
        end

        tbl3.alreadyOwned = var9(var1, var10, bundle, var3)

        tbl3.isUserEligibleForUnifiedPurchaseFlow = getUnifiedPurchaseFlowEligibility(var1)
        tbl3.robloxSubscriptionProducts = getRobloxSubscriptionProducts(var1):catch(function()
            return nil
        end)

        tbl3.cartPricingResponse = cartPricingResponse

        return all(tbl3):andThen(function(arg8)
            local var11 = arg5
            if FFlagRefreshPriceOnRetryAfterUpsell and bool1 then
                local refreshedExpectedPrice = arg8.bundleDetails.refreshedExpectedPrice
                if refreshedExpectedPrice ~= nil then
                    var11 = refreshedExpectedPrice
                    applyRefreshedPrice(arg6, refreshedExpectedPrice)
                end
            end

            if not arg8.bundleDetails.product then
                arg6:dispatch(ErrorOccurred(PurchaseError.NotForSale))
                return
            end

            if FFlagUnifiedPurchaseOptimizeTTIMarketplace then
                arg6:dispatch(
                    resolveBundlePromptState(
                        nil,
                        arg8.bundleDetails,
                        arg8.accountInfo,
                        arg8.balanceInfo,
                        var11,
                        arg8.alreadyOwned,
                        arg8.isUserEligibleForUnifiedPurchaseFlow,
                        arg8.robloxSubscriptionProducts
                    )
                )
                return
            end
            local id = arg8.bundleDetails.product.id
            getProductPurchasableDetails(var1, id):andThen(function(arg9)
                arg6:dispatch(
                    resolveBundlePromptState(
                        arg9,
                        arg8.bundleDetails,
                        arg8.accountInfo,
                        arg8.balanceInfo,
                        var11,
                        arg8.alreadyOwned,
                        arg8.isUserEligibleForUnifiedPurchaseFlow,
                        arg8.robloxSubscriptionProducts
                    )
                )
            end)
        end):catch(function(arg8)
            arg6:dispatch(ErrorOccurred(arg8))
        end)
    end)
end

return initiateBundlePurchase
