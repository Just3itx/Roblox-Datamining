-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:11:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PhoneUpsell = script:FindFirstAncestor("PhoneUpsell")
local PhoneUpsellParent = PhoneUpsell.Parent
local UserInputService = game:GetService("UserInputService")

local React = require(PhoneUpsellParent.React)
local Roact = require(PhoneUpsellParent.Roact)
local RoactRodux = require(PhoneUpsellParent.RoactRodux)
local Cryo = require(PhoneUpsellParent.Cryo)
local useSelector = require(PhoneUpsellParent.RoactUtils).Hooks.RoactRodux.useSelector
local useSignalState = require(PhoneUpsellParent.SignalsReact).useSignalState
local FFlagUseSignalsForCountryCodeList = require(PhoneUpsellParent.SharedFlags).FFlagUseSignalsForCountryCodeList
local GetCountryCodeListStore = require(PhoneUpsellParent.AuthCommon).Stores.GetCountryCodeListStore

local _LuauPolyfill = require(PhoneUpsellParent.LuauPolyfill)
local RoactNetworking = require(PhoneUpsellParent.RoactServiceTags).RoactNetworking
local RoactServices = require(PhoneUpsellParent.RoactServices).RoactServices
local EventStreamConstants = require(PhoneUpsell.DuplicateAnalytics.EventStreamConstants)
local RoactAnalyticsAuthEvents = require(PhoneUpsell.DuplicateAnalytics.RoactAnalyticsAuthEvents)
local debounce = require(PhoneUpsell.Utils.debounce)
local mergeProps = require(PhoneUpsell.Utils.mergeProps)

local PhoneVerificationUpsellState = require(PhoneUpsell.Components.PhoneVerificationUpsellState)
local EntryView = require(PhoneUpsell.Components.EntryView)
local AddPhoneView = require(PhoneUpsell.Components.AddPhoneView)
local VerifyPhoneView = require(PhoneUpsell.Components.VerifyPhoneView)
local PhoneVerificationStatusOverlay = require(PhoneUpsell.Components.PhoneVerificationStatusOverlay)

local Foundation = require(PhoneUpsellParent.Foundation)
local IconSize = Foundation.Enums.IconSize
local Loading = Foundation.Loading

local useLocalization = require(PhoneUpsellParent.Localization).Hooks.useLocalization

local SetPhoneNumber = require(PhoneUpsell.Thunks.SetPhoneNumber)
local VerifyPhoneCode = require(PhoneUpsell.Thunks.VerifyPhoneCode)
local ResendPhoneCode = require(PhoneUpsell.Thunks.ResendPhoneCode)
local SetIsPhoneVerified = require(PhoneUpsellParent.ContactImporter).Actions.SetIsPhoneVerified

local GetPrefixAndNationalNumberFromRawPhoneAndDefaultPrefix = require(PhoneUpsell.Utils.GetPrefixAndNationalNumberFromRawPhoneAndDefaultPrefix)

local RoactAppExperiment = require(PhoneUpsellParent.RoactAppExperiment)
local GetFStringAndroidPhoneVerificationLayer = require(PhoneUpsellParent.SharedFlags).GetFStringAndroidPhoneVerificationLayer
local GetFStringIOSPhoneVerificationLayer = require(PhoneUpsellParent.SharedFlags).GetFStringIOSPhoneVerificationLayer

local GetFFlagLuaUsePhoneNumberTextTypeForPhoneUpsell = require(PhoneUpsell.Flags.GetFFlagLuaUsePhoneNumberTextTypeForPhoneUpsell)
local GetFFlagPhoneUseParentSizeForScreenSize = require(PhoneUpsell.Flags.GetFFlagPhoneUseParentSizeForScreenSize)

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
    isOTPInputTypeEnabled = false,
    isPhoneNumberTextTypeEnabled = false,
    alwaysShowAddPhoneLegalText = false,
    requireAddPhoneLegalTextCheckbox = false,
    closeUpsell = func1,
    showWebpage = function(_) end
}

local var1 = RoactRodux.connect(not FFlagUseSignalsForCountryCodeList and function(arg1, _)
    return {
        countryCodeList = arg1.CountryCodeList
    }
end or nil, function(arg1)
    return {
        setPhoneNumber = function(arg2, arg3, arg4, arg5)
            return arg1(SetPhoneNumber(arg2, arg3, arg4, arg5, nil))
        end,
        verifyPhoneCode = function(arg2, arg3)
            return arg1(VerifyPhoneCode(arg2, arg3))
        end,
        resendPhoneCode = function(arg2)
            return arg1(ResendPhoneCode(arg2))
        end,
        setIsPhoneVerified = function(arg2)
            return arg1(SetIsPhoneVerified(arg2))
        end
    }
end)(function(tbl3) -- name: PhoneVerificationUpsellOverlay
    local var1 = mergeProps(tbl2, tbl3)
    local var2, var3 = React.useState(if var1.entryConfig then PhoneVerificationUpsellState.Entry else PhoneVerificationUpsellState.AddPhone)

    local phoneNumber, var5 = React.useState("")
    local countryCode, setCountryCode = React.useState(tbl1)
    local var8, var9 = React.useState(false)
    local code, var11 = React.useState("")
    local var12, var13 = React.useState("")
    local errorMessage, var15 = React.useState("")
    local var4, var17 = React.useState("")
    local var18, _ = React.useState(false)
    local current, var20 = React.useState(false)
    local isDisabled, var22 = React.useState(false)
    local isKeyboardShowing, var24 = React.useState(false)
    local keyboardHeight, var26 = React.useState(0)
    local var27, var28 = React.useState(Vector2.new(400, 400))
    local var29 = React.useRef(false)

    local var30 = useLocalization({
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
        if var8 or not var1.countryCodeList or not (#var1.countryCodeList > 0) then
            return
        end

        for _, value in var1.countryCodeList do
            if value.isDefault then
                setCountryCode(value)
            end
        end

        var9(true)
    end, { var1.countryCodeList, var8 })

    local function func2() -- Luacid: Inlined by compiler; 2 call sites recovered
        local default = IdentityProtocol.default
        default:supportsGetPhoneNumber():andThen(function(bool1: boolean?)
            print("PhoneVerification: Autofill phone number supported: {}!", bool1)
            if not bool1 then
                return
            end
            var1.authEventAnalytics.reportModalActionWithSection(
                var1.eventContext,
                "phoneAutofillEligible",
                "autofill",
                var1.origin,
                var2
            )
            local phoneNumber = default:getPhoneNumber()
            if not phoneNumber then
                return
            end
            phoneNumber:andThen(function(str1: string?)
                if not str1 or str1 == "" then
                    var1.authEventAnalytics.reportModalActionWithSection(
                        var1.eventContext,
                        "phoneAutofillNull",
                        "autofill",
                        var1.origin,
                        var2
                    )

                    return
                end

                local var31, var32 = GetPrefixAndNationalNumberFromRawPhoneAndDefaultPrefix(str1, countryCode.prefix)

                if var31 == tbl1.prefix then
                    var1.authEventAnalytics.reportModalActionWithSection(
                        var1.eventContext,
                        "phoneAutofillUSFound",
                        "autofill",
                        var1.origin,
                        var2
                    )
                end
                var5(var32)

                var1.authEventAnalytics.reportModalActionWithSection(
                    var1.eventContext,
                    "phoneAutofillSuccess",
                    "autofill",
                    var1.origin,
                    var2
                )
            end)
        end)
    end

    local function func3() -- Luacid: Inlined by compiler; 1 call site recovered
        local default = IdentityProtocol.default
        default:supportsGetSMSOTP():andThen(function(bool1: boolean?)
            print("PhoneVerification: Autofill OTP supported: {}!", bool1)
            if not bool1 then
                return
            end

            var1.authEventAnalytics.reportModalActionWithSection(
                var1.eventContext,
                "codeAutofillEligible",
                "autofill",
                var1.origin,
                var2
            )
            local sMsotp = default:getSMSOTP()
            if not sMsotp then
                return
            end

            sMsotp:andThen(function(str1: string?)
                if str1 and str1 ~= "" then
                    var11(str1)
                    var13(str1)
                    var1.authEventAnalytics.reportModalActionWithSection(
                        var1.eventContext,
                        "codeAutofillSuccess",
                        "autofill",
                        var1.origin,
                        var2
                    )
                end
            end)
        end)
    end

    React.useEffect(function()
        return function()
            var29.current = current
        end
    end, { current })

    React.useEffect(function()
        connection = UserInputService:GetPropertyChangedSignal("OnScreenKeyboardVisible"):Connect(function()
            var24(UserInputService.OnScreenKeyboardVisible)
            var26(UserInputService.OnScreenKeyboardVisible and UserInputService.OnScreenKeyboardSize.Y or 0)
        end)

        var1.authEventAnalytics.reportModalShownWithSection(
            var1.eventContext,
            var1.origin,
            PhoneVerificationUpsellState.AddPhone
        )
        if var1.isAutofillPhoneNumberEnabled then
            func2()
        end

        return function()
            if connection then
                connection:Disconnect()
            end
            connection = nil
            if not var29.current then
                var1.onCancelled()
            end
        end
    end, {})

    local var31 = useSelector(function(arg1)
        return arg1.ScreenSize
    end)

    local function handleCloseClick()
        var1.authEventAnalytics.reportModalDismissedWithSection(var1.eventContext, var1.origin, var2)

        var1.closeUpsell()
    end

    local function handlePhoneErrors(num1: number?) -- Luacid: Inlined by compiler; 15 call sites recovered
        if num1 == 2 then
            return var30.invalidPhoneFormatKey
        elseif num1 == 6 then
            return var30.tooManyAttemptsKey
        elseif num1 == 7 then
            return var30.invalidVerificationCodeKey
        elseif num1 == 8 then
            return var30.invalidPhoneNumberKey
        elseif num1 == 9 then
            return var30.tooManyAccountsKey
        end

        return var30.genericErrorKey
    end

    local function handleSetPhone()
        var22(true)
        local var32 = var1.setPhoneNumber(var1.networking, countryCode.code, countryCode.prefix, phoneNumber)
        if var32 then
            var32:andThen(function()
                var3(PhoneVerificationUpsellState.VerifyPhone)
                var22(false)
                var1.authEventAnalytics.reportModalShownWithSection(
                    var1.eventContext,
                    var1.origin,
                    PhoneVerificationUpsellState.VerifyPhone
                )

                if var1.isAutofillSMSOtpEnabled then
                    func3()
                end
            end):catch(function(tbl4)
                if not tbl4 then
                    var1.authEventAnalytics.reportModalShownWithSectionAndError(
                        var1.eventContext,
                        EventStreamConstants.Field.ErrorMessage,
                        var1.origin,
                        PhoneVerificationUpsellState.AddPhone,
                        ""
                    )
                    var15(var30.genericErrorKey)
                elseif tbl4.PhoneRegexFailed then
                    var1.authEventAnalytics.reportModalShownWithSectionAndError(
                        var1.eventContext,
                        EventStreamConstants.Field.ErrorMessage,
                        var1.origin,
                        PhoneVerificationUpsellState.AddPhone,
                        ""
                    )
                    var15(var30.invalidPhoneFormatKey)
                else
                    var1.authEventAnalytics.reportModalShownWithSectionAndError(
                        var1.eventContext,
                        EventStreamConstants.Field.ErrorMessage,
                        var1.origin,
                        PhoneVerificationUpsellState.AddPhone,
                        tbl4.ErrorCode
                    )
                    local var33 = var15
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
                        genericErrorKey = var30.genericErrorKey
                    end

                    var33(genericErrorKey)
                end
                var22(false)
            end)
        end
        var1.authEventAnalytics.reportInteractWithActionAndSection(
            var1.eventContext,
            "",
            "",
            var1.origin,
            EventStreamConstants.Button.Continue,
            PhoneVerificationUpsellState.AddPhone
        )
    end

    local function handleVerifyPhone()
        var22(true)
        local var32 = var1.verifyPhoneCode(var1.networking, var12)
        if var32 then
            var32:andThen(function()
                var20(true)
            end):catch(function(tbl4)
                if not tbl4 then
                    var1.authEventAnalytics.reportModalShownWithSectionAndError(
                        var1.eventContext,
                        EventStreamConstants.Field.ErrorMessage,
                        var1.origin,
                        PhoneVerificationUpsellState.VerifyPhone,
                        ""
                    )
                    var17(var30.genericErrorKey)
                else
                    var1.authEventAnalytics.reportModalShownWithSectionAndError(
                        var1.eventContext,
                        EventStreamConstants.Field.ErrorMessage,
                        var1.origin,
                        PhoneVerificationUpsellState.VerifyPhone,
                        tbl4.ErrorCode
                    )
                    local var33 = var17
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
                        genericErrorKey = var30.genericErrorKey
                    end

                    var33(genericErrorKey)
                end
                var22(false)
            end)
        end
        var1.authEventAnalytics.reportInteractWithActionAndSection(
            var1.eventContext,
            "",
            "",
            var1.origin,
            EventStreamConstants.Button.AutoSubmit,
            PhoneVerificationUpsellState.VerifyPhone
        )
    end

    local function handleResendCode()
        local var32 = var1.resendPhoneCode(var1.networking)
        if var32 then
            var32:andThen(function() end):catch(function(tbl4)
                if not tbl4 then
                    var1.authEventAnalytics.reportModalShownWithSectionAndError(
                        var1.eventContext,
                        EventStreamConstants.Field.ErrorMessage,
                        var1.origin,
                        PhoneVerificationUpsellState.VerifyPhone,
                        ""
                    )
                    var17(var30.genericErrorKey)
                    return
                end
                var1.authEventAnalytics.reportModalShownWithSectionAndError(
                    var1.eventContext,
                    EventStreamConstants.Field.ErrorMessage,
                    var1.origin,
                    PhoneVerificationUpsellState.VerifyPhone,
                    tbl4.ErrorCode
                )
                local var33 = var17
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
                    genericErrorKey = var30.genericErrorKey
                end

                var33(genericErrorKey)
            end)
        end

        var1.authEventAnalytics.reportInteractWithActionAndSection(
            var1.eventContext,
            "",
            "",
            var1.origin,
            EventStreamConstants.Button.ResendCode,
            PhoneVerificationUpsellState.VerifyPhone
        )
    end

    local function returnToAddPhone()
        var3(PhoneVerificationUpsellState.AddPhone)
        var1.authEventAnalytics.reportInteractWithActionAndSection(
            var1.eventContext,
            "",
            "",
            var1.origin,
            EventStreamConstants.Button.ChangePhoneNumber,
            PhoneVerificationUpsellState.VerifyPhone
        )
    end

    local function proceedToAddPhone()
        var3(PhoneVerificationUpsellState.AddPhone)
        var1.authEventAnalytics.reportInteractWithActionAndSection(
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
            var1.authEventAnalytics.reportModalActionWithSection(
                var1.eventContext,
                EventStreamConstants.Field.TermsOfService,
                "",
                var1.origin,
                var2
            )
            var1.showWebpage("https://en.help.roblox.com/hc/articles/9483830673556-Roblox-SMS-Terms-of-Service")
        end
    end

    local function navigateToPrivacy()
        if not isDisabled then
            var1.authEventAnalytics.reportModalActionWithSection(
                var1.eventContext,
                EventStreamConstants.Field.PrivacyPolicy,
                "",
                var1.origin,
                var2
            )
            var1.showWebpage("https://en.help.roblox.com/hc/articles/115004630823")
        end
    end

    local function onPhoneNumberTextChange(arg1)
        if not isDisabled then
            var15("")
            var5(arg1.Text)
        end
    end

    local function onCountryCodeSelectorClick()
        var1.authEventAnalytics.reportInteractWithActionAndSection(
            var1.eventContext,
            EventStreamConstants.Field.CountryPrefix,
            EventStreamConstants.ActionType.Focus,
            var1.origin,
            "",
            PhoneVerificationUpsellState.AddPhone
        )
    end

    local function onPhoneInputFocus()
        var1.authEventAnalytics.reportInteractWithActionAndSection(
            var1.eventContext,
            EventStreamConstants.Field.PhoneNumber,
            EventStreamConstants.ActionType.Focus,
            var1.origin,
            "",
            PhoneVerificationUpsellState.AddPhone
        )
        if not var1.shouldAutofillAndroidPhoneNumberAtLaunch then
            func2()
        end
    end

    local var32 = debounce(function(arg1)
        var13(arg1)
    end, 0.5)

    local function onCodeTextChange(arg1)
        local str1 = string.sub(arg1.Text, 1, 6)
        if str1 ~= code then
            var17("")
        end
        var11(str1)
        var32(str1)
    end

    local function onCodeInputFocus()
        var1.authEventAnalytics.reportInteractWithActionAndSection(
            var1.eventContext,
            EventStreamConstants.Field.VerificationCode,
            EventStreamConstants.ActionType.Focus,
            var1.origin,
            "",
            PhoneVerificationUpsellState.VerifyPhone
        )
    end

    React.useEffect(function()
        if string.len(var12) == 6 then
            handleVerifyPhone()
        end
    end, { var12 })

    React.useEffect(function()
        if not current then
            return
        end

        var1.setIsPhoneVerified({ isPhoneVerified = true })
        var1.authEventAnalytics.reportModalShownWithSection(
            var1.eventContext,
            var1.origin,
            PhoneVerificationUpsellState.Success
        )
        var1.onSuccess()
    end, { current })

    local image = React.createElement(
        Loading,
        {
            size = IconSize.Large,
            Position = UDim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5)
        }
    )
    local createElement = React.createElement
    local var33 = if GetFFlagPhoneUseParentSizeForScreenSize() then "Frame" else React.Fragment
    local tbl4

    if GetFFlagPhoneUseParentSizeForScreenSize() then
        tbl4 = {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0)
        }

        tbl4[Roact.Change.AbsoluteSize] = function(arg1)
            var28(arg1.AbsoluteSize)
        end
    else
        tbl4 = nil
    end

    local tbl5 = { Entry = 0, AddPhone = 0, VerifyPhone = 0, LoadingOverlay = 0 }
    local var34

    if var2 == PhoneVerificationUpsellState.Entry then
        var34 = var1.entryConfig

        if var34 then
            var34 = React.createElement(EntryView, {
                screenSize = if GetFFlagPhoneUseParentSizeForScreenSize() then var27 else var31,
                onClose = handleCloseClick,
                titleKey = var1.entryConfig.titleKey,
                descriptionKey = var1.entryConfig.descriptionKey,
                buttonKey = var1.entryConfig.buttonKey,
                onButtonClick = proceedToAddPhone,
                extraButtonKey = var1.entryConfig.extraButtonConfig.extraButtonKey,
                onExtraButtonClick = var1.entryConfig.extraButtonConfig.onExtraButtonClick
            })
        end
    else
        var34 = false
    end

    tbl5.Entry = var34
    local element2

    if var2 == PhoneVerificationUpsellState.AddPhone then
        element2 = React.createElement(AddPhoneView, {
            screenSize = if GetFFlagPhoneUseParentSizeForScreenSize() then var27 else var31,
            countryCode = countryCode,
            setCountryCode = setCountryCode,
            phoneNumber = phoneNumber,
            errorMessage = errorMessage,
            isDisabled = isDisabled,
            onPhoneNumberTextChange = onPhoneNumberTextChange,
            onSetPhoneNumber = handleSetPhone,
            onClose = handleCloseClick,
            onTermsOfUseClick = navigateToSMSTerms,
            onPrivacyPolicyClick = navigateToPrivacy,
            onPhoneInputFocus = onPhoneInputFocus,
            onCountryCodeSelectorClick = onCountryCodeSelectorClick,
            isKeyboardShowing = isKeyboardShowing,
            keyboardHeight = keyboardHeight,
            usePhoneNumberTextType = GetFFlagLuaUsePhoneNumberTextTypeForPhoneUpsell() and var1.isPhoneNumberTextTypeEnabled,
            titleKey = var1.addPhoneTitleKey,
            descriptionKey = var1.addPhoneDescriptionKey,
            buttonKey = var1.addPhoneButtonKey,
            legalTextKey = var1.addPhoneLegalTextKey,
            extraButtonKey = var1.extraButtonTextKey,
            onExtraButtonClick = var1.onExtraButtonClick,
            alwaysShowLegalText = var1.alwaysShowAddPhoneLegalText,
            requireLegalTextCheckbox = var1.requireAddPhoneLegalTextCheckbox
        })
    else
        element2 = false
    end

    tbl5.AddPhone = element2
    local var35

    if var2 == PhoneVerificationUpsellState.VerifyPhone then
        local createElement2 = React.createElement
        local var36 = VerifyPhoneView
        local tbl6 = {
            screenSize = 0,
            phoneNumber = 0,
            prefix = 0,
            code = 0,
            errorMessage = 0,
            onCodeTextChange = 0,
            onResendPhoneCode = 0,
            onClose = 0,
            returnToAddPhone = 0,
            onCodeInputFocus = 0,
            isKeyboardShowing = 0,
            keyboardHeight = 0,
            useOTPInputType = 0,
            extraButtonKey = 0,
            onExtraButtonClick = 0
        }

        if GetFFlagPhoneUseParentSizeForScreenSize() then
            var31 = var27
        end

        tbl6.screenSize = var31
        tbl6.phoneNumber = phoneNumber
        tbl6.prefix = countryCode.prefix
        tbl6.code = code
        tbl6.errorMessage = var4
        tbl6.onCodeTextChange = onCodeTextChange
        tbl6.onResendPhoneCode = handleResendCode
        tbl6.onClose = handleCloseClick
        tbl6.returnToAddPhone = returnToAddPhone
        tbl6.onCodeInputFocus = onCodeInputFocus
        tbl6.isKeyboardShowing = isKeyboardShowing
        tbl6.keyboardHeight = keyboardHeight
        tbl6.useOTPInputType = var1.isOTPInputTypeEnabled
        tbl6.extraButtonKey = var1.verifyPhoneExtraButtonKey
        tbl6.onExtraButtonClick = var1.onVerifyPhoneExtraButtonClick
        var35 = createElement2(var36, tbl6)
    else
        var35 = false
    end

    tbl5.VerifyPhone = var35

    tbl5.LoadingOverlay = var18 and React.createElement(PhoneVerificationStatusOverlay, { image = image, text = var30.verifyingKey })
    return createElement(var33, tbl4, tbl5)
end)

local var2 = if FFlagUseSignalsForCountryCodeList then React.memo(function(arg1)
    local countryCodeList = useSignalState(GetCountryCodeListStore(false).getCountryCodeList)
    return React.createElement(var1, Cryo.Dictionary.union(arg1, { countryCodeList = countryCodeList }))
end) else var1

local var3 = RoactServices.connect({ networking = RoactNetworking, authEventAnalytics = RoactAnalyticsAuthEvents })(var2)

return (RoactAppExperiment.connectUserLayer(
    { GetFStringAndroidPhoneVerificationLayer(), GetFStringIOSPhoneVerificationLayer() },
    function(arg1, _)
        local var4 = arg1[GetFStringAndroidPhoneVerificationLayer()] or {}
        local var5 = arg1[GetFStringIOSPhoneVerificationLayer()] or {}
        return {
            isAutofillPhoneNumberEnabled = var4.IsAutofillPhoneNumberEnabled,
            isAutofillSMSOtpEnabled = var4.IsAutofillSMSOtpEnabled,
            isOTPInputTypeEnabled = var5.IsAutofillSMSOtpEnabled,
            isPhoneNumberTextTypeEnabled = var5.IsAutofillPhoneNumberEnabled
        }
    end
)(
    var3
))
