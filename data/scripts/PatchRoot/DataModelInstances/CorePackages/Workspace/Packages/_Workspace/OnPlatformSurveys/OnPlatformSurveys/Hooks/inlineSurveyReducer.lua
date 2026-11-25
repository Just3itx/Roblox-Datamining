-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local OnPlatformSurveys = script:FindFirstAncestor("OnPlatformSurveys")
local OnPlatformSurveysParent = OnPlatformSurveys.Parent

local Dash = require(OnPlatformSurveysParent.Dash)

local FFlagInlineSurveyBranching = require(OnPlatformSurveysParent.SharedFlags).FFlagInlineSurveyBranching

local inlineSurveyHelpers = require(OnPlatformSurveys.Utils.inlineSurveyHelpers)
local Phase = require(OnPlatformSurveys.Enums.Phase)
local _InlineSurveyTypes = require(OnPlatformSurveys.Types.InlineSurveyTypes)

local answer = {}

local function getInitialState(bool1: boolean?)
    return {
        phase = Phase.Loading,
        hasInvite = bool1 == true,
        questions = {},
        index = 1,
        answersByQuestionId = {},
        answer = answer,
        surveyId = nil,
        idempotencyKey = nil,
        errorType = nil
    }
end

local function closedState(hasInvite: boolean)
    return Dash.join(getInitialState(hasInvite), { phase = Phase.Closed })
end

return {
    getInitialState = getInitialState,
    reducer = function(tbl2, tbl3)
        if tbl3.type == "fetchRequested" then
            return (getInitialState(tbl2.hasInvite))
        elseif tbl3.type == "questionsReceived" then
            local response = tbl3.response

            if response == nil or response.shouldPromptSurvey ~= true then
                return closedState(tbl2.hasInvite)
            end
            local questions = response.questions
            if questions == nil or #questions == 0 then
                return closedState(tbl2.hasInvite)
            end
            return Dash.join(
                getInitialState(tbl2.hasInvite),
                {
                    phase = if tbl2.hasInvite then Phase.Invite else Phase.Started,
                    questions = questions,
                    surveyId = response.surveyId
                }
            )
        elseif tbl3.type == "fetchFailed" then
            return Dash.join(tbl2, { phase = Phase.Error, errorType = "fetch" })
        elseif tbl3.type == "setAnswer" then
            return Dash.join(tbl2, { answer = tbl3.answer })
        elseif tbl3.type == "next" then
            local answersByQuestionId = inlineSurveyHelpers.mergeCurrentAnswerIntoBatch(tbl2.answersByQuestionId, tbl2.questions[tbl2.index], tbl2.answer)
            local index = if FFlagInlineSurveyBranching then inlineSurveyHelpers.resolveNextIndex(tbl2.questions, tbl2.index, tbl2.answer) or tbl2.index + 1 else tbl2.index + 1
            return Dash.join(tbl2, { index = index, answersByQuestionId = answersByQuestionId, answer = answer, errorType = Dash.None })
        elseif tbl3.type == "submitStarted" then
            return Dash.join(tbl2, {
                phase = Phase.Submitting,
                answersByQuestionId = inlineSurveyHelpers.mergeCurrentAnswerIntoBatch(tbl2.answersByQuestionId, tbl2.questions[tbl2.index], tbl2.answer),
                idempotencyKey = tbl3.idempotencyKey,
                errorType = Dash.None
            })
        elseif tbl3.type == "submitSucceeded" then
            return Dash.join(tbl2, { phase = Phase.Completed, errorType = Dash.None })
        elseif tbl3.type == "submitFailed" then
            return Dash.join(tbl2, { phase = Phase.Error, errorType = "submit" })
        elseif tbl3.type == "inviteAccepted" then
            return Dash.join(tbl2, { phase = Phase.Started })
        elseif tbl3.type == "inviteDeclined" or tbl3.type == "dismissed" then
            return closedState(tbl2.hasInvite)
        else
            return tbl2
        end
    end
}
