-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T15:41:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local FriendsNetworking = require(FriendsLanding.dependencies).FriendsNetworking

local FriendsLandingParent = FriendsLanding.Parent

local FFlagMigrateFriendshipStatusesRemainingActions = require(FriendsLandingParent.SharedFlags).FFlagMigrateFriendshipStatusesRemainingActions

return function(arg1)
    return {
        fetchFriends = function(arg2)
            return arg1(FriendsNetworking.GetFriendsFromUserId.API(arg2))
        end,
        getFriendRequestsCount = function()
            return arg1(FriendsNetworking.GetFriendRequestsCount.API())
        end,
        getInactiveFriends = function(arg2)
            return arg1(FriendsNetworking.GetInactiveFriends.API(arg2))
        end,
        unfriendTargetUser = not FFlagMigrateFriendshipStatusesRemainingActions and function(arg2)
            return arg1(FriendsNetworking.UnfriendTargetUserId.API(arg2))
        end or nil
    }
end
