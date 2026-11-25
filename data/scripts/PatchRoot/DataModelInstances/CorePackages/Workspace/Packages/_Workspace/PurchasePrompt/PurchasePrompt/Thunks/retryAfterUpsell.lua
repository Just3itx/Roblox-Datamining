-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:41:22Z
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

local purchaseItem = require(script.Parent.purchaseItem)

local num1 = game:DefineFastInt("UpsellAccountBalanceRetryAttemps", 3)
local num2 = game:DefineFastInt("UpsellAccountBalanceRetryIntervalSec", 1)

local bool1 = game:DefineFastFlag("RetryAfterUpsellV2", false)
local retryAfterUpsellV2 = require(script.Parent.retryAfterUpsellV2)

local bool2 = game:DefineFastFlag("AddUnifiedPurchaseRobuxUpsellCompletedTelemetry2", false)
local logUnifiedPurchaseTelemetryCounter = require(PurchasePrompt.Utils.logUnifiedPurchaseTelemetryCounter)
local UnifiedPurchaseTelemetry = require(PurchasePrompt.Events.UnifiedPurchaseTelemetry)
local FFlagAXMISWithBlackbird = require(PurchasePrompt.Parent.SharedFlags).FFlagAXMISWithBlackbird

local tbl1 = { Analytics, Network, ExternalSettings }

if bool1 then
    return retryAfterUpsellV2
end

local function retryAfterUpsell(arg1)
    local var1 = arg1 or num1

    return Thunk.new(script.Name, tbl1, function(arg2, arg3)
        local var2 = arg3[Analytics]
        local var3 = arg3[Network]
        local var4 = arg3[ExternalSettings]
        local state = arg2:getState()
        local requestType = state.promptRequest.requestType
        local promptState = state.promptState
        local purchaseFlow = state.purchaseFlow

        local upsellFlow = getUpsellFlow(var4.getPlatform())

        if requestType == RequestType.None then
            return
        end

        if promptState ~= PromptState.UpsellInProgress and promptState ~= PromptState.PollingBalance then
            return
        end

        if requestType == RequestType.Subscription or FFlagAXMISWithBlackbird and requestType == RequestType.RobuxUpsell then
            if promptState == PromptState.UpsellInProgress then
                arg2:dispatch(PurchaseCompleteRecieved())
                arg2:dispatch(completeRequest())
            end
        else
            if purchaseFlow == PurchaseFlow.RobuxUpsellV2 or purchaseFlow == PurchaseFlow.LargeRobuxUpsell then
                arg2:dispatch(SetPromptState(PromptState.PollingBalance))
            end

            return getBalanceInfo(var3, var4, false):andThen(function(arg4)
                local state2 = arg2:getState()
                local bool3 = state2.accountInfo.membershipType == 4
                local playerPrice = getPlayerPrice(state2.productInfo, bool3)

                if not hasPendingRequest(arg2:getState()) then
                    return
                end

                local balance = state2.accountInfo.balance
                local robux = arg4.robux
                arg2:dispatch(BalanceInfoRecieved(arg4))
                local state3 = arg2:getState()

                if balance == robux then
                    if var1 > 0 then
                        delay(num2, function()
                            arg2:dispatch(retryAfterUpsell(var1 - 1))
                        end)
                    else
                        var2.signalFailedPurchasePostUpsell()
                        if upsellFlow == UpsellFlow.Web then
                            arg2:dispatch(ErrorOccurred(PurchaseError.InvalidFundsUnknown))
                        else
                            arg2:dispatch(ErrorOccurred(PurchaseError.InvalidFunds))
                        end
                        if bool2 and state2.purchaseAnalyticsMetadata then
                            local purchaseAnalyticsMetadata = state2.purchaseAnalyticsMetadata
                            logUnifiedPurchaseTelemetryCounter(
                                UnifiedPurchaseTelemetry.UnifiedRobuxUpsellRobuxPurchaseFailedCounter,
                                purchaseAnalyticsMetadata.surface,
                                purchaseAnalyticsMetadata.productType
                            )
                        end
                    end

                    return
                end

                if playerPrice == nil or not (robux < playerPrice) then
                    if bool2 and state2.purchaseAnalyticsMetadata then
                        local purchaseAnalyticsMetadata = state2.purchaseAnalyticsMetadata
                        logUnifiedPurchaseTelemetryCounter(
                            UnifiedPurchaseTelemetry.UnifiedRobuxUpsellRobuxPurchaseCompletedCounter,
                            purchaseAnalyticsMetadata.surface,
                            purchaseAnalyticsMetadata.productType
                        )
                    end

                    arg2:dispatch(purchaseItem())
                    return
                end

                if purchaseFlow ~= PurchaseFlow.LargeRobuxUpsell then
                    if upsellFlow == UpsellFlow.Web then
                        arg2:dispatch(ErrorOccurred(PurchaseError.InvalidFundsUnknown))
                    else
                        arg2:dispatch(ErrorOccurred(PurchaseError.InvalidFunds))
                    end
                    arg2:dispatch(sendCounter(Counter.UpsellFailedNotEnoughRobux))
                    return
                end

                local platform = var4.getPlatform()
                local paymentPlatform = getPaymentPlatform(platform)

                return getRobuxUpsellSuggestions(
                    playerPrice,
                    robux,
                    paymentPlatform,
                    isEligibleForRobuxUpsellPlusButton(
                        state3.isUserEligibleForUnifiedPurchaseFlow,
                        state3.robloxSubscriptionProducts,
                        state3.productPayload,
                        selectPrice(state3),
                        state3.promptRequest.requestType
                    )
                ):andThen(
                    function(arg5)
                        if not hasPendingRequest(arg2:getState()) then
                            return
                        end
                        arg2:dispatch(PromptNativeUpsellSuggestions(arg5.products, 1, arg5.virtualItemBadgeType, arg5.experimentVariant))

                        arg2:dispatch(sendCounter(Counter.UpsellModalShownAgain))
                    end,
                    function()
                        if not hasPendingRequest(arg2:getState()) then
                            return
                        end

                        arg2:dispatch(SetPromptState(PromptState.LargeRobuxUpsell))
                        arg2:dispatch(sendCounter(Counter.UpsellGenericModalShownAgain))
                    end
                )
            end):catch(function(arg4)
                arg2:dispatch(ErrorOccurred(arg4))
            end)
        end
    end)
end

return retryAfterUpsell
