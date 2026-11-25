-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:11:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PhoneUpsellParent = script:FindFirstAncestor("PhoneUpsell").Parent

local React = require(PhoneUpsellParent.React)
local UIBlox = require(PhoneUpsellParent.UIBlox)
local normalizeFontFace = require(PhoneUpsellParent.Foundation).Utility.normalizeFontFace
local useStyle = UIBlox.Core.Style.useStyle
local useLocalization = require(PhoneUpsellParent.Localization).Hooks.useLocalization
local TextField = UIBlox.App.Input.TextField
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert

local GetFFlagAddMorePhoneUpsellEvents = require(PhoneUpsellParent.SharedFlags).GetFFlagAddMorePhoneUpsellEvents

local function getButtonStackProps(text: string, onActivated: (...any) -> (...any), isDisabled: boolean, text2: string?, onActivated2: ((...any) -> (...any))?)
    local buttons = {{
        buttonType = ButtonType.Secondary,
        props = { onActivated = onActivated, text = text, isDisabled = isDisabled }
    }}

    if onActivated2 and text2 and text2 ~= "" then
        table.insert(
            buttons,
            1,
            {
                buttonType = ButtonType.Secondary,
                props = { onActivated = onActivated2, text = text2, isDisabled = false }
            }
        )
    end

    return {
        buttonHeight = 48,
        forcedFillDirection = Enum.FillDirection.Horizontal,
        buttons = buttons
    }
end

local function InGameVerifyPhoneView(tbl1)
    local var1 = useStyle()
    local tokens = var1.Tokens
    local tbl2 = {
        titleKey = "Feature.VerificationUpsell.Heading.VerifyYourPhone",
        verificationCodeKey = "Feature.VerificationUpsell.Heading.VerificationCode",
        placeholderKey = "Feature.VerificationUpsell.Label.SixDigitCode",
        descriptionKey = "Feature.VerificationUpsell.Label.EnterCode",
        buttonKey = "Feature.VerificationUpsell.Action.ResendCode",
        buttonDisabledKey = "Feature.VerificationUpsell.Action.CodeResent",
        changePhoneNumberKey = "Feature.VerificationUpsell.Action.ChangePhoneNumber",
        editPhoneDescriptionKey = "Feature.VerificationUpsell.Action.EditPhoneNumber"
    }

    if tbl1.extraButtonKey and tbl1.extraButtonKey ~= "" then
        tbl2.extraButtonKey = tbl1.extraButtonKey
    end
    local var2 = useLocalization(tbl2)
    local var3, var4 = React.useState(0)
    local isDisabled = var3 ~= 0

    local function getBodyText(descriptionKey: string) -- Luacid: Inlined by compiler; 1 call site recovered
        return descriptionKey:gsub("{phoneNumber}", "+" .. tbl1.prefix .. tbl1.phoneNumber)
    end

    local function handleResendButtonClick()
        tbl1.onResendPhoneCode()
        var4(10)
        local startTime = tick()

        local function countDown() -- Luacid: Inlined by compiler; 1 call site recovered
            local var5 = 10 - (tick() - startTime)

            if var5 > 0 then
                var4(math.ceil(var5))
                task.delay(1, countDown)
                return
            end
            var4(0)
        end

        countDown()
    end

    local var5 = if isDisabled then var2.buttonDisabledKey .. " (" .. var3 .. ")" else var2.buttonKey
    local error = tbl1.errorMessage and tbl1.errorMessage ~= ""

    local createElement = React.createElement
    local var7 = InteractiveAlert
    local tbl3 = {
        title = var2.titleKey,
        screenSize = tbl1.screenSize,
        buttonStackInfo = getButtonStackProps(var5, handleResendButtonClick, isDisabled, var2.editPhoneDescriptionKey, tbl1.onExtraButtonClick),
        onCloseClicked = tbl1.onClose,
        position = if tbl1.isKeyboardShowing then UDim2.new(0.5, 0, 1, -tbl1.keyboardHeight) or nil else nil,
        anchorPoint = tbl1.isKeyboardShowing and Vector2.new(0.5, 1) or nil,
        middleContent = 0
    }

    function tbl3.middleContent()
        local createElement2 = React.createElement
        local str1 = "Frame"
        local tbl4 = {
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.Y,
            Size = UDim2.new(1, 0, 0, 0)
        }
        local tableValue1 = React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            Padding = UDim.new(0, tokens.Size.Size_200)
        })
        local createElement3 = React.createElement
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
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                Padding = UDim.new(0, tokens.Size.Size_200)
            }),
            TextBox = React.createElement(TextField, {
                text = tbl1.code,
                placeholder = "",
                required = true,
                onChange = function(text)
                    tbl1.onCodeTextChange({ Text = text })
                end,
                LayoutOrder = 1,
                width = UDim.new(1, 0),
                error = error,
                textInputType = if tbl1.useOTPInputType then Enum.TextInputType.OneTimePassword else Enum.TextInputType.Number,
                onFocusGained = if GetFFlagAddMorePhoneUpsellEvents() then tbl1.onCodeInputFocus else nil
            }),
            ErrorText = error
                and React.createElement("TextLabel", {
                    Text = tbl1.errorMessage,
                    TextTransparency = 0,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Top,
                    TextWrapped = true,
                    BackgroundTransparency = 1,
                    TextColor3 = tokens.Color.System.Alert.Color3,
                    FontFace = normalizeFontFace(tokens.Typography.BodyLarge.Font),
                    TextSize = var1.Font.BaseSize * var1.Font.CaptionSmall.RelativeSize,
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    LayoutOrder = 2
                })
        }

        local tbl7 = {
            ListLayout = tableValue1,
            createElement3(str2, tbl5, tbl6),
            BodyText = React.createElement("TextLabel", {
                LayoutOrder = 3,
                BackgroundTransparency = 1,
                Text = getBodyText(var2.descriptionKey),
                TextSize = var1.Font.BaseSize * var1.Font.CaptionHeader.RelativeSize,
                TextColor3 = var1.Theme.TextDefault.Color,
                TextTransparency = var1.Theme.TextDefault.Transparency,
                FontFace = normalizeFontFace(tokens.Typography.BodyLarge.Font),
                TextXAlignment = Enum.TextXAlignment.Left,
                AutomaticSize = Enum.AutomaticSize.Y,
                TextWrapped = true,
                Size = UDim2.new(1, 0, 0, 0)
            })
        }
        return createElement2(str1, tbl4, tbl7)
    end

    return createElement(var7, tbl3)
end

return InGameVerifyPhoneView
