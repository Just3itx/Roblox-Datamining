-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:41:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local SharedFlags = require(PurchasePromptParent.SharedFlags)

local _SetABVariation = require(PurchasePrompt.Actions.SetABVariation)
local ErrorOccurred = require(PurchasePrompt.Actions.ErrorOccurred)
local RequestAssetPurchase = require(PurchasePrompt.Actions.RequestAssetPurchase)
local RequestGamepassPurchase = require(PurchasePrompt.Actions.RequestGamepassPurchase)
local RequestProductPurchase = require(PurchasePrompt.Actions.RequestProductPurchase)
local SetPurchaseFlowUUID = require(PurchasePrompt.Actions.SetPurchaseFlowUUID)
local PurchaseError = require(PurchasePrompt.Enums.PurchaseError)
local _Constants = require(PurchasePrompt.Misc.Constants)
local Network = require(PurchasePrompt.Services.Network)

local deprecated_GetProductInfo = require(PurchasePrompt.Network.deprecated_GetProductInfo)
local getProductInfo = require(PurchasePrompt.Network.getProductInfo)
local getBalanceInfo = require(PurchasePrompt.Network.getBalanceInfo)
local getIsAlreadyOwned = require(PurchasePrompt.Network.getIsAlreadyOwned)
local ExternalSettings = require(PurchasePrompt.Services.ExternalSettings)
local hasPendingRequest = require(PurchasePrompt.Utils.hasPendingRequest)
local Promise = require(PurchasePrompt.Promise)
local Thunk = require(PurchasePrompt.Thunk)
local IXPServiceWrapper = require(PurchasePromptParent.IxpServiceWrapper).IXPServiceWrapper
local _Logging = require(PurchasePromptParent.AppCommonLib).Logging
local LoggingProtocol = require(PurchasePromptParent.LoggingProtocol)
local ProductTypeEnum = require(PurchasePrompt.types).ProductTypeEnum
local RequestExperiencePurchase = require(PurchasePrompt.Actions.RequestExperiencePurchase)
local RequestLookPurchase = require(PurchasePrompt.Actions.RequestLookPurchase)
local RequestRobuxUpsellPurchase = require(PurchasePrompt.Actions.RequestRobuxUpsellPurchase)
local RequestDeveloperSubscriptionPurchase = require(PurchasePrompt.Actions.RequestDeveloperSubscriptionPurchase)
local RequestVIPServerPurchase = require(PurchasePrompt.Actions.RequestVIPServerPurchase)

local FFlagEnableUnifiedPurchaseFlowForDevSubs = require(PurchasePrompt.Parent.SharedFlags).FFlagEnableUnifiedPurchaseFlowForDevSubs
local SetIsUserEligibleForUnifiedPurchaseFlow = require(PurchasePrompt.Actions.SetIsUserEligibleForUnifiedPurchaseFlow)
local SetPromptState = require(PurchasePrompt.Actions.SetPromptState)
local PromptState = require(PurchasePrompt.Enums.PromptState)

local SetProductPayload = require(PurchasePrompt.Actions.SetProductPayload)
local resolvePromptState = require(script.Parent.resolvePromptState)
local fetchCartPricing = require(script.Parent.fetchCartPricing)
local fetchInGameItemCartPricing = require(script.Parent.fetchInGameItemCartPricing)
local FFlagMockCartPricingResponseInStudio = require(PurchasePrompt.Flags.FFlagMockCartPricingResponseInStudio)
local buildProductPayloadFromInitiateArgs = require(PurchasePrompt.Utils.buildProductPayloadFromInitiateArgs)

local FFlagEnableFetchCartPricingDuringInExperience = require(PurchasePrompt.Parent.SharedFlags).FFlagEnableFetchCartPricingDuringInExperience

local FFlagAXFetchCartPricingDuringInExperienceExposure = require(PurchasePrompt.Parent.SharedFlags).FFlagAXFetchCartPricingDuringInExperienceExposure

local FStringAXFetchCartPricingDuringInExperienceLayerName = require(PurchasePrompt.Parent.SharedFlags).FStringAXFetchCartPricingDuringInExperienceLayerName
local GetFFlagEnableCreatorStorePurchasingCutover = require(PurchasePrompt.Flags.GetFFlagEnableCreatorStorePurchasingCutover)
local FFlagEnablePurchaseFlowUUIDMigration = require(PurchasePrompt.Flags.FFlagEnablePurchaseFlowUUIDMigration)
local getUnifiedPurchaseFlowEligibility = require(PurchasePrompt.Network.getUnifiedPurchaseFlowEligibility)
local FFlagFixPurchasingErrorCounter = require(PurchasePrompt.Flags.FFlagFixPurchasingErrorCounter)
local FFlagRefreshPriceOnRetryAfterUpsell = require(PurchasePrompt.Flags.FFlagRefreshPriceOnRetryAfterUpsell)
local bool1 = game:DefineFastFlag("RefreshDevSubPriceOnRetryAfterUpsell2", false)
local FFlagRefreshLookPriceOnRetryAfterUpsell = require(PurchasePrompt.Flags.FFlagRefreshLookPriceOnRetryAfterUpsell)
local applyRefreshedPrice = if FFlagRefreshPriceOnRetryAfterUpsell or FFlagRefreshLookPriceOnRetryAfterUpsell then require(PurchasePrompt.Utils.applyRefreshedPrice) else nil
local FFlagAXSupportRentalPurchaseInUnifiedProductPurchaseFlow = require(PurchasePrompt.Parent.SharedFlags).FFlagAXSupportRentalPurchaseInUnifiedProductPurchaseFlow

local FFlagAddPurchaseOptionForProvidingBalance = require(PurchasePrompt.Parent.SharedFlags).FFlagAddPurchaseOptionForProvidingBalance

local FFlagLuaAppsEnablePromptVIPServerPurchase = require(PurchasePrompt.Parent.SharedFlags).FFlagLuaAppsEnablePromptVIPServerPurchase
local FFlagUnifiedPurchaseAddSkeleton = require(PurchasePrompt.Parent.SharedFlags).FFlagUnifiedPurchaseAddSkeleton
local FFlagAXMISWithBlackbird = SharedFlags.FFlagAXMISWithBlackbird
local FFlagEnableInExperiencePurchaseModalMetrics = require(PurchasePrompt.Flags.FFlagEnableInExperiencePurchaseModalMetrics)
local trackInExperiencePurchaseStart = require(PurchasePrompt.Utils.trackInExperiencePurchaseStart)
local AppContext = require(PurchasePrompt.Utils.AppContext)

local getRobloxSubscriptionProducts = require(PurchasePromptParent.RobloxSubscriptionPurchaseApp).Network.getRobloxSubscriptionProducts

local PurchaseFlowUUIDTelemetry = require(PurchasePrompt.Events.PurchaseFlowUUIDTelemetry)

local tbl1 = { Network, ExternalSettings }

local function initiatePurchase(subscriptionId, arg1, arg2, arg3, arg4, arg5, collectibleItemId, collectibleItemInstanceId, arg6, arg7, arg8, arg9)
    return Thunk.new(script.Name, tbl1, function(arg10, arg11)
        local var1 = arg11[Network]
        local var2 = arg11[ExternalSettings]

        if hasPendingRequest(arg10:getState()) and not arg9 then
            return nil
        end

        if FFlagEnablePurchaseFlowUUIDMigration then
            local str1 = HttpService:GenerateGUID(false)
            arg10:dispatch(SetPurchaseFlowUUID(str1))

            LoggingProtocol.default:logRobloxTelemetryCounter(
                PurchaseFlowUUIDTelemetry.InitiatePurchaseCounter,
                1,
                { method = "initiatePurchase" }
            )
        end

        if arg1 == Enum.InfoType.Asset then
            arg10:dispatch(
                RequestAssetPurchase(subscriptionId, arg2, arg3, arg4, arg5, collectibleItemId, collectibleItemInstanceId, arg6, arg7)
            )
        elseif arg1 == Enum.InfoType.GamePass then
            arg10:dispatch(RequestGamepassPurchase(subscriptionId, arg4))
        elseif arg1 == Enum.InfoType.Product then
            arg10:dispatch(RequestProductPurchase(subscriptionId, arg2, arg4))
        elseif arg1 == ProductTypeEnum.Experience then
            arg10:dispatch(RequestExperiencePurchase(subscriptionId))
        elseif arg1 == ProductTypeEnum.Look then
            arg10:dispatch(RequestLookPurchase(subscriptionId))
        elseif FFlagEnableUnifiedPurchaseFlowForDevSubs and arg1 == ProductTypeEnum.DeveloperSubscription then
            arg10:dispatch(RequestDeveloperSubscriptionPurchase(subscriptionId, arg7))
        elseif FFlagAXMISWithBlackbird and arg1 == ProductTypeEnum.RobuxUpsell then
            arg10:dispatch(RequestRobuxUpsellPurchase())
        else
            if arg1 ~= ProductTypeEnum.VIPServer then
                assert(false, "Invalid product type")
                return nil
            end

            arg10:dispatch(RequestVIPServerPurchase())
        end

        if var2.getFlagOrder66() then
            arg10:dispatch(ErrorOccurred(PurchaseError.PurchaseDisabled))
            return nil
        end

        if FFlagLuaAppsEnablePromptVIPServerPurchase and arg1 == ProductTypeEnum.VIPServer and var2.isStudio() then
            arg10:dispatch(ErrorOccurred(PurchaseError.UnsupportedInStudio))
            return nil
        end

        if FFlagEnableInExperiencePurchaseModalMetrics and not arg9 then
            trackInExperiencePurchaseStart(arg10)
        end

        local var3 = nil
        local providedRobuxBalance = nil
        local var4 = nil
        if FFlagAXSupportRentalPurchaseInUnifiedProductPurchaseFlow then
            local purchaseOptions = arg10:getState().purchaseOptions
            if purchaseOptions ~= nil and purchaseOptions.shouldSkipOwnershipCheck == true then
                var3 = true
            end

            if FFlagAddPurchaseOptionForProvidingBalance and purchaseOptions ~= nil and purchaseOptions.providedRobuxBalance ~= nil then
                providedRobuxBalance = purchaseOptions.providedRobuxBalance
            end

            if FFlagUnifiedPurchaseAddSkeleton and purchaseOptions ~= nil and purchaseOptions.enablePreloadedPurchaseUI == true then
                var4 = true
            end
        end

        local purchaseCallbacks = arg10:getState().purchaseCallbacks
        local fetchProductInfo = if purchaseCallbacks == nil or purchaseCallbacks.fetchProductInfo == nil then nil else purchaseCallbacks.fetchProductInfo
        local var5 = arg8
        if FFlagUnifiedPurchaseAddSkeleton and var4 then
            arg10:dispatch(SetIsUserEligibleForUnifiedPurchaseFlow(true))
            arg10:dispatch(SetPromptState(PromptState.InitializingPurchase))
        end

        local tbl2

        if FFlagRefreshPriceOnRetryAfterUpsell and arg9 then
            local productPayload = arg10:getState().productPayload
            tbl2 = {
                collectibleItemId = collectibleItemId,
                collectibleItemInstanceId = collectibleItemInstanceId,
                timedOptionDays = if productPayload then productPayload.timedOptionDays else nil
            }
        else
            tbl2 = nil
        end

        local cartPricingResponse = if FFlagEnableFetchCartPricingDuringInExperience then if arg10:getState().purchaseOptions.shouldFetchCartPricing then arg10:dispatch(fetchCartPricing()) else nil else arg10:dispatch(fetchCartPricing())

        if FFlagAXFetchCartPricingDuringInExperienceExposure
            and arg1 == Enum.InfoType.Asset
            and not (arg10:getState().purchaseOptions.shouldFetchCartPricing or arg9)
        then
            IXPServiceWrapper:LogFlagLinkedUserLayerExposure(FStringAXFetchCartPricingDuringInExperienceLayerName)
        end

        local var7 = FFlagEnableFetchCartPricingDuringInExperience
            and arg1 == Enum.InfoType.Asset
            and not (arg10:getState().purchaseOptions.shouldFetchCartPricing or arg9)
            and function(arg12)
                return arg10:dispatch(fetchCartPricing(nil, arg12))
            end
            or nil

        local var8 = FFlagMockCartPricingResponseInStudio and var2.isStudio() or AppContext.get() == AppContext.Enum.IN_EXPERIENCE
        local inGameItemCartPricingResponse = if (arg1 == Enum.InfoType.GamePass or arg1 == Enum.InfoType.Product) and var8 then arg10:dispatch(fetchInGameItemCartPricing()) else nil
        local all = Promise.all
        local tbl3 = {
            productInfo = 0,
            accountInfo = 0,
            alreadyOwned = 0,
            balanceInfo = 0,
            isUserEligibleForUnifiedPurchaseFlow = 0,
            robloxSubscriptionProducts = 0,
            cartPricingResponse = 0,
            inGameItemCartPricingResponse = 0
        }
        local var10

        if GetFFlagEnableCreatorStorePurchasingCutover() then
            if fetchProductInfo ~= nil and not arg9 then
                var10 = fetchProductInfo()
            else
                local var11 = getProductInfo

                local var12 = subscriptionId
                local var13 = arg1

                if not FFlagRefreshPriceOnRetryAfterUpsell then
                    tbl2 = nil
                end

                if not FFlagEnableFetchCartPricingDuringInExperience then
                    var7 = nil
                end

                var10 = var11(var1, var12, var13, var5, tbl2, var7)
            end
        else
            var10 = deprecated_GetProductInfo(var1, subscriptionId, arg1)
        end

        tbl3.productInfo = var10

        tbl3.accountInfo = Promise.resolve({ isPremium = Players.LocalPlayer.MembershipType == Enum.MembershipType.Premium })

        tbl3.alreadyOwned = getIsAlreadyOwned(var1, subscriptionId, arg1, var3)
        tbl3.balanceInfo = getBalanceInfo(var1, var2, false, true, providedRobuxBalance)

        tbl3.isUserEligibleForUnifiedPurchaseFlow = getUnifiedPurchaseFlowEligibility(var1, arg1)

        tbl3.robloxSubscriptionProducts = getRobloxSubscriptionProducts():catch(function()
            return nil
        end)

        tbl3.cartPricingResponse = cartPricingResponse

        tbl3.inGameItemCartPricingResponse = inGameItemCartPricingResponse

        return all(tbl3):andThen(function(arg12)
            if FFlagEnableUnifiedPurchaseFlowForDevSubs
                and arg12.productInfo.ProductType == ProductTypeEnum.DeveloperSubscription
                and (arg10:getState().productPayload == nil or arg10:getState().productPayload.kind == nil)
            then
                arg10:dispatch(
                    SetProductPayload({
                        subscriptionId = subscriptionId,
                        kind = ProductTypeEnum.DeveloperSubscription,
                        expectedPrice = arg12.productInfo.PriceInRobux,
                        iconImageAssetId = arg12.productInfo.IconImageAssetId,
                        isSubscriptionInRobux = not (arg12.productInfo.PriceInRobux == nil) and arg12.productInfo.PriceInRobux > 0
                    })
                )
            end

            local productPayload = arg10:getState().productPayload
            if not (productPayload and productPayload.kind) then
                local productPayloadFromInitiateArgs = buildProductPayloadFromInitiateArgs(
                    subscriptionId,
                    arg1,
                    arg2,
                    arg3,
                    arg4,
                    arg5,
                    collectibleItemId,
                    collectibleItemInstanceId,
                    arg6,
                    arg7,
                    var5
                )
                if productPayloadFromInitiateArgs then
                    arg10:dispatch(SetProductPayload(productPayloadFromInitiateArgs))
                end
            end

            local var11 = arg7

            if (FFlagRefreshPriceOnRetryAfterUpsell or FFlagRefreshLookPriceOnRetryAfterUpsell) and arg9 then
                local refreshedExpectedPrice = arg12.productInfo.refreshedExpectedPrice

                if bool1
                    and FFlagEnableUnifiedPurchaseFlowForDevSubs
                    and arg12.productInfo.ProductType == ProductTypeEnum.DeveloperSubscription
                then
                    refreshedExpectedPrice = arg12.productInfo.PriceInRobux
                end
                if refreshedExpectedPrice ~= nil then
                    applyRefreshedPrice(arg10, refreshedExpectedPrice)
                    var11 = refreshedExpectedPrice
                end
            end

            arg10:dispatch(
                resolvePromptState(
                    arg12.productInfo,
                    arg12.accountInfo,
                    arg12.balanceInfo,
                    arg12.alreadyOwned,
                    arg3,
                    var11,
                    arg12.isUserEligibleForUnifiedPurchaseFlow,
                    arg12.robloxSubscriptionProducts
                )
            )
        end):catch(function(arg12)
            if not FFlagFixPurchasingErrorCounter then
                arg10:dispatch(ErrorOccurred(arg12))
                return
            end

            if PurchaseError.isMember(arg12) then
                arg10:dispatch(ErrorOccurred(arg12))
                return
            end
            arg10:dispatch(ErrorOccurred(PurchaseError.UnknownFailure))
        end)
    end)
end
return initiatePurchase
