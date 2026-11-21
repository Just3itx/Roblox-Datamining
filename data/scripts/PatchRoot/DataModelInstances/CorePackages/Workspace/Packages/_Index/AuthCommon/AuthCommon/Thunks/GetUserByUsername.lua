-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:41:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent

local Promise = require(AuthCommonParent.Promise)
local PostGetUserByUsername = require(AuthCommon.Http.Requests.PostGetUserByUsername)

return function(arg1, str1: string)
    return function()
        return PostGetUserByUsername(arg1, str1):andThen(function(arg2)
            if not (arg2 and arg2.responseBody) then
                return Promise.reject()
            end

            local data = arg2.responseBody.data
            if data == nil or #data == 0 then
                return Promise.reject()
            end
            local var1 = data[1]
            return Promise.resolve(var1)
        end)
    end
end
