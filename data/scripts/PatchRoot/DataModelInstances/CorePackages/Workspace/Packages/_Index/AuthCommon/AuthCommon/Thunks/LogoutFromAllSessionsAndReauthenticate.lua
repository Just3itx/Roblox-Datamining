-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:50:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent

local Promise = require(AuthCommonParent.Promise)

local LogoutFromAllSessionsAndReauthenticateRequest = require(AuthCommon.Http.Requests.LogoutFromAllSessionsAndReauthenticateRequest)

return function(arg1)
    return LogoutFromAllSessionsAndReauthenticateRequest(arg1):andThen(function(arg2)
        return Promise.resolve(arg2.responseBody)
    end):catch(function(arg2)
        if arg2.data then
            return Promise.reject(arg2.data.errorCode)
        elseif not arg2.StatusCode then
            return Promise.reject()
        end
        return Promise.reject({ arg2.StatusCode })
    end)
end
