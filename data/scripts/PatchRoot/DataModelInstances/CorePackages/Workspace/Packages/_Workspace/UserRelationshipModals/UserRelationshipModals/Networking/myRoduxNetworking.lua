-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:11:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserRelationshipModals = script:FindFirstAncestor("UserRelationshipModals")
local UserRelationshipModalsParent = UserRelationshipModals.Parent

local RoduxNetworking = require(UserRelationshipModalsParent.RoduxNetworking)

local HttpRequest = require(UserRelationshipModalsParent.HttpRequest)
local maxRetryCount = game:DefineFastInt("AddFriendsHttpRetryCount", 3)

local RODUX_KEY = require(UserRelationshipModals.Rodux.RODUX_KEY)

local networkImpl = HttpRequest.config({
    requestFunction = function(arg1, arg2, arg3)
        return HttpRequest.requestFunctions.RequestInternal(arg1, arg2, arg3)
    end,
    maxRetryCount = maxRetryCount
})

return (RoduxNetworking.config({ keyPath = `{RODUX_KEY}.NetworkStatus`, networkImpl = networkImpl }))
