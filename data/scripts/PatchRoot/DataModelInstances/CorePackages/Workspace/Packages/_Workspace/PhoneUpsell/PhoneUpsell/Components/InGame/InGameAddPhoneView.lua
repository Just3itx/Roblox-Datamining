-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PhoneUpsell = script:FindFirstAncestor("PhoneUpsell")
local UserInputService = game:GetService("UserInputService")
local PhoneUpsellParent = PhoneUpsell.Parent

local React = require(PhoneUpsellParent.React)
local Roact = require(PhoneUpsellParent.Roact)
local UIBlox = require(PhoneUpsellParent.UIBlox)
local AuthCommon = require(PhoneUpsellParent.AuthCommon)
local Style = require(PhoneUpsellParent.Style)
local normalizeFontFace = require(PhoneUpsellParent.Foundation).Utility.normalizeFontFace
local useStyle = UIBlox.Core.Style.useStyle
local useLocalization = require(PhoneUpsellParent.Localization).Hooks.useLocalization
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local mergeProps = require(PhoneUpsell.Utils.mergeProps)
local TextField = UIBlox.App.Input.TextField
local CountryCodeButton = require(PhoneUpsell.Components.InGame.CountryCodeButton)
local CountryCodeDropdownContainer = AuthCommon.Components.InGame.CountryCodeDropdownContainer
local useExternalEvent = require(PhoneUpsellParent.RoactUtils).Hooks.useExternalEvent

local GetFFlagAddMorePhoneUpsellEvents = require(PhoneUpsellParent.SharedFlags).GetFFlagAddMorePhoneUpsellEvents
local FFlagInExperienceAddPhoneViewNewCopy = require(PhoneUpsellParent.SharedFlags).FFlagInExperienceAddPhoneViewNewCopy

local vector2 = Vector2.new(10000, 10000)

local tbl1 = {
    alwaysShowLegalText = false,
    requireLegalTextCheckbox = false,
    buttonKey = if FFlagInExperienceAddPhoneViewNewCopy then "Feature.AccountSettings.Action.Verify" else "Feature.VerificationUpsell.Action.Next",
    legalTextKey = "Feature.VerificationUpsell.Description.ShortCodeLegalDisclaimerUA",
    prefix = "1"
}

local function getButtonStackProps(text: string, onActivated: (...any) -> (...any), isDisabled: boolean, text2: string, onActivated2: (...any) -> (...any))
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

    return { buttonHeight = 48, buttons = buttons }
end

local function InGameAddPhoneView(tbl2)
    local var1 = mergeProps(tbl1, tbl2)
    local var2 = FFlagInExperienceAddPhoneViewNewCopy
        and {
            phoneNumberKey = "Feature.VerificationUpsell.Label.PhoneNumber",
            disclaimerKey = "Feature.VerificationUpsell.Description.VerificationCodeSmsFeesMayApply",
            termsOfUseKey = "Feature.VerificationUpsell.Action.TermsOfUse",
            privacyPolicyKey = "Feature.VerificationUpsell.Action.PrivacyPolicy",
            subtitleKey = "Feature.AccountSettings.Description.AddPhoneNumber",
            phonePrivacyDisclaimerKey = "Feature.AccountSettings.Description.NotShownPublicly",
            titleKey = var1.titleKey,
            descriptionKey = var1.descriptionKey,
            buttonKey = var1.buttonKey,
            legalTextKey = var1.legalTextKey
        }
        or {
            phoneNumberKey = "Feature.VerificationUpsell.Label.PhoneNumber",
            disclaimerKey = "Feature.VerificationUpsell.Description.VerificationCodeSmsFeesMayApply",
            termsOfUseKey = "Feature.VerificationUpsell.Action.TermsOfUse",
            privacyPolicyKey = "Feature.VerificationUpsell.Action.PrivacyPolicy",
            titleKey = var1.titleKey,
            descriptionKey = var1.descriptionKey,
            buttonKey = var1.buttonKey,
            legalTextKey = var1.legalTextKey
        }
    if var1.extraButtonKey and var1.extraButtonKey ~= "" then
        var2.extraButtonKey = var1.extraButtonKey
    end

    local var3 = useStyle()
    local tokens = var3.Tokens
    local bodyLarge = tokens.Typography.BodyLarge
    local font = bodyLarge.Font
    local fontSize = bodyLarge.FontSize

    local var4 = useLocalization(var2)

    local baseSize = var3.Font.BaseSize
    local relativeSize = var3.Font.CaptionHeader.RelativeSize
    local isDisabled = var1.isDisabled

    local small = tokens.Gap.Small
    local size1200 = tokens.Size.Size_1200

    local prefix = var1.countryCode.prefix
    local dropdownVisible, var6 = React.useState(false)
    local xOffset = math.max(Style.GetTextSize(prefix, fontSize, font, vector2).X + 24, size1200)
    local var7, var8 = React.useState(300)

    local function onAbsoluteSizeChanged(arg1)
        var8(arg1.AbsoluteSize.X)
    end

    local var9 = React.useRef(nil)
    local var10 = React.useRef(nil)
    local forwardRef = React.useRef(nil)

    local vector2_2 = Vector2.new(0, 0)
    local vector2_3 = Vector2.new(0, 0)
    local vector2_4 = Vector2.new(0, 0)

    if var9.current then
        vector2_2 = var9.current.AbsolutePosition
    end

    if var10.current then
        vector2_3 = var10.current.AbsolutePosition
    end

    if forwardRef.current then
        vector2_4 = forwardRef.current.AbsolutePosition
    end

    local maxHeight = math.min(var1.screenSize.Y - (vector2_2.Y + size1200 + small - vector2_3.Y) - small, 400)

    local var12 = React.useCallback(function(arg1)
        local var12 = size1200 + small
        local bool1

        if arg1.Position.X > vector2_4.X and arg1.Position.X < vector2_4.X + var7 and arg1.Position.Y > vector2_4.Y + var12 then
            bool1 = arg1.Position.Y < vector2_4.Y + var12 + maxHeight
        else
            bool1 = false
        end

        local bool2

        if arg1.Position.X > vector2_4.X and arg1.Position.X < vector2_4.X + xOffset and arg1.Position.Y > vector2_4.Y then
            bool2 = arg1.Position.Y < vector2_4.Y + size1200
        else
            bool2 = false
        end
        if dropdownVisible and not (bool1 or bool2) then
            var6(false)
        end
    end, {
        dropdownVisible,
        vector2_4,
        var7,
        xOffset,
        size1200
    })

    useExternalEvent(UserInputService.InputBegan, var12)

    local error = var1.errorMessage and var1.errorMessage ~= ""

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl3 = {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        [Roact.Ref] = var9
    }
    local tbl4 = {
        ListLayout = React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            FillDirection = Enum.FillDirection.Vertical,
            Padding = UDim.new(0, tokens.Size.Size_200)
        }),
        PhoneInputContainer = 0,
        ErrorText = 0
    }
    local createElement2 = React.createElement
    local str2 = "Frame"
    local tbl5 = {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = 0
    }
    local tbl6 = {
        ListLayout = React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            FillDirection = Enum.FillDirection.Horizontal,
            Padding = UDim.new(0, small)
        }),
        CountryCodeButton = React.createElement(CountryCodeButton, {
            countryPrefix = "+" .. prefix,
            onButtonClick = function()
                var6(not dropdownVisible)
                if GetFFlagAddMorePhoneUpsellEvents then
                    var1.onCountryCodeSelectorClick()
                end
            end,
            size = UDim2.new(0, xOffset, 0, tokens.Size.Size_1200),
            layoutOrder = 1,
            font = font,
            textSize = fontSize,
            forwardRef = forwardRef,
            error = error
        }),
        PhoneInputBox = React.createElement(TextField, {
            text = var1.phoneNumber,
            placeholder = "",
            required = true,
            onChange = function(text: string)
                var1.onPhoneNumberTextChange({ Text = text })
            end,
            LayoutOrder = 2,
            width = UDim.new(1, -(xOffset + small)),
            error = error,
            textInputType = if var1.usePhoneNumberTextType then Enum.TextInputType.Phone else Enum.TextInputType.Number,
            onFocusGained = if GetFFlagAddMorePhoneUpsellEvents() then var1.onPhoneInputFocus else nil
        })
    }

    tbl4.PhoneInputContainer = createElement2(str2, tbl5, tbl6)

    tbl4.ErrorText = error
        and React.createElement("TextLabel", {
            Text = var1.errorMessage,
            TextTransparency = 0,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            TextWrapped = true,
            BackgroundTransparency = 1,
            TextColor3 = tokens.Color.System.Alert.Color3,
            FontFace = normalizeFontFace(tokens.Typography.BodyLarge.Font),
            TextSize = baseSize * var3.Font.CaptionSmall.RelativeSize,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            LayoutOrder = 1
        })
    local phoneInput = createElement(str1, tbl3, tbl4)

    local addPhoneView = React.createElement(InteractiveAlert, {
        screenSize = var1.screenSize,
        buttonStackInfo = getButtonStackProps(var4.buttonKey, var1.onSetPhoneNumber, isDisabled, var4.extraButtonKey, var1.onExtraButtonClick),
        position = var1.isKeyboardShowing and UDim2.new(0.5, 0, 1, -var1.keyboardHeight) or UDim2.fromScale(0.5, 0.5),
        anchorPoint = if var1.isKeyboardShowing then Vector2.new(0.5, 1) or nil else nil,
        title = var4.titleKey,
        onAbsoluteSizeChanged = onAbsoluteSizeChanged,
        onCloseClicked = var1.onClose,
        middleContent = FFlagInExperienceAddPhoneViewNewCopy and function()
            return React.createElement(
                "Frame",
                {
                    BackgroundTransparency = 1,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Size = UDim2.new(1, 0, 0, 0)
                },
                {
                    AddPhoneViewFrame = React.createElement(
                        "Frame",
                        {
                            BackgroundTransparency = 1,
                            AutomaticSize = Enum.AutomaticSize.Y,
                            Size = UDim2.new(1, 0, 0, 0)
                        },
                        {
                            ListLayout = React.createElement("UIListLayout", {
                                SortOrder = Enum.SortOrder.LayoutOrder,
                                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                                Padding = UDim.new(0, tokens.Size.Size_200)
                            }),
                            SubtitleText = React.createElement("TextLabel", {
                                LayoutOrder = -1,
                                BackgroundTransparency = 1,
                                Text = var4.subtitleKey,
                                TextSize = baseSize,
                                TextColor3 = var3.Theme.TextEmphasis.Color,
                                TextTransparency = var3.Theme.TextEmphasis.Transparency,
                                FontFace = normalizeFontFace(tokens.Typography.BodyLarge.Font),
                                TextXAlignment = Enum.TextXAlignment.Left,
                                TextWrapped = true,
                                Size = UDim2.new(1, 0, 0, 0),
                                AutomaticSize = Enum.AutomaticSize.Y
                            }),
                            PhoneInput = phoneInput,
                            PhonePrivacyText = React.createElement("TextLabel", {
                                LayoutOrder = 2,
                                BackgroundTransparency = 1,
                                Text = var4.phonePrivacyDisclaimerKey,
                                TextSize = baseSize * relativeSize,
                                TextColor3 = var3.Theme.TextEmphasis.Color,
                                TextTransparency = var3.Theme.TextEmphasis.Transparency,
                                FontFace = normalizeFontFace(tokens.Typography.BodyLarge.Font),
                                TextXAlignment = Enum.TextXAlignment.Left,
                                TextWrapped = true,
                                Size = UDim2.new(1, 0, 0, 0),
                                AutomaticSize = Enum.AutomaticSize.Y
                            }),
                            PrivacyText = React.createElement("TextLabel", {
                                LayoutOrder = 3,
                                BackgroundTransparency = 1,
                                Text = var4.disclaimerKey,
                                TextSize = baseSize * relativeSize,
                                TextColor3 = var3.Theme.TextEmphasis.Color,
                                TextTransparency = var3.Theme.TextEmphasis.Transparency,
                                FontFace = normalizeFontFace(tokens.Typography.BodyLarge.Font),
                                TextXAlignment = Enum.TextXAlignment.Left,
                                TextWrapped = true,
                                Size = UDim2.new(1, 0, 0, 0),
                                AutomaticSize = Enum.AutomaticSize.Y
                            })
                        }
                    )
                }
            )
        end or function()
            return React.createElement(
                "Frame",
                {
                    BackgroundTransparency = 1,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Size = UDim2.new(1, 0, 0, 0)
                },
                {
                    AddPhoneViewFrame = React.createElement(
                        "Frame",
                        {
                            BackgroundTransparency = 1,
                            AutomaticSize = Enum.AutomaticSize.Y,
                            Size = UDim2.new(1, 0, 0, 0)
                        },
                        {
                            ListLayout = React.createElement("UIListLayout", {
                                SortOrder = Enum.SortOrder.LayoutOrder,
                                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                                Padding = UDim.new(0, tokens.Size.Size_200)
                            }),
                            PhoneInput = phoneInput,
                            PrivacyText = React.createElement("TextLabel", {
                                LayoutOrder = 2,
                                BackgroundTransparency = 1,
                                Text = var4.disclaimerKey,
                                TextSize = baseSize * relativeSize,
                                TextColor3 = var3.Theme.TextEmphasis.Color,
                                TextTransparency = var3.Theme.TextEmphasis.Transparency,
                                FontFace = normalizeFontFace(tokens.Typography.BodyLarge.Font),
                                TextXAlignment = Enum.TextXAlignment.Left,
                                TextWrapped = true,
                                Size = UDim2.new(1, 0, 0, 0),
                                AutomaticSize = Enum.AutomaticSize.Y
                            })
                        }
                    )
                }
            )
        end
    })

    local createElement3 = React.createElement
    local tbl7 = {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        BorderSizePixel = 0,
        [Roact.Ref] = var10
    }

    return createElement3("Frame", tbl7, {
        AddPhoneView = addPhoneView,
        CountryCodeSelectorFrame = React.createElement("Frame", {
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.Y,
            Size = UDim2.new(0, var7 - 24, 0, 0),
            ZIndex = 2,
            BorderSizePixel = 0,
            Position = UDim2.new(0, vector2_2.X - vector2_3.X, 0, vector2_2.Y + size1200 + small - vector2_3.Y)
        }, {
            CountryCodeDropdown = React.createElement(CountryCodeDropdownContainer, {
                dropdownVisible = dropdownVisible,
                position = UDim2.new(0, 0, 0, 0),
                maxHeight = maxHeight,
                onCountryCodeSelected = function(arg1)
                    var1.setCountryCode(arg1)
                    var6(false)
                end
            })
        })
    })
end

return InGameAddPhoneView
