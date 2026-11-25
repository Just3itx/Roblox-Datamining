-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:51:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _ContextActionService = game:GetService("ContextActionService")

local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local PurchasePromptDeps = require(PurchasePromptParent.PurchasePromptDeps)
local ToastRodux = require(PurchasePromptParent.ToastRodux)

local PromptState = require(PurchasePrompt.Enums.PromptState)
local PurchaseError = require(PurchasePrompt.Enums.PurchaseError)

local _RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local RobloxTranslator = require(PurchasePromptParent.RobloxTranslator)

local Roact = PurchasePromptDeps.Roact
local ToastType = ToastRodux.Enums.ToastType
local IAPExperience = PurchasePromptDeps.IAPExperience
local SubscriptionPurchaseFlow = IAPExperience.PurchaseFlow.SubscriptionPurchaseFlow
local SubscriptionPurchaseFlowState = IAPExperience.PurchaseFlow.SubscriptionPurchaseFlowState
local PurchaseErrorType = IAPExperience.PurchaseFlow.PurchaseErrorType
local VPCModalType = require(PurchasePrompt.Enums.VPCModalType)

local GetFFlagEnableSubscriptionPurchaseToast = require(PurchasePrompt.Flags.GetFFlagEnableSubscriptionPurchaseToast)

local GetFFlagEnableVpcForInExperienceSubscriptionPurchase = require(PurchasePrompt.Flags.GetFFlagEnableVpcForInExperienceSubscriptionPurchase)

local var1 = Roact.PureComponent:extend(script.Name)

function var1.init(arg1)
    function arg1.confirmButtonPressed()
        local props = arg1.props
        local promptState = props.promptState

        if promptState == PromptState.PromptSubscriptionPurchase then
            props.promptSubscriptionPurchase()
        elseif promptState == PromptState.PurchaseComplete or promptState == PromptState.Error then
            props.endPurchase()
        end
    end

    function arg1.cancelButtonPressed()
        arg1.props.endPurchase()
    end
end

function var1.getFlowState(arg1)
    local props = arg1.props

    local promptState = props.promptState

    if promptState == PromptState.PromptSubscriptionPurchase then
        return SubscriptionPurchaseFlowState.PurchaseModal
    end

    if promptState == PromptState.Error then
        if GetFFlagEnableVpcForInExperienceSubscriptionPurchase() and props.purchaseError == PurchaseError.VpcRequired then
            return SubscriptionPurchaseFlowState.PurchaseVPCModal
        end

        return SubscriptionPurchaseFlowState.Error
    end

    return SubscriptionPurchaseFlowState.None
end

function var1.getErrorType(arg1)
    local props = arg1.props

    if props.purchaseError == PurchaseError.AlreadySubscribed then
        return PurchaseErrorType.AlreadySubscribed
    end

    if props.purchaseError == PurchaseError.SubscriptionExceededUserSpendLimit then
        return PurchaseErrorType.SubscriptionExceededUserSpendLimit
    end

    if props.purchaseError == PurchaseError.SubscriptionUnsupportedLocale then
        return PurchaseErrorType.SubscriptionUnsupportedLocale
    end

    if props.purchaseError == PurchaseError.RestrictedUser then
        return PurchaseErrorType.RestrictedUser
    end

    if props.purchaseError == PurchaseError.SubscriptionPurchasePlatformNotSupported then
        return PurchaseErrorType.SubscriptionPurchasePlatformNotSupported
    end

    if props.purchaseError == PurchaseError.SubscriptionInvalidSaleLocation then
        return PurchaseErrorType.SubscriptionInvalidSaleLocation
    end

    if props.purchaseError == PurchaseError.SubscriptionNotForSale then
        return PurchaseErrorType.SubscriptionNotForSale
    end

    if props.purchaseError == PurchaseError.VpcRequired then
        return PurchaseErrorType.VpcRequired
    end

    if props.purchaseError == PurchaseError.ExceedParentalSpendLimit then
        return PurchaseErrorType.ExceedParentalSpendLimit
    end

    if props.purchaseError == PurchaseError.EconomicRestriction then
        return PurchaseErrorType.EconomicRestriction
    end

    return PurchaseErrorType.Unknown
end

function var1.getVPCModalType(_, purchaseVpcModal)
    if purchaseVpcModal == SubscriptionPurchaseFlowState.PurchaseVPCModal then
        return VPCModalType.toRawValue(VPCModalType.EnablePurchase)
    end
    return VPCModalType.toRawValue(VPCModalType.None)
end

function var1.render(arg1)
    local props = arg1.props

    local purchaseState = arg1:getFlowState()
    local errorType = arg1:getErrorType()

    return Roact.createElement(SubscriptionPurchaseFlow, {
        screenSize = props.screenSize,
        purchaseState = purchaseState,
        errorType = errorType,
        economicRestrictionError = props.economicRestrictionError,
        purchaseVPCType = arg1:getVPCModalType(purchaseState),
        subscriptionId = props.subscriptionId,
        name = props.name,
        subscriptionProviderId = props.subscriptionProviderId,
        subscriptionProviderName = props.subscriptionProviderName,
        priceTier = props.priceTier,
        displayPrice = props.displayPrice,
        period = props.period,
        disclaimerText = props.disclaimerText,
        description = props.description,
        itemIcon = props.itemIcon,
        primaryPaymentMethod = props.primaryPaymentMethod,
        secondaryPaymentMethod = props.secondaryPaymentMethod,
        acceptControllerIcon = if props.isGamepadEnabled then "rbxasset://textures/ui/Controls/DesignSystem/ButtonA.png" else nil,
        isTestingMode = props.isTestingMode,
        purchaseSubscription = props.promptSubscriptionPurchase,
        cancelPurchase = props.endPurchase,
        flowComplete = props.endPurchase,
        onAnalyticEvent = props.onAnalyticEvent,
        eventPrefix = "InGame"
    })
end

function var1.didUpdate(arg1)
    if not GetFFlagEnableSubscriptionPurchaseToast() then
        return
    end

    local flowState = arg1:getFlowState()
    local errorType = arg1:getErrorType()

    if flowState ~= SubscriptionPurchaseFlowState.Error or errorType ~= PurchaseErrorType.Unknown then
        return
    end

    arg1.props.setCurrentToastMessage({
        toastTitle = RobloxTranslator:FormatByKey("Feature.Subscription.Error.GenericSubscribeError"),
        toastType = ToastType.NetworkingError
    })
    arg1.props.endPurchase()
end

return var1
