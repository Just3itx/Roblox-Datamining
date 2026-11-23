-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:40:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AccountUpgrade = script:FindFirstAncestor("AccountUpgrade")
local AccountUpgradeParent = AccountUpgrade.Parent

local React = require(AccountUpgradeParent.React)
local Foundation = require(AccountUpgradeParent.Foundation)
local AuthAnalytics = require(AccountUpgradeParent.AuthAnalytics)
local AuthSignup = require(AccountUpgradeParent.AuthSignup)

local EventStreamConstants = AuthAnalytics.EventStreamConstants

local usernameSuggestionShown = AuthAnalytics.Events.usernameSuggestionShown
local FFlagAccountUpgradeOAuthTelemetry = require(AccountUpgrade.Flags.FFlagAccountUpgradeOAuthTelemetry)

local CollapsingTextInputValidator = AuthSignup.Components.CollapsingTextInputValidator
local UsernameValidator = AuthSignup.Thunks.UsernameValidator

local View = Foundation.View
local FoundationText = Foundation.Text
local Chip = Foundation.Chip

local InputSize = Foundation.Enums.InputSize
local InputLabelSize = Foundation.Enums.InputLabelSize

local function UsernameSuggestionList(tbl1)
    local tbl2 = {}
    for layoutOrder, text in ipairs(tbl1.suggestionUsernames) do
        tbl2[`Suggestion{layoutOrder}`] = React.createElement(Chip, {
            text = text,
            onActivated = function()
                tbl1.onUsernameSelected(text)
            end,
            LayoutOrder = layoutOrder
        })
    end

    React.useEffect(function()
        usernameSuggestionShown(
            tbl1.eventContext,
            tbl1.inputUsername,
            tbl1.suggestionUsernames,
            EventStreamConstants.Field.Username
        )
    end, {})

    return React.createElement(View, {
        tag = "row align-y-top gap-small size-full-0 auto-y padding-top-large",
        LayoutOrder = tbl1.LayoutOrder,
        testId = "AccountUpgradeUsernameSuggestions"
    }, {
        Prompt = if tbl1.promptText == nil or tbl1.promptText == "" then nil else React.createElement(FoundationText, {
            Text = tbl1.promptText,
            tag = "auto-xy text-body-small text-align-x-left content-emphasis",
            LayoutOrder = 1,
            testId = "AccountUpgradeUsernameSuggestionsPrompt"
        }),
        Options = React.createElement(View, { tag = "col align-x-left gap-small auto-xy", LayoutOrder = 2 }, tbl2)
    })
end

local function UsernameFieldWithSuggestions(tbl1)
    local textBoxRef = React.useRef(nil)
    local onSuggestionSelected = tbl1.onSuggestionSelected
    local updatePillClicked = tbl1.updatePillClicked
    local onUsernameSelected = React.useCallback(function(currentText: string)
        if updatePillClicked ~= nil then
            updatePillClicked()
        end

        local current = textBoxRef.current
        if current ~= nil then
            current.Text = currentText
        end

        if onSuggestionSelected ~= nil then
            onSuggestionSelected(currentText)
        end
    end, { onSuggestionSelected, updatePillClicked })
    local suggestionUsernames = tbl1.suggestions or {}
    local bool1 = #suggestionUsernames > 0 and onSuggestionSelected ~= nil
    local createElement = React.createElement
    local var4 = View
    local tbl2 = {
        tag = "col size-full-0 auto-y",
        LayoutOrder = tbl1.LayoutOrder,
        testId = "AccountUpgradeUsernameField"
    }
    local tbl3 = {
        Validator = React.createElement(CollapsingTextInputValidator, {
            layoutOrder = 1,
            titleTextKey = tbl1.titleTextKey,
            summaryErrorTextKey = tbl1.summaryErrorTextKey,
            prerequisiteMet = tbl1.isPrerequisiteMet,
            placeholderText = tbl1.placeholderText,
            prefilledText = tbl1.prefilledUsername,
            textInputType = Enum.TextInputType.Username,
            returnKeyType = Enum.ReturnKeyType.Next,
            validator = UsernameValidator,
            validatorAdditionalProps = tbl1.validatorAdditionalProps,
            onInputTextChanged = tbl1.onTextChanged,
            onInputTextValidated = tbl1.onTextValidated,
            textBoxFocusedCallback = tbl1.onFocused,
            updateIssueCondition = tbl1.onIssueConditionChanged,
            textBoxRef = textBoxRef,
            pillClicked = tbl1.pillClicked,
            resetPillClicked = tbl1.resetPillClicked,
            useFoundationTextInput = tbl1.useFoundationTextInput,
            useFoundationTitle = true,
            foundationInputSize = tbl1.inputSize or InputSize.Medium,
            foundationTitleSize = tbl1.titleSize or InputLabelSize.Medium,
            foundationTitleIsRequired = true,
            foundationTitleIsBold = tbl1.isTitleBold,
            paddingTopOverride = 0,
            contentGapOverride = tbl1.contentGap,
            useTrailingPadding = true,
            colorContentOverride = tbl1.colorContentOverride
        }),
        Suggestions = if bool1 then React.createElement(UsernameSuggestionList, {
            inputUsername = tbl1.username,
            suggestionUsernames = suggestionUsernames,
            promptText = tbl1.suggestionPrompt,
            eventContext = if FFlagAccountUpgradeOAuthTelemetry and tbl1.eventContext then tbl1.eventContext else EventStreamConstants.Context.SinglePageSignUpScreen,
            onUsernameSelected = onUsernameSelected,
            LayoutOrder = 2
        }) else nil
    }
    return createElement(var4, tbl2, tbl3)
end

return UsernameFieldWithSuggestions
