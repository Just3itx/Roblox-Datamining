-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:10:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PhoneUpsell = script:FindFirstAncestor("PhoneUpsell")
local PhoneUpsellParent = PhoneUpsell.Parent

local React = require(PhoneUpsellParent.React)

local UIBlox = require(PhoneUpsellParent.UIBlox)

local Foundation = require(PhoneUpsellParent.Foundation)
local Checkbox = Foundation.Checkbox

local FoundationText = Foundation.Text
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local withStyle = UIBlox.Style.withStyle
local withLocalization = require(PhoneUpsellParent.Localization).withLocalization
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local PartialPageModal = UIBlox.App.Dialog.Modal.PartialPageModal
local getPartialPageModalMiddleContentWidth = UIBlox.App.Dialog.Modal.getPartialPageModalMiddleContentWidth

local AuthCommon = require(PhoneUpsellParent.AuthCommon)
local TextBoxStateWrapper = AuthCommon.Components.TextBoxStateWrapper
local PhoneNumberTextBox = AuthCommon.Components.PhoneNumberTextBox
local LinkButton = UIBlox.App.Button.LinkButton
local mergeProps = require(PhoneUpsell.Utils.mergeProps)

local FFlagHomePhoneVerificationUpsellNewCopy = require(PhoneUpsellParent.SharedFlags).FFlagHomePhoneVerificationUpsellNewCopy
local FFlagPhoneUpsellFocusNavigation = require(PhoneUpsell.Flags.FFlagPhoneUpsellFocusNavigation)

local tbl1 = {
    alwaysShowLegalText = false,
    requireLegalTextCheckbox = false,
    buttonKey = "Feature.VerificationUpsell.Action.Continue",
    legalTextKey = "Feature.VerificationUpsell.Description.ShortCodeLegalDisclaimerUA",
    shouldShowVerificationText = not FFlagHomePhoneVerificationUpsellNewCopy and nil
}

local function getButtonStackProps(text: string, onActivated: (...any) -> (...any), isDisabled: boolean, text2: string, onActivated2: (...any) -> (...any), tbl2)
    local buttons = {{
        buttonType = ButtonType.PrimarySystem,
        props = { onActivated = onActivated, text = text, isDisabled = isDisabled }
    }}

    if text2 and text2 ~= "" then
        table.insert(
            buttons,
            1,
            {
                buttonType = ButtonType.Secondary,
                props = { onActivated = onActivated2, text = text2, isDisabled = false }
            }
        )
    end

    local tbl4 = {
        buttonHeight = 48,
        forcedFillDirection = Enum.FillDirection.Vertical,
        buttons = buttons
    }

    if tbl2 then
        tbl4.disableRoactGamepadButtonSelection = true
        buttons[#buttons].props.NextSelectionUp = tbl2.NextSelectionUp
    end

    return tbl4
end

local function AddPhoneView(tbl2)
    local var1 = mergeProps(tbl1, tbl2)

    local function noOp() end

    local isChecked, onActivated = React.useState(false)

    local nextSelectionUp = React.useRef(nil)

    local partialPageModalMiddleContentWidth = getPartialPageModalMiddleContentWidth(var1.screenSize.X)

    local tbl3 = {
        phoneNumberKey = "Feature.VerificationUpsell.Label.PhoneNumber",
        phonePrivacyDisclaimerKey = "Feature.VerificationUpsell.Description.PhoneNumberNeverPublic",
        termsOfUseKey = "Feature.VerificationUpsell.Action.TermsOfUse",
        privacyPolicyKey = "Feature.VerificationUpsell.Action.PrivacyPolicy",
        titleKey = var1.titleKey,
        descriptionKey = var1.descriptionKey,
        buttonKey = var1.buttonKey,
        legalTextKey = var1.legalTextKey,
        verificationKey = if FFlagHomePhoneVerificationUpsellNewCopy then "Feature.VerificationUpsell.Description.AddPhoneBody" else nil
    }

    if var1.extraButtonKey and var1.extraButtonKey ~= "" then
        tbl3.extraButtonKey = var1.extraButtonKey
    end

    return withStyle(function(arg1)
        return withLocalization(tbl3)(function(arg2)
            local baseSize = arg1.Font.BaseSize
            local relativeSize = arg1.Font.Body.RelativeSize
            local relativeSize2 = arg1.Font.CaptionHeader.RelativeSize
            local isDisabled = var1.isDisabled or var1.requireLegalTextCheckbox and not isChecked
            local bool1 = var1.countryCode.prefix == "1" and not var1.disableLegalText
            local createElement = React.createElement
            local var5 = PartialPageModal
            local tbl4 = {
                title = arg2.titleKey,
                screenSize = var1.screenSize,
                buttonStackProps = getButtonStackProps(
                    arg2.buttonKey,
                    var1.onSetPhoneNumber,
                    isDisabled,
                    arg2.extraButtonKey,
                    var1.onExtraButtonClick,
                    FFlagPhoneUpsellFocusNavigation and bool1 and {
                        NextSelectionUp = nextSelectionUp
                    } or nil
                ),
                onCloseClicked = var1.onClose,
                position = var1.isKeyboardShowing and UDim2.new(0.5, 0, 1, -var1.keyboardHeight) or nil,
                anchorPoint = var1.isKeyboardShowing and Vector2.new(0.5, 1) or nil
            }
            local tbl5 = { Middle = 0 }
            local createElement2 = React.createElement
            local str1 = "Frame"
            local tbl6 = {
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.Y,
                Size = UDim2.new(1, 0, 0, 0)
            }
            local tbl7 = {
                ContentPadding = React.createElement("UIPadding", { PaddingTop = UDim.new(0, 12), PaddingBottom = UDim.new(0, 24) }),
                ListLayout = React.createElement("UIListLayout", {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    Padding = UDim.new(0, 6)
                }),
                BodyText = React.createElement("TextLabel", {
                    LayoutOrder = 0,
                    BackgroundTransparency = 1,
                    Text = arg2.descriptionKey,
                    TextSize = baseSize,
                    TextColor3 = arg1.Theme.TextDefault.Color,
                    TextTransparency = arg1.Theme.TextDefault.Transparency,
                    FontFace = normalizeFontFace(arg1.Tokens.Typography.BodyLarge.Font),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextWrapped = true,
                    Size = UDim2.new(0, partialPageModalMiddleContentWidth, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y
                }),
                PhoneInput = React.createElement(TextBoxStateWrapper, {
                    ChildClass = PhoneNumberTextBox,
                    ErrorState = var1.errorMessage ~= "",
                    ErrorText = var1.errorMessage,
                    Size = UDim2.new(1, 0, 0, 36),
                    LayoutOrder = 1,
                    ChildProps = {
                        CountryCode = var1.countryCode,
                        SetCountryCode = var1.setCountryCode,
                        Text = var1.phoneNumber,
                        PlaceholderText = arg2.phoneNumberKey,
                        Font = arg1.Font.Body.Font,
                        TextSize = baseSize * relativeSize,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Color = arg1.Theme.BackgroundUIContrast.Color,
                        Transparency = arg1.Theme.BackgroundUIContrast.Transparency,
                        TextColor = arg1.Theme.TextDefault.Color,
                        PlaceholderColor = arg1.Theme.UIDefault.Color,
                        TextTransparency = arg1.Theme.TextDefault.Transparency,
                        ClearTextOnFocus = false,
                        PaddingX = 12,
                        TextInputTypeOverride = var1.usePhoneNumberTextType and Enum.TextInputType.Phone or Enum.TextInputType.Number,
                        onChangeText = var1.onPhoneNumberTextChange,
                        onFocused = var1.onPhoneInputFocus,
                        onFocusLost = noOp,
                        phoneCountryCodeSelectorCallback = var1.onCountryCodeSelectorClick
                    }
                }),
                PrivacyText = React.createElement("TextLabel", {
                    LayoutOrder = 2,
                    BackgroundTransparency = 1,
                    Text = arg2.phonePrivacyDisclaimerKey,
                    TextSize = baseSize * relativeSize2,
                    TextColor3 = arg1.Theme.TextEmphasis.Color,
                    TextTransparency = arg1.Theme.TextEmphasis.Transparency,
                    FontFace = normalizeFontFace(arg1.Tokens.Typography.BodyLarge.Font),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextWrapped = true,
                    Size = UDim2.new(0, partialPageModalMiddleContentWidth, 0, 24)
                }),
                VerificationText = if FFlagHomePhoneVerificationUpsellNewCopy and var1.shouldShowVerificationText then React.createElement(
                    FoundationText,
                    {
                        tag = "auto-y size-full-0 text-wrap text-body-small text-align-x-left",
                        Text = arg2.verificationKey,
                        LayoutOrder = 2
                    }
                ) else nil,
                LegalTextContainer = 0,
                LegalButtonsContainer = 0
            }

            local bool2 = not var1.disableLegalText

            if bool2 then
                if var1.requireLegalTextCheckbox then
                    bool2 = React.createElement("Frame", {
                        LayoutOrder = 3,
                        BackgroundTransparency = 1,
                        Size = UDim2.new(0, partialPageModalMiddleContentWidth, 0, 0),
                        AutomaticSize = Enum.AutomaticSize.Y
                    }, {
                        UIListLayout = React.createElement("UIListLayout", {
                            FillDirection = Enum.FillDirection.Horizontal,
                            HorizontalAlignment = Enum.HorizontalAlignment.Center,
                            VerticalAlignment = Enum.VerticalAlignment.Center,
                            Padding = UDim.new(0, 6)
                        }),
                        LegalCheckbox = React.createElement(Checkbox, { onActivated = onActivated, isChecked = isChecked, label = "" }),
                        LegalText = React.createElement("TextLabel", {
                            BackgroundTransparency = 1,
                            Text = arg2.legalTextKey,
                            TextSize = baseSize * relativeSize2,
                            TextColor3 = arg1.Theme.TextDefault.Color,
                            TextTransparency = arg1.Theme.TextDefault.Transparency,
                            FontFace = normalizeFontFace(arg1.Tokens.Typography.BodyLarge.Font),
                            TextXAlignment = Enum.TextXAlignment.Left,
                            TextWrapped = true,
                            Size = UDim2.new(1, -32, 0, 0),
                            AutomaticSize = Enum.AutomaticSize.Y
                        })
                    })
                elseif var1.alwaysShowLegalText or var1.countryCode.prefix == "1" then
                    bool2 = React.createElement("TextLabel", {
                        LayoutOrder = 3,
                        BackgroundTransparency = 1,
                        Text = arg2.legalTextKey,
                        TextSize = baseSize * relativeSize2,
                        TextColor3 = arg1.Theme.TextDefault.Color,
                        TextTransparency = arg1.Theme.TextDefault.Transparency,
                        FontFace = normalizeFontFace(arg1.Tokens.Typography.BodyLarge.Font),
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextWrapped = true,
                        Size = UDim2.new(0, partialPageModalMiddleContentWidth, 0, 0),
                        AutomaticSize = Enum.AutomaticSize.Y
                    })
                else
                    bool2 = nil
                end
            end

            tbl7.LegalTextContainer = bool2
            local bool3

            if var1.countryCode.prefix == "1" then
                bool3 = not var1.disableLegalText

                if bool3 then
                    local createElement3 = React.createElement
                    local str2 = "Frame"
                    local tbl8 = {
                        LayoutOrder = 4,
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 0, 0),
                        AutomaticSize = Enum.AutomaticSize.Y
                    }
                    local tbl9 = {
                        UIListLayout = React.createElement("UIListLayout", {
                            FillDirection = Enum.FillDirection.Horizontal,
                            SortOrder = Enum.SortOrder.LayoutOrder,
                            HorizontalAlignment = Enum.HorizontalAlignment.Center,
                            VerticalAlignment = Enum.VerticalAlignment.Center,
                            Padding = UDim.new(0, 5)
                        }),
                        TermsOfUseButton = React.createElement(LinkButton, {
                            text = arg2.termsOfUseKey,
                            onActivated = var1.onTermsOfUseClick,
                            layoutOrder = 5,
                            fontStyle = "CaptionBody",
                            size = UDim2.fromScale(0.2, 0.2),
                            buttonRef = if FFlagPhoneUpsellFocusNavigation then nextSelectionUp else nil
                        }),
                        TextButtonDivider = React.createElement("TextLabel", {
                            LayoutOrder = 6,
                            BackgroundTransparency = 1,
                            Text = "-",
                            TextSize = baseSize * relativeSize2,
                            TextColor3 = arg1.Theme.TextDefault.Color,
                            TextTransparency = arg1.Theme.TextDefault.Transparency,
                            FontFace = normalizeFontFace(arg1.Tokens.Typography.BodyLarge.Font),
                            TextXAlignment = Enum.TextXAlignment.Center,
                            TextWrapped = true,
                            AutomaticSize = Enum.AutomaticSize.XY
                        }),
                        PrivacyPolicyButton = React.createElement(
                            LinkButton,
                            {
                                text = arg2.privacyPolicyKey,
                                onActivated = var1.onPrivacyPolicyClick,
                                layoutOrder = 7,
                                fontStyle = "CaptionBody"
                            }
                        )
                    }
                    bool3 = createElement3(str2, tbl8, tbl9)
                end
            else
                bool3 = false
            end

            tbl7.LegalButtonsContainer = bool3
            tbl5.Middle = createElement2(str1, tbl6, tbl7)
            return createElement(var5, tbl4, tbl5)
        end)
    end)
end

return AddPhoneView
