-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local Players = game:GetService("Players")
local ErrorOccurred = require(PurchasePrompt.Actions.ErrorOccurred)
local SetPromptState = require(PurchasePrompt.Actions.SetPromptState)
local UpsellFlow = require(PurchasePrompt.Enums.UpsellFlow)
local PromptState = require(PurchasePrompt.Enums.PromptState)
local PurchaseError = require(PurchasePrompt.Enums.PurchaseError)
local _PurchaseFlow = require(PurchasePrompt.Enums.PurchaseFlow)
local getUpsellFlow = require(PurchasePrompt.NativeUpsell.getUpsellFlow)
local Constants = require(PurchasePrompt.Misc.Constants)
local postPurchaseWarningAcknowledge = require(PurchasePrompt.Network.postPurchaseWarningAcknowledge)
local Analytics = require(PurchasePrompt.Services.Analytics)
local ExternalSettings = require(PurchasePrompt.Services.ExternalSettings)
local Network = require(PurchasePrompt.Services.Network)
local PlatformInterface = require(PurchasePrompt.Services.PlatformInterface)
local Thunk = require(PurchasePrompt.Thunk)
local Promise = require(PurchasePrompt.Promise)

local getAppFeaturePolicies = require(PurchasePromptParent.UniversalAppPolicy).getAppFeaturePolicies
local GetFStringVNGWebshopUrl = require(PurchasePromptParent.SharedFlags).GetFStringVNGWebshopUrl

local retryAfterUpsell = require(script.Parent.retryAfterUpsell)

local IAPExperience = require(PurchasePromptParent.IAPExperience)
local PreparePaymentCheck = IAPExperience.PreparePaymentCheck
local GetEnableConsolePreparePaymentCheck = IAPExperience.GetEnableConsolePreparePaymentCheck

local SelectedRobuxPackage = require(PurchasePrompt.Utils.SelectedRobuxPackage)
local DesktopUpsellExperiment = IAPExperience.Utility.DesktopUpsellExperiment

local tbl1 = {
    Analytics,
    ExternalSettings,
    Network,
    PlatformInterface
}

local function launchRobuxUpsell()
    return Thunk.new(script.Name, tbl1, function(arg1, arg2)
        local var1 = arg2[Analytics]
        local var2 = arg2[ExternalSettings]
        local var3 = arg2[Network]
        local var4 = arg2[PlatformInterface]
        local state = arg1:getState()

        local upsellFlow = getUpsellFlow(var2.getPlatform())
        local robuxProductId = not (upsellFlow == UpsellFlow.Web) and SelectedRobuxPackage.getRobuxProductId(state)
        local productId = state.productInfo.productId
        if GetEnableConsolePreparePaymentCheck() and not PreparePaymentCheck(robuxProductId) then
            arg1:dispatch(ErrorOccurred(PurchaseError.NotEnoughRobuxNoUpsell))
            return
        end

        if state.promptState == PromptState.U13PaymentModal then
            var1.signalScaryModalConfirmed(productId, "U13PaymentModal", robuxProductId)
        elseif state.promptState == PromptState.U13MonthlyThreshold1Modal then
            var1.signalScaryModalConfirmed(productId, "U13MonthlyThreshold1Modal", robuxProductId)
        elseif state.promptState == PromptState.U13MonthlyThreshold2Modal then
            var1.signalScaryModalConfirmed(productId, "U13MonthlyThreshold2Modal", robuxProductId)
        elseif state.promptState == PromptState.ParentalConsentWarningPaymentModal13To17 then
            var1.signalScaryModalConfirmed(productId, "ConfirmedParentalConsentWarningPaymentModal13To17", robuxProductId)
        end

        if state.promptState == PromptState.U13PaymentModal then
            postPurchaseWarningAcknowledge.Post(var3, postPurchaseWarningAcknowledge.UserActionType.ConfirmedU13PaymentModal)
        elseif state.promptState == PromptState.U13MonthlyThreshold1Modal then
            postPurchaseWarningAcknowledge.Post(
                var3,
                postPurchaseWarningAcknowledge.UserActionType.ConfirmedU13MonthlyThreshold1Modal
            )
        elseif state.promptState == PromptState.U13MonthlyThreshold2Modal then
            postPurchaseWarningAcknowledge.Post(
                var3,
                postPurchaseWarningAcknowledge.UserActionType.ConfirmedU13MonthlyThreshold2Modal
            )
        elseif state.promptState == PromptState.ParentalConsentWarningPaymentModal13To17 then
            postPurchaseWarningAcknowledge.Post(
                var3,
                postPurchaseWarningAcknowledge.UserActionType.ConfirmedParentalConsentWarningPaymentModal13To17
            )
        end

        if var2.getFFlagDisableRobuxUpsell() then
            arg1:dispatch(ErrorOccurred(PurchaseError.NotEnoughRobuxNoUpsell))
            return
        end

        if upsellFlow == UpsellFlow.Web then
            local requestType = state.requestType
            var1.signalProductPurchaseUpsellConfirmed(productId, requestType, SelectedRobuxPackage.getProductId(state))

            if getAppFeaturePolicies().getRedirectBuyRobuxToVNG() then
                if state.promptState == PromptState.LeaveRobloxWarning then
                    var3.getVngShopUrl(var3):andThen(function(arg3)
                        var4.openVngStore(arg3.vngShopRedirectUrl)
                        arg1:dispatch(SetPromptState(PromptState.UpsellInProgress))
                    end):catch(function()
                        var4.openVngStore(GetFStringVNGWebshopUrl())
                        arg1:dispatch(SetPromptState(PromptState.UpsellInProgress))
                    end)

                    return
                end

                arg1:dispatch(SetPromptState(PromptState.LeaveRobloxWarning))
                return
            end

            local tbl2 = {
                analyticId = state.purchaseFlowUUID
            }

            local variant = DesktopUpsellExperiment.getVariant()
            if variant == DesktopUpsellExperiment.variants.OpenRobuxStore then
                var4.openRobuxStoreWithContext(tbl2, SelectedRobuxPackage.getProductId(state))
            elseif variant == DesktopUpsellExperiment.variants.OpenPaymentsPage then
                var4.openPaymentsPageWithContext(tbl2, SelectedRobuxPackage.getProductId(state))
            else
                var4.startRobuxUpsellWebByFlowWithContext(tbl2, state.purchaseFlow, SelectedRobuxPackage.getProductId(state))
            end

            arg1:dispatch(SetPromptState(PromptState.UpsellInProgress))
            return
        end
        if upsellFlow == UpsellFlow.Mobile then
            local robuxProductId2 = SelectedRobuxPackage.getRobuxProductId(state)
            local productId2 = state.productInfo.productId
            local requestType = state.requestType
            local localPlayer = Players.LocalPlayer

            var1.signalProductPurchaseUpsellConfirmed(productId2, requestType, robuxProductId2)
            if game:GetEngineFeature("NativePurchaseWithLocalPlayer") then
                var4.promptNativePurchaseWithLocalPlayer(robuxProductId2)
            else
                var4.promptNativePurchase(localPlayer, robuxProductId2)
            end
            arg1:dispatch(SetPromptState(PromptState.UpsellInProgress))
            return
        end

        if upsellFlow == UpsellFlow.Xbox then
            local robuxProductId2 = SelectedRobuxPackage.getRobuxProductId(state)
            local productId2 = state.productInfo.productId
            local requestType = state.requestType

            var1.signalProductPurchaseUpsellConfirmed(productId2, requestType, robuxProductId2)
            arg1:dispatch(SetPromptState(PromptState.UpsellInProgress))
            return Promise.new(function(callback, callback2)
                local var5 = nil

                local success, result = pcall(function()
                    var5 = var4.beginPlatformStorePurchase(robuxProductId2)
                end)

                if success then
                    callback(var5)
                else
                    callback2(result)
                end
            end):andThen(function(arg3)
                if arg3 == Constants.PlatformPurchaseResult.PurchaseResult_Success then
                    var1.signalXboxInGamePurchaseSuccess(productId2, requestType, robuxProductId2)
                elseif arg3 == Constants.PlatformPurchaseResult.PurchaseResult_UserCancelled then
                    var1.signalXboxInGamePurchaseCanceled(productId2, requestType, robuxProductId2)
                else
                    var1.signalXboxInGamePurchaseFailure(productId2, requestType, robuxProductId2)
                end

                if arg3 == Constants.PlatformPurchaseResult.PurchaseResult_Success
                    or arg3 == Constants.PlatformPurchaseResult.PurchaseResult_RobuxUpdated
                then
                    return arg1:dispatch(retryAfterUpsell())
                end
                return arg1:dispatch(ErrorOccurred(PurchaseError.UnknownFailure))
            end)
        elseif upsellFlow == UpsellFlow.Unavailable then
            arg1:dispatch(ErrorOccurred(PurchaseError.NotEnoughRobuxNoUpsell))
        else
            warn("Need more Robux: platform not supported for Robux purchase")
        end
    end)
end

return launchRobuxUpsell
