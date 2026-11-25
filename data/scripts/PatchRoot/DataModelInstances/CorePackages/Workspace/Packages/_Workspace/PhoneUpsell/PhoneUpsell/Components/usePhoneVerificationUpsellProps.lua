-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:11:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PhoneUpsell = script:FindFirstAncestor("PhoneUpsell")
local PhoneUpsellParent = PhoneUpsell.Parent
local UserInputService = game:GetService("UserInputService")

local React = require(PhoneUpsellParent.React)
local useSelector = require(PhoneUpsellParent.RoactUtils).Hooks.RoactRodux.useSelector
local useDispatch = require(PhoneUpsellParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useSignalState = require(PhoneUpsellParent.SignalsReact).useSignalState
local FFlagUseSignalsForCountryCodeList = require(PhoneUpsellParent.SharedFlags).FFlagUseSignalsForCountryCodeList
local GetCountryCodeListStore = require(PhoneUpsellParent.AuthCommon).Stores.GetCountryCodeListStore

local _LuauPolyfill = require(PhoneUpsellParent.LuauPolyfill)
local RoactNetworking = require(PhoneUpsellParent.RoactServiceTags).RoactNetworking
local EventStreamConstants = require(PhoneUpsell.DuplicateAnalytics.EventStreamConstants)
local RoactAnalyticsAuthEvents = require(PhoneUpsell.DuplicateAnalytics.RoactAnalyticsAuthEvents)
local debounce = require(PhoneUpsell.Utils.debounce)
local mergeProps = require(PhoneUpsell.Utils.mergeProps)
local useRoactService = require(PhoneUpsellParent.RobloxAppHooks).useRoactService

local PhoneVerificationUpsellState = require(PhoneUpsell.Components.PhoneVerificationUpsellState)
local Constants = require(PhoneUpsell.Constants)

local useLocalization = require(PhoneUpsellParent.Localization).Hooks.useLocalization

local SetPhoneNumber = require(PhoneUpsell.Thunks.SetPhoneNumber)
local VerifyPhoneCode = require(PhoneUpsell.Thunks.VerifyPhoneCode)
local ResendPhoneCode = require(PhoneUpsell.Thunks.ResendPhoneCode)
local SetIsPhoneVerified = require(PhoneUpsellParent.ContactImporter).Actions.SetIsPhoneVerified

local GetPrefixAndNationalNumberFromRawPhoneAndDefaultPrefix = require(PhoneUpsell.Utils.GetPrefixAndNationalNumberFromRawPhoneAndDefaultPrefix)

local useUserExperiment = require(PhoneUpsellParent.RoactAppExperiment).useUserExperiment
local GetFStringAndroidPhoneVerificationLayer = require(PhoneUpsellParent.SharedFlags).GetFStringAndroidPhoneVerificationLayer
local GetFStringIOSPhoneVerificationLayer = require(PhoneUpsellParent.SharedFlags).GetFStringIOSPhoneVerificationLayer
local GetFFlagPhoneUseParentSizeForScreenSize = require(PhoneUpsell.Flags.GetFFlagPhoneUseParentSizeForScreenSize)
local GetFFlagAddMorePhoneUpsellEvents = require(PhoneUpsellParent.SharedFlags).GetFFlagAddMorePhoneUpsellEvents

local IdentityProtocol = require(PhoneUpsellParent.IdentityProtocol).IdentityProtocol

local tbl1 = { name = "United States", code = "US", prefix = "1", localizedName = "United States" }

local function func1() end

local tbl2 = {
    onSuccess = func1,
    onFailure = func1,
    onCancelled = func1,
    origin = "",
    eventContext = "",
    addPhoneTitleKey = "Feature.VerificationUpsell.Action.AddPhone",
    addPhoneDescriptionKey = "Feature.VerificationUpsell.Description.VerificationCodeSmsFeesMayApply",
    extraButtonTextKey = "",
    onExtraButtonClick = func1,
    shouldAutofillAndroidPhoneNumberAtLaunch = false,
    alwaysShowAddPhoneLegalText = false,
    requireAddPhoneLegalTextCheckbox = false,
    closeUpsell = func1,
    showWebpage = function(_) end
}

local function usePhoneVerificationUpsellProps(tbl3)
    local var1 = mergeProps(tbl2, tbl3)

    local var2 = if FFlagUseSignalsForCountryCodeList then useSignalState(GetCountryCodeListStore(false).getCountryCodeList) else useSelector(function(arg1)
        return arg1.CountryCodeList
    end)

    local var3 = useDispatch()
    local function func2(arg1, code, prefix, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
        return var3(SetPhoneNumber(arg1, code, prefix, arg2, nil))
    end
    local function func3(arg1, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
        return var3(VerifyPhoneCode(arg1, arg2))
    end
    local function func4(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
        return var3(ResendPhoneCode(arg1))
    end
    local function func5(tbl4: {isPhoneVerified: boolean}) -- Luacid: Inlined by compiler; 1 call site recovered
        return var3(SetIsPhoneVerified(tbl4))
    end

    local var4 = useRoactService(RoactNetworking)
    local var5 = useRoactService(RoactAnalyticsAuthEvents)

    local var6, var7, isOtpInputTypeEnabled, isPhoneNumberTextTypeEnabled = useUserExperiment({ GetFStringAndroidPhoneVerificationLayer(), GetFStringIOSPhoneVerificationLayer() }, function(arg1)
        local var6 = arg1[GetFStringAndroidPhoneVerificationLayer()] or {}
        local var7 = arg1[GetFStringIOSPhoneVerificationLayer()] or {}
        return var6.IsAutofillPhoneNumberEnabled, var6.IsAutofillSMSOtpEnabled, var7.IsAutofillSMSOtpEnabled, var7.IsAutofillPhoneNumberEnabled
    end)

    local phoneUpsellState, var11 = React.useState(if var1.entryConfig then PhoneVerificationUpsellState.Entry else PhoneVerificationUpsellState.AddPhone)

    local phoneNumber, var13 = React.useState("")
    local countryCode, setCountryCode = React.useState(tbl1)
    local var16, var17 = React.useState(false)
    local code, var19 = React.useState("")
    local var20, var21 = React.useState("")
    local addPhoneErrorMessage, var23 = React.useState("")
    local verifyPhoneErrorMessage, var25 = React.useState("")
    local isLoading, _ = React.useState(false)
    local current, var28 = React.useState(false)
    local isDisabled, var30 = React.useState(false)
    local isKeyboardShowing, var32 = React.useState(false)
    local onScreenKeyboardHeight, var34 = React.useState(0)
    local var35, setParentSize = React.useState(Vector2.new(400, 400))
    local var37 = React.useRef(false)

    local var38 = useLocalization({
        verifyingKey = "Feature.VerificationUpsell.Label.Verifying",
        invalidPhoneFormatKey = "Feature.VerificationUpsell.Response.ErrorPhoneFormatInvalid",
        invalidPhoneNumberKey = "Feature.VerificationUpsell.Response.InvalidPhoneNumberError",
        invalidVerificationCodeKey = "Feature.VerificationUpsell.Message.InvalidSmsCode",
        tooManyAccountsKey = "Feature.VerificationUpsell.Response.PhoneHasTooManyAssociatedAccounts",
        tooManyAttemptsKey = "Feature.VerificationUpsell.Response.TooManyAttemptsTryAgainLater",
        genericErrorKey = "Feature.VerificationUpsell.Response.ErrorTryAgain"
    })

    local connection = nil

    React.useEffect(function()
        if var16 or not var2 or not (#var2 > 0) then
            return
        end

        for _, value in var2 do
            if value.isDefault then
                setCountryCode(value)
            end
        end

        var17(true)
    end, { var2, var16 })

    local function func6() -- Luacid: Inlined by compiler; 2 call sites recovered
        local default = IdentityProtocol.default
        default:supportsGetPhoneNumber():andThen(function(bool1: boolean?)
            print("PhoneVerification: Autofill phone number supported: {}!", bool1)
            if not bool1 then
                return
            end
            var5.reportModalActionWithSection(var1.eventContext, "phoneAutofillEligible", "autofill", var1.origin, phoneUpsellState)

            local phoneNumber = default:getPhoneNumber()
            if not phoneNumber then
                return
            end
            phoneNumber:andThen(function(str1: string?)
                if not str1 or str1 == "" then
                    var5.reportModalActionWithSection(var1.eventContext, "phoneAutofillNull", "autofill", var1.origin, phoneUpsellState)

                    return
                end

                local var39, var40 = GetPrefixAndNationalNumberFromRawPhoneAndDefaultPrefix(str1, countryCode.prefix)

                if var39 == tbl1.prefix then
                    var5.reportModalActionWithSection(var1.eventContext, "phoneAutofillUSFound", "autofill", var1.origin, phoneUpsellState)
                end

                var13(var40)

                var5.reportModalActionWithSection(var1.eventContext, "phoneAutofillSuccess", "autofill", var1.origin, phoneUpsellState)
            end)
        end)
    end
    local function func7() -- Luacid: Inlined by compiler; 1 call site recovered
        local default = IdentityProtocol.default
        default:supportsGetSMSOTP():andThen(function(bool1: boolean?)
            print("PhoneVerification: Autofill OTP supported: {}!", bool1)
            if not bool1 then
                return
            end

            var5.reportModalActionWithSection(var1.eventContext, "codeAutofillEligible", "autofill", var1.origin, phoneUpsellState)

            local sMsotp = default:getSMSOTP()
            if not sMsotp then
                return
            end

            sMsotp:andThen(function(str1: string?)
                if str1 and str1 ~= "" then
                    var19(str1)
                    var21(str1)
                    var5.reportModalActionWithSection(var1.eventContext, "codeAutofillSuccess", "autofill", var1.origin, phoneUpsellState)
                end
            end)
        end)
    end

    React.useEffect(function()
        return function()
            var37.current = current
        end
    end, { current })

    React.useEffect(function()
        connection = UserInputService:GetPropertyChangedSignal("OnScreenKeyboardVisible"):Connect(function()
            var32(UserInputService.OnScreenKeyboardVisible)
            var34(UserInputService.OnScreenKeyboardVisible and UserInputService.OnScreenKeyboardSize.Y or 0)
        end)

        var5.reportModalShownWithSection(
            var1.eventContext,
            var1.origin,
            if GetFFlagAddMorePhoneUpsellEvents() then phoneUpsellState else PhoneVerificationUpsellState.AddPhone
        )

        if var6 then
            func6()
        end

        return function()
            if connection then
                connection:Disconnect()
            end
            connection = nil
            if not var37.current then
                var1.onCancelled()
            end
        end
    end, {})

    local var39 = useSelector(function(arg1)
        return arg1.ScreenSize
    end)

    local function handleCloseClick()
        var5.reportModalDismissedWithSection(var1.eventContext, var1.origin, phoneUpsellState)
        var1.closeUpsell()
    end

    local function handlePhoneErrors(num1: number?) -- Luacid: Inlined by compiler; 15 call sites recovered
        if num1 == 2 then
            return var38.invalidPhoneFormatKey
        elseif num1 == 6 then
            return var38.tooManyAttemptsKey
        elseif num1 == 7 then
            return var38.invalidVerificationCodeKey
        elseif num1 == 8 then
            return var38.invalidPhoneNumberKey
        elseif num1 == 9 then
            return var38.tooManyAccountsKey
        end

        return var38.genericErrorKey
    end

    local function handleSetPhone()
        var30(true)
        local var40 = func2(var4, countryCode.code, countryCode.prefix, phoneNumber)
        if var40 then
            var40:andThen(function()
                var11(PhoneVerificationUpsellState.VerifyPhone)
                var30(false)
                var5.reportModalShownWithSection(var1.eventContext, var1.origin, PhoneVerificationUpsellState.VerifyPhone)

                if var7 then
                    func7()
                end
            end):catch(function(tbl4)
                if not tbl4 then
                    var5.reportModalShownWithSectionAndError(
                        var1.eventContext,
                        EventStreamConstants.Field.ErrorMessage,
                        var1.origin,
                        PhoneVerificationUpsellState.AddPhone,
                        ""
                    )
                    var23(var38.genericErrorKey)
                elseif tbl4.PhoneRegexFailed then
                    var5.reportModalShownWithSectionAndError(
                        var1.eventContext,
                        EventStreamConstants.Field.ErrorMessage,
                        var1.origin,
                        PhoneVerificationUpsellState.AddPhone,
                        ""
                    )
                    var23(var38.invalidPhoneFormatKey)
                else
                    var5.reportModalShownWithSectionAndError(
                        var1.eventContext,
                        EventStreamConstants.Field.ErrorMessage,
                        var1.origin,
                        PhoneVerificationUpsellState.AddPhone,
                        tbl4.ErrorCode
                    )
                    local var41 = var23
                    local errorCode = tbl4.ErrorCode
                    local genericErrorKey

                    if errorCode == 2 then
                        genericErrorKey = handlePhoneErrors(2)
                    elseif errorCode == 6 then
                        genericErrorKey = handlePhoneErrors(6)
                    elseif errorCode == 7 then
                        genericErrorKey = handlePhoneErrors(7)
                    elseif errorCode == 8 then
                        genericErrorKey = handlePhoneErrors(8)
                    elseif errorCode == 9 then
                        genericErrorKey = handlePhoneErrors(9)
                    else
                        genericErrorKey = var38.genericErrorKey
                    end

                    var41(genericErrorKey)
                end
                var30(false)
            end)
        end
        var5.reportInteractWithActionAndSection(
            var1.eventContext,
            "",
            "",
            var1.origin,
            EventStreamConstants.Button.Continue,
            PhoneVerificationUpsellState.AddPhone
        )
    end

    local function handleVerifyPhone()
        var30(true)
        local var40 = func3(var4, var20)
        if var40 then
            var40:andThen(function()
                var28(true)
            end):catch(function(tbl4)
                if not tbl4 then
                    var5.reportModalShownWithSectionAndError(
                        var1.eventContext,
                        EventStreamConstants.Field.ErrorMessage,
                        var1.origin,
                        PhoneVerificationUpsellState.VerifyPhone,
                        ""
                    )
                    var25(var38.genericErrorKey)
                else
                    var5.reportModalShownWithSectionAndError(
                        var1.eventContext,
                        EventStreamConstants.Field.ErrorMessage,
                        var1.origin,
                        PhoneVerificationUpsellState.VerifyPhone,
                        tbl4.ErrorCode
                    )
                    local var41 = var25
                    local errorCode = tbl4.ErrorCode
                    local genericErrorKey

                    if errorCode == 2 then
                        genericErrorKey = handlePhoneErrors(2)
                    elseif errorCode == 6 then
                        genericErrorKey = handlePhoneErrors(6)
                    elseif errorCode == 7 then
                        genericErrorKey = handlePhoneErrors(7)
                    elseif errorCode == 8 then
                        genericErrorKey = handlePhoneErrors(8)
                    elseif errorCode == 9 then
                        genericErrorKey = handlePhoneErrors(9)
                    else
                        genericErrorKey = var38.genericErrorKey
                    end

                    var41(genericErrorKey)
                end
                var30(false)
            end)
        end
        var5.reportInteractWithActionAndSection(
            var1.eventContext,
            "",
            "",
            var1.origin,
            EventStreamConstants.Button.AutoSubmit,
            PhoneVerificationUpsellState.VerifyPhone
        )
    end

    local function handleResendCode()
        var25("")
        local var40 = func4(var4)
        if var40 then
            var40:andThen(function() end):catch(function(tbl4)
                if not tbl4 then
                    var5.reportModalShownWithSectionAndError(
                        var1.eventContext,
                        EventStreamConstants.Field.ErrorMessage,
                        var1.origin,
                        PhoneVerificationUpsellState.VerifyPhone,
                        ""
                    )
                    var25(var38.genericErrorKey)
                    return
                end
                var5.reportModalShownWithSectionAndError(
                    var1.eventContext,
                    EventStreamConstants.Field.ErrorMessage,
                    var1.origin,
                    PhoneVerificationUpsellState.VerifyPhone,
                    tbl4.ErrorCode
                )
                local var41 = var25
                local errorCode = tbl4.ErrorCode
                local genericErrorKey

                if errorCode == 2 then
                    genericErrorKey = handlePhoneErrors(2)
                elseif errorCode == 6 then
                    genericErrorKey = handlePhoneErrors(6)
                elseif errorCode == 7 then
                    genericErrorKey = handlePhoneErrors(7)
                elseif errorCode == 8 then
                    genericErrorKey = handlePhoneErrors(8)
                elseif errorCode == 9 then
                    genericErrorKey = handlePhoneErrors(9)
                else
                    genericErrorKey = var38.genericErrorKey
                end

                var41(genericErrorKey)
            end)
        end

        var5.reportInteractWithActionAndSection(
            var1.eventContext,
            "",
            "",
            var1.origin,
            EventStreamConstants.Button.ResendCode,
            PhoneVerificationUpsellState.VerifyPhone
        )
    end

    local function returnToAddPhone()
        var11(PhoneVerificationUpsellState.AddPhone)
        var5.reportInteractWithActionAndSection(
            var1.eventContext,
            "",
            "",
            var1.origin,
            EventStreamConstants.Button.ChangePhoneNumber,
            PhoneVerificationUpsellState.VerifyPhone
        )
    end

    local function proceedToAddPhone()
        var11(PhoneVerificationUpsellState.AddPhone)
        var5.reportInteractWithActionAndSection(
            var1.eventContext,
            "",
            "",
            var1.origin,
            EventStreamConstants.Button.Continue,
            PhoneVerificationUpsellState.Entry
        )
    end

    local function navigateToSMSTerms()
        if not isDisabled then
            var5.reportModalActionWithSection(
                var1.eventContext,
                EventStreamConstants.Field.TermsOfService,
                "",
                var1.origin,
                phoneUpsellState
            )
            var1.showWebpage(Constants.TERMS_OF_SERVICE_URL)
        end
    end

    local function navigateToPrivacy()
        if not isDisabled then
            var5.reportModalActionWithSection(
                var1.eventContext,
                EventStreamConstants.Field.PrivacyPolicy,
                "",
                var1.origin,
                phoneUpsellState
            )
            var1.showWebpage(Constants.PRIVACY_POLICY_URL)
        end
    end

    local function onPhoneNumberTextChange(arg1)
        if not isDisabled then
            var23("")
            var13(arg1.Text)
        end
    end

    local function onCountryCodeSelectorClick()
        var5.reportInteractWithActionAndSection(
            var1.eventContext,
            EventStreamConstants.Field.CountryPrefix,
            EventStreamConstants.ActionType.Focus,
            var1.origin,
            "",
            PhoneVerificationUpsellState.AddPhone
        )
    end

    local function onPhoneInputFocus()
        var5.reportInteractWithActionAndSection(
            var1.eventContext,
            EventStreamConstants.Field.PhoneNumber,
            EventStreamConstants.ActionType.Focus,
            var1.origin,
            "",
            PhoneVerificationUpsellState.AddPhone
        )
        if not var1.shouldAutofillAndroidPhoneNumberAtLaunch then
            func6()
        end
    end

    local var40 = debounce(function(arg1)
        var21(arg1)
    end, 0.5)

    local function onCodeTextChange(arg1)
        local str1 = string.sub(arg1.Text, 1, 6)
        if str1 ~= code then
            var25("")
        end
        var19(str1)
        var40(str1)
    end

    local function onCodeInputFocus()
        var5.reportInteractWithActionAndSection(
            var1.eventContext,
            EventStreamConstants.Field.VerificationCode,
            EventStreamConstants.ActionType.Focus,
            var1.origin,
            "",
            PhoneVerificationUpsellState.VerifyPhone
        )
    end

    React.useEffect(function()
        if string.len(var20) == 6 then
            handleVerifyPhone()
        end
    end, { var20 })

    React.useEffect(function()
        if not current then
            return
        end

        func5({ isPhoneVerified = true })
        var5.reportModalShownWithSection(var1.eventContext, var1.origin, PhoneVerificationUpsellState.Success)

        var1.onSuccess()
    end, { current })

    local tbl4 = {
        phoneUpsellState = phoneUpsellState,
        screenSize = 0,
        setParentSize = 0,
        handleCloseClick = 0,
        proceedToAddPhone = 0,
        countryCode = 0,
        setCountryCode = 0,
        phoneNumber = 0,
        addPhoneErrorMessage = 0,
        isDisabled = 0,
        onPhoneNumberTextChange = 0,
        handleSetPhone = 0,
        navigateToSMSTerms = 0,
        navigateToPrivacy = 0,
        onPhoneInputFocus = 0,
        onCountryCodeSelectorClick = 0,
        isKeyboardShowing = 0,
        onScreenKeyboardHeight = 0,
        code = 0,
        verifyPhoneErrorMessage = 0,
        onCodeTextChange = 0,
        handleResendCode = 0,
        returnToAddPhone = 0,
        onCodeInputFocus = 0,
        isLoading = 0,
        verifyingKey = 0,
        isOTPInputTypeEnabled = 0,
        isPhoneNumberTextTypeEnabled = 0
    }

    if GetFFlagPhoneUseParentSizeForScreenSize() then
        var39 = var35
    end

    tbl4.screenSize = var39
    tbl4.setParentSize = setParentSize
    tbl4.handleCloseClick = handleCloseClick
    tbl4.proceedToAddPhone = proceedToAddPhone
    tbl4.countryCode = countryCode
    tbl4.setCountryCode = setCountryCode
    tbl4.phoneNumber = phoneNumber
    tbl4.addPhoneErrorMessage = addPhoneErrorMessage
    tbl4.isDisabled = isDisabled
    tbl4.onPhoneNumberTextChange = onPhoneNumberTextChange
    tbl4.handleSetPhone = handleSetPhone
    tbl4.navigateToSMSTerms = navigateToSMSTerms
    tbl4.navigateToPrivacy = navigateToPrivacy
    tbl4.onPhoneInputFocus = onPhoneInputFocus
    tbl4.onCountryCodeSelectorClick = onCountryCodeSelectorClick
    tbl4.isKeyboardShowing = isKeyboardShowing
    tbl4.onScreenKeyboardHeight = onScreenKeyboardHeight
    tbl4.code = code
    tbl4.verifyPhoneErrorMessage = verifyPhoneErrorMessage
    tbl4.onCodeTextChange = onCodeTextChange
    tbl4.handleResendCode = handleResendCode
    tbl4.returnToAddPhone = returnToAddPhone
    tbl4.onCodeInputFocus = onCodeInputFocus
    tbl4.isLoading = isLoading
    tbl4.verifyingKey = var38.verifyingKey
    tbl4.isOTPInputTypeEnabled = isOtpInputTypeEnabled
    tbl4.isPhoneNumberTextTypeEnabled = isPhoneNumberTextTypeEnabled
    return tbl4
end

return usePhoneVerificationUpsellProps
