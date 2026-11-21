-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:31:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfileBackgroundParent = script:FindFirstAncestor("EditProfileBackground").Parent
local LuaSocialLibrariesDeps = require(EditProfileBackgroundParent.LuaSocialLibrariesDeps)
local RoduxNetworking = LuaSocialLibrariesDeps.RoduxNetworking
local httpRequest = LuaSocialLibrariesDeps.httpRequest
local var1 = require(EditProfileBackgroundParent.Lumberyak).Logger.new(nil, "EditProfileBackground"):new(
    "EditProfileBackground Networking"
)
local maxRetryCount = game:DefineFastInt("EditProfileBackgroundHttpRetryCount", 3)

local networkImpl = httpRequest.config({
    requestFunction = function(arg1, arg2, arg3)
        var1:info("Fetching: {}", string.format("[ requestMethod = %q, url = %q ]", arg2, arg1))
        return httpRequest.requestFunctions.RequestInternal(arg1, arg2, arg3)
    end,
    postRequestFunction = function(arg1, arg2)
        var1:debug(
            "Returned: {}",
            string.format(
                "[ requestMethod = %q, url = %q, statusCode = %s, body = %s ]",
                arg2.requestMethod,
                arg2.url,
                arg1.StatusCode,
                arg1.Body
            )
        )
    end,
    maxRetryCount = maxRetryCount
})

return (RoduxNetworking.config({ keyPath = "EditProfileBackground.networkStatus", networkImpl = networkImpl }))
