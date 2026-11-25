-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:11:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PhoneUpsell = script:FindFirstAncestor("PhoneUpsell")
local PhoneUpsellParent = PhoneUpsell.Parent

local usePhoneVerificationUpsellProps = require(PhoneUpsell.Components.usePhoneVerificationUpsellProps)

local React = require(PhoneUpsellParent.React)
local Roact = require(PhoneUpsellParent.Roact)

local _LuauPolyfill = require(PhoneUpsellParent.LuauPolyfill)
local mergeProps = require(PhoneUpsell.Utils.mergeProps)

local PhoneVerificationUpsellState = require(PhoneUpsell.Components.PhoneVerificationUpsellState)
local EntryView = require(PhoneUpsell.Components.EntryView)
local AddPhoneView = require(PhoneUpsell.Components.AddPhoneView)
local VerifyPhoneView = require(PhoneUpsell.Components.VerifyPhoneView)
local PhoneVerificationStatusOverlay = require(PhoneUpsell.Components.PhoneVerificationStatusOverlay)

local Foundation = require(PhoneUpsellParent.Foundation)
local IconSize = Foundation.Enums.IconSize
local Loading = Foundation.Loading

local GetFFlagLuaUsePhoneNumberTextTypeForPhoneUpsell = require(PhoneUpsell.Flags.GetFFlagLuaUsePhoneNumberTextTypeForPhoneUpsell)
local GetFFlagPhoneUseParentSizeForScreenSize = require(PhoneUpsell.Flags.GetFFlagPhoneUseParentSizeForScreenSize)
local GetFFlagDisableVerifyPhoneViewOnSuccess = require(PhoneUpsell.Flags.GetFFlagDisableVerifyPhoneViewOnSuccess)
local GetFFlagFixIosOtpAutofill = require(PhoneUpsell.Flags.GetFFlagFixIosOtpAutofill)

local FFlagHomePhoneVerificationUpsellNewCopy = require(PhoneUpsellParent.SharedFlags).FFlagHomePhoneVerificationUpsellNewCopy

local function func1() end

local tbl1 = {
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

local function UpsellContainer(tbl2)
    local var1 = mergeProps(tbl1, tbl2)

    local var2 = usePhoneVerificationUpsellProps(var1)

    local image = React.createElement(
        Loading,
        {
            size = IconSize.Large,
            Position = UDim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5)
        }
    )
    local createElement = React.createElement
    local var3 = if GetFFlagPhoneUseParentSizeForScreenSize() then "Frame" else React.Fragment
    local tbl3

    if GetFFlagPhoneUseParentSizeForScreenSize() then
        tbl3 = {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0)
        }

        tbl3[Roact.Change.AbsoluteSize] = function(arg1)
            var2.setParentSize(arg1.AbsoluteSize)
        end
    else
        tbl3 = nil
    end

    local tbl4 = { Entry = 0, AddPhone = 0, VerifyPhone = 0, LoadingOverlay = 0 }
    local element2

    if var2.phoneUpsellState == PhoneVerificationUpsellState.Entry then
        element2 = var1.entryConfig
            and React.createElement(EntryView, {
                screenSize = var2.screenSize,
                onClose = var2.handleCloseClick,
                titleKey = var1.entryConfig.titleKey,
                descriptionKey = var1.entryConfig.descriptionKey,
                buttonKey = var1.entryConfig.buttonKey,
                onButtonClick = var2.proceedToAddPhone,
                extraButtonKey = var1.entryConfig.extraButtonConfig.extraButtonKey,
                onExtraButtonClick = var1.entryConfig.extraButtonConfig.onExtraButtonClick
            })
    else
        element2 = false
    end

    tbl4.Entry = element2
    local element3

    if var2.phoneUpsellState == PhoneVerificationUpsellState.AddPhone then
        element3 = React.createElement(AddPhoneView, {
            screenSize = var2.screenSize,
            countryCode = var2.countryCode,
            setCountryCode = var2.setCountryCode,
            phoneNumber = var2.phoneNumber,
            errorMessage = var2.addPhoneErrorMessage,
            isDisabled = var2.isDisabled,
            onPhoneNumberTextChange = var2.onPhoneNumberTextChange,
            onSetPhoneNumber = var2.handleSetPhone,
            onClose = var2.handleCloseClick,
            onTermsOfUseClick = var2.navigateToSMSTerms,
            onPrivacyPolicyClick = var2.navigateToPrivacy,
            onPhoneInputFocus = var2.onPhoneInputFocus,
            onCountryCodeSelectorClick = var2.onCountryCodeSelectorClick,
            isKeyboardShowing = var2.isKeyboardShowing,
            keyboardHeight = var2.onScreenKeyboardHeight,
            usePhoneNumberTextType = GetFFlagLuaUsePhoneNumberTextTypeForPhoneUpsell() and var2.isPhoneNumberTextTypeEnabled,
            titleKey = var1.addPhoneTitleKey,
            descriptionKey = var1.addPhoneDescriptionKey,
            buttonKey = var1.addPhoneButtonKey,
            legalTextKey = var1.addPhoneLegalTextKey,
            extraButtonKey = var1.extraButtonTextKey,
            onExtraButtonClick = var1.onExtraButtonClick,
            alwaysShowLegalText = var1.alwaysShowAddPhoneLegalText,
            requireLegalTextCheckbox = var1.requireAddPhoneLegalTextCheckbox,
            disableLegalText = var1.disableLegalText,
            shouldShowVerificationText = if FFlagHomePhoneVerificationUpsellNewCopy then var1.shouldShowVerificationText else nil
        })
    else
        element3 = false
    end

    tbl4.AddPhone = element3
    local element4

    if var2.phoneUpsellState == PhoneVerificationUpsellState.VerifyPhone then
        element4 = React.createElement(VerifyPhoneView, {
            screenSize = var2.screenSize,
            phoneNumber = var2.phoneNumber,
            prefix = var2.countryCode.prefix,
            code = var2.code,
            errorMessage = var2.verifyPhoneErrorMessage,
            isDisabled = if GetFFlagDisableVerifyPhoneViewOnSuccess() then var2.isDisabled else nil,
            onCodeTextChange = var2.onCodeTextChange,
            onResendPhoneCode = var2.handleResendCode,
            onClose = var2.handleCloseClick,
            returnToAddPhone = var2.returnToAddPhone,
            onCodeInputFocus = var2.onCodeInputFocus,
            isKeyboardShowing = var2.isKeyboardShowing,
            keyboardHeight = var2.onScreenKeyboardHeight,
            useOTPInputType = if GetFFlagFixIosOtpAutofill() then var2.isOTPInputTypeEnabled else var1.isOTPInputTypeEnabled,
            extraButtonKey = var1.verifyPhoneExtraButtonKey,
            onExtraButtonClick = var1.onVerifyPhoneExtraButtonClick
        })
    else
        element4 = false
    end

    tbl4.VerifyPhone = element4

    tbl4.LoadingOverlay = var2.isLoading and React.createElement(PhoneVerificationStatusOverlay, { image = image, text = var2.verifyingKey })
    return createElement(var3, tbl3, tbl4)
end

return UpsellContainer
