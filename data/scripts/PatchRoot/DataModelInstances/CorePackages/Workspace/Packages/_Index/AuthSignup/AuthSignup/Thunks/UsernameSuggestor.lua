-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:21:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthSignup = script:FindFirstAncestor("AuthSignup")
local AuthSignupParent = AuthSignup.Parent

local PostUsernameSuggestions = require(AuthSignup.Requests.PostUsernameSuggestions)

local Promise = require(AuthSignupParent.Promise)

local StatusCodes = require(AuthSignupParent.Http).StatusCodes

return {
    suggestUsernames = function(arg1, arg2, arg3, _)
        return PostUsernameSuggestions(arg1, arg2, arg3):andThen(function(arg4)
            if arg4 == nil or arg4.responseBody == nil then
                return Promise.reject()
            end
            local didGenerateNewUsername = arg4.responseBody.didGenerateNewUsername
            local suggestedUsernames = arg4.responseBody.suggestedUsernames
            return Promise.resolve({ shouldUpdateState = true, didGenerate = didGenerateNewUsername, suggestions = suggestedUsernames })
        end, function(arg4)
            local statusCode = arg4.StatusCode

            return Promise.resolve(
                {
                    shouldUpdateState = statusCode ~= StatusCodes.TOO_MANY_REQUESTS,
                    didGenerate = false,
                    suggestions = {}
                }
            )
        end)
    end
}
