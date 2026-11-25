-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:01:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local httpRequest = require(ProfilePlatformParent.LuaSocialLibrariesDeps).httpRequest
local RODUX_KEY = require(ProfilePlatform.Common.Constants).RODUX_KEY
local var1 = require(ProfilePlatformParent.Lumberyak).Logger.new(nil, RODUX_KEY):new(RODUX_KEY .. " Networking")
local maxRetryCount = game:DefineFastInt("ProfilePlatformHttpRetryCount", 3)

return (httpRequest.config({
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
}))
