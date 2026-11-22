-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialExperienceJoin = script:FindFirstAncestor("SocialExperienceJoin")
local SocialExperienceJoinParent = SocialExperienceJoin.Parent
local LuaSocialLibrariesDeps = require(SocialExperienceJoinParent.LuaSocialLibrariesDeps)
local httpRequest = LuaSocialLibrariesDeps.httpRequest
local RODUX_KEY = require(SocialExperienceJoin.Common.Constants).RODUX_KEY
local var1 = require(SocialExperienceJoinParent.Lumberyak).Logger.new(nil, RODUX_KEY):new(RODUX_KEY .. " Networking")
local maxRetryCount = game:DefineFastInt("SocialExperienceJoinHttpRetryCount", 3)

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
