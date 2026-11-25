-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:51:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local React = require(PurchasePromptParent.React)
local useMemo = React.useMemo
local useEffect = React.useEffect

local UIBlox = require(PurchasePromptParent.UIBlox)
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local ButtonType = UIBlox.App.Button.Enum.ButtonType

local LocalizationService = game:GetService("LocalizationService")
local Localization = require(PurchasePromptParent.Localization)
local LocalizationProvider = Localization.LocalizationProvider
local Localization2 = require(PurchasePromptParent.RobloxAppLocales).Localization
local useLocalization = Localization.Hooks.useLocalization

local PromptState = require(PurchasePrompt.Enums.PromptState)
local PurchaseError = require(PurchasePrompt.Enums.PurchaseError)

local IAPExperience = require(PurchasePromptParent.IAPExperience)
local formatEconomicRestrictionText = IAPExperience.Utility.formatEconomicRestrictionText
local addEconomicRestrictionKeysToLocalization = IAPExperience.Utility.addEconomicRestrictionKeysToLocalization

local formatTextWithParams = require(PurchasePrompt.Utils.formatTextWithParams)
local EconomicRestrictionsCounter = IAPExperience.Counters.EconomicRestrictionsCounter
local UniversalEconomicRestrictionsCounter = EconomicRestrictionsCounter.UniversalEconomicRestrictionsCounter
local EconomicRestrictionsSurface = EconomicRestrictionsCounter.EconomicRestrictionsSurface
local _ProductPurchasePromptCounter = IAPExperience.Counters.ProductPurchasePromptCounter.ProductPurchasePromptCounter
local default = require(PurchasePromptParent.LoggingProtocol).default
local FFlagPurchaseModalTimedOptionExtension = require(PurchasePromptParent.SharedFlags).FFlagPurchaseModalTimedOptionExtension
local UnifiedPurchaseCompletionModal = IAPExperience.UnifiedPurchaseCompletionModal
local UnifiedPurchaseCompletionModalV2 = IAPExperience.UnifiedPurchaseCompletionModalV2
local _FFlagFixPurchasingErrorCounter = require(PurchasePrompt.Flags.FFlagFixPurchasingErrorCounter)
local _FFlagAddSurfaceAndProductTypeToPromptCounter = require(PurchasePrompt.Flags.FFlagAddSurfaceAndProductTypeToPromptCounter)
local logProductPurchasePromptCounter = require(PurchasePrompt.Utils.logProductPurchasePromptCounter)

local _FFlagAddCenterDialogForUnifiedPurchaseModal = require(PurchasePromptParent.SharedFlags).FFlagAddCenterDialogForUnifiedPurchaseModal
local AppContext = require(PurchasePrompt.Utils.AppContext)

local FFlagAddCenterDialogForUnifiedPurchaseModal = require(PurchasePromptParent.SharedFlags).FFlagAddCenterDialogForUnifiedPurchaseModal

local FFlagEnableDevProductPendingProductsLimitExceededInUnifiedPurchase = require(PurchasePromptParent.SharedFlags).FFlagEnableDevProductPendingProductsLimitExceededInUnifiedPurchase

local FFlagLuaAppsEnablePromptVIPServerPurchase = require(PurchasePromptParent.SharedFlags).FFlagLuaAppsEnablePromptVIPServerPurchase

local function getPurchaseErrorText(arg1, purchaseError)
    if purchaseError == PurchaseError.CannotGetBalance then
        return arg1.PurchaseErrorCannotGetBalanceText
    end

    if purchaseError == PurchaseError.CannotGetItemPrice then
        return arg1.PurchaseErrorCannotGetItemPriceText
    end

    if purchaseError == PurchaseError.NotForSale then
        return arg1.PurchaseErrorNotForSaleText
    end

    if purchaseError == PurchaseError.NotForSaleHere then
        return arg1.PurchaseErrorNotForSaleHereText
    end

    if purchaseError == PurchaseError.AlreadyOwn then
        return arg1.PurchaseErrorAlreadyOwnText
    end

    if purchaseError == PurchaseError.Under13 then
        return arg1.PurchaseErrorUnder13Text
    end

    if purchaseError == PurchaseError.Limited then
        return arg1.PurchaseErrorLimitedText
    end

    if purchaseError == PurchaseError.ThirdPartyDisabled then
        return arg1.PurchaseErrorThirdPartyDisabledText
    end

    if purchaseError == PurchaseError.NotEnoughRobux then
        return arg1.PurchaseErrorNotEnoughRobuxText
    end

    if purchaseError == PurchaseError.NotEnoughRobuxXbox then
        return arg1.PurchaseErrorNotEnoughRobuxXboxText
    end

    if purchaseError == PurchaseError.NotEnoughRobuxNoUpsell then
        return arg1.PurchaseErrorNotEnoughRobuxNoUpsellText
    end

    if purchaseError == PurchaseError.TwoFactorNeeded then
        return arg1.PurchaseErrorTwoFactorNeededText
    end

    if purchaseError == PurchaseError.TwoFactorNeededSettings then
        return arg1.PurchaseErrorTwoFactorNeededSettingsText
    end

    if purchaseError == PurchaseError.UnknownFailure then
        return arg1.PurchaseErrorUnknownFailureText
    end

    if purchaseError == PurchaseError.UnknownFailureNoItemName then
        return arg1.PurchaseErrorUnknownFailureNoItemNameText
    end

    if purchaseError == PurchaseError.PurchaseDisabled then
        return arg1.PurchaseErrorPurchaseDisabledText
    end

    if purchaseError == PurchaseError.InvalidFunds then
        return arg1.PurchaseErrorInvalidFundsText
    end

    if purchaseError == PurchaseError.InvalidFundsUnknown then
        return arg1.PurchaseErrorInvalidFundsUnknownText
    end

    if purchaseError == PurchaseError.PremiumOnly then
        return arg1.PurchaseErrorPremiumOnlyText
    end

    if FFlagLuaAppsEnablePromptVIPServerPurchase and purchaseError == PurchaseError.VIPServerUnavailable then
        return arg1.PurchaseErrorVIPServerUnavailableText
    end

    if FFlagLuaAppsEnablePromptVIPServerPurchase and purchaseError == PurchaseError.UnsupportedInStudio then
        return arg1.PurchaseErrorUnsupportedInStudioText
    end

    return arg1.PurchaseErrorUnknownFailureNoItemNameText
end

local function getModalContent(arg1, tbl1)
    local promptState = tbl1.promptState
    local purchaseError = tbl1.purchaseError
    local isGenericChallengeResponse = tbl1.isGenericChallengeResponse
    local productInfo = tbl1.productInfo

    if promptState == PromptState.PurchaseComplete then
        if tbl1.useUnifiedPurchaseCompletionModal then
            if tbl1.isMultiItem then
                return {
                    messageText = arg1.MultiItemPurchaseCompleteBody,
                    titleText = arg1.PurchaseCompleteTitle
                }
            end

            if FFlagPurchaseModalTimedOptionExtension and tbl1.completionMessage then
                return {
                    messageText = tbl1.completionMessage,
                    titleText = arg1.PurchaseCompleteTitle
                }
            end

            return {
                messageText = formatTextWithParams(arg1.PurchaseCompleteBody, { ITEM_NAME = tbl1.productInfo.name }),
                titleText = arg1.PurchaseCompleteTitle
            }
        end

        return {
            messageText = formatTextWithParams(arg1.PurchaseCompleteSucceededText, { ITEM_NAME = tbl1.productInfo.name }),
            titleText = arg1.BuyItemTitle
        }
    end

    if promptState == PromptState.U13PaymentModal then
        return {
            messageText = arg1.ScaryModalOneText,
            titleText = arg1.BuyItemTitle
        }
    end

    if promptState == PromptState.U13MonthlyThreshold1Modal then
        return {
            messageText = arg1.ScaryModalTwoText,
            titleText = arg1.BuyItemTitle
        }
    end

    if promptState == PromptState.U13MonthlyThreshold2Modal then
        return {
            messageText = arg1.ScaryModalParentalText,
            titleText = arg1.BuyItemTitle
        }
    end

    if promptState == PromptState.ParentalConsentWarningPaymentModal13To17 then
        return {
            messageText = arg1.ParentalConsentText,
            titleText = arg1.BuyItemTitle
        }
    end

    if promptState ~= PromptState.Error then
        return {
            messageText = arg1.PurchaseErrorUnknownFailureNoItemNameText,
            titleText = arg1.ErrorTitle
        }
    end

    if purchaseError == PurchaseError.UnknownFailure then
        return {
            messageText = formatTextWithParams(arg1.PurchaseErrorUnknownFailureText, { ITEM_NAME = productInfo.name }),
            titleText = arg1.ErrorTitle
        }
    end

    if purchaseError == PurchaseError.TwoFactorNeededSettings or isGenericChallengeResponse(purchaseError) then
        return {
            messageText = arg1.Enable2SVLogoutText,
            titleText = arg1.ErrorTitle
        }
    end

    if purchaseError == PurchaseError.EconomicRestriction then
        return {
            messageText = formatEconomicRestrictionText(arg1, {
                violationType = tbl1.economicRestrictionError.violationType,
                timeoutMinutes = tbl1.economicRestrictionError.timeoutMinutes
            }, true),
            titleText = arg1.ErrorTitle
        }
    end

    if FFlagEnableDevProductPendingProductsLimitExceededInUnifiedPurchase
        and purchaseError == PurchaseError.PendingProductsLimitExceeded
    then
        return {
            messageText = arg1.DevProductPendingProductsLimitExceededMessageText,
            titleText = arg1.DevProductPendingProductsLimitExceededTitleText
        }
    end

    return {
        messageText = getPurchaseErrorText(arg1, purchaseError),
        titleText = arg1.ErrorTitle
    }
end

local function getButtonStackInfo(tbl1, arg1): {{buttonType: any, props: {inputIcon: string?, onActivated: any, text: any}}} | {{buttonType: any, props: {inputIcon: string?, onActivated: any, text: any}} | {props: {inputIcon: string?, onActivated: any, text: any}}}
    if not tbl1.includeCancelButton then
        return {{
            buttonType = ButtonType.PrimarySystem,
            props = {
                onActivated = tbl1.confirmButtonPressed,
                text = arg1.OkButtonText,
                inputIcon = if tbl1.isGamepadEnabled then "rbxasset://textures/ui/Controls/DesignSystem/ButtonA.png" else nil
            }
        }}
    end

    return {
        {
            props = {
                onActivated = tbl1.cancelButtonPressed,
                text = arg1.CancelPurchaseText,
                inputIcon = if tbl1.isGamepadEnabled then "rbxasset://textures/ui/Controls/DesignSystem/ButtonB.png" else nil
            }
        },
        {
            buttonType = ButtonType.PrimarySystem,
            props = {
                onActivated = tbl1.confirmButtonPressed,
                text = arg1.OkButtonText,
                inputIcon = if tbl1.isGamepadEnabled then "rbxasset://textures/ui/Controls/DesignSystem/ButtonA.png" else nil
            }
        }
    }
end

local function ProductPurchasePrompt(tbl1)
    local tbl2 = {
        PurchaseCompleteTitle = "IAPExperience.PurchasePrompt.Title.PurchaseCompleted",
        PurchaseCompleteBody = "IAPExperience.PurchasePrompt.Body.PurchaseCompleted",
        PurchaseCompleteSucceededText = "CoreScripts.PurchasePrompt.PurchaseMessage.Succeeded",
        BuyItemTitle = "CoreScripts.PurchasePrompt.Title.BuyItem",
        VerificationRequiredTitle = "CoreScripts.PurchasePrompt.Title.VerificationRequired",
        OkButtonText = "CoreScripts.PurchasePrompt.Button.OK",
        SettingsButtonText = "CoreScripts.PurchasePrompt.Button.Settings",
        CancelPurchaseText = "CoreScripts.PurchasePrompt.CancelPurchase.Cancel",
        ErrorTitle = "CoreScripts.PremiumModal.Title.Error",
        ScaryModalOneText = "CoreScripts.PurchasePrompt.PurchaseDetails.ScaryModalOne",
        ScaryModalTwoText = "CoreScripts.PurchasePrompt.PurchaseDetails.ScaryModalTwo",
        ScaryModalParentalText = "CoreScripts.PurchasePrompt.PurchaseDetails.ScaryModalParental",
        Enable2SVLogoutText = "CoreScripts.PurchasePrompt.PurchaseFailed.Enable2SVLogout",
        PurchaseErrorCannotGetBalanceText = "CoreScripts.PurchasePrompt.PurchaseFailed.CannotGetBalance",
        PurchaseErrorCannotGetItemPriceText = "CoreScripts.PurchasePrompt.PurchaseFailed.CannotGetItemPrice",
        PurchaseErrorNotForSaleText = "CoreScripts.PurchasePrompt.PurchaseFailed.NotForSale",
        PurchaseErrorNotForSaleHereText = "CoreScripts.PurchasePrompt.PurchaseFailed.NotForSaleHere",
        PurchaseErrorAlreadyOwnText = "CoreScripts.PurchasePrompt.PurchaseFailed.AlreadyOwn",
        PurchaseErrorUnder13Text = "CoreScripts.PurchasePrompt.PurchaseFailed.Under13",
        PurchaseErrorLimitedText = "CoreScripts.PurchasePrompt.PurchaseFailed.Limited",
        PurchaseErrorThirdPartyDisabledText = "CoreScripts.PurchasePrompt.PurchaseFailed.ThirdPartyDisabled",
        PurchaseErrorNotEnoughRobuxText = "CoreScripts.PurchasePrompt.PurchaseFailed.NotEnoughRobux",
        PurchaseErrorNotEnoughRobuxXboxText = "CoreScripts.PurchasePrompt.PurchaseFailed.NotEnoughRobuxXbox",
        PurchaseErrorNotEnoughRobuxNoUpsellText = "CoreScripts.PurchasePrompt.PurchaseFailed.NotEnoughRobuxNoUpsell",
        PurchaseErrorTwoFactorNeededText = "CoreScripts.PurchasePrompt.PurchaseFailed.Enable2SV",
        PurchaseErrorTwoFactorNeededSettingsText = "CoreScripts.PurchasePrompt.PurchaseFailed.Enable2SV",
        PurchaseErrorUnknownFailureText = "CoreScripts.PurchasePrompt.PurchaseFailed.UnknownFailure",
        PurchaseErrorUnknownFailureNoItemNameText = "CoreScripts.PurchasePrompt.PurchaseFailed.UnknownFailureNoItemName",
        PurchaseErrorPurchaseDisabledText = "CoreScripts.PurchasePrompt.PurchaseFailed.PurchaseDisabled",
        PurchaseErrorInvalidFundsText = "CoreScripts.PurchasePrompt.PurchaseFailed.InvalidFunds",
        PurchaseErrorInvalidFundsUnknownText = "CoreScripts.PurchasePrompt.PurchaseFailed.InvalidFunds",
        PurchaseErrorPremiumOnlyText = "CoreScripts.PurchasePrompt.PurchaseFailed.PremiumOnly",
        PurchaseErrorVIPServerUnavailableText = "Feature.PrivateServers.Description.VipServersNotSupported",
        PurchaseErrorUnsupportedInStudioText = "Feature.PrivateServers.Description.PrivateServerPurchaseUnavailableInStudio",
        DevProductPendingProductsLimitExceededTitleText = if FFlagEnableDevProductPendingProductsLimitExceededInUnifiedPurchase then "Purchasing.PurchaseDialog.Heading.PendingDeveloperProductLimitReached" else nil,
        DevProductPendingProductsLimitExceededMessageText = if FFlagEnableDevProductPendingProductsLimitExceededInUnifiedPurchase then "Purchasing.PurchaseDialog.Message.PendingDeveloperProductLimitReached" else nil,
        MultiItemPurchaseCompleteBody = "IAPExperience.PurchasePrompt.Body.PurchaseItemsSuccess"
    }
    addEconomicRestrictionKeysToLocalization(tbl2)

    local var1 = useLocalization(tbl2)

    local var2 = useMemo(function()
        return (getModalContent(var1, tbl1))
    end, { tbl1 })

    useEffect(function()
        logProductPurchasePromptCounter(tbl1.promptState, tbl1.purchaseError, tbl1.surface, tbl1.productType)
        if tbl1.purchaseError == PurchaseError.EconomicRestriction then
            default:logRobloxTelemetryCounter(UniversalEconomicRestrictionsCounter, 1, {
                surface = EconomicRestrictionsSurface.InExperience,
                failureReason = tostring(tbl1.economicRestrictionError.violationType)
            })
        end
    end, { tbl1.purchaseError })

    if not tbl1.useUnifiedPurchaseCompletionModal then
        return React.createElement(InteractiveAlert, {
            screenSize = tbl1.screenSize,
            title = var2.titleText,
            titleIcon = tbl1.titleIcon,
            bodyText = var2.messageText,
            buttonStackInfo = {
                buttons = getButtonStackInfo(tbl1, var1)
            }
        })
    end

    local launchAfterPurchaseButtonPressed = tbl1.launchAfterPurchaseButtonPressed
    local enableLaunchAfterPurchase = not (launchAfterPurchaseButtonPressed == nil) and tbl1.promptState == PromptState.PurchaseComplete
    local buttons = {
        text = var1.OkButtonText,
        onActivated = 0,
        onClose = 0,
        onShown = 0
    }
    if launchAfterPurchaseButtonPressed == nil or tbl1.promptState ~= PromptState.PurchaseComplete then
        launchAfterPurchaseButtonPressed = tbl1.confirmButtonPressed
    end

    buttons.onActivated = launchAfterPurchaseButtonPressed

    buttons.onClose = tbl1.cancelButtonPressed
    buttons.onShown = if enableLaunchAfterPurchase then tbl1.launchAfterPurchaseButtonShown else nil

    if FFlagAddCenterDialogForUnifiedPurchaseModal and AppContext.get() == AppContext.Enum.IN_APP then
        return React.createElement(UnifiedPurchaseCompletionModalV2, {
            title = var2.titleText,
            isError = tbl1.promptState ~= PromptState.PurchaseComplete,
            bodyText = var2.messageText,
            buttons = buttons,
            enableLaunchAfterPurchase = enableLaunchAfterPurchase
        })
    end
    return React.createElement(UnifiedPurchaseCompletionModal, {
        title = var2.titleText,
        isError = tbl1.promptState ~= PromptState.PurchaseComplete,
        bodyText = var2.messageText,
        buttons = buttons,
        enableLaunchAfterPurchase = enableLaunchAfterPurchase
    })
end

local function ProductPurchasePromptContainer(tbl1)
    return React.createElement(
        LocalizationProvider,
        {
            localization = Localization2.new(LocalizationService.RobloxLocaleId)
        },
        {
            ProductPurchasePrompt = React.createElement(ProductPurchasePrompt, tbl1)
        }
    )
end
return ProductPurchasePromptContainer
