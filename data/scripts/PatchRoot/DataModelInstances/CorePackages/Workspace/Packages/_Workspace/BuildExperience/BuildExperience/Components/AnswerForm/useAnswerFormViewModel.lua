-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:21:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent
local React = require(BuildExperienceParent.React)
local Signals = require(BuildExperienceParent.Signals)
local SignalsReact = require(BuildExperienceParent.SignalsReact)
local Foundation = require(BuildExperienceParent.Foundation)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)
local _chatTypes = require(BuildExperience.Chat.chatTypes)
local _AnswerFormView = require(script.Parent.AnswerFormView)
local FFlagBuildExperienceAnswerForm = require(BuildExperience.Flags.FFlagBuildExperienceAnswerForm)
local FFlagBuildExperienceAnswerFormStableInput = require(BuildExperience.Flags.FFlagBuildExperienceAnswerFormStableInput)

local function useStableCustomText(current: string?, str2: string?)
    local binding, var2 = React.useBinding(current and current.getText() or "")
    React.useEffect(function()
        local text = current and current.getText() or ""
        if binding:getValue() ~= text then
            var2(text)
        end
    end, { current })

    React.useEffect(function()
        if str2 == nil and (current == nil or current.getText() == nil) and binding:getValue() ~= "" then
            var2("")
        end
    end, { str2, current })

    local var3 = React.useRef(current)
    var3.current = current

    local setText = React.useCallback(function(str3: string?)
        var2(str3 or "")
        if var3.current then
            var3.current.setText(str3)
        end
    end, {})

    return {
        binding = binding,
        setText = setText,
        onChanged = React.useCallback(function(str3: string)
            if str3 ~= binding:getValue() then
                setText(str3)
            end
        end, {})
    }
end

local function useAnswerFormViewModel(tbl1): {LayoutOrder: any, customLabel: number, customText: any, customTextBinding: number, errorText: number, footerInset: number, isCustom: boolean, isForwardDisabled: number, isMultiSelect: boolean, isReadOnly: boolean, isSubmitting: any, onCustomActivated: number, onCustomChanged: number, onForward: number, onStop: number, options: {[any]: any}, progressText: number, showForward: number, title: any}?
    local state = tbl1.state
    local draft = if state then state.draft else nil

    local var1 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            if draft then
                return (draft.getText(arg1))
            end

            return nil
        end)
    end, { draft })
    local var2 = SignalsReact.useSignalState(var1)
    local var3 = if FFlagBuildExperienceAnswerForm and FFlagBuildExperienceAnswerFormStableInput then useStableCustomText(draft, var2) else nil
    local var4 = Foundation.Hooks.useTokens()
    local var5 = useLocalization({
        customOption = LocalizationStrings.ANSWER_FORM_CUSTOM_OPTION,
        progress = {
            "CommonUI.Controls.Label.PageCount",
            ["current:int"] = if state then state.questionIndex else 0,
            ["total:int"] = if state then state.questionCount else 0
        }
    })
    if state == nil then
        return nil
    end
    assert(
        not (tbl1.actions == nil or tbl1.onSubmitText == nil) and tbl1.onStop ~= nil,
        "Active answer form requires actions"
    )

    local actions = tbl1.actions
    local setText = if var3 then var3.setText else state.draft.setText
    local onSubmitText = tbl1.onSubmitText
    local isReadOnly = tbl1.isReadOnly == true
    local question = state.question
    local bool2 = question.responseType == "multi_select"
    local isCustom = #question.options == 0 or var2 ~= nil
    local customText = var2 or ""
    local selectedOptionId = state.selectedOptionId
    local options = {}
    for _, option in question.options do
        local tbl3 = {
            id = option.id,
            title = option.title,
            description = option.description,
            isSelected = 0,
            onActivated = 0
        }
        local bool4 = not isCustom

        if bool4 then
            if typeof(selectedOptionId) == "table" then
                bool4 = table.find(selectedOptionId, option.id) ~= nil
            else
                bool4 = selectedOptionId == option.id
            end
        end

        tbl3.isSelected = bool4

        function tbl3.onActivated()
            if state.isSubmitting or isReadOnly then
                return
            end
            setText(nil)
            local var7 = actions.onAnswerSelectedByToolCallId[state.toolCallId]
            if var7 == nil then
                return
            end

            if isCustom then
                var7(question, option, true)
                return
            end
            var7(question, option)
        end

        table.insert(options, tbl3)
    end

    local var7 = string.match(customText, "^%s*(.-)%s*$") or ""
    local bool4 = typeof(selectedOptionId) == "table" and #selectedOptionId > 0
    local isSubmitting = state.isSubmitting

    if not isSubmitting then
        if isReadOnly then
            isSubmitting = isReadOnly
        elseif isCustom then
            isSubmitting = var7 == ""
        else
            isSubmitting = not bool4
        end
    end

    local module = {
        LayoutOrder = tbl1.LayoutOrder,
        title = question.question,
        options = options,
        isMultiSelect = bool2,
        isSubmitting = state.isSubmitting,
        isReadOnly = isReadOnly,
        isCustom = isCustom,
        customText = customText,
        customTextBinding = if var3 then var3.binding else nil,
        customLabel = var5.customOption,
        progressText = var5.progress,
        errorText = tbl1.errorText,
        showForward = bool2 or isCustom,
        isForwardDisabled = isSubmitting,
        footerInset = var4.Padding.Small,
        onCustomActivated = 0,
        onCustomChanged = 0,
        onForward = 0,
        onStop = 0
    }

    function module.onCustomActivated()
        if not (state.isSubmitting or isReadOnly) then
            setText("")
        end
    end
    module.onCustomChanged = not var3 and function(str1: string)
        state.draft.setText(str1)
    end or var3.onChanged

    function module.onForward()
        if isSubmitting then
            return
        end

        if isCustom then
            onSubmitText(state.toolCallId, question.id, var7)
        else
            local var8 = actions.onAnswerConfirmedByToolCallId[state.toolCallId]
            if var8 ~= nil then
                var8()
            end
        end
    end
    module.onStop = tbl1.onStop
    return module
end

return useAnswerFormViewModel
