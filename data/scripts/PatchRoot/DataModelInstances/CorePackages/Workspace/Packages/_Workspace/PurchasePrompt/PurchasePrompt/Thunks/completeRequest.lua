-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:40:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local _RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local CompleteRequest = require(scriptParentParent.Actions.CompleteRequest)
local PromptState = require(scriptParentParent.Enums.PromptState)
local RequestType = require(scriptParentParent.Enums.RequestType)
local PurchaseError = require(scriptParentParent.Enums.PurchaseError)

local SelectedRobuxPackage = require(scriptParentParent.Utils.SelectedRobuxPackage)

local Counter = require(scriptParentParent.Enums.Counter)
local sendCounter = require(scriptParentParent.Thunks.sendCounter)

local Analytics = require(scriptParentParent.Services.Analytics)
local PublicBindables = require(scriptParentParent.Services.PublicBindables)
local Thunk = require(scriptParentParent.Thunk)

local FFlagEnableUnifiedPurchaseFlowForDevSubs = require(scriptParentParent.Parent.SharedFlags).FFlagEnableUnifiedPurchaseFlowForDevSubs

local tbl1 = { Analytics, PublicBindables }

local function completeRequest()
    return Thunk.new(script.Name, tbl1, function(arg1, arg2)
        local var1 = arg2[Analytics]
        local state = arg1:getState()
        local requestType = state.promptRequest.requestType
        local purchaseError = state.purchaseError
        local id = state.promptRequest.id
        local hasCompletedPurchase = state.hasCompletedPurchase

        local robuxProductId = SelectedRobuxPackage.getRobuxProductId(state)
        local productId = state.productInfo and state.productInfo.productId

        if state.promptState == PromptState.U13PaymentModal then
            var1.signalScaryModalCanceled(productId, "U13PaymentModal", robuxProductId)
        elseif state.promptState == PromptState.U13MonthlyThreshold1Modal then
            var1.signalScaryModalCanceled(productId, "U13MonthlyThreshold1Modal", robuxProductId)
        elseif state.promptState == PromptState.U13MonthlyThreshold2Modal then
            var1.signalScaryModalCanceled(productId, "U13MonthlyThreshold2Modal", robuxProductId)
        elseif state.promptState == PromptState.ParentalConsentWarningPaymentModal13To17 then
            var1.signalScaryModalCanceled(productId, "ParentalConsentWarningPaymentModal13To17", robuxProductId)
        end

        if state.promptState == PromptState.PurchaseComplete then
            arg1:dispatch(sendCounter(Counter.Success))
        elseif state.promptState == PromptState.Error then
            arg1:dispatch(sendCounter(Counter.Failed))
        else
            arg1:dispatch(sendCounter(Counter.Cancelled))
        end

        if requestType == RequestType.Product then
            local userId = Players.LocalPlayer.UserId

            MarketplaceService:SignalPromptProductPurchaseFinished(userId, id, hasCompletedPurchase)
        elseif requestType == RequestType.GamePass then
            MarketplaceService:SignalPromptGamePassPurchaseFinished(Players.LocalPlayer, id, hasCompletedPurchase)
        elseif requestType == RequestType.Bundle then
            MarketplaceService:SignalPromptBundlePurchaseFinished(Players.LocalPlayer, id, hasCompletedPurchase)
        elseif requestType == RequestType.Asset then
            MarketplaceService:SignalPromptPurchaseFinished(Players.LocalPlayer, id, hasCompletedPurchase)

            local assetTypeId = state.productInfo.assetTypeId
            if hasCompletedPurchase and assetTypeId then
                pcall(function()
                    MarketplaceService:SignalAssetTypePurchased(Players.LocalPlayer, assetTypeId)
                end)
            end
        elseif requestType == RequestType.Subscription then
            MarketplaceService:SignalPromptSubscriptionPurchaseFinished(
                id,
                hasCompletedPurchase or purchaseError == PurchaseError.AlreadySubscribed
            )
        elseif FFlagEnableUnifiedPurchaseFlowForDevSubs and requestType == RequestType.DeveloperSubscription then
            MarketplaceService:SignalPromptSubscriptionPurchaseFinished(
                state.promptRequest.subscriptionId,
                hasCompletedPurchase or purchaseError == PurchaseError.AlreadySubscribed
            )
        end

        local windowStateChangedBindable = arg2[PublicBindables].getWindowStateChangedBindable()
        if windowStateChangedBindable then
            windowStateChangedBindable:Fire({ isShown = false, hasCompletedPurchase = hasCompletedPurchase })
        end

        if state.purchaseCallbacks.onFlowComplete then
            state.purchaseCallbacks.onFlowComplete()
        end
        return arg1:dispatch(CompleteRequest())
    end)
end

return completeRequest
