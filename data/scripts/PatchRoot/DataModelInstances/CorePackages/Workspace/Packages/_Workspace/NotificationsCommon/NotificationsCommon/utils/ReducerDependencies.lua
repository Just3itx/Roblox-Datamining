-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:21:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local LuaSocialLibrariesDeps = require(scriptParentParentParent.LuaSocialLibrariesDeps)
local Lumberyak = require(scriptParentParentParent.Lumberyak)
local ShareLinksNetworking = require(scriptParentParentParent.ShareLinksNetworking)
local ShareLinksRodux = require(scriptParentParentParent.ShareLinksRodux)

local RoduxNetworking = LuaSocialLibrariesDeps.RoduxNetworking
local httpRequest = LuaSocialLibrariesDeps.httpRequest

local logger = Lumberyak.Logger.new(nil, "ShareGame")
local maxRetryCount = game:DefineFastInt("ShareGameHttpRetryCount", 3)
local var1 = logger:new("ShareGame Networking")
local networkImpl = httpRequest.config({
    requestFunction = function(arg1, arg2, arg3)
        var1:info("Fetching: {}", string.format("[ requestMethod = %q, url = %q ]", arg2, arg1))
        return httpRequest.requestFunctions.HttpRbxApi(arg1, arg2, arg3)
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

local var3 = RoduxNetworking.config({ keyPath = "NetworkStatus", networkImpl = networkImpl })

return {
    ShareLinksRodux = ShareLinksRodux.config({ keyPath = "ShareGame.ShareLinks" }),
    RoduxNetworking = var3,
    ShareLinksNetworking = ShareLinksNetworking.config({ roduxNetworking = var3 })
}
