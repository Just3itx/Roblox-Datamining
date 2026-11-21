-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T15:41:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local dependencies = require(FriendsLanding.dependencies)
local getDeepValue = dependencies.SocialLibraries.Dictionary.getDeepValue

local FriendsNetworking = dependencies.FriendsNetworking

return function(arg1)
    local deepValue = getDeepValue(arg1, string.format("FriendsLanding.Friends.byUserId.%s", arg1.LocalUserId))

    return {
        localUserId = arg1.LocalUserId,
        screenSize = arg1.ScreenSize,
        inactiveFriendsNetworkRequestStatus = FriendsNetworking.GetInactiveFriends.getStatus(arg1, arg1.LocalUserId),
        friendRequestCount = getDeepValue(arg1, "FriendsLanding.Friends.requests.receivedCount") or 0,
        totalFriendCount = deepValue and #deepValue or 0
    }
end
