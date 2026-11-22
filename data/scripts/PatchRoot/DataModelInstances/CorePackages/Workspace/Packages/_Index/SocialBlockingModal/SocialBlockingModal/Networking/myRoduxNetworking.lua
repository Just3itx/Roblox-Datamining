-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T16:50:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialBlockingModal = script:FindFirstAncestor("SocialBlockingModal")
local SocialBlockingModalParent = SocialBlockingModal.Parent

local RoduxNetworking = require(SocialBlockingModalParent.RoduxNetworking)
local ChallengeRequestWrapper = require(SocialBlockingModalParent.GenericChallenges).Middleware.ChallengeRequestWrapper

local HttpRequest = require(SocialBlockingModalParent.HttpRequest)
local maxRetryCount = game:DefineFastInt("AddFriendsHttpRetryCount", 3)

local RODUX_KEY = require(SocialBlockingModal.Rodux.RODUX_KEY)

local var1 = HttpRequest.config({
    requestFunction = function(arg1, arg2, arg3)
        return HttpRequest.requestFunctions.RequestInternal(arg1, arg2, arg3)
    end,
    maxRetryCount = maxRetryCount
})

return (RoduxNetworking.config(
    {
        keyPath = `{RODUX_KEY}.NetworkStatus`,
        networkImpl = ChallengeRequestWrapper(var1)
    }
))
