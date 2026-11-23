-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:40:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AccountUpgrade = script:FindFirstAncestor("AccountUpgrade")
local AccountUpgradeParent = AccountUpgrade.Parent

local React = require(AccountUpgradeParent.React)
local Foundation = require(AccountUpgradeParent.Foundation)
local AuthCommon = require(AccountUpgradeParent.AuthCommon)
local AuthSignup = require(AccountUpgradeParent.AuthSignup)
local SharedFlags = require(AccountUpgradeParent.SharedFlags)
local UsernameFieldWithSuggestions = require(script.Parent.UsernameFieldWithSuggestions)
local AccountUpgradeFieldError = require(script.Parent.AccountUpgradeFieldError)
local AccountUpgradeField = require(AccountUpgrade.AccountUpgradeField)
local _resolveFieldStates = require(AccountUpgrade.Utils.resolveFieldStates)

local GetFFlagAuthCollapsingValidatorFoundationInput = SharedFlags.GetFFlagAuthCollapsingValidatorFoundationInput

local CollapsingTextInputValidator = AuthSignup.Components.CollapsingTextInputValidator
local PasswordValidator = AuthSignup.Thunks.PasswordValidator

local View = Foundation.View
local FoundationText = Foundation.Text
local Icon = Foundation.Icon
local InputLabel = Foundation.InputLabel
local TextInput = Foundation.TextInput
local Chip = Foundation.Chip

local InputSize = Foundation.Enums.InputSize
local InputLabelSize = Foundation.Enums.InputLabelSize
local ChipSize = Foundation.Enums.ChipSize
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize

local UIConstants = AuthCommon.Common.UIConstants
local UserGender = AuthCommon.Enums.UserGender
local formatBoldRichText = AuthCommon.Utils.formatBoldRichText

local function AccountUpgradeFields(tbl1)
    local form = tbl1.form
    local bool1 = tbl1.size == InputSize.Large
    local var1 = if bool1 then InputSize.Large else InputSize.Medium
    local var2 = if bool1 then InputLabelSize.Large else InputLabelSize.Medium
    local size = if bool1 then ChipSize.Large else ChipSize.Medium
    local var4 = Foundation.Hooks.useTokens()
    local isChecked = form.gender == UserGender.Female
    local bool2 = form.gender == UserGender.Male

    local useFoundationTextInput = GetFFlagAuthCollapsingValidatorFoundationInput()

    local color3 = var4.Color.Content.Default.Color3
    local fieldStates = form.fieldStates
    local bool4 = tbl1.boldLabels == true or form.boldFieldLabels == true
    local function labelText(str1: string) -- Luacid: Inlined by compiler; 3 call sites recovered
        if bool4 then
            return (formatBoldRichText(str1))
        end

        return str1
    end

    local createElement = React.createElement
    local var5 = View
    local tbl2 = {
        tag = "col gap-large size-full-0 auto-y",
        LayoutOrder = tbl1.LayoutOrder
    }
    local tbl3 = {
        BirthdayField = 0,
        UsernameField = 0,
        PasswordField = 0,
        EmailField = 0,
        GenderField = 0
    }
    local var6

    if fieldStates[AccountUpgradeField.Birthday] == nil then
        var6 = nil
    else
        local createElement2 = React.createElement
        local var7 = View
        local tbl4 = { tag = "col gap-small size-full-0 auto-y", LayoutOrder = 1 }

        local tbl5 = {
            Label = React.createElement(InputLabel, {
                Text = labelText(form.birthdayLabel),
                RichText = bool4,
                isRequired = true,
                size = var2,
                LayoutOrder = 1,
                testId = "AccountUpgradeBirthdayLabel"
            }),
            BirthdayButton = 0
        }

        local createElement3 = React.createElement
        local var8 = View
        local tbl6 = {
            tag = {
                ["row flex-between align-y-center padding-medium stroke-standard stroke-position-inner radius-medium stroke-emphasis"] = true,
                ["size-full-1000"] = not bool1,
                ["size-full-1200"] = bool1
            },
            onActivated = form.onBirthdayActivated,
            LayoutOrder = 2,
            testId = "AccountUpgradeBirthdayField"
        }

        local tbl7 = {
            Text = React.createElement(FoundationText, {
                Text = if form.birthdayText ~= "" then form.birthdayText else form.birthdayPlaceholder,
                tag = {
                    ["auto-xy text-align-x-left"] = true,
                    ["text-body-medium"] = not bool1,
                    ["text-body-large"] = bool1,
                    ["content-emphasis"] = form.birthdayText ~= "",
                    ["content-muted"] = form.birthdayText == ""
                },
                LayoutOrder = 1
            }),
            CalendarIcon = React.createElement(Icon, {
                name = IconName.Calendar,
                size = IconSize.Small,
                style = var4.Color.Content.Muted,
                LayoutOrder = 2,
                testId = "AccountUpgradeBirthdayIcon"
            })
        }
        tbl5.BirthdayButton = createElement3(var8, tbl6, tbl7)
        var6 = createElement2(var7, tbl4, tbl5)
    end

    tbl3.BirthdayField = var6
    local element

    if fieldStates[AccountUpgradeField.Username] == nil then
        element = nil
    else
        element = React.createElement(UsernameFieldWithSuggestions, {
            LayoutOrder = 2,
            titleTextKey = form.usernameTitleTextKey,
            isTitleBold = bool4,
            inputSize = var1,
            titleSize = var2,
            summaryErrorTextKey = form.usernameSummaryErrorTextKey,
            isPrerequisiteMet = form.isUsernamePrerequisiteMet,
            validatorAdditionalProps = form.usernameValidatorAdditionalProps,
            placeholderText = form.usernamePlaceholder,
            username = form.username,
            prefilledUsername = form.prefilledUsername,
            suggestions = form.usernameSuggestions,
            suggestionPrompt = form.usernameSuggestionPrompt,
            eventContext = form.usernameSuggestionEventContext,
            onSuggestionSelected = form.onUsernameSuggestionSelected,
            pillClicked = form.pillClicked,
            updatePillClicked = form.updatePillClicked,
            resetPillClicked = form.resetPillClicked,
            onTextChanged = form.onUsernameChanged,
            onTextValidated = form.onUsernameValidated,
            onFocused = form.onUsernameFocused,
            onIssueConditionChanged = form.onUsernameIssueConditionChanged,
            useFoundationTextInput = useFoundationTextInput,
            contentGap = var4.Gap.Small,
            colorContentOverride = color3
        })
    end

    tbl3.UsernameField = element
    local var7

    if fieldStates[AccountUpgradeField.Password] == nil then
        var7 = nil
    else
        local createElement2 = React.createElement
        local var8 = View
        local tbl4 = {
            tag = "col size-full-0 auto-y",
            LayoutOrder = 3,
            testId = "AccountUpgradePasswordField"
        }

        local tbl5 = {
            Validator = React.createElement(CollapsingTextInputValidator, {
                layoutOrder = 1,
                titleTextKey = form.passwordTitleTextKey,
                summaryErrorTextKey = form.passwordSummaryErrorTextKey,
                prerequisiteMet = form.isPasswordPrerequisiteMet,
                placeholderText = form.passwordPlaceholder,
                textInputType = if form.hidePassword then Enum.TextInputType.Password else Enum.TextInputType.PasswordShown,
                returnKeyType = Enum.ReturnKeyType.Next,
                validator = PasswordValidator,
                validatorAdditionalProps = form.passwordValidatorAdditionalProps,
                onInputTextChanged = form.onPasswordChanged,
                onInputTextValidated = form.onPasswordValidated,
                textBoxFocusedCallback = form.onPasswordFocused,
                useFoundationTextInput = useFoundationTextInput,
                useFoundationTitle = true,
                foundationInputSize = var1,
                foundationTitleSize = var2,
                foundationTitleIsRequired = true,
                foundationTitleIsBold = bool4,
                foundationIconTrailing = {
                    name = if form.hidePassword then UIConstants.HIDE_PASSWORD_ICON else UIConstants.SHOW_PASSWORD_ICON,
                    onActivated = form.onPasswordVisibilityToggle
                },
                paddingTopOverride = 0,
                contentGapOverride = var4.Gap.Small,
                useTrailingPadding = true,
                colorContentOverride = color3
            })
        }
        var7 = createElement2(var8, tbl4, tbl5)
    end

    tbl3.PasswordField = var7
    local var8

    if fieldStates[AccountUpgradeField.Email] == nil then
        var8 = nil
    else
        local createElement2 = React.createElement
        local var9 = View
        local tbl4 = { tag = "col gap-small size-full-0 auto-y", LayoutOrder = 4 }

        local tbl5 = {
            Label = React.createElement(InputLabel, {
                Text = labelText(form.emailLabel),
                RichText = bool4,
                size = var2,
                LayoutOrder = 1,
                testId = "AccountUpgradeEmailLabel"
            }),
            Input = React.createElement(TextInput, {
                text = form.email,
                placeholder = form.emailPlaceholder,
                textInputType = Enum.TextInputType.Email,
                onChanged = form.onEmailChanged,
                hasError = not (form.emailError == nil) and form.emailError ~= "",
                label = "",
                width = UDim.new(1, 0),
                size = var1,
                LayoutOrder = 2,
                testId = "AccountUpgradeEmailInput"
            }),
            Error = React.createElement(AccountUpgradeFieldError, { text = form.emailError, LayoutOrder = 3 })
        }
        var8 = createElement2(var9, tbl4, tbl5)
    end

    tbl3.EmailField = var8
    local element2

    if fieldStates[AccountUpgradeField.Gender] == nil then
        element2 = nil
    else
        element2 = React.createElement(View, {
            tag = "col gap-small size-full-0 auto-y",
            LayoutOrder = 5
        }, {
            Label = React.createElement(InputLabel, {
                Text = labelText(form.genderLabel),
                RichText = bool4,
                size = var2,
                LayoutOrder = 1,
                testId = "AccountUpgradeGenderLabel"
            }),
            Options = React.createElement(View, {
                tag = "row gap-small size-full-0 auto-y",
                LayoutOrder = 2
            }, {
                Female = React.createElement(Chip, {
                    text = form.femaleText,
                    leading = IconName.HeadFemale,
                    size = size,
                    isChecked = isChecked,
                    onActivated = function()
                        form.onGenderChanged(if isChecked then UserGender.Unknown else UserGender.Female)
                    end,
                    LayoutOrder = 1,
                    testId = "AccountUpgradeGenderFemale"
                }),
                Male = React.createElement(Chip, {
                    text = form.maleText,
                    leading = IconName.HeadMale,
                    size = size,
                    isChecked = bool2,
                    onActivated = function()
                        form.onGenderChanged(if bool2 then UserGender.Unknown else UserGender.Male)
                    end,
                    LayoutOrder = 2,
                    testId = "AccountUpgradeGenderMale"
                })
            })
        })
    end

    tbl3.GenderField = element2
    return createElement(var5, tbl2, tbl3)
end

return AccountUpgradeFields
