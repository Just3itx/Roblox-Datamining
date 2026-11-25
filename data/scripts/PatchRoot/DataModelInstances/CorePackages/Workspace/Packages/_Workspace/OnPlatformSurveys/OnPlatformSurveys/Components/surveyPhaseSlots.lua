-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:51:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local OnPlatformSurveys = script:FindFirstAncestor("OnPlatformSurveys")
local OnPlatformSurveysParent = OnPlatformSurveys.Parent

local Foundation = require(OnPlatformSurveysParent.Foundation)
local React = require(OnPlatformSurveysParent.React)

local ButtonVariant = Foundation.Enums.ButtonVariant
local Radius = Foundation.Enums.Radius
local Skeleton = Foundation.Skeleton
local FoundationText = Foundation.Text
local View = Foundation.View

local FFlagInlineSurveyEnhancements = require(OnPlatformSurveysParent.SharedFlags).FFlagInlineSurveyEnhancements

local inlineSurveyHelpers = require(OnPlatformSurveys.Utils.inlineSurveyHelpers)
local Phase = require(OnPlatformSurveys.Enums.Phase)
local questionRenderers = require(OnPlatformSurveys.Components.Questions.questionRenderers)
local _inlineSurveyReducer = require(OnPlatformSurveys.Hooks.inlineSurveyReducer)
local _InlineSurveyTypes = require(OnPlatformSurveys.Types.InlineSurveyTypes)

local function LoadingBody(tbl1)
    local size600 = tbl1.tokens.Size.Size_600
    return React.createElement(View, { tag = "col gap-medium size-full-0 auto-y" }, {
        Line1 = React.createElement(Skeleton, { radius = Radius.Medium, Size = UDim2.new(1, 0, 0, size600), LayoutOrder = 1 }),
        Line2 = React.createElement(Skeleton, { radius = Radius.Medium, Size = UDim2.new(1, 0, 0, size600), LayoutOrder = 2 }),
        Line3 = React.createElement(Skeleton, { radius = Radius.Medium, Size = UDim2.new(0.6, 0, 0, size600), LayoutOrder = 3 })
    })
end

local function QuestionBody(tbl1)
    local question = tbl1.state.questions[tbl1.state.index]
    local input = questionRenderers.renderQuestion({
        question = question,
        answer = tbl1.state.answer,
        onAnswerChanged = tbl1.onAnswerChanged,
        isDisabled = tbl1.state.phase == Phase.Submitting,
        layoutOrder = 2
    })

    return React.createElement(View, { tag = "col gap-xlarge size-full-0 auto-y" }, {
        Title = React.createElement(FoundationText, {
            Text = question.title,
            tag = "size-full-0 auto-y text-body-large text-wrap text-align-x-left content-emphasis",
            LayoutOrder = 1
        }),
        Input = input
    })
end

return {
    getSlots = function(state, tbl1, tokens, tbl2)
        if state.phase == Phase.Invite then
            return {
                headerTitle = tbl1.surveyTitle,
                body = React.createElement(
                    FoundationText,
                    {
                        Text = tbl1.inviteBody,
                        tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-default"
                    }
                ),
                primaryAction = {
                    text = tbl1.inviteAccept,
                    variant = ButtonVariant.Emphasis,
                    onActivated = tbl2.onAccept
                }
            }
        end

        if state.phase == Phase.Loading then
            return {
                headerTitle = nil,
                body = React.createElement(LoadingBody, { tokens = tokens }),
                primaryAction = nil
            }
        end
        if state.phase == Phase.Error then
            return {
                headerTitle = nil,
                body = React.createElement(
                    FoundationText,
                    {
                        Text = tbl1.errorText,
                        tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-center content-default"
                    }
                ),
                primaryAction = {
                    text = tbl1.retry,
                    variant = ButtonVariant.Standard,
                    onActivated = tbl2.onRetry
                }
            }
        end

        if state.phase == Phase.Completed then
            return {
                headerTitle = tbl1.completedTitle,
                body = nil,
                primaryAction = {
                    text = tbl1.done,
                    variant = ButtonVariant.Emphasis,
                    onActivated = tbl2.onDismiss
                }
            }
        end
        if state.phase ~= Phase.Started and state.phase ~= Phase.Submitting or state.questions[state.index] == nil then
            return { headerTitle = nil, body = nil, primaryAction = nil }
        end

        local isLoading = state.phase == Phase.Submitting
        local body = React.createElement(QuestionBody, { state = state, onAnswerChanged = tbl2.onAnswerChanged })

        if not FFlagInlineSurveyEnhancements then
            local var1 = inlineSurveyHelpers.mergeCurrentAnswerIntoBatch(state.answersByQuestionId, state.questions[state.index], state.answer)
            local isDisabled = isLoading or not inlineSurveyHelpers.canSubmitAll(state.questions, var1)
            return {
                headerTitle = tbl1.surveyTitle,
                body = body,
                primaryAction = {
                    text = tbl1.send,
                    variant = ButtonVariant.Emphasis,
                    onActivated = tbl2.onSubmit,
                    isLoading = isLoading,
                    isDisabled = isDisabled
                }
            }
        end

        local var1 = inlineSurveyHelpers.isLastQuestion(state.questions, state.index, state.answer)
        local isDisabled = isLoading or not inlineSurveyHelpers.canAdvance(state.questions, state.index, state.answersByQuestionId, state.answer)
        return {
            headerTitle = tbl1.surveyTitle,
            body = body,
            primaryAction = {
                text = if var1 then tbl1.send else tbl1.next,
                variant = ButtonVariant.Emphasis,
                onActivated = tbl2.onSubmit,
                isLoading = isLoading,
                isDisabled = isDisabled
            }
        }
    end
}
