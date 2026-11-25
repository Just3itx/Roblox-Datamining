-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local OnPlatformSurveys = script:FindFirstAncestor("OnPlatformSurveys")
local OnPlatformSurveysParent = OnPlatformSurveys.Parent

local React = require(OnPlatformSurveysParent.React)

local SharedFlags = require(OnPlatformSurveysParent.SharedFlags)
local FFlagInlineSurveyEnhancements = SharedFlags.FFlagInlineSurveyEnhancements
local FFlagInlineSurveyChoiceTextEntry = SharedFlags.FFlagInlineSurveyChoiceTextEntry

local InlineQuestionType = require(OnPlatformSurveys.Enums.InlineQuestionType)
local MultipleChoiceQuestion = require(OnPlatformSurveys.Components.Questions.MultipleChoiceQuestion)
local TextQuestion = require(OnPlatformSurveys.Components.Questions.TextQuestion)
local ThumbsQuestion = require(OnPlatformSurveys.Components.Questions.ThumbsQuestion)
local _InlineSurveyTypes = require(OnPlatformSurveys.Types.InlineSurveyTypes)

local function isThumbsQuestion(arg1)
    if arg1.type ~= InlineQuestionType.MultipleChoiceSingle then
        return false
    end
    local choices = arg1.choices
    if choices == nil or #choices ~= 2 then
        return false
    end

    if FFlagInlineSurveyChoiceTextEntry then
        for _, value in choices do
            if value.requiresText == true then
                return false
            end
        end
    end
    local tbl1 = {}
    for _, value in choices do
        tbl1[value.id] = true
    end
    return tbl1["1"] == true and tbl1["2"] == true
end

return {
    renderQuestion = function(tbl1)
        local question = tbl1.question
        if isThumbsQuestion(question) then
            return React.createElement(ThumbsQuestion, tbl1)
        elseif FFlagInlineSurveyEnhancements and question.type == InlineQuestionType.Text then
            return React.createElement(TextQuestion, {
                answer = tbl1.answer,
                onAnswerChanged = tbl1.onAnswerChanged,
                isDisabled = tbl1.isDisabled,
                layoutOrder = tbl1.layoutOrder
            })
        elseif question.type == InlineQuestionType.MultipleChoiceSingle or question.type == InlineQuestionType.MultipleChoiceMulti then
            return React.createElement(MultipleChoiceQuestion, {
                question = question,
                answer = tbl1.answer,
                onAnswerChanged = tbl1.onAnswerChanged,
                isDisabled = tbl1.isDisabled,
                layoutOrder = tbl1.layoutOrder
            })
        end

        return nil
    end,
    isThumbsQuestion = isThumbsQuestion
}
