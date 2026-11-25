-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:50:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local OnPlatformSurveys = script:FindFirstAncestor("OnPlatformSurveys")
local OnPlatformSurveysParent = OnPlatformSurveys.Parent

local Foundation = require(OnPlatformSurveysParent.Foundation)
local React = require(OnPlatformSurveysParent.React)

local List = Foundation.List
local ListItemInputType = Foundation.Enums.ListItemInputType
local TextInput = Foundation.TextInput
local View = Foundation.View

local FFlagInlineSurveyChoiceTextEntry = require(OnPlatformSurveysParent.SharedFlags).FFlagInlineSurveyChoiceTextEntry

local inlineSurveyHelpers = require(OnPlatformSurveys.Utils.inlineSurveyHelpers)
local InlineQuestionType = require(OnPlatformSurveys.Enums.InlineQuestionType)
local _InlineSurveyTypes = require(OnPlatformSurveys.Types.InlineSurveyTypes)

local tbl1 = {}
local tbl2 = {}

return React.memo(function(tbl3) -- name: MultipleChoiceQuestion
    local question = tbl3.question
    local answer = tbl3.answer
    local onAnswerChanged = tbl3.onAnswerChanged
    local isDisabled = tbl3.isDisabled == true
    local bool2 = question.type == InlineQuestionType.MultipleChoiceMulti
    local var1 = question.choices or tbl2

    local var2 = React.useMemo(function()
        local result = ({})
        for _, value in answer.choiceIds or tbl1 do
            result[value] = true
        end
        return result
    end, { answer })

    local var3 = React.useRef(answer)
    var3.current = answer

    local var4 = React.useMemo(function()
        local result = ({})
        for value, value2 in var1 do
            local id = value2.id

            local str1 = string.format("Choice_%d_%s", value, id)

            result[str1] = React.createElement(List.Item, {
                title = value2.label,
                LayoutOrder = if FFlagInlineSurveyChoiceTextEntry then value * 2 else value,
                onActivated = {
                    onActivated = function()
                        if isDisabled then
                            return
                        end
                        onAnswerChanged({
                            choiceIds = inlineSurveyHelpers.toggleChoice(answer, id, bool2),
                            choiceTexts = if FFlagInlineSurveyChoiceTextEntry then answer.choiceTexts else nil
                        })
                    end,
                    inputType = if bool2 then ListItemInputType.Checkbox else ListItemInputType.Radio,
                    isChecked = var2[id] == true
                }
            })

            if not FFlagInlineSurveyChoiceTextEntry or value2.requiresText ~= true then
                continue
            end

            local str2 = string.format("ChoiceText_%d_%s", value, id)
            local createElement = React.createElement
            local var4 = TextInput
            local tbl4 = {
                text = if answer.choiceTexts == nil then "" else answer.choiceTexts[id] or "",
                label = "",
                width = UDim.new(1, 0),
                isDisabled = isDisabled,
                LayoutOrder = value * 2 + 1,
                onChanged = 0
            }

            function tbl4.onChanged(str3: string)
                if isDisabled then
                    return
                end
                local current = var3.current
                local choiceTexts = current.choiceTexts == nil and {} or table.clone(current.choiceTexts)
                choiceTexts[id] = str3
                onAnswerChanged({ choiceIds = current.choiceIds, choiceTexts = choiceTexts })
            end

            result[str2] = createElement(var4, tbl4)
        end

        return result
    end, {
        var1,
        answer,
        var2,
        bool2,
        isDisabled,
        onAnswerChanged
    })
    return React.createElement(View, {
        tag = "col gap-small size-full-0 auto-y",
        LayoutOrder = tbl3.layoutOrder
    }, {
        Choices = React.createElement(List.Root, {
            LayoutOrder = 1,
            hasDivider = { hasDivider = true, isInset = false },
            isContained = { isContained = false, hasMargin = false }
        }, var4)
    })
end)
