-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:41:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent
local Promise = require(AuthCommonParent.Promise)
local GetAuthMetaData = require(AuthCommon.Http.Requests.GetAuthMetaData)

return function(arg1)
    return GetAuthMetaData(arg1):andThen(function(arg2)
        if arg2 and arg2.responseBody then
            return Promise.resolve(arg2.responseBody)
        end
        return Promise.reject()
    end, function(arg2)
        return Promise.reject({ arg2.StatusCode })
    end)
end
