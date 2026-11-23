-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:40:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AccountUpgrade = script:FindFirstAncestor("AccountUpgrade")
local AccountUpgradeParent = AccountUpgrade.Parent

local LocalizationService = game:GetService("LocalizationService")

local Promise = require(AccountUpgradeParent.Promise)
local React = require(AccountUpgradeParent.React)

local useLocalization = require(AccountUpgradeParent.Localization).Hooks.useLocalization
local useRoactService = require(AccountUpgradeParent.RobloxAppHooks).useRoactService
local RoactNetworking = require(AccountUpgradeParent.RoactServiceTags).RoactNetworking
local AuthCommon = require(AccountUpgradeParent.AuthCommon)
local AuthAnalytics = require(AccountUpgradeParent.AuthAnalytics)
local EventStreamConstants = AuthAnalytics.EventStreamConstants
local authButtonClick = AuthAnalytics.Events.authButtonClick
local authClientError = AuthAnalytics.Events.authClientError
local UsernameSuggestor = require(AccountUpgradeParent.AuthSignup).Thunks.UsernameSuggestor
local SharedFlags = require(AccountUpgradeParent.SharedFlags)
local FFlagAllowCurrentUsernameOnSignup = SharedFlags.FFlagAllowCurrentUsernameOnSignup
local GetFFlagEnableAuditForSinglePageSignUp = SharedFlags.GetFFlagEnableAuditForSinglePageSignUp
local DateHelper = require(AccountUpgradeParent.Time).DateHelper
local FFlagEnableDesktopSsoSignupDialog = require(AccountUpgrade.Flags.FFlagEnableDesktopSsoSignupDialog)
local AccountUpgradeField = require(AccountUpgrade.AccountUpgradeField)
local AccountUpgradeFlow = require(AccountUpgrade.AccountUpgradeFlow)
local AccountUpgradeSurface = require(AccountUpgrade.AccountUpgradeSurface)
local AccountUpgradeAnalytics = require(AccountUpgrade.Analytics.AccountUpgradeAnalytics)
local getFlowSpec = require(AccountUpgrade.FlowSpec).getFlowSpec
local computeIsAccountUpgradeButtonEnabled = require(AccountUpgrade.Utils.computeIsAccountUpgradeButtonEnabled)
local getAccountUpgradeErrorCode = require(AccountUpgrade.Utils.getAccountUpgradeErrorCode)
local getAccountUpgradeErrorTextKey = require(AccountUpgrade.Utils.getAccountUpgradeErrorTextKey)
local resolveFieldStates = require(AccountUpgrade.Utils.resolveFieldStates)

local useMarketingConsent = require(AccountUpgrade.Hooks.useMarketingConsent)
local useTextFieldValue = require(AccountUpgrade.Hooks.useTextFieldValue)
local FFlagAccountUpgradeOAuthTelemetry = require(AccountUpgrade.Flags.FFlagAccountUpgradeOAuthTelemetry)
local FFlagAccountUpgradeOAuthDialogFitsContent = require(AccountUpgrade.Flags.FFlagAccountUpgradeOAuthDialogFitsContent)
local FFlagAccountUpgradeMarketingConsent = require(AccountUpgrade.Flags.FFlagAccountUpgradeMarketingConsent)
local _AccountUpgradeView = require(script.Parent.AccountUpgradeView)
local _AccountUpgradeFields = require(script.Parent.AccountUpgradeFields)

local InputValidity = AuthCommon.Enums.InputValidity
local UserGender = AuthCommon.Enums.UserGender
local UsernameValidationContext = AuthCommon.Enums.UsernameValidationContext
local isStringEmail = AuthCommon.Utils.isStringEmail
local AccountUpgradeRequest = AuthCommon.Http.Requests.AccountUpgradeRequest

local tbl1 = {
    startTermsTag = "<a href=\"terms\">",
    endTermsTag = "</a>",
    startPrivacyTag = "<a href=\"privacy\">",
    endPrivacyTag = "</a>"
}

local function noop() end

local tbl2 = { text = nil, isChecked = false, isDisabled = false, onToggled = noop, submit = noop }

local function hasField(arg1, arg2): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
    return table.find(arg1.requiredFields, arg2) ~= nil or table.find(arg1.optionalFields, arg2) ~= nil
end

local tbl3 = {
    [AccountUpgradeField.Birthday] = "Authentication.SignUp.Response.BirthdayMustBeSetFirst",
    [AccountUpgradeField.Username] = "Authentication.SignUp.Response.UsernameMustBeSetFirst"
}

local function getSummaryErrorTextKey(arg1, str1: string): string -- Luacid: Inlined by compiler; 2 call sites recovered
    local blockingField = arg1.blockingField
    if blockingField == nil then
        return str1
    end

    return assert(tbl3[blockingField], `Account upgrade field has no blocker error key: {blockingField}`)
end

local function resolveLegalText(arg1, tbl4)
    local var1 = if tbl4.flow == AccountUpgradeFlow.OAuth then FFlagAccountUpgradeOAuthDialogFitsContent else FFlagEnableDesktopSsoSignupDialog

    if not var1 or tbl4.hidesLegalText == true then
        return {}
    end

    local linkedPlatformAccountName = if arg1.linkedAccountLegalTextKey then tbl4.linkedPlatformAccountName else nil

    if linkedPlatformAccountName then
        return {
            activeKey = arg1.linkedAccountLegalTextKey,
            linkedPlatformAccountName = linkedPlatformAccountName
        }
    end

    local var2

    if arg1.legalTextKey then
        var2 = table.clone(tbl1)
        var2[1] = arg1.legalTextKey
    else
        var2 = nil
    end

    return {
        activeKey = arg1.legalTextKey,
        standardKey = var2
    }
end

local function reportEmail() end

local function useAccountUpgradeViewModel(tbl4)
    local flow = tbl4.flow or AccountUpgradeFlow.Pioneer
    local spec = getFlowSpec(flow)
    assert(spec ~= nil, `Unsupported account upgrade flow: {flow}`)
    local surface = tbl4.surface or AccountUpgradeSurface.Dialog
    local var3 = if FFlagAccountUpgradeOAuthTelemetry then AccountUpgradeAnalytics.getEventOrigin(flow, surface) else flow
    local var4 = useRoactService(RoactNetworking)
    local submit = if FFlagEnableDesktopSsoSignupDialog then tbl4.submit else nil
    local var5 = FFlagEnableDesktopSsoSignupDialog and spec.hostReportsSubmit == true
    local currentUsername = if FFlagAllowCurrentUsernameOnSignup then tbl4.currentUsername else nil
    local birthday, var7 = React.useState(nil)
    local usernameValid, var9 = React.useState(
        if currentUsername ~= nil and currentUsername ~= "" then InputValidity.Valid else InputValidity.Unvalidated
    )

    local passwordValid, var11 = React.useState(InputValidity.Unvalidated)
    local gender, var13 = React.useState(UserGender.Unknown)
    local isBirthdayPickerOpen, var15 = React.useState(false)
    local isCloseConfirmationOpen, var17 = React.useState(false)
    local isSubmitting, var19 = React.useState(false)
    local hidePassword, var21 = React.useState(true)
    local var22, var23 = React.useState({})
    local pillClicked, var25 = React.useState(false)

    local var26, var27 = React.useState(nil)

    local var28 = React.useRef(false)

    React.useEffect(function()
        if FFlagAccountUpgradeOAuthTelemetry then
            AccountUpgradeAnalytics.reportOpened(flow, surface)
        end
    end, { flow, surface })

    local var29 = React.useCallback(function()
        var9(InputValidity.Unvalidated)
        var23({})
    end, {})

    local var30 = React.useCallback(function()
        var11(InputValidity.Unvalidated)
    end, {})

    local var31 = useTextFieldValue(currentUsername, var29)

    local var32 = React.useRef(currentUsername)
    local var33 = useTextFieldValue(nil, var30)
    local var34 = useTextFieldValue(nil, reportEmail)

    local var35 = FFlagEnableDesktopSsoSignupDialog and tbl4.isHidden == true
    local onChanged = var33.onChanged
    local valueRef = var31.valueRef
    if FFlagEnableDesktopSsoSignupDialog then
        React.useEffect(function()
            if var35 then
                var32.current = valueRef.current
                onChanged("")
            end
        end, { var35, onChanged, valueRef })
    end

    local value = var31.value
    local value2 = var33.value
    local value3 = var34.value
    local emailValid = value3 == "" or isStringEmail(value3)
    local emailError = if value3 == "" then nil elseif emailValid then nil else "Authentication.SignUp.Response.InvalidEmail"
    local monthsLocalizationKeys = DateHelper.MonthsLocalizationKeys
    local monthText = if birthday then monthsLocalizationKeys[birthday.Month] else nil
    local var38

    if var26 == nil or var26.isHandled then
        var38 = nil
    else
        local errorCode = if submit then nil else var26.errorCode
        var38 = var26.errorTextKey or getAccountUpgradeErrorTextKey(errorCode)
    end

    local onLegalLinkSelected = tbl4.onLegalLinkSelected

    local onLegalLinkActivated = if FFlagEnableDesktopSsoSignupDialog or FFlagAccountUpgradeOAuthTelemetry or FFlagAccountUpgradeOAuthDialogFitsContent then React.useCallback(function(str1: string)
        if str1 == "terms" then
            if FFlagAccountUpgradeOAuthTelemetry then
                AccountUpgradeAnalytics.reportLegalLinkActivated(flow, surface, "terms")
            end
            if onLegalLinkSelected then
                onLegalLinkSelected("terms")
            end
        elseif str1 == "privacy" then
            if FFlagAccountUpgradeOAuthTelemetry then
                AccountUpgradeAnalytics.reportLegalLinkActivated(flow, surface, "privacy")
            end
            if onLegalLinkSelected then
                onLegalLinkSelected("privacy")
            end
        end
    end, { flow, surface, onLegalLinkSelected }) else nil

    local var40 = FFlagEnableDesktopSsoSignupDialog

    if var40 then
        if spec.capturesAuditContent == true then
            var40 = GetFFlagEnableAuditForSinglePageSignUp()
        else
            var40 = false
        end
    end

    local var41 = resolveLegalText(spec, tbl4)
    local activeKey = var41.activeKey
    local linkedPlatformAccountName = var41.linkedPlatformAccountName

    local var42 = useLocalization({
        titleText = spec.titleTextKey,
        subtitleText = spec.subtitleTextKey,
        legalText = var41.standardKey,
        legalTextTemplate = if var40 then activeKey else nil,
        usernameTitle = if var40 then "Authentication.Login.Label.Username" else nil,
        passwordTitle = if var40 then "CommonUI.Messages.Label.Password" else nil,
        birthdayLabel = "Authentication.SignUp.Label.Birthday",
        birthdayPlaceholder = "Authentication.SignUp.Description.BirthdayHint",
        usernamePlaceholder = "Authentication.SignUp.Message.Username.NoRealNameUse",
        usernameSuggestionPrompt = "Authentication.SignUp.Description.Try",
        passwordPlaceholder = "Authentication.SignUp.Label.PasswordPlaceholder",
        emailLabel = "Authentication.Login.Label.Email",
        emailPlaceholder = "Authentication.SignUp.Label.EnterYourEmail",
        genderLabel = "Authentication.SignUp.Label.Gender",
        femaleText = "Authentication.SignUp.Label.GenderFemale",
        maleText = "Authentication.SignUp.Label.GenderMale",
        saveText = spec.submitTextKey,
        emailError = emailError,
        submitError = var38,
        monthText = monthText,
        dayAffix = DateHelper.DayAffixLocalizationKey,
        yearAffix = DateHelper.YearAffixLocalizationKey
    })
    local legalText = if FFlagEnableDesktopSsoSignupDialog then useLocalization({
        legalText = linkedPlatformAccountName
            and {
                spec.linkedAccountLegalTextKey,
                platform = linkedPlatformAccountName,
                ctaButton = var42.saveText
            }
            or nil
    }).legalText else nil

    local auditContent = if FFlagEnableDesktopSsoSignupDialog then React.useMemo(function()
        if not var40 then
            return nil
        end

        local result = {}
        local function add(translationKey: string, translatedSourceString: string?, parameters) -- Luacid: Inlined by compiler; 6 call sites recovered
            if translatedSourceString == nil then
                return
            end

            table.insert(
                result,
                {
                    translationKey = translationKey,
                    translatedSourceString = translatedSourceString,
                    parameters = parameters
                }
            )
        end

        if hasField(spec, AccountUpgradeField.Birthday) then
            add("Authentication.SignUp.Label.Birthday", var42.birthdayLabel, nil)
        end
        add("Authentication.Login.Label.Username", var42.usernameTitle, nil)

        if hasField(spec, AccountUpgradeField.Password) then
            add("CommonUI.Messages.Label.Password", var42.passwordTitle, nil)
        end

        if hasField(spec, AccountUpgradeField.Email) then
            add("Authentication.Login.Label.Email", var42.emailLabel, nil)
        end

        if hasField(spec, AccountUpgradeField.Gender) then
            add("Authentication.SignUp.Label.Gender", var42.genderLabel, nil)
        end
        if activeKey then
            add(
                activeKey,
                var42.legalTextTemplate,
                linkedPlatformAccountName and {
                    platform = linkedPlatformAccountName,
                    ctaButton = var42.saveText
                } or tbl1
            )
        end
        return result
    end, {
        var40,
        spec,
        activeKey,
        linkedPlatformAccountName,
        var42.saveText,
        var42.birthdayLabel,
        var42.usernameTitle,
        var42.passwordTitle,
        var42.emailLabel,
        var42.genderLabel,
        var42.legalTextTemplate
    }) else nil

    local birthdayText = if birthday == nil or var42.monthText == nil then "" else DateHelper:GetFormattedFullString(
        var42.monthText,
        birthday.Day,
        var42.dayAffix,
        birthday.Year,
        var42.yearAffix,
        " ",
        LocalizationService.RobloxLocaleId
    )

    local var45 = resolveFieldStates
    local tbl5 = {
        spec = spec,
        isSatisfied = {
            [AccountUpgradeField.Birthday] = birthday ~= nil,
            [AccountUpgradeField.Username] = not (value == "") and usernameValid ~= InputValidity.Invalid,
            [AccountUpgradeField.Password] = not (value2 == "") and passwordValid == InputValidity.Valid
        }
    }
    local fieldStates = var45(tbl5)

    local var47 = fieldStates[AccountUpgradeField.Username]
    local var48 = fieldStates[AccountUpgradeField.Password]
    assert(var47 ~= nil, "Account upgrade flow must include a username state")

    local usernameValidatorAdditionalProps = React.useMemo(function()
        return {
            birthday = if birthday then birthday:FormatForEndpoint() else "",
            context = UsernameValidationContext.Signup,
            currentUsername = currentUsername
        }
    end, { birthday, currentUsername })

    local passwordValidatorAdditionalProps = React.useMemo(function()
        return { username = value }
    end, { value })

    local onUsernameValidated = React.useCallback(function(current: string, arg1)
        var9(arg1)

        if birthday == nil or current == "" then
            return
        end

        UsernameSuggestor.suggestUsernames(var4, current, birthday:FormatForEndpoint(), UsernameValidationContext.Signup):andThen(
            function(tbl6)
                if var31.valueRef.current == current and tbl6.shouldUpdateState then
                    var23(tbl6.suggestions or {})
                end
            end
        )
    end, { var4, birthday, var31.valueRef })

    local onPasswordValidated = React.useCallback(function(_: string, arg1)
        var11(arg1)
    end, {})

    local onFieldInteraction = if FFlagEnableDesktopSsoSignupDialog then tbl4.onFieldInteraction else nil

    local onBirthdayActivated = React.useCallback(function()
        if FFlagAccountUpgradeOAuthTelemetry then
            AccountUpgradeAnalytics.reportBirthdayActivated(flow, surface)
        end
        if onFieldInteraction then
            onFieldInteraction("BirthdayFocused")
        end
        var15(true)
    end, { flow, surface, onFieldInteraction })

    local onBirthdayPickerClosed = React.useCallback(function()
        if FFlagAccountUpgradeOAuthTelemetry then
            AccountUpgradeAnalytics.reportBirthdayPickerClosed(flow, surface)
        end
        var15(false)
    end, { flow, surface })

    local onBirthdayPickerAllPicked = if FFlagAccountUpgradeOAuthTelemetry then React.useCallback(function()
        AccountUpgradeAnalytics.reportBirthdayPickerAllPicked(flow, surface)
    end, { flow, surface }) else nil

    local onBirthdayConfirmed = React.useCallback(function(arg1)
        if FFlagAccountUpgradeOAuthTelemetry then
            AccountUpgradeAnalytics.reportBirthdayConfirmed(flow, surface)
        end
        if onFieldInteraction then
            onFieldInteraction("BirthdayConfirmed")
        end
        var7(arg1)
        var15(false)
    end, { flow, surface, onFieldInteraction })

    local onUsernameFocused = if FFlagEnableDesktopSsoSignupDialog or FFlagAccountUpgradeOAuthTelemetry then React.useCallback(function()
        if FFlagAccountUpgradeOAuthTelemetry then
            AccountUpgradeAnalytics.reportUsernameFocused(flow, surface)
        end
        if onFieldInteraction then
            onFieldInteraction("UsernameFocused")
        end
    end, { flow, surface, onFieldInteraction }) else nil

    local onPasswordFocused = if FFlagEnableDesktopSsoSignupDialog then React.useCallback(function()
        if onFieldInteraction then
            onFieldInteraction("PasswordFocused")
        end
    end, { onFieldInteraction }) else nil

    local onGenderChanged = if FFlagEnableDesktopSsoSignupDialog or FFlagAccountUpgradeOAuthTelemetry then React.useCallback(function(unknown: string)
        local var59 = if unknown == UserGender.Unknown then gender else unknown

        if FFlagAccountUpgradeOAuthTelemetry then
            AccountUpgradeAnalytics.reportGenderActivated(flow, surface, var59)
        end
        if onFieldInteraction then
            onFieldInteraction(if var59 == UserGender.Male then "GenderMaleActivated" else "GenderFemaleActivated")
        end

        var13(unknown)
    end, {
        flow,
        surface,
        gender,
        onFieldInteraction
    }) else nil

    local var60 = React.useCallback(function()
        if FFlagAccountUpgradeOAuthTelemetry then
            AccountUpgradeAnalytics.reportCloseButtonClicked(flow, surface)
        end
        var17(true)
    end, { flow, surface })

    local onCloseConfirmationBack = React.useCallback(function()
        if FFlagAccountUpgradeOAuthTelemetry then
            AccountUpgradeAnalytics.reportCloseWarningBack(flow, surface)
        end
        var17(false)
    end, { flow, surface })

    local onSignOut = tbl4.onSignOut
    local var1 = React.useMemo(function(): (() -> ())?
        return if onSignOut == nil then nil else function()
            if FFlagAccountUpgradeOAuthTelemetry then
                AccountUpgradeAnalytics.reportCloseWarningClose(flow, surface)
            end
            onSignOut()
        end
    end, { flow, surface, onSignOut })

    if spec.canDismiss then
        if spec.signsOutOnDismiss then
            if tbl4.onSignOut == nil or isSubmitting then
                var60 = nil
            end
        else
            var60 = tbl4.onClose
        end
    else
        var60 = nil
    end

    local isSaveEnabled = computeIsAccountUpgradeButtonEnabled({
        birthday = birthday,
        username = value,
        password = value2,
        usernameValid = usernameValid,
        passwordValid = passwordValid,
        email = value3,
        emailValid = emailValid,
        isSubmitting = isSubmitting,
        requiredFields = spec.requiredFields
    })

    local onPasswordVisibilityToggle = React.useCallback(function()
        if onFieldInteraction then
            onFieldInteraction(if hidePassword then "PasswordShown" else "PasswordHidden")
        end
        var21(function(arg1): boolean
            return not arg1
        end)
    end, { hidePassword, onFieldInteraction })

    local onUsernameSuggestionSelected = React.useCallback(function(str1: string)
        var31.onChanged(str1)
        var23({})
        if FFlagAccountUpgradeOAuthTelemetry and flow == AccountUpgradeFlow.OAuth then
            AccountUpgradeAnalytics.reportUsernameSuggestionSelected(flow, surface, str1)
            return
        end
        authButtonClick(
            EventStreamConstants.Context.SinglePageSignUpScreen,
            EventStreamConstants.Button.UsernameSuggestion,
            str1
        )
    end, { flow, surface, var31.onChanged })

    local updatePillClicked = React.useCallback(function()
        var25(true)
    end, {})

    local resetPillClicked = React.useCallback(function()
        var25(false)
    end, {})

    local usernameSuggestions = usernameValid ~= InputValidity.Invalid and {} or not (#var22 > 0) and {} or var22

    local tbl6 = tbl2
    if FFlagAccountUpgradeMarketingConsent then
        tbl6 = useMarketingConsent({ spec = spec, flow = flow, surface = surface, birthday = birthday })
    end

    local onSaveActivated = React.useCallback(function()
        if isSubmitting then
            return
        end
        if not var5 then
            authButtonClick(
                EventStreamConstants.Context.AccountUpgrade,
                EventStreamConstants.Button.Save,
                if FFlagAccountUpgradeOAuthTelemetry then flow else nil,
                nil,
                nil,
                var3
            )
        end
        var19(true)
        var27(nil)

        local tbl7 = {
            username = value,
            password = value2,
            birthday = if birthday then birthday:FormatForEndpoint() else "",
            age = if birthday then birthday:GetAgeInYears() else nil,
            email = value3,
            gender = gender
        }

        local var69 = if submit then Promise.try(function()
            local var69 = submit(tbl7)
            if not Promise.is(var69) then
                return Promise.reject({})
            end
            return var69
        end) else AccountUpgradeRequest(var4, {
            upgradeType = spec.upgradeType,
            username = tbl7.username,
            password = tbl7.password,
            birthday = tbl7.birthday,
            email = tbl7.email,
            gender = tbl7.gender
        })

        var69:andThen(function()
            if FFlagAccountUpgradeOAuthTelemetry and not var5 then
                AccountUpgradeAnalytics.reportSucceeded(flow, surface)
            end
            tbl6.submit()
            tbl4.onSignUpComplete({
                isSuccess = true,
                username = if currentUsername == nil then nil else value,
                displayName = if currentUsername == nil or value == currentUsername then nil else value
            })
        end, function(arg1)
            local var70 = submit == nil and {
                errorCode = getAccountUpgradeErrorCode(arg1)
            } or type(arg1) ~= "table" and {} or arg1

            local errorCode = var70.errorCode
            var19(false)
            var27(var70)
            if tbl4.onSignUpFailed then
                tbl4.onSignUpFailed(errorCode)
            end
            if var5 then
                return
            end

            authClientError(
                EventStreamConstants.Context.AccountUpgrade,
                if errorCode ~= nil then tostring(errorCode) else EventStreamConstants.State.Unknown,
                nil,
                var3
            )
            if FFlagAccountUpgradeOAuthTelemetry and not var28.current then
                var28.current = true
                AccountUpgradeAnalytics.reportFirstFailure(flow, surface, errorCode)
            end
        end)
    end, {
        birthday,
        currentUsername,
        value3,
        var3,
        flow,
        gender,
        isSubmitting,
        tbl6.submit,
        var4,
        value2,
        tbl4.onSignUpComplete,
        tbl4.onSignUpFailed,
        submit,
        var5,
        spec,
        surface,
        value
    })

    return {
        titleText = var42.titleText,
        subtitleText = var42.subtitleText,
        birthdayLabel = var42.birthdayLabel,
        birthday = birthday,
        birthdayText = birthdayText,
        birthdayPlaceholder = var42.birthdayPlaceholder,
        usernameTitleTextKey = "Authentication.Login.Label.Username",
        usernameSummaryErrorTextKey = getSummaryErrorTextKey(var47, "Authentication.SignUp.Label.ErrorsWithUsername"),
        isUsernamePrerequisiteMet = var47.isUnlocked,
        fieldStates = fieldStates,
        usernameValidatorAdditionalProps = usernameValidatorAdditionalProps,
        usernamePlaceholder = var42.usernamePlaceholder,
        username = value,
        prefilledUsername = var32.current,
        usernameSuggestions = usernameSuggestions,
        usernameSuggestionPrompt = `{var42.usernameSuggestionPrompt}:`,
        usernameSuggestionEventContext = if FFlagAccountUpgradeOAuthTelemetry and flow == AccountUpgradeFlow.OAuth then EventStreamConstants.Context.AccountUpgrade else nil,
        onUsernameSuggestionSelected = onUsernameSuggestionSelected,
        pillClicked = pillClicked,
        updatePillClicked = updatePillClicked,
        resetPillClicked = resetPillClicked,
        onUsernameValidated = onUsernameValidated,
        passwordTitleTextKey = "CommonUI.Messages.Label.Password",
        passwordSummaryErrorTextKey = if var48 then getSummaryErrorTextKey(var48, "Authentication.SignUp.Label.ErrorsWithPassword") else "Authentication.SignUp.Label.ErrorsWithPassword",
        isPasswordPrerequisiteMet = if var48 then var48.isUnlocked else false,
        passwordValidatorAdditionalProps = passwordValidatorAdditionalProps,
        passwordPlaceholder = var42.passwordPlaceholder,
        onPasswordValidated = onPasswordValidated,
        hidePassword = hidePassword,
        emailLabel = var42.emailLabel,
        emailPlaceholder = var42.emailPlaceholder,
        email = value3,
        emailError = var42.emailError,
        genderLabel = var42.genderLabel,
        femaleText = var42.femaleText,
        maleText = var42.maleText,
        gender = gender,
        saveText = var42.saveText,
        isSaveEnabled = isSaveEnabled,
        isSubmitting = isSubmitting,
        submitError = var42.submitError,
        legalText = legalText or var42.legalText,
        onLegalLinkActivated = onLegalLinkActivated,
        marketingConsentText = tbl6.text,
        isMarketingConsentChecked = tbl6.isChecked,
        isMarketingConsentDisabled = tbl6.isDisabled,
        onMarketingConsentToggled = tbl6.onToggled,
        boldFieldLabels = FFlagEnableDesktopSsoSignupDialog and spec.boldFieldLabels == true,
        fitsDialogToContent = FFlagAccountUpgradeOAuthDialogFitsContent and spec.fitsDialogToContent == true,
        auditContent = auditContent,
        isBirthdayPickerOpen = isBirthdayPickerOpen,
        hasBackdrop = tbl4.hasBackdrop,
        onClose = var60,
        confirmsClose = not (var60 == nil) and spec.signsOutOnDismiss,
        isCloseConfirmationOpen = isCloseConfirmationOpen,
        onCloseConfirmationBack = onCloseConfirmationBack,
        onSignOut = var1,
        onBirthdayActivated = onBirthdayActivated,
        onBirthdayConfirmed = onBirthdayConfirmed,
        onBirthdayPickerClosed = onBirthdayPickerClosed,
        onBirthdayPickerAllPicked = onBirthdayPickerAllPicked,
        onUsernameChanged = var31.onChanged,
        onPasswordChanged = var33.onChanged,
        onEmailChanged = var34.onChanged,
        onGenderChanged = onGenderChanged or var13,
        onUsernameFocused = onUsernameFocused,
        onPasswordFocused = onPasswordFocused,
        onPasswordVisibilityToggle = onPasswordVisibilityToggle,
        onSaveActivated = onSaveActivated
    }
end

return useAccountUpgradeViewModel
