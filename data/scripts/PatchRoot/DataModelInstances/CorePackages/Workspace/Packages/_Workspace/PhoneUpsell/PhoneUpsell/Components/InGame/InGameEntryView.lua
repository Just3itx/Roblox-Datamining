-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:10:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PhoneUpsell = script:FindFirstAncestor("PhoneUpsell")
local PhoneUpsellParent = PhoneUpsell.Parent

local React = require(PhoneUpsellParent.React)
local UIBlox = require(PhoneUpsellParent.UIBlox)
local Foundation = require(PhoneUpsellParent.Foundation)
local Checkbox = Foundation.Checkbox
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local useStyle = UIBlox.Core.Style.useStyle
local useLocalization = require(PhoneUpsellParent.Localization).Hooks.useLocalization
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local mergeProps = require(PhoneUpsell.Utils.mergeProps)
local LinkButton = UIBlox.App.Button.LinkButton

local GetFFlagDisablePVUpsellDataConsent = require(PhoneUpsellParent.SharedFlags).GetFFlagDisablePVUpsellDataConsent

local function noOp() end

local tbl1 = {
    onClose = noOp,
    isButtonDisabled = false,
    onExtraButtonClick = noOp,
    isExtraButtonDisabled = false,
    alwaysShowLegalText = false,
    requireLegalTextCheckbox = false,
    legalTextKey = "Feature.VerificationUpsell.Description.ShortCodeLegalDisclaimerUA",
    prefix = "1"
}

local function getButtonStackProps(text: string, buttonHeight: number, onActivated: (...any) -> (...any), isDisabled: boolean, text2: string, onActivated2: (...any) -> (...any), isDisabled2: boolean)
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
                props = { onActivated = onActivated2, text = text2, isDisabled = isDisabled2 }
            }
        )
    end
    return { buttonHeight = buttonHeight, buttons = buttons }
end

local function InGameEntryView(tbl2)
    local var1 = mergeProps(tbl1, tbl2)

    local isChecked, onActivated = React.useState(false)
    local tbl3 = {
        phoneNumberKey = "Feature.VerificationUpsell.Label.PhoneNumber",
        phonePrivacyDisclaimerKey = "Feature.VerificationUpsell.Description.PhoneNumberNeverPublic",
        termsOfUseKey = "Feature.VerificationUpsell.Action.TermsOfUse",
        privacyPolicyKey = "Feature.VerificationUpsell.Action.PrivacyPolicy",
        titleKey = var1.titleKey,
        descriptionKey = var1.descriptionKey,
        buttonKey = var1.buttonKey,
        legalTextKey = var1.legalTextKey
    }
    if var1.extraButtonKey and var1.extraButtonKey ~= "" then
        tbl3.extraButtonKey = var1.extraButtonKey
    end

    local var4 = useStyle()
    local baseSize = var4.Font.BaseSize
    local relativeSize = var4.Font.CaptionHeader.RelativeSize
    local size150 = var4.Tokens.Size.Size_150

    local var5 = useLocalization(tbl3)
    var5.legalTextKey = var5.legalTextKey:gsub("{buttonText}", var5.buttonKey)

    return React.createElement(InteractiveAlert, {
        title = var5.titleKey,
        screenSize = var1.screenSize,
        buttonStackInfo = getButtonStackProps(
            var5.buttonKey,
            var4.Tokens.Size.Size_1200,
            var1.onButtonClick,
            var1.isButtonDisabled,
            var5.extraButtonKey,
            var1.onExtraButtonClick,
            var1.isExtraButtonDisabled
        ),
        onCloseClicked = var1.onClose,
        middleContent = function()
            return React.createElement(
                "Frame",
                {
                    BackgroundTransparency = 1,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Size = UDim2.new(1, 0, 0, 0)
                },
                {
                    BodyText = React.createElement("TextLabel", {
                        LayoutOrder = 0,
                        BackgroundTransparency = 1,
                        Text = var5.descriptionKey,
                        TextSize = baseSize,
                        TextColor3 = var4.Theme.TextDefault.Color,
                        TextTransparency = var4.Theme.TextDefault.Transparency,
                        FontFace = normalizeFontFace(var4.Tokens.Typography.BodyLarge.Font),
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextWrapped = true,
                        Size = UDim2.new(1, 0, 0, 0),
                        AutomaticSize = Enum.AutomaticSize.Y,
                        RichText = true
                    })
                }
            )
        end,
        footerContent = GetFFlagDisablePVUpsellDataConsent() and function()
            return nil
        end or function()
            local createElement = React.createElement
            local str1 = "Frame"
            local tbl4 = {
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.Y,
                Size = UDim2.new(1, 0, 0, 0)
            }
            local tbl5 = {
                ContentPadding = React.createElement("UIPadding", { PaddingTop = UDim.new(0, var4.Tokens.Size.Size_300) }),
                ListLayout = React.createElement("UIListLayout", {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    Padding = UDim.new(0, var4.Tokens.Size.Size_150)
                }),
                LegalTextContainer = 0,
                LegalButtonsContainer = 0
            }
            local element

            if var1.requireLegalTextCheckbox then
                element = React.createElement(
                    "Frame",
                    {
                        LayoutOrder = 3,
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 0, 0),
                        AutomaticSize = Enum.AutomaticSize.Y
                    },
                    {
                        UIListLayout = React.createElement("UIListLayout", {
                            FillDirection = Enum.FillDirection.Horizontal,
                            HorizontalAlignment = Enum.HorizontalAlignment.Center,
                            VerticalAlignment = Enum.VerticalAlignment.Center,
                            Padding = UDim.new(0, size150)
                        }),
                        LegalCheckbox = React.createElement(Checkbox, { onActivated = onActivated, isChecked = isChecked, label = "" }),
                        LegalText = React.createElement("TextLabel", {
                            BackgroundTransparency = 1,
                            Text = var5.legalTextKey,
                            TextSize = baseSize * relativeSize,
                            TextColor3 = var4.Theme.TextDefault.Color,
                            TextTransparency = var4.Theme.TextDefault.Transparency,
                            FontFace = normalizeFontFace(var4.Tokens.Typography.BodyLarge.Font),
                            TextXAlignment = Enum.TextXAlignment.Left,
                            TextWrapped = true,
                            Size = UDim2.new(1, -(26 + size150), 0, 0),
                            AutomaticSize = Enum.AutomaticSize.Y
                        })
                    }
                )
            elseif var1.alwaysShowLegalText or var1.countryCode.prefix == "1" then
                element = React.createElement("TextLabel", {
                    LayoutOrder = 3,
                    BackgroundTransparency = 1,
                    Text = var5.legalTextKey,
                    TextSize = baseSize * relativeSize,
                    TextColor3 = var4.Theme.TextDefault.Color,
                    TextTransparency = var4.Theme.TextDefault.Transparency,
                    FontFace = normalizeFontFace(var4.Tokens.Typography.BodyLarge.Font),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextWrapped = true,
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y
                })
            else
                element = false
            end

            tbl5.LegalTextContainer = element
            local element2

            if var1.countryCode.prefix == "1" then
                element2 = React.createElement(
                    "Frame",
                    {
                        LayoutOrder = 4,
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 0, 0),
                        AutomaticSize = Enum.AutomaticSize.Y
                    },
                    {
                        UIListLayout = React.createElement("UIListLayout", {
                            FillDirection = Enum.FillDirection.Horizontal,
                            SortOrder = Enum.SortOrder.LayoutOrder,
                            HorizontalAlignment = Enum.HorizontalAlignment.Center,
                            VerticalAlignment = Enum.VerticalAlignment.Center,
                            Padding = UDim.new(0, 5)
                        }),
                        TermsOfUseButton = React.createElement(LinkButton, {
                            text = var5.termsOfUseKey,
                            onActivated = var1.onTermsOfUseClick,
                            layoutOrder = 5,
                            fontStyle = "CaptionBody",
                            size = UDim2.fromScale(0.2, 0.2)
                        }),
                        TextButtonDivider = React.createElement("TextLabel", {
                            LayoutOrder = 6,
                            BackgroundTransparency = 1,
                            Text = "-",
                            TextSize = baseSize * relativeSize,
                            TextColor3 = var4.Theme.TextDefault.Color,
                            TextTransparency = var4.Theme.TextDefault.Transparency,
                            FontFace = normalizeFontFace(var4.Tokens.Typography.BodyLarge.Font),
                            TextXAlignment = Enum.TextXAlignment.Center,
                            TextWrapped = true,
                            AutomaticSize = Enum.AutomaticSize.XY
                        }),
                        PrivacyPolicyButton = React.createElement(
                            LinkButton,
                            {
                                text = var5.privacyPolicyKey,
                                onActivated = var1.onPrivacyPolicyClick,
                                layoutOrder = 7,
                                fontStyle = "CaptionBody"
                            }
                        )
                    }
                )
            else
                element2 = false
            end

            tbl5.LegalButtonsContainer = element2
            return createElement(str1, tbl4, tbl5)
        end
    })
end

return InGameEntryView
