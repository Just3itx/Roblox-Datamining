-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:10:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfile = script:FindFirstAncestor("EditProfile")
local EditProfileParent = EditProfile.Parent
local LuaSocialLibrariesDeps = require(EditProfileParent.LuaSocialLibrariesDeps)
local RoduxNetworking = require(EditProfileParent.RoduxNetworking)
local httpRequest = LuaSocialLibrariesDeps.httpRequest
local RODUX_KEY = require(EditProfile.Common.Constants).RODUX_KEY

local maxRetryCount = game:DefineFastInt("EditProfileMaxHttpRetries", 5)

local networkImpl = httpRequest.config({
    requestFunction = function(arg1, arg2, arg3)
        return httpRequest.requestFunctions.RequestInternal(arg1, arg2, arg3)
    end,
    maxRetryCount = maxRetryCount
})

return (RoduxNetworking.config({ keyPath = RODUX_KEY .. ".NetworkStatus", networkImpl = networkImpl }))
