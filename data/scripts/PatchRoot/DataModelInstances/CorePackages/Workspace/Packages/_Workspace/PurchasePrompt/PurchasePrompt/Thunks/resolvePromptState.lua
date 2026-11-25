-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local UserInputService = game:GetService("UserInputService")

local SetPurchaseFlow = require(PurchasePrompt.Actions.SetPurchaseFlow)
local SetPromptState = require(PurchasePrompt.Actions.SetPromptState)
local ProductInfoReceived = require(PurchasePrompt.Actions.ProductInfoReceived)
local AccountInfoReceived = require(PurchasePrompt.Actions.AccountInfoReceived)
local BalanceInfoRecieved = require(PurchasePrompt.Actions.BalanceInfoRecieved)
local PromptNativeUpsellSuggestions = require(PurchasePrompt.Actions.PromptNativeUpsellSuggestions)
local ErrorOccurred = require(PurchasePrompt.Actions.ErrorOccurred)
local CompleteRequest = require(PurchasePrompt.Actions.CompleteRequest)

local PurchaseFlow = require(PurchasePrompt.Enums.PurchaseFlow)
local PromptState = require(PurchasePrompt.Enums.PromptState)
local PurchaseError = require(PurchasePrompt.Enums.PurchaseError)
local PaymentPlatform = require(PurchasePrompt.Enums.PaymentPlatform)
local RequestType = require(PurchasePrompt.Enums.RequestType)

local _RobuxUpsell = require(PurchasePrompt.Models.RobuxUpsell)

local getRobuxUpsellSuggestions = require(PurchasePrompt.Network.getRobuxUpsellSuggestions)

local ABTest = require(PurchasePrompt.Services.ABTest)
local Analytics = require(PurchasePrompt.Services.Analytics)
local ExternalSettings = require(PurchasePrompt.Services.ExternalSettings)
local Network = require(PurchasePrompt.Services.Network)

local Counter = require(PurchasePrompt.Enums.Counter)
local sendCounter = require(PurchasePrompt.Thunks.sendCounter)
local completeRequest = require(PurchasePrompt.Thunks.completeRequest)

local meetsPrerequisites = require(PurchasePrompt.Utils.meetsPrerequisites)
local isEligibleForRobuxUpsellPlusButton = require(PurchasePrompt.Utils.isEligibleForRobuxUpsellPlusButton)
local getPlayerProductInfoPrice = require(PurchasePrompt.Utils.getPlayerProductInfoPrice)
local getPaymentPlatform = require(PurchasePrompt.Utils.getPaymentPlatform)
local _getPaymentFromPlatformLegacy = require(PurchasePrompt.Utils.getPaymentFromPlatformLegacy)
local _getHasAmazonUserAgent = require(PurchasePrompt.Utils.getHasAmazonUserAgent)
local hasPendingRequest = require(PurchasePrompt.Utils.hasPendingRequest)
local SetPurchaseAnalyticsMetadata = require(PurchasePrompt.Actions.SetPurchaseAnalyticsMetadata)
local getPurchaseSurface = require(PurchasePrompt.Utils.getPurchaseSurface)
local Thunk = require(PurchasePrompt.Thunk)
local getProductTypeFromRequestType = require(PurchasePrompt.Utils.getProductTypeFromRequestType)
local _GetFFlagEnableLuobuInGameUpsell = require(PurchasePrompt.Flags.GetFFlagEnableLuobuInGameUpsell)
local GetFStringLargerRobuxUpsellIxpLayer = require(PurchasePromptParent.SharedFlags).GetFStringLargerRobuxUpsellIxpLayer
local LargerRobuxUpsellTest = require(PurchasePrompt.Flags.LargerRobuxUpsellTest)
local SetIsUserEligibleForUnifiedPurchaseFlow = require(PurchasePrompt.Actions.SetIsUserEligibleForUnifiedPurchaseFlow)
local SetPostPurchaseActions = require(PurchasePrompt.Actions.SetPostPurchaseActions)
local FFlagUpdatePriceTelemetry = require(PurchasePromptParent.SharedFlags).FFlagUpdatePriceTelemetry
local selectPrice = require(PurchasePrompt.Selectors.selectPrice)

local _RobloxSubscriptionPurchaseApp = require(PurchasePromptParent.RobloxSubscriptionPurchaseApp)
local SetRobloxSubscriptionProducts = require(PurchasePrompt.Actions.SetRobloxSubscriptionProducts)
local selectCartPricingOverride = require(PurchasePrompt.Selectors.selectCartPricingOverride)

local tbl1 = {
    ABTest,
    Analytics,
    ExternalSettings,
    Network
}

local FFlagEnableUpsellSuggestionsAnalyticsId = require(PurchasePromptParent.SharedFlags).FFlagEnableUpsellSuggestionsAnalyticsId

local function handleSuccessfulUpsellSuggestions(arg1, arg2)
    if not hasPendingRequest(arg1:getState()) then
        return
    end
    arg1:dispatch(PromptNativeUpsellSuggestions(arg2.products, 1, arg2.virtualItemBadgeType, arg2.experimentVariant))

    arg1:dispatch(sendCounter(Counter.UpsellModalShown))
end

local function handleFailedUpsellProduct(arg1, _)
    if not hasPendingRequest(arg1:getState()) then
        return
    end

    if arg1:getState().purchaseFlow == PurchaseFlow.LargeRobuxUpsell then
        arg1:dispatch(SetPromptState(PromptState.LargeRobuxUpsell))
        arg1:dispatch(sendCounter(Counter.UpsellModalShown))
    else
        arg1:dispatch(ErrorOccurred(PurchaseError.NotEnoughRobuxXbox))
        arg1:dispatch(sendCounter(Counter.UpsellGenericModalShown))
    end
end

local function resolvePromptState(arg1, arg2, arg3, arg4, arg5, price, arg6, arg7)
    return Thunk.new(script.Name, tbl1, function(arg8, arg9)
        local state = arg8:getState()
        local var1 = arg9[ABTest]
        local var2 = arg9[Analytics]
        local var3 = arg9[ExternalSettings]
        local _ = arg9[Network]

        arg8:dispatch(ProductInfoReceived(arg1))
        arg8:dispatch(AccountInfoReceived(arg2))
        arg8:dispatch(BalanceInfoRecieved(arg3))
        if arg6 then
            arg8:dispatch(SetIsUserEligibleForUnifiedPurchaseFlow(true))
            local state2 = arg8:getState()

            local var4 = SetPurchaseAnalyticsMetadata
            local tbl2 = {
                purchaseFlowUUID = state2.purchaseFlowUUID,
                surface = getPurchaseSurface(state2.purchaseAnalyticsMetadata),
                productType = getProductTypeFromRequestType(state2.promptRequest.requestType),
                productId = state2.productInfo.productId,
                productTargetId = state2.productInfo.productTargetId,
                saleLocationUniverseId = game.GameId or 0,
                price = if FFlagUpdatePriceTelemetry then selectPrice(state2).priceInRobux elseif state2.productInfo.price then state2.productInfo.price else price,
                productUniverseId = state2.purchaseAnalyticsMetadata.productUniverseId,
                userRobuxBalance = state2.accountInfo.balance
            }
            arg8:dispatch(var4(tbl2))

            if arg7 then
                arg8:dispatch(SetRobloxSubscriptionProducts(arg7))
            end
        else
            arg8:dispatch(SetIsUserEligibleForUnifiedPurchaseFlow(false))
        end

        local var4 = not (var3.getFlagBypassThirdPartySettingForRobloxPurchase() and arg5)
            and (var3.getLuaUseThirdPartyPermissions() or var3.getFlagRestrictSales2())

        local var5, var6 = meetsPrerequisites(arg1, arg4, var4, var3, price)
        if not var5 then
            if not var3.isStudio() and var6 == PurchaseError.ThirdPartyDisabled then
                return arg8:dispatch(CompleteRequest())
            end
            return arg8:dispatch(ErrorOccurred(var6))
        end

        local robux = arg3.robux
        local hasFailed = arg3.hasFailed
        local isPremium = arg2.isPremium
        local playerProductInfoPrice = getPlayerProductInfoPrice(arg1, isPremium)
        if price ~= nil then
            playerProductInfoPrice = price
        end
        local platform = UserInputService:GetPlatform()

        local var7 = selectCartPricingOverride((arg8:getState()))
        local var8 = if var7 == nil then playerProductInfoPrice else var7.priceInRobux

        if hasFailed or not (robux < var8) then
            if playerProductInfoPrice <= robux and state.promptRequest.requestType == RequestType.RobuxUpsell then
                return arg8:dispatch(completeRequest())
            end

            if state.requestType ~= RequestType.AvatarCreationFee then
                var2.signalProductPurchaseShown(arg1.productId, state.requestType)
            end

            return arg8:dispatch(SetPromptState(PromptState.PromptPurchase))
        end

        if var3.getFFlagDisableRobuxUpsell() then
            return arg8:dispatch(ErrorOccurred(PurchaseError.NotEnoughRobuxNoUpsell))
        end

        local paymentPlatform = getPaymentPlatform(platform)

        if arg6 or paymentPlatform ~= PaymentPlatform.Web then
            arg8:dispatch(SetPurchaseFlow(PurchaseFlow.RobuxUpsellV2))
        end

        if arg6 then
            arg8:dispatch(SetPostPurchaseActions({}))
        end

        if LargerRobuxUpsellTest.isEnabled() then
            local fStringLargerRobuxUpsellIxpLayer = GetFStringLargerRobuxUpsellIxpLayer()
            local layerData = var1.getLayerData(fStringLargerRobuxUpsellIxpLayer)
            if layerData then
                var1.logUserLayerExposure(fStringLargerRobuxUpsellIxpLayer)
                if LargerRobuxUpsellTest.isUserEnrolled(layerData) then
                    arg8:dispatch(SetPurchaseFlow(PurchaseFlow.LargeRobuxUpsell))
                end
            end
        end

        local gameId = game.GameId
        local productId = arg1.ProductId
        local displayName = arg1.DisplayName
        local purchaseFlowUuid = if FFlagEnableUpsellSuggestionsAnalyticsId then state.purchaseFlowUUID or nil else nil
        local state2 = arg8:getState()
        return getRobuxUpsellSuggestions(
            playerProductInfoPrice,
            robux,
            paymentPlatform,
            isEligibleForRobuxUpsellPlusButton(
                state2.isUserEligibleForUnifiedPurchaseFlow,
                state2.robloxSubscriptionProducts,
                state2.productPayload,
                selectPrice(state2),
                state2.promptRequest.requestType
            ),
            productId,
            displayName,
            gameId,
            purchaseFlowUuid
        ):andThen(
            function(arg10)
                return handleSuccessfulUpsellSuggestions(arg8, arg10)
            end,
            function()
                return handleFailedUpsellProduct(arg8, state)
            end
        )
    end)
end

return resolvePromptState
