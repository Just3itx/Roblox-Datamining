-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:41:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent

local Promise = require(AuthCommonParent.Promise)
local GetUserByIdRequest = require(AuthCommon.Http.Requests.GetUserByIdRequest)

return function(arg1, str1: string)
    return GetUserByIdRequest(arg1, str1):andThen(function(arg2)
        if not (arg2 and arg2.responseBody) then
            return Promise.reject()
        end

        local responseBody = arg2.responseBody
        if responseBody == nil then
            return Promise.reject()
        end
        return Promise.resolve(responseBody)
    end)
end
