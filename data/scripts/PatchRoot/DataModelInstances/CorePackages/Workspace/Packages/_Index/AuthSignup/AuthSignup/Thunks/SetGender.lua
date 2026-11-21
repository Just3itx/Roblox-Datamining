-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:21:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthSignup = script:FindFirstAncestor("AuthSignup")
local AuthSignupParent = AuthSignup.Parent

local PostSetGender = require(AuthSignup.Requests.PostSetGender)

local Promise = require(AuthSignupParent.Promise)

return {
    setGender = function(arg1, arg2)
        return PostSetGender(arg1, arg2):andThen(function(arg3)
            if arg3 == nil or arg3.responseBody == nil then
                return Promise.reject()
            end

            return Promise.resolve()
        end):catch(function(_)
            return Promise.reject()
        end)
    end
}
