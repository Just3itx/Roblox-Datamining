-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:10:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local Action = require(scriptParent.Action)

return function(arg1)
    if type(arg1) ~= "string" then
        arg1 = arg1.Name
    end

    return {
        Succeeded = Action(arg1 .. "_Succeeded", function(ids, responseBody, namedIds, arg2, additionalData)
            return {
                ids = ids,
                responseBody = responseBody,
                namedIds = namedIds,
                postBody = if arg2 then arg2.postBody or nil else nil,
                queryArgs = arg2 and arg2.queryArgs,
                additionalData = additionalData
            }
        end),
        Failed = Action(arg1 .. "_Failed", function(ids, error, namedIds, arg2, additionalData)
            return {
                ids = ids,
                error = error,
                namedIds = namedIds,
                postBody = if arg2 then arg2.postBody or nil else nil,
                queryArgs = arg2 and arg2.queryArgs or nil,
                additionalData = additionalData
            }
        end)
    }
end
