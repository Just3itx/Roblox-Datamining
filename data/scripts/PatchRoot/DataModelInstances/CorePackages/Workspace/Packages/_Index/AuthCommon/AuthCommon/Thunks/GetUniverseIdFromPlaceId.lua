-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:41:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent
local Url = require(AuthCommonParent.Http).Url

return function(arg1, arg2)
    return arg1(string.format("%suniverses/v1/places/%d/universe", Url.APIS_URL, arg2), "GET"):andThen(function(arg3)
        if arg3 and arg3.responseBody and arg3.responseBody.universeId then
            return arg3.responseBody.universeId
        end
        error("Failed to get universeId from placeId: " .. tostring(arg2))
    end)
end
