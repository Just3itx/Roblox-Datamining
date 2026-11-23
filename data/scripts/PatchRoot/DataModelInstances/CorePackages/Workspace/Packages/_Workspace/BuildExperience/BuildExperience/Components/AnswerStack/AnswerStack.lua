-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:21:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local OptionSelector = require(script.Parent.OptionSelector)

local Button = Foundation.Button
local View = Foundation.View

local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize

local function isOptionSelected(selectedOptionId, id: string) -- Luacid: Inlined by compiler; 1 call site recovered
    if typeof(selectedOptionId) == "string" then
        return selectedOptionId == id
    end
    if typeof(selectedOptionId) ~= "table" then
        return false
    end
    for _, value in selectedOptionId do
        if value == id then
            return true
        end
    end
    return false
end

local function getFirstSelectedOptionId(selectedOptionId) -- Luacid: Inlined by compiler; 1 call site recovered
    if typeof(selectedOptionId) == "string" then
        return selectedOptionId
    elseif typeof(selectedOptionId) == "table" then
        return selectedOptionId[1]
    end

    return nil
end

local function AnswerStack(tbl1)
    local var1 = useLocalization(
        {
            selectAnOption = LocalizationStrings.ANSWER_STACK_SELECT_AN_OPTION,
            submit = LocalizationStrings.ANSWER_STACK_SUBMIT
        }
    )
    local onOptionSelected = tbl1.onOptionSelected
    local options = tbl1.options
    local bool1 = (tbl1.selectionMode or "single") == "multi"
    local selectedOptionId = tbl1.selectedOptionId
    local onConfirm = tbl1.onConfirm
    local bool2 = bool1 and onConfirm ~= nil
    local firstSelectedOptionId = if bool2 or selectedOptionId == nil then nil else getFirstSelectedOptionId(selectedOptionId)
    local tbl2 = ({})
    for layoutOrder, option in options do
        if firstSelectedOptionId ~= nil and option.id ~= firstSelectedOptionId then
            continue
        end

        local id = option.id
        local createElement = React.createElement
        local var2 = OptionSelector
        local tbl3 = {
            LayoutOrder = layoutOrder,
            title = option.title,
            description = option.description,
            isSelected = isOptionSelected(selectedOptionId, option.id),
            selectionStyle = if bool2 then "intermediate" else "committed",
            testId = `AnswerStack.Option.{option.id}`,
            onActivated = 0
        }

        function tbl3.onActivated()
            onOptionSelected(option)
        end

        tbl2[id] = createElement(var2, tbl3)
    end

    local tbl3 = {
        Options = React.createElement(View, { LayoutOrder = 1, tag = "col gap-medium size-full-0 auto-y" }, tbl2)
    }

    if bool2 and onConfirm ~= nil then
        local isDisabled = tbl1.isConfirmDisabled == true
        local createElement = React.createElement
        local var2 = View
        local tbl4 = { LayoutOrder = 2, tag = "row align-x-right size-full-0 auto-y" }

        local tbl5 = {
            Button = React.createElement(Button, {
                text = if isDisabled then var1.selectAnOption else tbl1.confirmLabel or var1.submit,
                size = InputSize.Medium,
                variant = ButtonVariant.Standard,
                isDisabled = isDisabled,
                onActivated = onConfirm,
                testId = `{tbl1.testId or "AnswerStack"}.Confirm`
            })
        }
        tbl3.Confirm = createElement(var2, tbl4, tbl5)
    end

    return React.createElement(View, {
        LayoutOrder = tbl1.LayoutOrder,
        testId = tbl1.testId or "AnswerStack",
        tag = "col gap-medium size-full-0 auto-y padding-top-small"
    }, tbl3)
end

return AnswerStack
