-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:41:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local SetPromptState = require(PurchasePrompt.Actions.SetPromptState)
local ErrorOccurred = require(PurchasePrompt.Actions.ErrorOccurred)
local BundleProductInfoReceived = require(PurchasePrompt.Actions.BundleProductInfoReceived)
local AccountInfoReceived = require(PurchasePrompt.Actions.AccountInfoReceived)
local BalanceInfoRecieved = require(PurchasePrompt.Actions.BalanceInfoRecieved)
local PromptNativeUpsellSuggestions = require(PurchasePrompt.Actions.PromptNativeUpsellSuggestions)
local SetPurchaseFlow = require(PurchasePrompt.Actions.SetPurchaseFlow)

local PromptState = require(PurchasePrompt.Enums.PromptState)
local PurchaseError = require(PurchasePrompt.Enums.PurchaseError)
local PurchaseFlow = require(PurchasePrompt.Enums.PurchaseFlow)

local _RobuxUpsell = require(PurchasePrompt.Models.RobuxUpsell)

local getRobuxUpsellSuggestions = require(PurchasePrompt.Network.getRobuxUpsellSuggestions)

local Analytics = require(PurchasePrompt.Services.Analytics)
local Network = require(PurchasePrompt.Services.Network)

local getPaymentPlatform = require(PurchasePrompt.Utils.getPaymentPlatform)
local _getPaymentFromPlatformLegacy = require(PurchasePrompt.Utils.getPaymentFromPlatformLegacy)
local _getHasAmazonUserAgent = require(PurchasePrompt.Utils.getHasAmazonUserAgent)
local isEligibleForRobuxUpsellPlusButton = require(PurchasePrompt.Utils.isEligibleForRobuxUpsellPlusButton)

local GetFFlagRespectBalanceInfoForBundleUpsellInStudio = require(PurchasePrompt.Flags.GetFFlagRespectBalanceInfoForBundleUpsellInStudio)
local Thunk = require(PurchasePrompt.Thunk)
local getPurchaseSurface = require(PurchasePrompt.Utils.getPurchaseSurface)

local _GetFFlagEnableLuobuInGameUpsell = require(PurchasePrompt.Flags.GetFFlagEnableLuobuInGameUpsell)
local SetIsUserEligibleForUnifiedPurchaseFlow = require(PurchasePrompt.Actions.SetIsUserEligibleForUnifiedPurchaseFlow)
local SetPurchaseAnalyticsMetadata = require(PurchasePrompt.Actions.SetPurchaseAnalyticsMetadata)

local getProductTypeFromRequestType = require(PurchasePrompt.Utils.getProductTypeFromRequestType)
local meetsBundlePrerequisites = require(PurchasePrompt.Utils.meetsBundlePrerequisites)
local SetPostPurchaseActions = require(PurchasePrompt.Actions.SetPostPurchaseActions)
local FFlagUpdatePriceTelemetry = require(PurchasePrompt.Parent.SharedFlags).FFlagUpdatePriceTelemetry
local selectPrice = require(PurchasePrompt.Selectors.selectPrice)
local selectCartPricingOverride = require(PurchasePrompt.Selectors.selectCartPricingOverride)

local _RobloxSubscriptionPurchaseApp = require(PurchasePrompt.Parent.RobloxSubscriptionPurchaseApp)
local SetRobloxSubscriptionProducts = require(PurchasePrompt.Actions.SetRobloxSubscriptionProducts)

local function getBundlePriceFromProductInfo(arg1, isPremium) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1 and arg1.product ~= nil then
        if isPremium and arg1.product.premiumPricing ~= nil then
            return arg1.product.premiumPricing.premiumPriceInRobux or 0
        end

        return arg1.product.priceInRobux or 0
    end

    return 0
end

local tbl1 = { Analytics, Network }

local function resolveBundlePromptState(_, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    return Thunk.new(script.Name, tbl1, function(arg8, arg9)
        arg8:getState()
        local _ = arg9[Analytics]
        local _ = arg9[Network]

        arg8:dispatch(BundleProductInfoReceived(arg1))
        arg8:dispatch(AccountInfoReceived(arg2))
        arg8:dispatch(BalanceInfoRecieved(arg3))
        if arg6 then
            arg8:dispatch(SetIsUserEligibleForUnifiedPurchaseFlow(true))
            local state = arg8:getState()

            local var1 = SetPurchaseAnalyticsMetadata
            local tbl2 = {
                purchaseFlowUUID = state.purchaseFlowUUID,
                surface = getPurchaseSurface(state.purchaseAnalyticsMetadata),
                productType = getProductTypeFromRequestType(state.promptRequest.requestType),
                productId = state.productInfo.productId,
                productTargetId = state.productInfo.productTargetId,
                saleLocationUniverseId = game.GameId or 0,
                price = if FFlagUpdatePriceTelemetry then selectPrice(state).priceInRobux elseif state.productInfo.price then state.productInfo.price else arg4,
                productUniverseId = state.purchaseAnalyticsMetadata.productUniverseId,
                userRobuxBalance = state.accountInfo.balance
            }
            arg8:dispatch(var1(tbl2))

            if arg7 then
                arg8:dispatch(SetRobloxSubscriptionProducts(arg7))
            end
        else
            arg8:dispatch(SetIsUserEligibleForUnifiedPurchaseFlow(false))
        end

        if arg4 == nil then
            local isPremium = arg2.isPremium
            arg4 = getBundlePriceFromProductInfo(arg1, isPremium)
        end

        local var1 = selectCartPricingOverride(arg8:getState())
        local var2 = if var1 ~= nil then var1.priceInRobux else arg4
        local var3, var4 = meetsBundlePrerequisites(arg1, arg3, var2, arg5)
        local var5 = arg4
        local platform = UserInputService:GetPlatform()
        local bool1 = var4 == PurchaseError.NotEnoughRobux

        if RunService:IsStudio() and GetFFlagRespectBalanceInfoForBundleUpsellInStudio() and bool1 then
            bool1 = arg3.robux < var5
            var3 = var3 or not bool1
        end

        if var3 then
            return arg8:dispatch(SetPromptState(PromptState.PromptPurchase))
        end

        if not bool1 then
            return arg8:dispatch(ErrorOccurred(var4))
        end

        if arg6 then
            arg8:dispatch(SetPurchaseFlow(PurchaseFlow.RobuxUpsellV2))
        end

        if arg6 then
            arg8:dispatch(SetPostPurchaseActions({}))
        end

        local _ = var5 - arg3.robux
        local _isPremium = arg2.isPremium

        local paymentPlatform = getPaymentPlatform(platform)

        local robux = arg3.robux
        local state = arg8:getState()

        return getRobuxUpsellSuggestions(
            var5,
            robux,
            paymentPlatform,
            isEligibleForRobuxUpsellPlusButton(
                state.isUserEligibleForUnifiedPurchaseFlow,
                state.robloxSubscriptionProducts,
                state.productPayload,
                selectPrice(state),
                state.promptRequest.requestType
            )
        ):andThen(
            function(arg10)
                arg8:dispatch(PromptNativeUpsellSuggestions(arg10.products, 1, arg10.virtualItemBadgeType, arg10.experimentVariant))
            end,
            function()
                arg8:dispatch(ErrorOccurred(PurchaseError.NotEnoughRobuxXbox))
            end
        )
    end)
end

return resolveBundlePromptState
