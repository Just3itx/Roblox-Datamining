-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:50:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local OnPlatformSurveys = script:FindFirstAncestor("OnPlatformSurveys")
local OnPlatformSurveysParent = OnPlatformSurveys.Parent
local HttpService = game:GetService("HttpService")

local Url = require(OnPlatformSurveysParent.Http).Url

local _InlineSurveyTypes = require(OnPlatformSurveys.Types.InlineSurveyTypes)

return {
    fetchInlineSurvey = function(arg1, input: string)
        return arg1(
            string.format("%s%s?eventType=%s&surveyType=inline", Url.APIS_URL, "v1/survey", HttpService:UrlEncode(input)),
            "GET"
        ):andThen(
            function(arg2)
                return arg2.responseBody
            end
        )
    end,
    submitSurveyResponse = function(arg1, input)
        return arg1(Url.APIS_URL .. "v1/survey/response", "POST", { postBody = HttpService:JSONEncode(input) }):andThen(function(arg2)
            return arg2.responseBody
        end)
    end
}
