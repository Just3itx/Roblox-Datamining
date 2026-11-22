-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:40:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfileQRCode = script:FindFirstAncestor("ProfileQRCode")
local ProfileQRCodeParent = ProfileQRCode.Parent
local LuaSocialLibrariesDeps = require(ProfileQRCodeParent.LuaSocialLibrariesDeps)
local httpRequest = LuaSocialLibrariesDeps.httpRequest
local RODUX_KEY = require(ProfileQRCode.Common.Constants).RODUX_KEY
local var1 = require(ProfileQRCodeParent.Lumberyak).Logger.new(nil, "ProfileQRCode"):new("ProfileQRCode Networking")
local maxRetryCount = game:DefineFastInt("ProfileQRCodeHttpRetryCount", 3)

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

return (LuaSocialLibrariesDeps.RoduxNetworking.config({ keyPath = RODUX_KEY .. ".NetworkStatus", networkImpl = networkImpl }))
