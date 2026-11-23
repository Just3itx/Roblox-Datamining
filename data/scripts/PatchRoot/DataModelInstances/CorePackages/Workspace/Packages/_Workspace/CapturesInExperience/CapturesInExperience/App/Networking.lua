-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:31:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local LuaSocialLibrariesDeps = require(scriptParentParentParent.LuaSocialLibrariesDeps)
local Lumberyak = require(scriptParentParentParent.Lumberyak)
local ContentSharingNetworking = require(scriptParentParentParent.ContentSharingNetworking)
local ShareLinksNetworking = require(scriptParentParentParent.ShareLinksNetworking)
local ShareLinksRodux = require(scriptParentParentParent.ShareLinksRodux)
local FFlagCreateMomentsToast = require(scriptParentParent.Flags.FFlagCreateMomentsToast)
local FFlagMomentsCaptureEndIxpEnabled = require(scriptParentParent.Flags.FFlagMomentsCaptureEndIxpEnabled)

local httpRequest = LuaSocialLibrariesDeps.httpRequest
local RoduxNetworking = LuaSocialLibrariesDeps.RoduxNetworking

local Constants = require(scriptParentParent.Constants)

local logger = Lumberyak.Logger.new(nil, Constants.LoggerKey)

local networkImpl = httpRequest.config({
    requestFunction = function(arg1, arg2, arg3)
        logger:debug(`Request: [ requestMethod = {arg2}, url = {arg1} ]`)
        return httpRequest.requestFunctions.HttpRbxApi(arg1, arg2, arg3)
    end,
    maxRetryCount = game:DefineFastInt("CapturesMaxHttpRequestRetries", 2),
    maxWaitTime = game:DefineFastInt("CapturesMaxHttpRequestWaitTime", 8)
})

local var2 = RoduxNetworking.config({ keyPath = "NetworkStatus", networkImpl = networkImpl })

return {
    RoduxNetworking = var2,
    ContentSharingNetworking = if FFlagCreateMomentsToast or FFlagMomentsCaptureEndIxpEnabled then ContentSharingNetworking.config({ roduxNetworking = var2 }) else nil,
    ShareLinksNetworking = ShareLinksNetworking.config({ roduxNetworking = var2 }),
    ShareLinksRodux = ShareLinksRodux.config({ keyPath = "ShareLinks" })
}
