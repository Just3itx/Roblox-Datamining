-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:21:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericChallengesParent = script:FindFirstAncestor("GenericChallenges").Parent

local Promise = require(GenericChallengesParent.Promise)
local Cryo = require(GenericChallengesParent.Cryo)
local IsChallengeHttpResponse = require(script.Parent.IsChallengeHttpResponse)
local InterceptChallenge = require(script.Parent.InterceptChallenge)
local _Http = require(GenericChallengesParent.Http)

return function(arg1, arg2)
    local var1 = InterceptChallenge
    if arg2 ~= nil then
        var1 = arg2
    end
    return function(str1: string, str2: string, arg3)
        local var2, var3 = arg1(str1, str2, arg3)

        return var2:andThen(function(arg4)
            return Promise.resolve(arg4)
        end):catch(function(arg4)
            if arg4.StatusCode == nil or arg4.Headers == nil or not IsChallengeHttpResponse(arg4.StatusCode, arg4.Headers) then
                return Promise.reject(arg4)
            end

            local tbl1 = {
                retryRequestCallback = function(headers)
                    return arg1(str1, str2, Cryo.Dictionary.join(arg3, { headers = headers }))
                end,
                rawResponseHeaders = arg4.Headers
            }

            return var1(tbl1)
        end), var3
    end
end
