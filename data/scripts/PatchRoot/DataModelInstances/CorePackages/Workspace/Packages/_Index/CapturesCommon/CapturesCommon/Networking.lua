-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local LuaSocialLibrariesDeps = require(scriptParentParent.LuaSocialLibrariesDeps)

local ContentSharingNetworking = require(scriptParentParent.ContentSharingNetworking)
local httpRequest = LuaSocialLibrariesDeps.httpRequest
local RoduxNetworking = LuaSocialLibrariesDeps.RoduxNetworking

local var1 = httpRequest.config({
    requestFunction = function(arg1, arg2, arg3)
        return httpRequest.requestFunctions.HttpRbxApi(arg1, arg2, arg3)
    end,
    postRequestFunction = function(_, _) end,
    maxRetryCount = game:DefineFastInt("CapturesCommonMaxHttpRequestRetries", 2),
    maxWaitTime = game:DefineFastInt("CapturesCommonMaxHttpRequestWaitTime", 8)
})

local roduxNetworking = RoduxNetworking.config({ keyPath = "NetworkStatus", networkImpl = var1 })

return {
    CapturesCommonNetworkImpl = var1,
    CapturesCommonNetworking = ContentSharingNetworking.config({ roduxNetworking = roduxNetworking })
}
