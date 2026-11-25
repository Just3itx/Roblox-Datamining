-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:11:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PhoneUpsell = script:FindFirstAncestor("PhoneUpsell")
local PhoneUpsellParent = PhoneUpsell.Parent

local React = require(PhoneUpsellParent.React)
local UIBlox = require(PhoneUpsellParent.UIBlox)
local normalizeFontFace = require(PhoneUpsellParent.Foundation).Utility.normalizeFontFace
local useStyle = UIBlox.Core.Style.useStyle
local useLocalization = require(PhoneUpsellParent.Localization).Hooks.useLocalization

local ButtonType = UIBlox.App.Button.Enum.ButtonType
local TextInputBoxWithBorder = require(PhoneUpsellParent.AuthCommon).Components.TextInputBoxWithBorder
local PartialPageModal = UIBlox.App.Dialog.Modal.PartialPageModal
local getPartialPageModalMiddleContentWidth = UIBlox.App.Dialog.Modal.getPartialPageModalMiddleContentWidth
local LinkButton = UIBlox.App.Button.LinkButton

local GetFFlagDisableVerifyPhoneViewOnSuccess = require(PhoneUpsell.Flags.GetFFlagDisableVerifyPhoneViewOnSuccess)

local function VerifyPhoneView(tbl1)
    local var1 = useStyle()
    local tbl2 = {
        titleKey = "Feature.VerificationUpsell.Heading.VerifyYourPhone",
        verificationCodeKey = "Feature.VerificationUpsell.Heading.VerificationCode",
        placeholderKey = "Feature.VerificationUpsell.Label.SixDigitCode",
        descriptionKey = "Feature.VerificationUpsell.Label.EnterCode",
        buttonKey = "Feature.VerificationUpsell.Action.ResendCode",
        buttonDisabledKey = "Feature.VerificationUpsell.Action.CodeResent",
        changePhoneNumberKey = "Feature.VerificationUpsell.Action.ChangePhoneNumber"
    }

    if tbl1.extraButtonKey and tbl1.extraButtonKey ~= "" then
        tbl2.extraButtonKey = tbl1.extraButtonKey
    end
    local var2 = useLocalization(tbl2)
    local isDisabled, var4 = React.useState(false)
    local var5, var6 = React.useState(0)

    local function getButtonStackProps(buttonKey: string, buttonDisabledKey: string, num1: number, callback: (...any) -> (...any), text: string?, onActivated: ((...any) -> (...any))?)
        local function getButtonText() -- Luacid: Inlined by compiler; 1 call site recovered
            if isDisabled then
                return buttonDisabledKey .. " (" .. var5 .. ")"
            end

            return buttonKey
        end

        local buttons = {{
            buttonType = ButtonType.PrimarySystem,
            props = {
                onActivated = function() -- name: handleButtonClick
                    callback()
                    var4(true)
                    var6(num1)
                    local startTime = tick()

                    local function countDown()
                        local var7 = tick() - startTime
                        local var8 = num1 - var7

                        if var8 > 0 then
                            var6(math.round(var8))
                            task.delay(1, countDown)
                            return
                        end
                        var6(0)
                        var4(false)
                    end

                    countDown()
                end,
                text = getButtonText(),
                isDisabled = isDisabled or GetFFlagDisableVerifyPhoneViewOnSuccess() and tbl1.isDisabled
            }
        }}

        if onActivated and text and text ~= "" then
            table.insert(buttons, 1, {
                buttonType = ButtonType.Secondary,
                props = {
                    onActivated = onActivated,
                    text = text,
                    isDisabled = GetFFlagDisableVerifyPhoneViewOnSuccess() and tbl1.isDisabled
                }
            })
        end

        return {
            buttonHeight = 48,
            forcedFillDirection = Enum.FillDirection.Vertical,
            buttons = buttons
        }
    end

    local function getBodyText(descriptionKey: string) -- Luacid: Inlined by compiler; 1 call site recovered
        return descriptionKey:gsub("{phoneNumber}", "+" .. tbl1.prefix .. tbl1.phoneNumber)
    end

    local partialPageModalMiddleContentWidth = getPartialPageModalMiddleContentWidth(tbl1.screenSize.X)
    return React.createElement(PartialPageModal, {
        title = var2.titleKey,
        screenSize = tbl1.screenSize,
        buttonStackProps = getButtonStackProps(
            var2.buttonKey,
            var2.buttonDisabledKey,
            10,
            tbl1.onResendPhoneCode,
            var2.extraButtonKey,
            tbl1.onExtraButtonClick
        ),
        onCloseClicked = tbl1.onClose,
        position = if tbl1.isKeyboardShowing then UDim2.new(0.5, 0, 1, -tbl1.keyboardHeight) or nil else nil,
        anchorPoint = if tbl1.isKeyboardShowing then Vector2.new(0.5, 1) or nil else nil
    }, {
        Middle = React.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.Y,
                Size = UDim2.new(1, 0, 0, 0)
            },
            {
                ContentPadding = React.createElement("UIPadding", { PaddingTop = UDim.new(0, 24), PaddingBottom = UDim.new(0, 24) }),
                ListLayout = React.createElement("UIListLayout", {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    HorizontalAlignment = Enum.HorizontalAlignment.Left,
                    Padding = UDim.new(0, 12)
                }),
                BodyText = React.createElement("TextLabel", {
                    LayoutOrder = 1,
                    BackgroundTransparency = 1,
                    Text = getBodyText(var2.descriptionKey),
                    TextSize = var1.Font.BaseSize,
                    TextColor3 = var1.Theme.TextDefault.Color,
                    TextTransparency = var1.Theme.TextDefault.Transparency,
                    FontFace = normalizeFontFace(var1.Tokens.Typography.BodyLarge.Font),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    TextWrapped = true,
                    Size = UDim2.new(0, partialPageModalMiddleContentWidth, 0, 0)
                }),
                TextBox = React.createElement(TextInputBoxWithBorder, {
                    text = tbl1.code,
                    textInputType = tbl1.useOTPInputType and Enum.TextInputType.OneTimePassword or Enum.TextInputType.Number,
                    textInputHeight = 36,
                    layoutOrder = 2,
                    placeholderText = var2.placeholderKey,
                    errorText = tbl1.errorMessage,
                    onChangeTextCallback = tbl1.onCodeTextChange,
                    Size = UDim2.new(1, 0, 0, 0),
                    onFocused = tbl1.onCodeInputFocus,
                    maxLength = 6
                }),
                ChangePhoneButton = React.createElement(LinkButton, {
                    text = var2.changePhoneNumberKey,
                    onActivated = tbl1.returnToAddPhone,
                    layoutOrder = 3,
                    fontStyle = "CaptionBody",
                    minPaddingX = 0,
                    minPaddingY = 0
                })
            }
        )
    })
end

return VerifyPhoneView
