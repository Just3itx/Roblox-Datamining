-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:11:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Roact = require(scriptParentParentParent.Roact)
local UIBlox = require(scriptParentParentParent.UIBlox)
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local Images = UIBlox.App.ImageSet.Images

local LocalizationService = game:GetService("LocalizationService")
local Localization = require(scriptParentParentParent.AppLocales).Localization
local LocalizationProvider = require(scriptParentParentParent.Localization).LocalizationProvider
local withLocalization = require(scriptParentParentParent.Localization).withLocalization
local PurchaseErrorType = require(scriptParentParent.Enums.PurchaseErrorType)
local EconomicRestrictionsViolationType = require(scriptParentParent.Enums.EconomicRestrictionsViolationType)

local PurchaseFlowType = require(scriptParent.PurchaseFlowType)
local default = require(scriptParentParentParent.LoggingProtocol).default
local logger = require(scriptParentParent.Utility.logger)
local getAppContext = require(scriptParentParent.Utility.getAppContext)
local var1 = Roact.Component:extend(script.Name)
local PurchaseErrorPromptCounter = require(scriptParentParent.Generic.Events.PurchaseErrorPromptCounter)
local PurchaseErrorPromptShownCounter = PurchaseErrorPromptCounter.PurchaseErrorPromptShownCounter
local EconomicRestrictionsPromptShownCounter = PurchaseErrorPromptCounter.EconomicRestrictionsPromptShownCounter

var1.defaultProps = {
    anchorPoint = Vector2.new(0.5, 0.5),
    position = UDim2.new(0.5, 0, 0.5, 0)
}

function var1.getErrorTitle(_, tbl1, arg1, subscription)
    if arg1 == PurchaseErrorType.FailedRobuxPurchase then
        return tbl1.robuxFailedPurchaseTitle
    end

    if arg1 == PurchaseErrorType.AlreadySubscribed then
        return tbl1.alreadySubscribedTitle
    end

    if subscription == PurchaseFlowType.Subscription then
        return tbl1.cantSubscribeTitle
    end

    return tbl1.titleText
end

function var1.getErrorMessage(_, tbl1, arg1, tbl2)
    if arg1 == PurchaseErrorType.AlreadyOwn then
        return tbl1.alreadyOwnText
    elseif arg1 == PurchaseErrorType.FailedGrant then
        return tbl1.failedGrantText
    elseif arg1 == PurchaseErrorType.FailedGrantUnknown then
        return tbl1.failedGrantUnknownText
    elseif arg1 == PurchaseErrorType.Limited then
        return tbl1.limitedText
    elseif arg1 == PurchaseErrorType.NotEnoughRobux then
        return tbl1.notEnoughRobuxText
    elseif arg1 == PurchaseErrorType.NotForSale then
        return tbl1.notForSaleText
    elseif arg1 == PurchaseErrorType.NotForSaleExperience then
        return tbl1.notForSaleExperienceText
    elseif arg1 == PurchaseErrorType.PremiumOnly then
        return tbl1.premiumOnlyText
    elseif arg1 == PurchaseErrorType.ThirdPartyDisabled then
        return tbl1.thirdPartyDisabledText
    elseif arg1 == PurchaseErrorType.Under13 then
        return tbl1.under13Text
    elseif arg1 == PurchaseErrorType.PremiumPlatformUnavailable then
        return tbl1.premiumPlatformUnavailable
    elseif arg1 == PurchaseErrorType.AlreadyPremium then
        return tbl1.alreadyPremium
    elseif arg1 == PurchaseErrorType.PurchaseLimit then
        return tbl1.purchaseLimitText
    elseif arg1 == PurchaseErrorType.ParentalLimit then
        return tbl1.parentalLimitText
    elseif arg1 == PurchaseErrorType.FailedRobuxPurchase then
        return tbl1.robuxFailedPurchaseText
    elseif arg1 == PurchaseErrorType.AlreadySubscribed then
        return tbl1.alreadySubscribedText
    elseif arg1 == PurchaseErrorType.SubscriptionNotForSale then
        return tbl1.subscriptionNotForSaleText
    elseif arg1 == PurchaseErrorType.SubscriptionExceededUserSpendLimit then
        return tbl1.parentalRestrictionSubscriptionText
    elseif arg1 == PurchaseErrorType.SubscriptionUnsupportedLocale then
        return tbl1.subscriptionUnsupportedLocaleText
    elseif arg1 == PurchaseErrorType.RestrictedUser then
        return tbl1.restrictedUserText
    elseif arg1 == PurchaseErrorType.SubscriptionPurchasePlatformNotSupported
        or arg1 == PurchaseErrorType.SubscriptionInvalidSaleLocation
    then
        return tbl1.subscriptionUnsupportedPlatformText
    elseif arg1 == PurchaseErrorType.VpcRequired then
        return tbl1.vpcRequiredText
    elseif arg1 == PurchaseErrorType.ExceedParentalSpendLimit then
        return tbl1.exceedParentalSpendLimitText
    elseif arg1 == PurchaseErrorType.EconomicRestriction then
        return formatEconomicRestrictionText(tbl1, tbl2)
    end

    return tbl1.unknownText
end

function formatEconomicRestrictionText(tbl1, tbl2)
    local timeoutMinutes = tbl2.timeoutMinutes
    local violationType = tbl2.violationType
    default:logRobloxTelemetryCounter(
        EconomicRestrictionsPromptShownCounter,
        1,
        {
            violationType = tostring(violationType),
            appContext = getAppContext()
        }
    )

    if not (timeoutMinutes and violationType) then
        logger.error({
            error = "Timeout and violationType is required for economic restriction text. Showing unknown error.",
            timeoutMinutes = timeoutMinutes,
            violationType = violationType
        })
        return tbl1.unknownText
    end

    local economicRestrictionViolationLabel = getEconomicRestrictionViolationLabel(tbl1, violationType)
    local num1 = math.ceil(timeoutMinutes / 60)

    if not (num1 >= 24) then
        return tbl1.economicRestrictionBaseTextHours:gsub("{hour}", tostring(num1)):gsub(
            "{violation}",
            economicRestrictionViolationLabel
        )
    end

    local num2 = math.ceil(num1 / 24)
    return tbl1.economicRestrictionBaseTextDays:gsub("{day}", tostring(num2)):gsub(
        "{violation}",
        economicRestrictionViolationLabel
    )
end

function getEconomicRestrictionViolationLabel(tbl1, violationType)
    if violationType == EconomicRestrictionsViolationType.Chargeback then
        return tbl1.chargebackViolationLabel
    end

    if violationType == EconomicRestrictionsViolationType.AbuseOfAffiliateSystem then
        return tbl1.fraudAbuseOfAffiliateSystemViolationLabel
    end

    if violationType == EconomicRestrictionsViolationType.AttemptedUnauthorizedPaymentMethodUse then
        return tbl1.fraudAttemptedUnauthorizedPaymentMethodUseViolationLabel
    end

    if violationType == EconomicRestrictionsViolationType.PaymentAuthorizationAttempt then
        return tbl1.fraudPaymentAbuseViolationLabel
    end

    if violationType == EconomicRestrictionsViolationType.RepeatedRefundRequests then
        return tbl1.fraudRepeatedRefundRequestsViolationLabel
    end

    if violationType == EconomicRestrictionsViolationType.SuspiciousAccountPatterns then
        return tbl1.fraudSuspiciousAccountPatternsViolationLabel
    end

    if violationType == EconomicRestrictionsViolationType.SuspiciousRefundRequests then
        return tbl1.fraudSuspiciousRefundRequestsViolationLabel
    end

    if violationType == EconomicRestrictionsViolationType.UnauthorizedPurchase then
        return tbl1.fraudUnauthorizedPurchaseViolationLabel
    end

    if violationType == EconomicRestrictionsViolationType.UseOfUnauthorizedOffPlatformTransactions then
        return tbl1.fraudUseOfUnauthorizedOffPlatformTransactionsViolationLabel
    end

    if violationType == EconomicRestrictionsViolationType.VirtualEconomyAbuse then
        return tbl1.fraudVirtualEconomyAbuseViolationLabel
    end

    logger.error({ message = "Invalid violation type", violationType = violationType })

    return ""
end

function getIsAlreadyOwnedError(errorType): boolean
    return errorType == PurchaseErrorType.AlreadyOwn
        or errorType == PurchaseErrorType.AlreadyPremium
        or errorType == PurchaseErrorType.AlreadySubscribed
end

function getErrorTitleIcon(errorType)
    return if getIsAlreadyOwnedError(errorType) then Images["icons/status/success_large"] else Images["icons/status/error_large"]
end

function var1.renderNewAlertWithLocalization(arg1)
    return withLocalization({
        titleText = "IAPExperience.PurchaseError.Title.Error",
        robuxFailedPurchaseTitle = "IAPExperience.PurchaseError.Title.RobuxPurchaseFailed",
        robuxFailedPurchaseText = "IAPExperience.PurchaseError.Text.FailedRobuxPurchase",
        unknownText = "IAPExperience.PurchaseError.Text.UnknownError",
        okText = "IAPExperience.PurchaseError.Text.Ok",
        alreadyOwnText = "IAPExperience.PurchaseError.Text.AlreadyOwn",
        failedGrantText = "IAPExperience.PurchaseError.Text.FailedGrant",
        failedGrantUnknownText = "IAPExperience.PurchaseError.Text.FailedGrantUnknown",
        limitedText = "IAPExperience.PurchaseError.Text.Limited",
        notEnoughRobuxText = "IAPExperience.PurchaseError.Text.NotEnoughRobux",
        notForSaleText = "IAPExperience.PurchaseError.Text.NotForSale",
        notForSaleExperienceText = "IAPExperience.PurchaseError.Text.NotForSaleExperience",
        premiumOnlyText = "IAPExperience.PurchaseError.Text.PremiumOnly",
        thirdPartyDisabledText = "IAPExperience.PurchaseError.Text.ThirdPartyDisabled",
        under13Text = "IAPExperience.PurchaseError.Text.Under13",
        premiumPlatformUnavailable = "IAPExperience.PurchaseError.Text.PremiumPlatformUnavailable",
        alreadyPremium = "IAPExperience.PurchaseError.AlreadyPremium",
        purchaseLimitText = "IAPExperience.PurchaseError.Text.PurchaseLimit",
        parentalLimitText = "IAPExperience.PurchaseError.Text.ParentalLimit",
        alreadySubscribedTitle = "IAPExperience.PurchaseError.Title.AlreadySubscribed",
        cantSubscribeTitle = "IAPExperience.PurchaseError.Title.CantSubscribe",
        alreadySubscribedText = "IAPExperience.PurchaseError.Text.AlreadySubscribed",
        subscriptionNotForSaleText = "IAPExperience.PurchaseError.Text.SubscriptionNotForSale",
        parentalRestrictionSubscriptionText = "IAPExperience.PurchaseError.Text.ParentalRestrictionSubscription",
        subscriptionUnsupportedLocaleText = "IAPExperience.PurchaseError.Text.SubscriptionUnsupportedLocale",
        restrictedUserText = "IAPExperience.PurchaseError.Text.RestrictedUser",
        subscriptionUnsupportedPlatformText = "IAPExperience.PurchaseError.Text.SubscriptionUnsupportedPlatform",
        vpcRequiredText = "IAPExperience.PurchaseError.Text.VpcRequired",
        exceedParentalSpendLimitText = "Feature.Subscription.Message.MonthlySpendRestrictionsMonthlyLimitExceed",
        chargebackViolationLabel = "Feature.NotApproved.Label.AbuseType.Chargeback",
        fraudAbuseOfAffiliateSystemViolationLabel = "Feature.NotApproved.Label.Sublabel.FraudAbuseOfTheAffiliateSystem",
        fraudAttemptedUnauthorizedPaymentMethodUseViolationLabel = "Feature.NotApproved.Label.Sublabel.FraudAttemptedUnauthorizedPaymentMethodUse",
        fraudPaymentAbuseViolationLabel = "Feature.NotApproved.Label.Sublabel.FraudPaymentAbuse",
        fraudRepeatedRefundRequestsViolationLabel = "Feature.NotApproved.Label.Sublabel.FraudRepeatedRefundRequests",
        fraudSuspiciousAccountPatternsViolationLabel = "Feature.NotApproved.Label.Sublabel.FraudSuspiciousAccountPatterns",
        fraudSuspiciousRefundRequestsViolationLabel = "Feature.NotApproved.Label.Sublabel.FraudSuspiciousRefundRequests",
        fraudUnauthorizedPurchaseViolationLabel = "Feature.NotApproved.Label.Sublabel.FraudUnauthorizedPurchase",
        fraudUseOfUnauthorizedOffPlatformTransactionsViolationLabel = "Feature.NotApproved.Label.Sublabel.FraudUseOfUnauthorizedOffPlatformTransactions",
        fraudVirtualEconomyAbuseViolationLabel = "Feature.NotApproved.Label.Sublabel.FraudVirtualEconomyAbuse",
        economicRestrictionBaseTextHours = "IAPExperience.PurchaseError.Text.EconomicRestrictionsHours",
        economicRestrictionBaseTextDays = "IAPExperience.PurchaseError.Text.EconomicRestrictionsDays"
    })(
        function(arg2)
            return arg1:renderAlert(arg2)
        end
    )
end

function var1.render(arg1)
    return Roact.createElement(
        LocalizationProvider,
        {
            localization = Localization.new(LocalizationService.RobloxLocaleId)
        },
        {
            Alert = arg1:renderNewAlertWithLocalization()
        }
    )
end

function var1.renderAlert(tbl1, tbl2)
    local props = tbl1.props
    local var2 = props.errorType and PurchaseErrorType.toRawValue(props.errorType) or tostring(props.errorType)
    logger.debug({
        message = "Purchase Error Prompt Shown",
        errorType = tostring(props.errorType),
        errorLabel = var2,
        flowType = tostring(props.flowType),
        screenHeight = props.screenSize.Y,
        screenWidth = props.screenSize.X,
        portrait = props.screenSize.X < props.screenSize.Y,
        appContext = getAppContext()
    })
    default:logRobloxTelemetryCounter(PurchaseErrorPromptShownCounter, 1, {
        errorType = tostring(props.errorType),
        errorLabel = var2,
        flowType = tostring(props.flowType),
        screenHeight = props.screenSize.Y,
        screenWidth = props.screenSize.X,
        portrait = props.screenSize.X < props.screenSize.Y,
        appContext = getAppContext()
    })

    return Roact.createElement(InteractiveAlert, {
        anchorPoint = props.anchorPoint,
        position = props.position,
        screenSize = props.screenSize,
        title = tbl1:getErrorTitle(tbl2, props.errorType, props.flowType),
        titleIcon = getErrorTitleIcon(props.errorType),
        bodyText = tbl1:getErrorMessage(tbl2, props.errorType, props.economicRestrictionError),
        buttonStackInfo = {
            buttons = {{
                buttonType = ButtonType.PrimarySystem,
                props = {
                    onActivated = props.doneActivated,
                    text = tbl2.okText,
                    inputIcon = props.doneControllerIcon
                }
            }}
        }
    })
end

return var1
