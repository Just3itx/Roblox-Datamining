-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:20:56Z
-- Luau bytecode version: 14 | Luau type version: 3
local VerifiedBadgesParent = script:FindFirstAncestor("VerifiedBadges").Parent

local UsersNetworking = require(VerifiedBadgesParent.UsersNetworking)

local RoduxNetworking = require(VerifiedBadgesParent.RoduxNetworking)
local HttpRequest = require(VerifiedBadgesParent.HttpRequest)

local var1 = RoduxNetworking.config({
    keyPath = "VerifiedBadges.NetworkStatus",
    networkImpl = HttpRequest.config({ requestFunction = HttpRequest.requestFunctions.RequestInternal, maxRetryCount = 0 })
})

return {
    RoduxNetworking = var1,
    FriendsNetworking = require(VerifiedBadgesParent.FriendsNetworking).config({ roduxNetworking = var1 }),
    UsersNetworking = UsersNetworking.config({ roduxNetworking = var1 })
}
