-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:41:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")

local SetPromptState = require(PurchasePrompt.Actions.SetPromptState)
local BalanceInfoRecieved = require(PurchasePrompt.Actions.BalanceInfoRecieved)
local PurchaseCompleteRecieved = require(PurchasePrompt.Actions.PurchaseCompleteRecieved)
local ErrorOccurred = require(PurchasePrompt.Actions.ErrorOccurred)
local PromptNativeUpsellSuggestions = require(PurchasePrompt.Actions.PromptNativeUpsellSuggestions)

local _types = require(PurchasePrompt.types)

local PurchaseFlow = require(PurchasePrompt.Enums.PurchaseFlow)
local UpsellFlow = require(PurchasePrompt.Enums.UpsellFlow)
local PurchaseError = require(PurchasePrompt.Enums.PurchaseError)
local PromptState = require(PurchasePrompt.Enums.PromptState)
local RequestType = require(PurchasePrompt.Enums.RequestType)

local Counter = require(PurchasePrompt.Enums.Counter)
local sendCounter = require(PurchasePrompt.Thunks.sendCounter)

local _RobuxUpsell = require(PurchasePrompt.Models.RobuxUpsell)
local getRobuxUpsellSuggestions = require(PurchasePrompt.Network.getRobuxUpsellSuggestions)
local getBalanceInfo = require(PurchasePrompt.Network.getBalanceInfo)
local Network = require(PurchasePrompt.Services.Network)
local Analytics = require(PurchasePrompt.Services.Analytics)
local ExternalSettings = require(PurchasePrompt.Services.ExternalSettings)
local completeRequest = require(PurchasePrompt.Thunks.completeRequest)
local getPlayerPrice = require(PurchasePrompt.Utils.getPlayerPrice)
local hasPendingRequest = require(PurchasePrompt.Utils.hasPendingRequest)
local getPaymentPlatform = require(PurchasePrompt.Utils.getPaymentPlatform)
local isEligibleForRobuxUpsellPlusButton = require(PurchasePrompt.Utils.isEligibleForRobuxUpsellPlusButton)
local selectPrice = require(PurchasePrompt.Selectors.selectPrice)
local getUpsellFlow = require(PurchasePrompt.NativeUpsell.getUpsellFlow)
local Thunk = require(PurchasePrompt.Thunk)

local FFlagAXMISWithBlackbird = require(PurchasePrompt.Parent.SharedFlags).FFlagAXMISWithBlackbird

local bool1 = game:DefineFastFlag("AddUnifiedPurchaseRobuxUpsellCompletedTelemetry", false)
local logUnifiedPurchaseTelemetryCounter = require(PurchasePrompt.Utils.logUnifiedPurchaseTelemetryCounter)
local UnifiedPurchaseTelemetry = require(PurchasePrompt.Events.UnifiedPurchaseTelemetry)

local purchaseItem = require(script.Parent.purchaseItem)

local num1 = game:DefineFastInt("UpsellAccountBalanceRetryAttemps", 3)
local num2 = game:DefineFastInt("UpsellAccountBalanceRetryIntervalSec", 1)

local tbl1 = { Analytics, Network, ExternalSettings }

local function restartUpsell(arg1, _, arg2, robux, arg3)
    local state = arg1:getState()
    return getRobuxUpsellSuggestions(
        arg2,
        robux,
        arg3,
        isEligibleForRobuxUpsellPlusButton(
            state.isUserEligibleForUnifiedPurchaseFlow,
            state.robloxSubscriptionProducts,
            state.productPayload,
            selectPrice(state),
            state.promptRequest.requestType
        )
    ):andThen(
        function(arg4)
            if not hasPendingRequest(arg1:getState()) then
                return
            end
            arg1:dispatch(PromptNativeUpsellSuggestions(arg4.products, 1, arg4.virtualItemBadgeType, arg4.experimentVariant))

            arg1:dispatch(sendCounter(Counter.UpsellModalShownAgain))
        end,
        function()
            if not hasPendingRequest(arg1:getState()) then
                return
            end

            arg1:dispatch(SetPromptState(PromptState.LargeRobuxUpsell))
            arg1:dispatch(sendCounter(Counter.UpsellGenericModalShownAgain))
        end
    )
end

local function retryAfterUpsell(num3: number?)
    local num4 = num3 or num1

    return Thunk.new(script.Name, tbl1, function(arg1, arg2)
        local var1 = arg2[Analytics]
        local var2 = arg2[Network]
        local var3 = arg2[ExternalSettings]
        local state = arg1:getState()
        local requestType = state.promptRequest.requestType
        local promptState = state.promptState
        local purchaseFlow = state.purchaseFlow

        local upsellFlow = getUpsellFlow(var3.getPlatform())

        if requestType == RequestType.None then
            return
        end

        if promptState ~= PromptState.UpsellInProgress and promptState ~= PromptState.PollingBalance then
            return
        end

        if requestType == RequestType.Subscription or FFlagAXMISWithBlackbird and requestType == RequestType.RobuxUpsell then
            if promptState == PromptState.UpsellInProgress then
                arg1:dispatch(PurchaseCompleteRecieved())
                arg1:dispatch(completeRequest())
            end
        else
            if purchaseFlow == PurchaseFlow.RobuxUpsellV2 or purchaseFlow == PurchaseFlow.LargeRobuxUpsell then
                arg1:dispatch(SetPromptState(PromptState.PollingBalance))
            end

            return getBalanceInfo(var2, var3, false):andThen(function(arg3)
                local state2 = arg1:getState()
                local bool2 = state2.accountInfo.membershipType == 4
                local playerPrice = getPlayerPrice(state2.productInfo, bool2)

                if not hasPendingRequest(arg1:getState()) then
                    return
                end

                local paymentPlatform = getPaymentPlatform(var3.getPlatform())

                local balance = state2.accountInfo.balance
                local robux = arg3.robux
                arg1:dispatch(BalanceInfoRecieved(arg3))

                if balance ~= robux then
                    if playerPrice ~= nil and robux < playerPrice then
                        if purchaseFlow == PurchaseFlow.LargeRobuxUpsell or upsellFlow == UpsellFlow.Web then
                            return restartUpsell(arg1, var2, playerPrice, robux, paymentPlatform)
                        end
                        arg1:dispatch(ErrorOccurred(PurchaseError.InvalidFunds))
                        arg1:dispatch(sendCounter(Counter.UpsellFailedNotEnoughRobux))
                        return
                    end

                    if bool1 and state2.purchaseAnalyticsMetadata then
                        local purchaseAnalyticsMetadata = state2.purchaseAnalyticsMetadata
                        logUnifiedPurchaseTelemetryCounter(
                            UnifiedPurchaseTelemetry.UnifiedRobuxUpsellRobuxPurchaseCompletedCounter,
                            purchaseAnalyticsMetadata.surface,
                            purchaseAnalyticsMetadata.productType
                        )
                    end

                    arg1:dispatch(purchaseItem())
                    return
                end

                if num4 > 0 then
                    delay(num2, function()
                        arg1:dispatch(retryAfterUpsell(num4 - 1))
                    end)

                    return
                end

                var1.signalFailedPurchasePostUpsell()
                if upsellFlow == UpsellFlow.Web then
                    restartUpsell(arg1, var2, playerPrice, robux, paymentPlatform)
                else
                    arg1:dispatch(ErrorOccurred(PurchaseError.InvalidFunds))
                end
                if bool1 and state2.purchaseAnalyticsMetadata then
                    local purchaseAnalyticsMetadata = state2.purchaseAnalyticsMetadata
                    logUnifiedPurchaseTelemetryCounter(
                        UnifiedPurchaseTelemetry.UnifiedRobuxUpsellRobuxPurchaseFailedCounter,
                        purchaseAnalyticsMetadata.surface,
                        purchaseAnalyticsMetadata.productType
                    )
                end
            end):catch(function(arg3)
                arg1:dispatch(ErrorOccurred(arg3))
            end)
        end
    end)
end

return retryAfterUpsell
