-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:31:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AccountUpgrade = script:FindFirstAncestor("AccountUpgrade")
local AccountUpgradeParent = AccountUpgrade.Parent

local AuthAnalytics = require(AccountUpgradeParent.AuthAnalytics)
local AuthCommon = require(AccountUpgradeParent.AuthCommon)
local LoggingProtocol = require(AccountUpgradeParent.LoggingProtocol)

local AccountUpgradeFlow = require(AccountUpgrade.AccountUpgradeFlow)
local AccountUpgradeSurface = require(AccountUpgrade.AccountUpgradeSurface)
local FFlagAccountUpgradeOAuthTelemetry = require(AccountUpgrade.Flags.FFlagAccountUpgradeOAuthTelemetry)

local UserGender = AuthCommon.Enums.UserGender
local EventStreamConstants = AuthAnalytics.EventStreamConstants
local TelemetryConfigs = AuthAnalytics.TelemetryConfigs
local authButtonClick = AuthAnalytics.Events.authButtonClick
local authFormInteraction = AuthAnalytics.Events.authFormInteraction
local authModalShown = AuthAnalytics.Events.authModalShown
local authPageload = AuthAnalytics.Events.authPageload
local default = LoggingProtocol.default

local ActionType = EventStreamConstants.ActionType
local Context = EventStreamConstants.Context
local Button = EventStreamConstants.Button
local Field = EventStreamConstants.Field
local State = EventStreamConstants.State

local tbl1 = {
    [AccountUpgradeSurface.Dialog] = EventStreamConstants.Origin.AccountUpgradeOAuthDialog,
    [AccountUpgradeSurface.FullPage] = EventStreamConstants.Origin.AccountUpgradeOAuthFullPage
}

local function getEventOrigin(oAuth, arg1) -- Luacid: Inlined by compiler; 18 call sites recovered
    return if oAuth == AccountUpgradeFlow.OAuth then tbl1[arg1] else oAuth
end

local function logCounter(arg1, flow, surface, errorCode: string?) -- Luacid: Inlined by compiler; 8 call sites recovered
    default:logRobloxTelemetryCounter(arg1, 1, { flow = flow, surface = surface, errorCode = errorCode })
end

local module = { getEventOrigin = getEventOrigin }

function module.reportOpened(oAuth, surface)
    if oAuth ~= AccountUpgradeFlow.OAuth then
        return
    end

    local var1 = if FFlagAccountUpgradeOAuthTelemetry then oAuth else nil
    authPageload(Context.AccountUpgrade, var1, nil, (getEventOrigin(oAuth, surface)))
    logCounter(TelemetryConfigs.AccountUpgradePageMountConfig, oAuth, surface, nil)
end

function module.reportCloseButtonClicked(oAuth, surface)
    if oAuth ~= AccountUpgradeFlow.OAuth then
        return
    end

    local eventOrigin = getEventOrigin(oAuth, surface)
    local var1 = if FFlagAccountUpgradeOAuthTelemetry then oAuth else nil
    authButtonClick(Context.AccountUpgrade, Button.DismissCornerX, var1, nil, nil, eventOrigin)
    authModalShown(Context.AccountUpgradeCloseWarning, var1, nil, eventOrigin)
    logCounter(TelemetryConfigs.AccountUpgradeCloseButtonClickedConfig, oAuth, surface, nil)
end

function module.reportCloseWarningBack(oAuth, surface)
    if oAuth ~= AccountUpgradeFlow.OAuth then
        return
    end

    local eventOrigin = getEventOrigin(oAuth, surface)
    local var1 = if FFlagAccountUpgradeOAuthTelemetry then oAuth else nil
    authButtonClick(Context.AccountUpgradeCloseWarning, Button.Back, var1, nil, nil, eventOrigin)
    logCounter(TelemetryConfigs.AccountUpgradeCloseWarningBackButtonClickedConfig, oAuth, surface, nil)
end

function module.reportCloseWarningClose(oAuth, surface)
    if oAuth ~= AccountUpgradeFlow.OAuth then
        return
    end

    local eventOrigin = getEventOrigin(oAuth, surface)
    local var1 = if FFlagAccountUpgradeOAuthTelemetry then oAuth else nil
    authButtonClick(Context.AccountUpgradeCloseWarning, Button.Close, var1, nil, nil, eventOrigin)
    logCounter(TelemetryConfigs.AccountUpgradeCloseWarningCloseButtonClickedConfig, oAuth, surface, nil)
end

function module.reportBirthdayActivated(oAuth, arg1)
    if oAuth ~= AccountUpgradeFlow.OAuth then
        return
    end

    local eventOrigin = getEventOrigin(oAuth, arg1)
    authFormInteraction(Context.AccountUpgrade, Field.Birthday, ActionType.Focus, eventOrigin)
    authFormInteraction(Context.AccountUpgrade, Field.BirthdayPicker, State.BirthdayPickerOpened, eventOrigin)
end

function module.reportBirthdayConfirmed(oAuth, arg1)
    if oAuth ~= AccountUpgradeFlow.OAuth then
        return
    end
    authButtonClick(Context.AccountUpgrade, Button.ConfirmBirthday, oAuth, nil, nil, (getEventOrigin(oAuth, arg1)))
end

function module.reportBirthdayPickerClosed(oAuth, arg1)
    if oAuth ~= AccountUpgradeFlow.OAuth then
        return
    end
    authFormInteraction(
        Context.AccountUpgrade,
        Field.BirthdayPicker,
        State.BirthdayPickerClosedWithoutConfirm,
        (getEventOrigin(oAuth, arg1))
    )
end

function module.reportBirthdayPickerAllPicked(oAuth, arg1)
    if oAuth ~= AccountUpgradeFlow.OAuth then
        return
    end
    authFormInteraction(
        Context.AccountUpgrade,
        Field.BirthdayPicker,
        State.BirthdayPickerAllPicked,
        (getEventOrigin(oAuth, arg1))
    )
end

function module.reportUsernameFocused(oAuth, arg1)
    if oAuth ~= AccountUpgradeFlow.OAuth then
        return
    end
    authFormInteraction(Context.AccountUpgrade, Field.Username, ActionType.Focus, (getEventOrigin(oAuth, arg1)))
end

function module.reportUsernameSuggestionSelected(oAuth, arg1, str1: string)
    if oAuth ~= AccountUpgradeFlow.OAuth then
        return
    end
    authButtonClick(Context.AccountUpgrade, Button.UsernameSuggestion, str1, nil, nil, (getEventOrigin(oAuth, arg1)))
end

function module.reportGenderActivated(oAuth, arg1, male: string)
    if oAuth ~= AccountUpgradeFlow.OAuth then
        return
    end

    local var1 = if male == UserGender.Male then Button.GenderMale else Button.GenderFemale
    authButtonClick(Context.AccountUpgrade, var1, oAuth, nil, nil, (getEventOrigin(oAuth, arg1)))
end

function module.reportLegalLinkActivated(oAuth, arg1, str1: string)
    if oAuth ~= AccountUpgradeFlow.OAuth then
        return
    end

    local var1 = if str1 == "terms" then Field.TermsOfService else Field.PrivacyPolicy
    authFormInteraction(Context.AccountUpgrade, var1, oAuth, (getEventOrigin(oAuth, arg1)))
end

function module.reportSucceeded(oAuth, surface)
    if oAuth ~= AccountUpgradeFlow.OAuth then
        return
    end
    authPageload(Context.AccountUpgrade, State.UpgradeSuccess, nil, (getEventOrigin(oAuth, surface)))
    logCounter(TelemetryConfigs.AccountUpgradeSuccessConfig, oAuth, surface, nil)
end

function module.reportFirstFailure(oAuth, surface, num1: number?)
    if oAuth ~= AccountUpgradeFlow.OAuth then
        return
    end
    authPageload(Context.AccountUpgrade, State.UpgradeFailure, nil, (getEventOrigin(oAuth, surface)))

    local accountUpgradeFailureConfig = TelemetryConfigs.AccountUpgradeFailureConfig
    local errorCode = if num1 ~= nil then tostring(num1) else State.Unknown
    logCounter(accountUpgradeFailureConfig, oAuth, surface, errorCode)
end

function module.reportMarketingConsentShown(oAuth, arg1, bool1: boolean)
    if oAuth ~= AccountUpgradeFlow.OAuth then
        return
    end
    authFormInteraction(
        Context.AccountUpgrade,
        Field.MarketingEmailConsent,
        ActionType.Shown,
        getEventOrigin(oAuth, arg1),
        bool1
    )
end

function module.reportMarketingConsentToggled(oAuth, arg1, bool1: boolean)
    if oAuth ~= AccountUpgradeFlow.OAuth then
        return
    end
    authFormInteraction(
        Context.AccountUpgrade,
        Field.MarketingEmailConsent,
        ActionType.Click,
        getEventOrigin(oAuth, arg1),
        bool1
    )
end

function module.reportMarketingConsentSubmitted(oAuth, arg1, bool1: boolean)
    if oAuth ~= AccountUpgradeFlow.OAuth then
        return
    end
    authFormInteraction(
        Context.AccountUpgrade,
        Field.MarketingEmailConsent,
        ActionType.Submit,
        getEventOrigin(oAuth, arg1),
        bool1
    )
end

function module.reportMarketingConsentAutoOptIn(oAuth, arg1)
    if oAuth ~= AccountUpgradeFlow.OAuth then
        return
    end
    authFormInteraction(
        Context.AccountUpgrade,
        Field.MarketingEmailAutoOptIn,
        ActionType.Submit,
        (getEventOrigin(oAuth, arg1))
    )
end

function module.reportMarketingConsentWriteSucceeded(oAuth, surface)
    if oAuth ~= AccountUpgradeFlow.OAuth then
        return
    end
    logCounter(TelemetryConfigs.AccountUpgradeMarketingConsentWriteSuccessConfig, oAuth, surface, nil)
end

function module.reportMarketingConsentWriteFailed(oAuth, surface, num1: number?)
    if oAuth ~= AccountUpgradeFlow.OAuth then
        return
    end

    local accountUpgradeMarketingConsentWriteFailureConfig = TelemetryConfigs.AccountUpgradeMarketingConsentWriteFailureConfig
    local errorCode = if num1 ~= nil then tostring(num1) else State.Unknown
    logCounter(accountUpgradeMarketingConsentWriteFailureConfig, oAuth, surface, errorCode)
end

return module
