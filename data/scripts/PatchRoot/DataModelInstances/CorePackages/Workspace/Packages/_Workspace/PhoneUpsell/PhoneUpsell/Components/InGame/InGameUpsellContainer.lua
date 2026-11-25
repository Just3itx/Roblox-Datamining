-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:11:00Z
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
local InGameEntryView = require(PhoneUpsell.Components.InGame.InGameEntryView)
local InGameAddPhoneView = require(PhoneUpsell.Components.InGame.InGameAddPhoneView)
local InGameVerifyPhoneView = require(PhoneUpsell.Components.InGame.InGameVerifyPhoneView)

local GetFFlagLuaUsePhoneNumberTextTypeForPhoneUpsell = require(PhoneUpsell.Flags.GetFFlagLuaUsePhoneNumberTextTypeForPhoneUpsell)
local GetFFlagPhoneUseParentSizeForScreenSize = require(PhoneUpsell.Flags.GetFFlagPhoneUseParentSizeForScreenSize)
local GetFFlagFixIosOtpAutofill = require(PhoneUpsell.Flags.GetFFlagFixIosOtpAutofill)

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

local function InGameUpsellContainer(tbl2)
    local var1 = mergeProps(tbl1, tbl2)

    local var2 = usePhoneVerificationUpsellProps(var1)

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

    local tbl4 = { Entry = 0, AddPhone = 0, VerifyPhone = 0 }
    local element

    if var2.phoneUpsellState == PhoneVerificationUpsellState.Entry then
        element = var1.entryConfig
            and React.createElement(InGameEntryView, {
                screenSize = var2.screenSize,
                onClose = var2.handleCloseClick,
                titleKey = var1.entryConfig.titleKey,
                descriptionKey = var1.entryConfig.descriptionKey,
                buttonKey = var1.entryConfig.buttonKey,
                onButtonClick = var2.proceedToAddPhone,
                extraButtonKey = var1.entryConfig.extraButtonConfig.extraButtonKey,
                onExtraButtonClick = var1.closeUpsell,
                countryCode = var2.countryCode,
                onTermsOfUseClick = var2.navigateToSMSTerms,
                onPrivacyPolicyClick = var2.navigateToPrivacy,
                legalTextKey = var1.entryConfig.legalTextKey
            })
    else
        element = false
    end

    tbl4.Entry = element
    local element2

    if var2.phoneUpsellState == PhoneVerificationUpsellState.AddPhone then
        element2 = React.createElement(InGameAddPhoneView, {
            screenSize = var2.screenSize,
            countryCode = var2.countryCode,
            setCountryCode = var2.setCountryCode,
            phoneNumber = var2.phoneNumber,
            errorMessage = var2.addPhoneErrorMessage,
            isDisabled = var2.isDisabled,
            onPhoneNumberTextChange = var2.onPhoneNumberTextChange,
            onSetPhoneNumber = var2.handleSetPhone,
            onClose = var2.handleCloseClick,
            onCountryCodeSelectorClick = var2.onCountryCodeSelectorClick,
            isKeyboardShowing = var2.isKeyboardShowing,
            keyboardHeight = var2.onScreenKeyboardHeight,
            titleKey = var1.addPhoneTitleKey,
            buttonKey = var1.addPhoneButtonKey,
            extraButtonKey = "Feature.VerificationUpsell.Action.NotNow",
            onExtraButtonClick = var1.closeUpsell,
            usePhoneNumberTextType = GetFFlagLuaUsePhoneNumberTextTypeForPhoneUpsell() and var2.isPhoneNumberTextTypeEnabled,
            descriptionKey = var1.addPhoneDescriptionKey,
            legalTextKey = var1.addPhoneLegalTextKey,
            onPhoneInputFocus = var2.onPhoneInputFocus
        })
    else
        element2 = false
    end

    tbl4.AddPhone = element2
    local element3

    if var2.phoneUpsellState == PhoneVerificationUpsellState.VerifyPhone then
        element3 = React.createElement(InGameVerifyPhoneView, {
            screenSize = var2.screenSize,
            phoneNumber = var2.phoneNumber,
            prefix = var2.countryCode.prefix,
            code = var2.code,
            errorMessage = var2.verifyPhoneErrorMessage,
            onCodeTextChange = var2.onCodeTextChange,
            onResendPhoneCode = var2.handleResendCode,
            onClose = var2.handleCloseClick,
            returnToAddPhone = var2.returnToAddPhone,
            onCodeInputFocus = var2.onCodeInputFocus,
            isKeyboardShowing = var2.isKeyboardShowing,
            keyboardHeight = var2.onScreenKeyboardHeight,
            useOTPInputType = if GetFFlagFixIosOtpAutofill() then var2.isOTPInputTypeEnabled else var1.isOTPInputTypeEnabled,
            extraButtonKey = "Feature.VerificationUpsell.Action.EditPhoneNumber",
            onExtraButtonClick = var2.returnToAddPhone
        })
    else
        element3 = false
    end

    tbl4.VerifyPhone = element3
    return createElement(var3, tbl3, tbl4)
end

return InGameUpsellContainer
