-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:51:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local ContextActionService = game:GetService("ContextActionService")

local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local PurchasePromptDeps = require(PurchasePromptParent.PurchasePromptDeps)
local Roact = PurchasePromptDeps.Roact

local IAPExperience = PurchasePromptDeps.IAPExperience
local RobuxUpsellFlow = IAPExperience.PurchaseFlow.RobuxUpsellFlow
local RobuxUpsellFlowState = IAPExperience.PurchaseFlow.RobuxUpsellFlowState
local U13ConfirmType = IAPExperience.PurchaseFlow.U13ConfirmType
local PurchaseErrorType = IAPExperience.PurchaseFlow.PurchaseErrorType
local _RobuxUpsell = require(PurchasePrompt.Models.RobuxUpsell)

local PromptState = require(PurchasePrompt.Enums.PromptState)
local PurchaseError = require(PurchasePrompt.Enums.PurchaseError)
local VPCModalType = require(PurchasePrompt.Enums.VPCModalType)
local AppContext = require(PurchasePrompt.Utils.AppContext)

local var1 = Roact.PureComponent:extend(script.Name)

local GetFFlagDisablePurchasePromptFunctionForMaquettes = require(PurchasePrompt.Flags.GetFFlagDisablePurchasePromptFunctionForMaquettes)
local PaymentPlatform = require(PurchasePrompt.Enums.PaymentPlatform)
local getPaymentPlatform = require(PurchasePrompt.Utils.getPaymentPlatform)
local getUnifiedPurchaseModalType = require(PurchasePrompt.Utils.getUnifiedPurchaseModalType)
local emitPerformanceMetrics = require(PurchasePrompt.Utils.emitPerformanceMetrics)
local ExternalSettings = require(PurchasePrompt.Services.ExternalSettings)
local UnifiedPurchaseTelemetry = require(PurchasePrompt.Events.UnifiedPurchaseTelemetry)
local logUnifiedPurchaseTelemetryCounter = require(PurchasePrompt.Utils.logUnifiedPurchaseTelemetryCounter)
local sendUnifiedPurchaseEventLog = require(PurchasePrompt.Utils.sendUnifiedPurchaseEventLog)
local deriveUnifiedPurchaseEventRobuxPrice = require(PurchasePrompt.Utils.deriveUnifiedPurchaseEventRobuxPrice)
local UnifiedPurchaseEventNameEnum = require(PurchasePrompt.Enums.UnifiedPurchaseEventNameEnum)
local Constants = require(PurchasePrompt.Misc.Constants)
local HttpService = game:GetService("HttpService")
local FFlagFixCountersForUpsellModalShown = require(PurchasePrompt.Flags.FFlagFixCountersForUpsellModalShown)

local FFlagUnifiedPurchaseFlowMarketplaceUIImprovements = require(PurchasePromptParent.SharedFlags).FFlagUnifiedPurchaseFlowMarketplaceUIImprovements

local FFlagAddPerformanceMetricsToUnifiedPurchaseModal = require(PurchasePromptParent.SharedFlags).FFlagAddPerformanceMetricsToUnifiedPurchaseModal
local FFlagSkipBuyDelayForExperienceShop = require(PurchasePrompt.Flags.FFlagSkipBuyDelayForExperienceShop)

local FFlagLuaAppsEnablePromptVIPServerPurchase = require(PurchasePromptParent.SharedFlags).FFlagLuaAppsEnablePromptVIPServerPurchase

local _IAPExperience = require(PurchasePromptParent.IAPExperience)

function var1.init(arg1)
    function arg1.shouldUseDelayedInput(): boolean
        return not (FFlagSkipBuyDelayForExperienceShop and arg1.props.isFromInExperienceShop)
    end

    arg1.state = {
        canAcceptInput = not arg1.shouldUseDelayedInput()
    }

    function arg1.dispatchFetchPurchaseWarning()
        local props = arg1.props

        if arg1.props.useUnifiedProductPurchaseModal then
            local purchaseAnalyticsMetadata = arg1.props.purchaseAnalyticsMetadata or {}
            logUnifiedPurchaseTelemetryCounter(
                UnifiedPurchaseTelemetry.UnifiedRobuxUpsellModalBuyButtonClickedCounter,
                purchaseAnalyticsMetadata.surface,
                purchaseAnalyticsMetadata.productType
            )
            arg1:emitUnifiedPurchaseTelemetry(UnifiedPurchaseEventNameEnum.RobuxUpsellModalBuyClicked)
        end
        return arg1.props.dispatchFetchPurchaseWarning(props.robuxProviderId)
    end

    function arg1.promptRobuxPurchase()
        local props = arg1.props
        arg1.props.promptRobuxPurchase(arg1.props.networking, props.robuxProviderId, props.robuxProductId)
    end

    function arg1.onDelayedInputComplete()
        arg1:setState({ canAcceptInput = true })
    end

    function arg1.canAcceptInput()
        local state = arg1.state

        return not (Players and Players.LocalPlayer and Players.LocalPlayer.GameplayPaused) and state.canAcceptInput
    end

    function arg1.confirmButtonPressed()
        local props = arg1.props
        local promptState = props.promptState
        local purchaseError = props.purchaseError

        if not arg1.canAcceptInput() then
            return
        end

        if promptState == PromptState.RobuxUpsell then
            props.dispatchFetchPurchaseWarning()
            return
        end
        if promptState == PromptState.LargeRobuxUpsell then
            props.openRobuxStore()
            return
        end

        if promptState == PromptState.U13PaymentModal
            or promptState == PromptState.U13MonthlyThreshold1Modal
            or promptState == PromptState.U13MonthlyThreshold2Modal
            or promptState == PromptState.ParentalConsentWarningPaymentModal13To17
        then
            props.promptRobuxPurchase()
            return
        end
        if promptState == PromptState.PurchaseComplete then
            props.endPurchase()
            return
        end
        if promptState ~= PromptState.Error then
            return
        end
        if purchaseError == PurchaseError.TwoFactorNeeded or purchaseError == PurchaseError.TwoFactorNeededSettings then
            props.openSecuritySettings()
            return
        end
        props.endPurchase()
    end

    function arg1.cancelButtonPressed()
        arg1.props.endPurchase()
    end

    function arg1.onBuyItemButtonMounted(_)
        local purchaseAnalyticsMetadata = arg1.props.purchaseAnalyticsMetadata or {}
        if FFlagFixCountersForUpsellModalShown then
            logUnifiedPurchaseTelemetryCounter(
                UnifiedPurchaseTelemetry.UnifiedRobuxUpsellModalShownCounter,
                purchaseAnalyticsMetadata.surface,
                purchaseAnalyticsMetadata.productType
            )
        else
            logUnifiedPurchaseTelemetryCounter(
                UnifiedPurchaseTelemetry.UnifiedRobuxUpsellModalBuyButtonClickedCounter,
                purchaseAnalyticsMetadata.surface,
                purchaseAnalyticsMetadata.productType
            )
        end
        arg1:emitUnifiedPurchaseTelemetry(UnifiedPurchaseEventNameEnum.RobuxUpsellModalShown)

        if FFlagAddPerformanceMetricsToUnifiedPurchaseModal and purchaseAnalyticsMetadata and purchaseAnalyticsMetadata.surface then
            emitPerformanceMetrics(
                Constants.PerformanceMetrics.IntervalName.RobuxUpsellModalShown,
                purchaseAnalyticsMetadata.surface
            )
        end
    end
end

function var1.didMount(arg1)
    ContextActionService:BindCoreAction("ProductPurchaseConfirmButtonBind", function(_, userInputState, _)
        if userInputState == Enum.UserInputState.Begin then
            arg1.confirmButtonPressed()
        end
    end, false, Enum.KeyCode.ButtonA)
    ContextActionService:BindCoreAction("ProductPurchaseCancelButtonBind", function(_, userInputState, _)
        if userInputState == Enum.UserInputState.Begin then
            arg1.cancelButtonPressed()
        end
    end, false, Enum.KeyCode.ButtonB)
end

function var1.willUnmount(_)
    ContextActionService:UnbindCoreAction("ProductPurchaseConfirmButtonBind")
    ContextActionService:UnbindCoreAction("ProductPurchaseCancelButtonBind")
end

function var1.getFlowState(arg1)
    local props = arg1.props

    local promptState = props.promptState
    local purchaseError = props.purchaseError

    if promptState == PromptState.RobuxUpsell then
        return RobuxUpsellFlowState.PurchaseModal
    end

    if promptState == PromptState.LargeRobuxUpsell then
        return RobuxUpsellFlowState.LargeRobuxPurchaseModal
    end

    if promptState == PromptState.PurchaseInProgress then
        return RobuxUpsellFlowState.ItemPurchasePending
    end

    if promptState == PromptState.UpsellInProgress then
        return RobuxUpsellFlowState.RobuxPurchasePending
    end

    if promptState == PromptState.PollingBalance then
        return RobuxUpsellFlowState.RobuxGrantPending
    end

    if promptState == PromptState.U13PaymentModal then
        return RobuxUpsellFlowState.PurchaseWarning
    end

    if promptState == PromptState.U13MonthlyThreshold1Modal then
        return RobuxUpsellFlowState.PurchaseWarning
    end

    if promptState == PromptState.U13MonthlyThreshold2Modal then
        return RobuxUpsellFlowState.PurchaseWarning
    end

    if promptState == PromptState.PurchaseComplete then
        return RobuxUpsellFlowState.Success
    end

    if promptState == PromptState.LeaveRobloxWarning then
        return RobuxUpsellFlowState.LeaveRobloxWarning
    end

    if promptState == PromptState.EnablePurchaseVPCModal then
        return RobuxUpsellFlowState.PurchaseVPCModal
    end

    if promptState == PromptState.Error then
        if purchaseError == PurchaseError.TwoFactorNeeded or purchaseError == PurchaseError.TwoFactorNeededSettings then
            return RobuxUpsellFlowState.TwoStepRequired
        end

        return RobuxUpsellFlowState.Error
    end

    return RobuxUpsellFlowState.None
end

function var1.getU13ConfirmType(arg1)
    local promptState = arg1.props.promptState

    if promptState == PromptState.U13PaymentModal then
        return U13ConfirmType.U13PaymentModal
    end

    if promptState == PromptState.U13MonthlyThreshold1Modal then
        return U13ConfirmType.U13MonthlyThreshold1Modal
    end

    if promptState == PromptState.U13MonthlyThreshold2Modal then
        return U13ConfirmType.U13MonthlyThreshold2Modal
    end

    if promptState == PromptState.ParentalConsentWarningPaymentModal13To17 then
        return U13ConfirmType.ParentalConsentWarningPaymentModal13To17
    end

    return U13ConfirmType.None
end

function var1.getErrorType(arg1)
    local props = arg1.props

    if props.purchaseError == PurchaseError.AlreadyOwn then
        return PurchaseErrorType.AlreadyOwn
    end

    if props.purchaseError == PurchaseError.NotEnoughRobux
        or props.purchaseError == PurchaseError.NotEnoughRobuxXbox
        or props.purchaseError == PurchaseError.NotEnoughRobuxNoUpsell
    then
        if props.useUnifiedProductPurchaseModal and AppContext.get() == AppContext.Enum.IN_APP then
            return PurchaseErrorType.NotEnoughRobuxInApp
        end

        return PurchaseErrorType.NotEnoughRobux
    end

    if props.purchaseError == PurchaseError.Limited then
        return PurchaseErrorType.Limited
    end

    if props.purchaseError == PurchaseError.NotForSale then
        return PurchaseErrorType.NotForSale
    end

    if props.purchaseError == PurchaseError.NotForSaleHere then
        return PurchaseErrorType.NotForSaleExperience
    end

    if props.purchaseError == PurchaseError.PremiumOnly then
        return PurchaseErrorType.PremiumOnly
    end

    if props.purchaseError == PurchaseError.ThirdPartyDisabled then
        return PurchaseErrorType.ThirdPartyDisabled
    end

    if props.purchaseError == PurchaseError.Under13 then
        return PurchaseErrorType.Under13
    end

    if props.purchaseError == PurchaseError.InvalidFunds then
        return PurchaseErrorType.FailedGrant
    end

    if props.purchaseError == PurchaseError.InvalidFundsUnknown then
        return PurchaseErrorType.FailedGrantUnknown
    end

    if props.purchaseError == PurchaseError.EconomicRestriction then
        return PurchaseErrorType.EconomicRestriction
    end

    return PurchaseErrorType.Unknown
end

function var1.getVPCModalType(arg1)
    if arg1.props.promptState == PromptState.EnablePurchaseVPCModal then
        return VPCModalType.toRawValue(VPCModalType.EnablePurchase)
    end

    return VPCModalType.toRawValue(VPCModalType.None)
end

function var1.emitUnifiedPurchaseTelemetry(arg1, eventName)
    local props = arg1.props

    local purchaseAnalyticsMetadata = props.purchaseAnalyticsMetadata or {}

    local robuxPrice = deriveUnifiedPurchaseEventRobuxPrice(props.cartPricingResponse, purchaseAnalyticsMetadata.price)

    local tbl1 = {
        event_name = eventName,
        purchase_flow_uuid = purchaseAnalyticsMetadata.purchaseFlowUUID,
        product_id = purchaseAnalyticsMetadata.productId,
        product_type = purchaseAnalyticsMetadata.productType,
        product_target_id = purchaseAnalyticsMetadata.productTargetId,
        robux_price = robuxPrice,
        surface = purchaseAnalyticsMetadata.surface,
        user_roblox_balance = purchaseAnalyticsMetadata.userRobuxBalance,
        salelocation_universeid = purchaseAnalyticsMetadata.saleLocationUniverseId,
        product_universeid = purchaseAnalyticsMetadata.productUniverseId,
        event_metadata = HttpService:JSONEncode(
            {
                upsell_robux_package_id = props.robuxProductId,
                upsell_robux_package_amount = props.iapRobuxAmount
            }
        )
    }
    sendUnifiedPurchaseEventLog(tbl1)
end

function var1.render(arg1)
    local props = arg1.props
    local externalSettings = ExternalSettings.new()

    return Roact.createElement(RobuxUpsellFlow, {
        screenSize = props.screenSize,
        shouldAnimate = true,
        isDelayedInput = arg1.shouldUseDelayedInput(),
        onDelayedInputComplete = arg1.onDelayedInputComplete,
        model = props.humanoidModel,
        itemIcon = props.itemIcon,
        itemProductId = props.itemProductId,
        itemName = props.itemName,
        itemRobuxCost = props.itemRobuxCost,
        virtualItemPrice = props.virtualItemPrice,
        iapCostStr = props.iapCostStr,
        iapRobuxAmount = props.iapRobuxAmount,
        beforeRobuxBalance = props.beforeRobuxBalance,
        useUpsellSuggestions = props.useUpsellSuggestions,
        upsellSuggestions = props.upsellSuggestions,
        selectedUpsellIndex = props.selectedUpsellIndex,
        onUpsellSuggestionsSelected = props.onUpsellSuggestionsSelected,
        virtualItemBadgeType = props.virtualItemBadgeType,
        useUnifiedProductPurchaseModal = props.useUnifiedProductPurchaseModal,
        unifiedProductPurchaseModalType = getUnifiedPurchaseModalType(props.requestType),
        onBuyItemButtonMounted = arg1.onBuyItemButtonMounted,
        hideUserRobuxBalance = if FFlagUnifiedPurchaseFlowMarketplaceUIImprovements then props.purchaseAnalyticsMetadata and props.purchaseAnalyticsMetadata.surface == "Catalog" else nil,
        cartPricingResponse = props.cartPricingResponse,
        collectibleItemId = props.collectibleItemId,
        isCartPricingLoading = props.isCartPricingLoading,
        onCartOfferAppliedChanged = props.onCartOfferAppliedChanged,
        postPurchaseActions = props.postPurchaseActions,
        setPostPurchaseActions = props.setPostPurchaseActions,
        onRobloxPlusButtonActivated = props.onRobloxPlusButtonActivated,
        robloxPlusDiscountPercentage = props.robloxPlusDiscountPercentage,
        isMonthlyPrice = if FFlagLuaAppsEnablePromptVIPServerPurchase then props.isMonthlyPrice else nil,
        purchaseState = arg1:getFlowState(),
        errorType = arg1:getErrorType(),
        economicRestrictionError = props.economicRestrictionError,
        u13ConfirmType = arg1:getU13ConfirmType(),
        purchaseVPCType = arg1:getVPCModalType(),
        acceptControllerIcon = if props.isGamepadEnabled then "rbxasset://textures/ui/Controls/DesignSystem/ButtonA.png" else nil,
        cancelControllerIcon = if props.isGamepadEnabled then "rbxasset://textures/ui/Controls/DesignSystem/ButtonB.png" else nil,
        purchaseRobux = arg1.dispatchFetchPurchaseWarning,
        acceptPurchaseWarning = arg1.promptRobuxPurchase,
        openBuyRobux = props.openRobuxStore,
        showTermsOfUse = props.openTermsOfUse,
        openSecuritySettings = props.openSecuritySettings,
        cancelPurchase = props.endPurchase,
        flowComplete = props.endPurchase,
        onAnalyticEvent = props.onAnalyticEvent,
        eventPrefix = "InGame",
        isQuest = GetFFlagDisablePurchasePromptFunctionForMaquettes()
            and getPaymentPlatform(externalSettings.getPlatform()) == PaymentPlatform.Maquettes
    })
end

return var1
