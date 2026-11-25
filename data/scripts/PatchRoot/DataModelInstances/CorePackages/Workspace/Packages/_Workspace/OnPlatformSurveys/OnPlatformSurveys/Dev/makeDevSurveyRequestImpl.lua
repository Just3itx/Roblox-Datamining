-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:51:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local OnPlatformSurveys = script:FindFirstAncestor("OnPlatformSurveys")
local OnPlatformSurveysParent = OnPlatformSurveys.Parent

local Promise = require(OnPlatformSurveysParent.Promise)

local InlineQuestionType = require(OnPlatformSurveys.Enums.InlineQuestionType)
local _InlineSurveyTypes = require(OnPlatformSurveys.Types.InlineSurveyTypes)

local QUESTIONS = {{
    questionId = "q1",
    type = InlineQuestionType.MultipleChoiceSingle,
    title = "How would you rate your experience today?",
    required = true,
    choices = {
        { id = "great", label = "Great" },
        { id = "ok", label = "Okay" },
        { id = "bad", label = "Not great" }
    }
}}

local BRANCHING_QUESTIONS = {
    {
        questionId = "rating",
        type = InlineQuestionType.MultipleChoiceSingle,
        title = "How would you rate your experience today?",
        required = true,
        choices = {
            { id = "great", label = "Great", next = "details" },
            { id = "ok", label = "Okay", next = "details" },
            { id = "bad", label = "Not great", next = "issues" }
        }
    },
    {
        questionId = "issues",
        type = InlineQuestionType.MultipleChoiceMulti,
        title = "What went wrong?",
        required = true,
        choices = {
            { id = "performance", label = "Performance" },
            { id = "bugs", label = "Bugs" },
            { id = "confusing", label = "Confusing to use" }
        }
    },
    {
        questionId = "details",
        type = InlineQuestionType.Text,
        title = "Anything else you'd like to share?"
    }
}

local function isResponseUrl(str1: string): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
    return string.sub(str1, -16) == "/survey/response"
end

local function makeRequestImplFor(surveyId: string, questions) -- Luacid: Inlined by compiler; 2 call sites recovered
    return function(str1: string, _: string, _)
        return Promise.new(function(callback)
            task.delay(0.4, function()
                if isResponseUrl(str1) then
                    callback({ responseBody = { responseId = "dev-response" }, responseCode = 200 })
                    return
                end

                callback(
                    {
                        responseBody = {
                            surveyId = surveyId,
                            shouldPromptSurvey = true,
                            questions = questions
                        },
                        responseCode = 200
                    }
                )
            end)
        end)
    end
end

return {
    makeRequestImpl = function()
        return makeRequestImplFor("dev-survey", QUESTIONS)
    end,
    makeBranchingRequestImpl = function()
        return makeRequestImplFor("dev-branching-survey", BRANCHING_QUESTIONS)
    end,
    QUESTIONS = QUESTIONS,
    BRANCHING_QUESTIONS = BRANCHING_QUESTIONS,
    SURVEY_ID = "dev-survey",
    BRANCHING_SURVEY_ID = "dev-branching-survey",
    RESPONSE_DELAY_SECONDS = 0.4
}
