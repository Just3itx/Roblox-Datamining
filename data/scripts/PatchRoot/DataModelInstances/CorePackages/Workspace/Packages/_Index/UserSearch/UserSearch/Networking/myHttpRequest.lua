-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:10:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserSearchParent = script:FindFirstAncestor("UserSearch").Parent
local httpRequest = require(UserSearchParent.LuaSocialLibrariesDeps).httpRequest
local maxRetryCount = game:DefineFastInt("UserSearchHttpRetryCount", 3)

local bool1 = game:DefineFastFlag("MigrateUserSearchHttpRequestToRequestInternal", false)

return (httpRequest.config({
    requestFunction = function(arg1, arg2, arg3)
        if bool1 then
            return httpRequest.requestFunctions.RequestInternal(arg1, arg2, arg3)
        end
        return httpRequest.requestFunctions.HttpRbxApi(arg1, arg2, arg3)
    end,
    maxRetryCount = maxRetryCount
}))
