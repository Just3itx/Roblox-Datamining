-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialProof = script:FindFirstAncestor("SocialProof")
local SocialProofParent = SocialProof.Parent
local HttpRequest = require(SocialProofParent.HttpRequest)
local RoduxNetworking = require(SocialProofParent.RoduxNetworking)
local RODUX_KEY = require(SocialProof.Common.Constants).RODUX_KEY
local var1 = require(SocialProofParent.Lumberyak).Logger.new(nil, RODUX_KEY):new(RODUX_KEY .. " Networking")

return (RoduxNetworking.config({
    keyPath = RODUX_KEY .. ".NetworkStatus",
    networkImpl = HttpRequest.config({
        requestFunction = function(arg1, arg2, arg3)
            var1:info("Fetching: {}", string.format("[ requestMethod = %q, url = %q ]", arg2, arg1))
            return HttpRequest.requestFunctions.RequestInternal(arg1, arg2, arg3)
        end,
        postRequestFunction = function(arg1, arg2)
            var1:debug(
                "Returned: {}",
                string.format("[ requestMethod = %q, url = %q, statusCode = %s ]", arg2.requestMethod, arg2.url, arg1.StatusCode)
            )
        end
    })
}))
